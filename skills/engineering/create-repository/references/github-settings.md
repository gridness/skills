# GitHub repository policy

Read this reference only when the user has explicitly requested GitHub
repository creation or settings changes.

The portable policy captured from
[`gridness/a365`](https://github.com/gridness/a365) lives in
[`github-settings.json`](github-settings.json). The settings script consumes
that file directly, so it is the single source of truth.

## Scope

The policy covers repository features and merge behavior, Actions permissions,
Dependabot alerts and security updates, secret scanning and push protection,
CodeQL default setup, and an active ruleset for the default branch. The ruleset
keeps the a365 policy shape while requiring the generic Rust template's
`Quality` and `Test and coverage` checks.

Repository identity is user-owned input. Preserve the approved owner,
visibility, name, description, and topics. The policy also leaves collaborators,
teams, webhooks, deploy keys, environments, variables, secrets, and GitHub App
installations untouched because they are credentials or repository-specific
relationships rather than portable settings.

The optional `--bypass-app-id` adds one already-installed GitHub App to the
ruleset. Without it, only the repository Admin role can bypass. Never copy the
a365 integration ID to another repository without the user's confirmation that
the same App is installed there.

## Release prerequisites

The Rust release workflow intentionally preserves a365's short-lived GitHub
App token pattern. Before the first ordinary push to `main`, the owner must:

- install a release GitHub App on the new repository;
- set the Actions variable `RELEASE_APP_CLIENT_ID`; and
- set the Actions secret `RELEASE_APP_PRIVATE_KEY`.

The App needs repository Contents, Issues, and Pull requests write permissions.
The initial commit includes `[skip ci]`, leaving time to configure these values.
Do not request, print, or copy the private key. If the owner declines this App
setup, explain that `.github/workflows/release.yml` must be adapted before CD
can succeed; CI remains usable.

## Availability

Applying settings requires repository Administration write permission. GitHub
organization or enterprise policy may override Actions permissions. Rulesets,
CodeQL, or secret-scanning features on a private repository may require an
eligible GitHub plan. Treat a nonzero settings-script exit as a partial
application: inspect its last named stage, report the mismatch, and do not claim
that the repository matches the policy.
