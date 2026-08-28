# Confirmed Design Record

Use this reference only after the user explicitly confirms the presented shared understanding. The record makes that agreement durable for the people and agents working in the target project.

## Confirmation boundary

Confirmation is an explicit user statement that the presented product model and design language represent the shared understanding. Corrections reopen the proposal; revise it and request confirmation again. Begin the project document only after this boundary is observable in the conversation.

## Resolve the destination

Identify the target project root from the active workspace, supplied repository, or explicit path. If more than one project could be the target, ask the user which one. Read relevant project instructions and inspect the existing `docs/` tree before choosing a location and style.

Update an existing canonical design record when it covers the same app and subject. Otherwise create `docs/design-language.md`, creating `docs/` when needed. Follow an established project filename or documentation index convention when one exists. Keep one source of truth rather than creating date-stamped copies for successive confirmations.

## Write the synthesis

Write for a teammate who did not witness the conversation. Preserve decisions and their reasons; compress the dialogue itself. Use the project’s terminology and adapt the headings to its conventions while accounting for every applicable topic below:

- **Status:** app or feature scope, `Confirmed` status, confirmation date, and Apple-guidance access date.
- **Product understanding:** product sentence, audience, problem, outcome, differentiator, non-goals, and defining emotion.
- **People and scenarios:** first success, routine work, expert work, failure and recovery, environment, and accessibility context.
- **Domain model:** objects, relationships, lifecycle, ownership, source of truth, scale, and agreed terminology.
- **Design principles:** the current Apple principles that affected decisions, the tradeoffs they resolved, and the resulting behaviors.
- **Mac experience:** app/work model, windows and documents, information architecture, navigation, selection, inspectors, resizing, restoration, menus, commands, shortcuts, focus, pointer, keyboard, drag and drop, and customization.
- **Design language:** hierarchy, density, layout, spacing, typography, writing, semantic color, materials, appearance modes, iconography, imagery, motion, feedback, and the rule for custom components.
- **Components and states:** accepted and conditional components, rejected alternatives that materially shaped the design, empty/loading/offline/error/permission/destructive/sync states, undo, and recovery.
- **Apple ecosystem:** role of each platform, shared state, handoff moments, accepted or rejected integrations, availability, permissions, entitlements, and fallbacks.
- **Trust and inclusion:** privacy, security, data handling, accessibility, localization, right-to-left behavior, and system accessibility settings.
- **Delivery:** framework and deployment targets, implementation constraints, release boundary, and success measures.
- **Evidence:** direct Apple HIG and developer-documentation links with availability and access dates where relevant.
- **Decision ledger:** confirmed decisions, delegated assumptions with rationale and consequence, unresolved questions, and deferred work.

Represent every discussed topic once in its most natural section. Keep an unresolved item labeled as unresolved, and keep an assumption labeled as an assumption. Add no product requirement merely to fill a heading; mark a meaningful topic `Not applicable` with its reason or omit an empty topic when project conventions favor compact documents.

## Keep it authoritative

When a later proposal changes a recorded decision, obtain explicit confirmation, update the existing section, and keep the document internally consistent. Add a short decision-history entry only when the reason for replacing the old decision will matter to future work.

The document is complete when:

- its project and feature scope are unambiguous
- every `Decided`, `Assumed`, and material `Observed` item from the living brief is represented
- the design-language presentation and coverage ledgers agree with it
- current Apple sources support material native-design and availability claims
- unresolved questions and deferred work remain visible
- no transcript residue, invented decision, duplicate source of truth, or scaffold placeholder remains
- the final response links to the created or updated file and summarizes any remaining open decisions

Leave committing or publishing the record to the user’s requested workflow.
