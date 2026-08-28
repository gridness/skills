# Live Apple Guidance Research

Apple’s design language, component guidance, and platform APIs change. Use official sources live and keep the skill as a research route rather than a frozen copy of the HIG.

## Source protocol

1. Open the [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/) and the current [Design principles](https://developer.apple.com/design/human-interface-guidelines/design-principles/).
2. Read [Designing for macOS](https://developer.apple.com/design/human-interface-guidelines/designing-for-macos/) and the equivalent overview for every supported platform.
3. Enumerate the current HIG index under Foundations, Patterns, Components, Inputs, and Technologies. Classify every item against the product brief before opening only the detailed pages marked `Use` or `Conditional`.
4. For anything described as new or latest, inspect the HIG’s **New and updated** section, Apple’s current WWDC design guide and videos, platform release notes, and the relevant SwiftUI/AppKit/API availability documentation.
5. Use Apple Developer documentation to verify framework support, platform availability, deprecations, entitlements, and fallback behavior. HIG guidance establishes design intent; API documentation establishes what can ship.
6. Record the source title, direct URL, access date, published or updated date when available, supported OS versions, and whether the capability is shipping, beta, announced, or deprecated.

Search within `developer.apple.com` when a category URL or title has moved. Prefer current HIG and current framework documentation over archived guidance. If current Apple sources disagree or remain ambiguous, state the ambiguity and choose the behavior that best preserves user agency, data, accessibility, and platform familiarity.

## Required research branches

### Principles

Build a principle ledger from the live Design principles page. For each current principle, record:

- the product decision it influences
- the competing priorities it helps resolve
- the resulting interface behavior
- evidence or user research supporting that choice
- any remaining risk

Paraphrase guidance and link to it. Treat principles as tools for weighing decisions, not as decorative labels added after the design.

### Foundations

Always consider accessibility, inclusion, privacy, layout, typography, writing, color, appearance modes, materials, motion, icons, app icons, SF Symbols, imagery, localization, and right-to-left behavior. Read the detailed page when the app makes a nontrivial choice in that area.

### Patterns

Map the app’s workflows to current guidance for navigation, search, selection, data entry, feedback, loading, modality, onboarding, settings, permissions, drag and drop, copy and paste, undo and redo, file handling, sharing, collaboration, notifications, account management, and help. The live index is authoritative when its categories differ from this routing list.

### Components and inputs

Enumerate the current component and input indexes rather than relying on a remembered catalog. For every `Use` or `Conditional` entry, capture placement, hierarchy, labels, enabled and disabled states, keyboard behavior, pointer behavior, accessibility behavior, compact-window behavior, and platform variation.

### Platform technologies

Research technologies only after the user need is clear. Candidate areas include SwiftUI and AppKit, App Intents and Shortcuts, Spotlight, Siri, widgets, Live Activities, notifications, iCloud and CloudKit, document storage, Handoff and user activities, SharePlay, Sign in with Apple, sharing extensions, Quick Look, menu-bar extras, accessibility APIs, StoreKit, and platform-specific companion experiences. Verify current names and availability before recommending them.

## Evidence ledger

Use a compact table:

| Decision | Product reason | Apple guidance or API | Availability | Status | Consequence |
| --- | --- | --- | --- | --- | --- |

Each meaningful native-design recommendation needs a product reason and an Apple source. A link without a design consequence is not evidence; a design preference without a product reason is not a decision.
