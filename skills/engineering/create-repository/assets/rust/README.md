# {{ project_name }}

__GITHUB_ONLY_START__
[![CI](https://github.com/{{ github_slug }}/actions/workflows/ci.yml/badge.svg)](https://github.com/{{ github_slug }}/actions/workflows/ci.yml)
[![Coverage](https://codecov.io/gh/{{ github_slug }}/graph/badge.svg?branch=main)](https://codecov.io/gh/{{ github_slug }})
[![License](https://img.shields.io/github/license/{{ github_slug }})](LICENSE)

__GITHUB_ONLY_END__
{{ project_description }}

## Build and run

The repository uses the Rust toolchain pinned in `rust-toolchain.toml` and
[`just`](https://github.com/casey/just) for development commands.

```console
just build
just run
```

## Development

```console
just fmt
just clippy --locked
just test --locked
```

Crates live under `crates/`. Architecture decisions belong in `docs/adr/`, and
the project's shared domain language belongs in `CONTEXT.md`.

## Releases

Release Please maintains the version, changelog, release pull request, and draft
GitHub release. The release workflow validates Linux and macOS artifacts before
publishing them. It expects a least-privilege GitHub App configured through the
`RELEASE_APP_CLIENT_ID` Actions variable and `RELEASE_APP_PRIVATE_KEY` Actions
secret.
