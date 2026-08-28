---
name: apple-native-app-design
description: Interrogate, design, document, implement, or audit Apple-platform apps until the product and interaction model are decision-complete, then create clean macOS-first interfaces grounded in the current Apple Human Interface Guidelines. Use for Apple ecosystem app concepts, macOS UI architecture, SwiftUI or AppKit interface work, confirmed design records, and native-design reviews; not for generic web UI.
---

# Apple-Native App Design

Design the product as a Mac app, not as a visual theme applied to a generic interface. Treat Apple’s Human Interface Guidelines as a live decision framework. Let each system component earn its place through the app’s purpose, and let every supported Apple platform express the shared product model in its own native way.

Default to macOS as the primary experience unless the user names another primary platform. Preserve an existing project’s framework and deployment targets unless changing them is part of the request.

## Workflow

### 1. Build the living brief

Inspect any supplied brief, code, screenshots, product documents, and deployment settings before asking questions. For a new concept or an incomplete specification, read [references/interview.md](references/interview.md) and begin the relentless interview.

Ask one to three high-leverage questions per turn. Carry forward every answer in a compact living brief, expose contradictions, and ask follow-ups until every design-changing gap is answered or explicitly delegated to you. Delegated decisions become visible assumptions with rationale.

The discovery gate is closed until the brief identifies the product’s purpose, people, domain objects, primary workflows, Mac work model, platform roles, constraints, risks, and intended emotional character without unresolved contradictions. Existing implementations may already satisfy parts of the gate; credit what can be observed instead of asking again.

### 2. Research Apple’s current guidance

Read [references/hig-research.md](references/hig-research.md). Browse Apple’s official HIG and developer documentation live for the platforms, patterns, components, inputs, and technologies implicated by the brief.

Create an evidence ledger that connects each material recommendation to the relevant current Apple guidance or platform capability. Record availability and source dates where Apple provides them. Distinguish shipping, beta, announced, and deprecated behavior. “Latest” is established by current official sources, not memory.

Research is complete when every relevant branch of the current HIG index has been considered, every proposed capability has verified platform availability, and no recommendation relies on an unverified recollection of Apple guidance.

### 3. Model the native experience

Read [references/macos-native-coverage.md](references/macos-native-coverage.md). Define the product model before drawing screens:

- objects, states, relationships, selection, and ownership
- scene, window, document, navigation, and inspector structure
- menu commands, toolbar actions, context actions, shortcuts, focus, and input methods
- first-run, routine, expert, empty, loading, offline, error, permission, destructive, undo, and recovery behavior
- the distinct role of each Apple device and the continuity between them

Maintain a coverage ledger for the current HIG component index. Mark every component, relevant pattern, input, and ecosystem capability as `Use`, `Conditional`, `Defer`, or `Not applicable`, with a product reason. Read detailed Apple guidance for `Use` and `Conditional` entries. Coverage is exhaustive; inclusion is selective.

The model is complete when three representative scenarios — first success, routine expert work, and failure with recovery — can be performed end to end, with every action reachable through appropriate Mac commands and inputs.

### 4. Present the design language and confirm it

Present a shared-understanding proposal before creating or changing the interface. It must connect the product thesis and defining emotion to the HIG principle choices, Mac work and window model, information architecture, visual hierarchy, typography, color, materials, motion, iconography, component conventions, commands, platform roles, ecosystem capabilities, accessibility, trust, and recovery behavior. Make assumptions and unresolved decisions visible.

Ask the user to correct or explicitly confirm the proposal. Treat corrections as changes to the living brief, evidence ledger, and native-experience model, then present the revised understanding. Continued conversation or the absence of objections is not confirmation.

The confirmation gate closes only when the user explicitly confirms that the presented design language and product model are the shared understanding.

### 5. Record the confirmed discussion

After the confirmation gate closes, read [references/design-record.md](references/design-record.md). Resolve the target project root, inspect its existing documentation conventions, and write or update one canonical Markdown record under the project’s `docs/` directory. Default to `docs/design-language.md` when the project has no established location or filename for this material.

Synthesize every discussed topic, accepted decision, rationale, Apple source, assumption, and open item. Write a durable reference, not a transcript. If later discussion changes the design language, return to the confirmation gate and update the same record after the change is confirmed.

Documentation is complete when the record matches the confirmed understanding, accounts for every decided or assumed item in the living brief and coverage ledgers, marks unresolved items accurately, and the user receives its project-relative path.

### 6. Create the interface

Start from system-provided structure, controls, semantic colors, materials, typography, symbols, menus, focus behavior, and accessibility behavior. Custom presentation earns its place by expressing a domain-specific object or interaction that system UI cannot communicate well.

Keep content primary and hierarchy legible at every supported window size. Treat pointer precision, keyboard operation, menu-bar completeness, resizing, multiple windows, state restoration, light and dark appearances, increased contrast, reduced transparency, reduced motion, localization, and VoiceOver as first-class design conditions.

When implementation is requested, use the confirmed design record as the source of truth and map it into the project’s existing SwiftUI/AppKit architecture. Propose newer APIs behind availability-aware adoption paths; never raise a deployment target silently. Build and run the relevant checks, then verify the observable interface states in proportion to the change.

### 7. Hand off a decision-complete result

For design work, provide:

- the product thesis, defining emotion, and explicit assumptions
- information architecture, window map, and primary flows
- visual hierarchy and native component specification
- command, shortcut, input, state, and recovery behavior
- component-coverage and ecosystem-integration ledgers
- accessibility, privacy, localization, and platform adaptation decisions
- current Apple sources with availability notes
- the confirmed design record in the project’s `docs/` directory
- the few remaining decisions that genuinely require the user, if any

For implementation or audit work, connect findings to concrete files, screens, or behaviors and separate HIG evidence from product judgment. A polished appearance alone does not close the task; the interaction model, edge states, Mac conventions, and ecosystem roles must also be accounted for.
