# macOS-Native Coverage

Use this reference after discovery and live HIG research. It is a coverage ledger, not a component shopping list.

## Product structure before screens

Choose the Mac work model from the domain and workflows:

- **Document app:** people create, open, save, duplicate, version, move, export, and often view several independent documents.
- **Library app:** a persistent collection is the primary home; people browse, search, select, and inspect managed items.
- **Workspace app:** projects or accounts contain several tools and views used together over sustained sessions.
- **Utility:** a focused task benefits from a small, quickly accessible window.
- **Menu-bar app:** status or a frequent lightweight action is valuable without opening a primary window; settings and deeper work still need an appropriate home.

Record why the chosen model matches people’s mental model, where each object lives, what a window represents, and what happens when people create or close one. Define minimum and comfortable sizes, resizing behavior, full screen, window restoration, multiple-display behavior, tabbing when relevant, and active/inactive window states.

## Mac interaction architecture

Account for each area and mark it `Use`, `Conditional`, `Defer`, or `Not applicable`.

### Hierarchy and navigation

Decide whether the app needs a sidebar, content list or outline, detail view, inspector, tabs, search, filters, breadcrumbs or path controls, toolbar, title or document menu, and status presentation. Preserve selection and context as windows resize or navigation changes.

### Commands and acceleration

The menu bar exposes the complete command model. Toolbars expose frequent, context-relevant actions. Context menus expose a short useful subset for the current selection. Define labels, grouping, availability, toggled state, discoverable keyboard shortcuts, command conflicts, toolbar customization, and searchable or automatable actions.

### Direct manipulation and data work

Cover focus, hover, selection, multiple selection, double-click behavior, drag and drop, copy and paste, undo and redo, autosave, explicit save when domain-appropriate, import, export, open, reveal, rename, duplicate, delete, Quick Look, sharing, printing, and services. Apply only the behaviors the domain supports, but disposition every one.

### Controls and content

Select controls from the live HIG component index. Prefer system behavior and semantic styling. For each custom control, specify its focus ring, keyboard operation, pointer target, hover and pressed feedback, enabled and disabled appearance, accessibility role and value, menu equivalent when applicable, appearance adaptation, and window-size behavior.

## Visual system

- Let content and task hierarchy determine density, spacing, grouping, and emphasis.
- Use system typography, semantic colors, semantic materials, vibrancy, and SF Symbols where their meanings fit. Support the person’s accent color and current system appearance.
- Apply Apple’s current design system through system components and APIs. Custom materials and effects require a functional layering or hierarchy reason and must preserve legibility across increased contrast and reduced transparency.
- Use motion to explain state and spatial change. Provide an equivalent calm transition when Reduce Motion is enabled.
- Give domain content the expressive role; keep navigation and controls familiar, precise, and restrained.
- Test light, dark, increased-contrast, reduced-transparency, reduced-motion, grayscale or color-deficiency, VoiceOver, keyboard-only, and localized layouts.

## State and recovery matrix

Specify the interface, available actions, and recovery path for:

- first launch, onboarding, and first success
- empty, loading, progress, long-running, and completed work
- no selection, single selection, multiple selection, and stale selection
- offline, sync pending, sync conflict, unavailable service, and partial data
- permission not requested, granted, denied, restricted, and revoked
- invalid input, recoverable error, blocking error, and data migration
- destructive confirmation, undo, redo, restore, and permanent deletion
- signed out, expired entitlement, locked content, and account removal when applicable

Preserve people’s work and context across every transition. Prefer reversible actions and visible status over modal interruption.

## Apple ecosystem map

Give each device a job rather than cloning the Mac interface. Consider the current Apple capabilities that can remove friction from the user’s workflow, then verify each one in official documentation.

For every candidate integration, record:

| Capability | User moment | Device role | Shared state | Permission or entitlement | Offline/failure behavior | Availability | Disposition |
| --- | --- | --- | --- | --- | --- | --- | --- |

Consider sync and documents, Handoff and activity continuation, universal links and deep links, Spotlight, App Intents and Shortcuts, Siri, widgets, Live Activities, notifications, sharing, SharePlay, menu-bar presence, Quick Look and extensions, Sign in with Apple, purchases and entitlements, camera or nearby-device continuity, watch complications, Apple Pencil workflows, and spatial or media experiences only where the product supplies a credible user moment.

Cross-platform consistency means shared purpose, terminology, data, and recognizable state. Platform nativeness means adapting navigation, density, controls, input, windowing, and glanceability to each device.

## Completion ledger

Before handing off, confirm that the result includes:

- a justified Mac work and window model
- a screen/window map tied to domain objects and workflows
- complete menus, shortcuts, toolbar, focus, and input behavior
- every current relevant HIG component and pattern dispositioned
- all critical states and recovery paths specified
- system appearance and accessibility conditions verified
- each ecosystem integration accepted or rejected for a product reason
- current Apple evidence and API availability attached to material decisions

Any missing row is either a new interview question or an explicit, visible assumption.
