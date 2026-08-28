# {{ project_name }}

{{ project_description }}

## Repository shape

Rust crates live under `crates/`. Keep shared package metadata and dependencies
in the workspace `Cargo.toml`; crates should inherit them with `workspace =
true`. Record domain language in `CONTEXT.md` and durable architecture decisions
under `docs/adr/`.

## Change loop

Use the commands in `justfile`. Complete Rust changes with:

1. `just fmt`
2. `just clippy --locked`
3. `just test --locked`

Keep the changed package scoped while iterating when that materially shortens
feedback, then run the complete commands before handoff.

## Rust conventions

- Keep public crate APIs small and make `match` expressions exhaustive when the
  domain is closed.
- Prefer self-documenting enums, newtypes, or named methods over ambiguous
  boolean and `Option` parameters.
- Inline captured variables in formatting macros and use method references when
  they stay readable.
- Put each newly added test module in a sibling `*_tests.rs` file and attach it
  with an explicit `#[path = "..."]` attribute.
- Compare complete values in tests when equality expresses the invariant.
- Support Linux and macOS unless a feature is explicitly platform-specific.
