# Relentless Product Interview

The interview converts an app idea into a decision-complete design brief. Relentless means continuing through every answer that changes the product model or interface — not producing a long questionnaire.

## Interview behavior

- Ask one primary question at a time; add at most two tightly coupled questions when answering them together is easier.
- Ask the highest-leverage unresolved question. Purpose and domain model usually precede visual preferences.
- State why a choice matters when the user would otherwise be choosing blindly. Offer two or three concrete alternatives when a tradeoff is clearer than an open prompt.
- Follow abstract answers with a real scenario: who is at the Mac, what are they trying to finish, what do they start with, and what counts as success?
- Reflect contradictions immediately and ask which rule wins. Preserve exceptions only when the domain requires them.
- Credit answers found in code, documents, screenshots, and earlier turns. Never ask the user to repeat discoverable information.
- If the user delegates a choice, decide it, record the assumption and consequence, and continue. If the user changes direction, update the brief and revisit only the decisions invalidated by the change.
- End a question batch with the questions, not a premature interface proposal.

## Living brief

Keep this ledger in conversation or in a requested design artifact. Use `Unknown`, `Assumed`, `Decided`, and `Observed` so gaps remain visible.

- **Product sentence:** For [people] in [situation], the app helps them [valuable outcome] by [distinct mechanism].
- **Purpose:** core value, current alternative, differentiation, non-goals, defining emotion.
- **People:** primary and secondary audiences, expertise, frequency, environment, accessibility needs.
- **Domain:** objects, relationships, states, lifecycle, ownership, scale, source of truth, terminology.
- **Workflows:** first success, routine task, expert task, long-running task, collaboration, failure and recovery.
- **Mac model:** utility, menu-bar app, single-window library, multiwindow workspace, or document app; window behavior; selection; inspectors; commands; automation.
- **Platforms:** primary platform, minimum OS versions, device-specific jobs, shared data, transitions between devices.
- **Data:** creation, import, export, sync, offline behavior, conflicts, retention, deletion, migration.
- **Trust:** accounts, permissions, privacy, security, sensitive content, destructive actions, reversibility.
- **Business:** purchase model, entitlement, onboarding, account requirements, support and update expectations.
- **Expression:** brand character, content density, visual assets, sound or haptics, desired and undesired emotions.
- **Delivery:** existing code and framework, deadlines, team capability, technical constraints, success measures.
- **Evidence:** observed facts, explicit decisions, assumptions, contradictions, and open questions.

## Question branches

Use these as branches, not as a script. Skip what is already resolved.

### Purpose and people

Establish the meaningful outcome before features. Identify the person whose experience wins when needs conflict, the situation that triggers use, why the current solution falls short, what the app uniquely makes possible, and the emotion the finished experience should create.

### Domain and scale

Elicit the nouns people recognize, the actions they perform on them, and the states those objects pass through. Determine item counts, hierarchy depth, selection cardinality, ownership, versioning, collaboration, and whether the app manages a library, files, projects, sessions, or a service-backed account.

### Mac work style

Determine whether work is brief or sustained; focused or parallel; mouse-led, keyboard-led, drag-and-drop-led, or automated. Ask what belongs in separate windows, what people compare side by side, what must survive relaunch, what should be customizable, and which actions experts repeat often enough to deserve commands and shortcuts.

### Platform roles

For each proposed Apple platform, ask what job is uniquely valuable there. Clarify where work begins, continues, and finishes; which state crosses devices; whether a companion experience is still useful alone; and which device owns time-sensitive, glanceable, captured, or immersive moments.

### Trust and recovery

Trace permission requests, sensitive data, destructive actions, sync conflicts, network loss, interrupted work, and account loss. Ask how people verify consequences, reverse mistakes, recover data, and understand what the app is doing.

### Inclusion and context

Identify keyboard-only and VoiceOver workflows, vision or motion sensitivities, text and contrast needs, right-to-left and localization requirements, cultural meaning, noisy or quiet environments, and situations involving one hand, no touch, or multiple displays.

### Business and delivery

Resolve minimum deployment targets, App Store or direct distribution, sandboxing and entitlement constraints, monetization moments, account boundaries, existing framework choices, required integrations, deadline, and what must be true for the first release to count as successful.

## Discovery gate

Continue interviewing until all of the following are decided, observed, or explicitly delegated:

- one primary audience, problem, outcome, differentiator, and emotional target
- a stable domain vocabulary with object lifecycles and source of truth
- first-success, routine, expert, and failure-recovery scenarios
- Mac app/work/window model and the highest-frequency commands
- role and minimum OS target for each supported Apple platform
- data, sync, offline, permission, privacy, destructive, and recovery rules
- accessibility, localization, business, technical, and delivery constraints
- contradictions resolved and assumptions visible

After researching the HIG and ecosystem candidates, reopen the interview only for newly discovered choices that materially change the product. The interview ends when remaining gaps are implementation details with safe, reversible defaults.
