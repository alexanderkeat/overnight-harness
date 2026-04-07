---
name: new-request
description: "Scaffold a new overnight harness request from the current conversation. Reads what was discussed and generates fully populated PRD, architecture, user-stories, build-phases, and phase files — not blank templates. Invoke after describing your feature in chat: /new-request <name>. If no name is provided, derive one from the described feature."
---

# New Request — Generate from Conversation

This skill turns the current conversation into a complete, harness-ready request folder inside `overnight-harness/harness-context/Outstanding/`.

Do not write blank templates. Read what has been described in this conversation and generate real, populated content. The quality of the harness run depends entirely on the quality of these docs.

---

## Step 1: Determine the request name

If the user provided a name (e.g., `/new-request multi-format-atoms`), slugify it: lowercase, hyphens for spaces, no special characters.

If no name was provided, derive a slug from the feature described in the conversation (e.g., "real-time collaboration" → `real-time-collaboration`). Confirm the name before proceeding.

---

## Step 2: Check for conflicts

If `overnight-harness/harness-context/Outstanding/{name}/` already exists, ask the user whether to overwrite or pick a different name.

---

## Step 3: Extract from the conversation

Read the full conversation above. Extract:

- **What is being built** — the core feature or system
- **Why it's being built** — the problem it solves or the user need it addresses
- **Who uses it** — the user types or personas mentioned
- **Functional requirements** — what it must do (explicit and implied)
- **Non-goals** — anything explicitly ruled out or out of scope
- **Technical constraints** — stack decisions, integration points, architectural choices discussed
- **Data models** — any entities, schemas, or data structures discussed
- **API or interface contracts** — endpoints, commands, events, inputs/outputs
- **Phases** — any phasing or sequencing discussed; if not discussed, propose logical phases based on the feature scope
- **User stories** — any user-facing capabilities described (convert to story format)
- **Acceptance criteria** — any "it works when..." statements made

If any of these are absent from the conversation, make reasonable inferences based on what was described. Do not leave sections empty — write your best inference and mark it `[inferred]` so the developer knows to review it.

---

## Step 4: Create folder structure

```
overnight-harness/harness-context/Outstanding/{name}/
overnight-harness/harness-context/Outstanding/{name}/phases/
overnight-harness/harness-context/Outstanding/{name}/decisions/
```

---

## Step 5: Write the docs

Write each file with real content drawn from the conversation. Use the structure below as the skeleton — fill in all sections with substantive content, not placeholder text.

---

### `PRD.md`

```markdown
# Product Requirements Document — {Feature Name}

## Overview
{2-3 sentences: what this is, what problem it solves}

## Goals
{Bullet list of what success looks like — concrete and measurable}

## Non-Goals
{Bullet list of what is explicitly out of scope}

## Users
{Who uses this. Include relevant context about their workflow or expectations.}

## Requirements
{Numbered list of functional requirements. Each must be implementable and verifiable.}

## Constraints
{Technical, business, or timeline constraints that shape the implementation}
```

---

### `architecture.md`

```markdown
# Technical Architecture — {Feature Name}

## System Overview
{What is being built at a high level. Where does it fit in the existing codebase?}

## Stack
{Language, framework, key libraries — pulled from conversation or inferred from project context}

## Data Models
{Key data structures, types, schemas. Be specific — include field names and types where discussed.}

## API / Interface Contracts
{Endpoints, commands, events. For each: method, path/name, inputs, outputs, error cases.}

## Integrations
{External systems, services, or existing modules this touches}

## Key Decisions
{Architecture decisions already made in this conversation. List each with brief rationale.}

## Open Questions
{Architecture questions that were not resolved in the conversation. The agent will need to decide these during execution — flag anything important.}
```

---

### `user-stories.md`

```markdown
# User Stories — {Feature Name}

{One section per story. Minimum 3 stories. Write complete, detailed stories — not stubs.}

## Story 1: {Short Title}

**As a** {user type}
**I want to** {action}
**So that** {outcome or value}

### Acceptance Criteria
- [ ] {specific, verifiable criterion}
- [ ] {specific, verifiable criterion}

### Notes
{Edge cases, open questions, or constraints for this story}

## Story 2: ...
```

---

### `build-phases.md`

```markdown
# Build Phases — {Feature Name}

{Overview of the development phases. Each phase must be independently shippable and produce a PR.}

## Phase 1: {Title}
**Goal:** {One sentence}
**Delivers:** {What exists after this phase that didn't before — be concrete}
**Depends on:** {Prior phases or external prerequisites, or "none"}

## Phase 2: {Title}
...
```

---

### `phases/phase-01.md` (and additional phase files as needed)

Write one file per phase identified in the conversation. If phases weren't discussed, propose a sensible breakdown based on the feature complexity (e.g., data model + API + UI as separate phases).

```markdown
# Phase {N}: {Title}

## Status
Outstanding

## Goal
{One sentence: what this phase delivers}

## Deliverables
- [ ] {Concrete, observable deliverable 1}
- [ ] {Concrete, observable deliverable 2}

## Acceptance Criteria
{Each criterion must be objectively verifiable — something you can check without ambiguity.}
- [ ] {criterion 1}
- [ ] {criterion 2}

## Related User Stories
{Copy the FULL text of any user stories this phase implements — do not just reference them by name.
Sub-agents receive only this file. They cannot cross-reference other docs.}

## Architecture References
{Which sections of architecture.md are most relevant to this phase?}

## Notes
{Anything the agent should know before starting: gotchas, design choices, integration details}
```

---

## Step 6: Confirm creation

After writing all files, report a summary:

```
Created overnight-harness/harness-context/Outstanding/{name}/

  PRD.md              ← {N} requirements, {N} non-goals
  architecture.md     ← {stack}, {N} data models, {N} API contracts
  user-stories.md     ← {N} stories with acceptance criteria
  build-phases.md     ← {N} phases defined
  phases/
    phase-01.md       ← {phase 1 title}
    phase-02.md       ← {phase 2 title, if applicable}
    ...
  decisions/          ← ADRs will be written here during execution

[inferred] sections to review:
  {list any sections marked [inferred] that the developer should verify}

Ready to run. Clear context and use:
  /run {name}
```
