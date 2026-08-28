#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
policy_file="$script_dir/../references/github-settings.json"
repository=""
bypass_app_id=""
mode="preview"
expected_file=""

usage() {
	cat <<'EOF'
Usage: sync_github_settings.sh --repo OWNER/REPOSITORY [--apply | --check]
                               [--bypass-app-id ID]

Preview is the default. --apply changes settings and verifies them. --check
only verifies the current settings. The caller must have repository Admin
permission.
EOF
}

while (($#)); do
	case "$1" in
		--repo)
			repository="${2:-}"
			shift 2
			;;
		--bypass-app-id)
			bypass_app_id="${2:-}"
			shift 2
			;;
		--apply)
			[[ "$mode" == "preview" ]] || { echo "Choose only one mode" >&2; exit 2; }
			mode="apply"
			shift
			;;
		--check)
			[[ "$mode" == "preview" ]] || { echo "Choose only one mode" >&2; exit 2; }
			mode="check"
			shift
			;;
		-h|--help)
			usage
			exit 0
			;;
		*)
			echo "Unknown argument: $1" >&2
			usage >&2
			exit 2
			;;
	esac
done

[[ "$repository" =~ ^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$ ]] || {
	echo "--repo must have the form OWNER/REPOSITORY" >&2
	exit 2
}
if [[ -n "$bypass_app_id" && ! "$bypass_app_id" =~ ^[0-9]+$ ]]; then
	echo "--bypass-app-id must be numeric" >&2
	exit 2
fi

for command in gh jq; do
	command -v "$command" >/dev/null || {
		echo "Required command is unavailable: $command" >&2
		exit 2
	}
done

repo_info="$(gh repo view "$repository" --json nameWithOwner,url,visibility,viewerPermission)"
permission="$(jq -r '.viewerPermission' <<<"$repo_info")"
[[ "$permission" == "ADMIN" ]] || {
	echo "Repository Admin permission is required; current permission: $permission" >&2
	exit 1
}

rules_file="$(mktemp)"
trap 'rm -f "$rules_file" "$expected_file"' EXIT
if [[ -n "$bypass_app_id" ]]; then
	jq --argjson app_id "$bypass_app_id" '
		.ruleset
		| .bypass_actors += [{
			actor_id: $app_id,
			actor_type: "Integration",
			bypass_mode: "always"
		}]
	' "$policy_file" >"$rules_file"
else
	jq '.ruleset' "$policy_file" >"$rules_file"
fi

preview() {
	echo "Target: $(jq -r '.nameWithOwner + " (" + .visibility + ")"' <<<"$repo_info")"
	echo "Source policy: $(jq -r '.source_repository + " captured " + .captured_at' "$policy_file")"
	echo "Portable policy to apply:"
	jq '{repository, actions, workflow_permissions, artifact_retention, fork_pr_approval, code_scanning}' "$policy_file"
	echo "Ruleset to apply:"
	jq . "$rules_file"
}

ruleset_id() {
	gh api "repos/$repository/rulesets" \
		--jq '.[] | select(.name == "main read-only") | .id' \
		| head -n 1
}

verify_subset() {
	local label="$1"
	local endpoint="$2"
	local expected_file="$3"
	local current
	local expected
	current="$(gh api "$endpoint")"
	expected="$(jq -c . "$expected_file")"
	jq -e --argjson expected "$expected" 'contains($expected)' \
		<<<"$current" >/dev/null || {
		echo "Verification failed: $label" >&2
		return 1
	}
	echo "Verified: $label"
}

verify() {
	local id
	expected_file="$(mktemp)"

	jq '.repository' "$policy_file" >"$expected_file"
	verify_subset "repository features, merge policy, and secret scanning" \
		"repos/$repository" "$expected_file"

	jq '.actions' "$policy_file" >"$expected_file"
	verify_subset "Actions policy" "repos/$repository/actions/permissions" "$expected_file"

	jq '.workflow_permissions' "$policy_file" >"$expected_file"
	verify_subset "workflow permissions" \
		"repos/$repository/actions/permissions/workflow" "$expected_file"

	jq '.artifact_retention' "$policy_file" >"$expected_file"
	verify_subset "artifact and log retention" \
		"repos/$repository/actions/permissions/artifact-and-log-retention" "$expected_file"

	jq '.fork_pr_approval' "$policy_file" >"$expected_file"
	verify_subset "fork pull-request approval" \
		"repos/$repository/actions/permissions/fork-pr-contributor-approval" "$expected_file"

	gh api "repos/$repository/vulnerability-alerts" >/dev/null
	echo "Verified: Dependabot alerts"
	gh api "repos/$repository/automated-security-fixes" >/dev/null
	echo "Verified: Dependabot security updates"

	jq '.code_scanning' "$policy_file" >"$expected_file"
	verify_subset "CodeQL default setup" \
		"repos/$repository/code-scanning/default-setup" "$expected_file"

	id="$(ruleset_id)"
	[[ -n "$id" ]] || { echo "Verification failed: main ruleset is absent" >&2; return 1; }
	verify_subset "main ruleset" "repos/$repository/rulesets/$id" "$rules_file"
	rm -f "$expected_file"
	expected_file=""
	echo "GitHub settings match the portable a365 policy: $(jq -r '.url' <<<"$repo_info")"
}

apply() {
	local id
	echo "Applying: repository features, merge policy, and secret scanning"
	jq '.repository' "$policy_file" \
		| gh api --method PATCH "repos/$repository" --input - >/dev/null

	echo "Applying: Actions policy"
	jq '.actions' "$policy_file" \
		| gh api --method PUT "repos/$repository/actions/permissions" --input - >/dev/null

	echo "Applying: workflow permissions"
	jq '.workflow_permissions' "$policy_file" \
		| gh api --method PUT "repos/$repository/actions/permissions/workflow" --input - >/dev/null

	echo "Applying: artifact and log retention"
	jq '.artifact_retention' "$policy_file" \
		| gh api --method PUT \
			"repos/$repository/actions/permissions/artifact-and-log-retention" \
			--input - >/dev/null

	echo "Applying: fork pull-request approval"
	jq '.fork_pr_approval' "$policy_file" \
		| gh api --method PUT \
			"repos/$repository/actions/permissions/fork-pr-contributor-approval" \
			--input - >/dev/null

	echo "Applying: Dependabot alerts and security updates"
	gh api --method PUT "repos/$repository/vulnerability-alerts" >/dev/null
	gh api --method PUT "repos/$repository/automated-security-fixes" >/dev/null

	echo "Applying: CodeQL default setup"
	jq '.code_scanning' "$policy_file" \
		| gh api --method PATCH "repos/$repository/code-scanning/default-setup" --input - >/dev/null

	echo "Applying: main ruleset"
	id="$(ruleset_id)"
	if [[ -n "$id" ]]; then
		gh api --method PUT "repos/$repository/rulesets/$id" \
			--input "$rules_file" >/dev/null
	else
		gh api --method POST "repos/$repository/rulesets" \
			--input "$rules_file" >/dev/null
	fi

	verify
}

case "$mode" in
	preview)
		preview
		;;
	check)
		verify
		;;
	apply)
		preview
		apply
		;;
esac
