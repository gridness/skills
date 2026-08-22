---
name: gh-merge
description: Automatically commit, push and create PR to default branch once work is done.
disable-model-invocation: true
---

# GitHub Merge

When work is complete, follow through the remote update procedure.

## Procedure

1. Check git status and diff.
2. Run required tests/checks.
3. Create an appropriate commit message.
4. Commit only relevant files.
5. Push the current branch.
6. Create/update a GitHub PR using `gh pr create`.
7. Enable auto-merge:
   `gh pr merge --auto --squash`
8. Report PR URL and CI status.

## Stacked PRs

If merging to main requires merging multiple PRs, use GitHub Stacked Pull Requests: `gh stack`.

If a PR stack is available or created, use `gh stack merge` to merge it.
