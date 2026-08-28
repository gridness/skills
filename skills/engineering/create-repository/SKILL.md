---
name: create-repository
description: Scaffold a repository from a maintained project-type template, with optional GitHub creation and policy setup.
disable-model-invocation: true
---

# Create Repository

Create a new repository from one template under `assets/`. Each immediate child
directory is a repository type. The available type is currently:

- `rust`: a Rust 2024 workspace and CLI with the structure, CI, release flow,
  and portable repository policy of `gridness/a365`.

If the requested type has no asset directory, report the available types and
stop. Keep future repository types isolated in sibling asset directories.

## Resolve the request

Collect only missing values:

- repository type;
- destination directory, suggesting the current directory;
- project name and one-line description;
- Rust crate/binary name when it should differ from the normalized project
  name;
- whether to create or configure a GitHub repository; and
- for GitHub, the `owner/repository` slug and visibility.

Suggest `rust`, a crate name normalized from the project name, and public
GitHub visibility. Keep Apache-2.0 as the Rust template's license unless the
user explicitly asks to adapt the generated repository.

Inspect the destination before writing. It must be absent or empty. Preserve an
existing non-empty destination and ask for a new empty path.

Show the resolved template, destination, names, and GitHub action in one short
summary. Obtain explicit approval before creating local files or mutating
GitHub. Approval for local scaffolding alone does not authorize GitHub changes.

## Render and verify

Run the renderer from this skill directory:

```console
python3 scripts/render_template.py \
  --type rust \
  --destination <absolute-path> \
  --project-name <display-name> \
  --description <one-line-description> \
  [--crate-name <cargo-package-name>] \
  [--github-slug <owner/repository>]
```

The renderer refuses a non-empty destination and any unresolved template
token. From the rendered repository:

1. Run `cargo generate-lockfile`.
2. Run `just fmt`, `just clippy --locked`, and `just test --locked`.
3. Initialize `main` with `git init -b main` when it is not already a Git
   repository.
4. Commit the verified tree with a past-tense message such as
   `Bootstrapped <project> [skip ci]`.

Do not commit when validation fails. Fix template-derived failures and repeat
all three checks until the generated project is valid.

## GitHub branch

When the approved request includes GitHub, read
[references/github-settings.md](references/github-settings.md) before any
remote mutation.

After the initial local commit:

1. Verify `gh auth status` and that the requested slug does not already name an
   unrelated repository.
2. Create the repository with the approved values:

   ```console
   gh repo create <owner/repository> --<visibility> \
     --description <description> --source <absolute-path> --remote origin --push
   ```

3. Preview the policy, inspect the exact target, then apply it:

   ```console
   scripts/sync_github_settings.sh --repo <owner/repository>
   scripts/sync_github_settings.sh --repo <owner/repository> --apply
   ```

   Add `--bypass-app-id <id>` only when the user identifies an installed GitHub
   App that should bypass the `main` ruleset.
4. Report any release App credential or plan limitation described by the
   GitHub reference. Never invent, copy, or expose secrets.

For an existing GitHub repository, skip creation and use the same settings
script only after explicit approval of that exact slug. Organization or
enterprise policy can prevent a setting from matching; surface the failed
setting instead of claiming parity.

## Completion

Finish only when the generated tree has no template tokens, all local checks
pass, and the initial commit is clean. If GitHub was requested, also require the
repository URL and a successful settings verification, or name each setting
GitHub prevented from applying. Hand off the created file tree, validation
results, commit, URL when applicable, and any remaining release credential
setup.
