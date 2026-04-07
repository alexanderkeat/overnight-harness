---
name: phase-compact
description: "Phase compaction — reference documentation for the PERSIST step in the /run orchestrator. Describes the state files written between phases, their formats, and the rules governing session state. In the current architecture, the /run orchestrator handles persistence directly (Phase Step C) using the phase sub-agent's completion report. This file is kept as a reference for the state file formats and compaction rules."
---

# Phase Compaction: State File Reference

In the current harness architecture, each phase runs in its own sub-agent (dispatched via the Agent tool). The main orchestrator persists results to `.agent/` state files after each sub-agent returns. This document defines the file formats and rules.

## State Files

### `.agent/phase-{N}-ledger.md`

The canonical record of what happened in phase N. Future phases read this (especially the Deviations section) to understand constraints and carry-forward items.

```markdown
# Phase {N} Ledger

## What Was Built
{3-5 sentences summarizing deliverables}

## Key Decisions
| Decision | Choice | Reasoning |
|----------|--------|-----------|
| ...      | ...    | ...       |

## Architecture Changes
{One-liner per change, or "None"}

## Deviations

### Deferred Tasks
- {description} — deferred to Phase {X} because {reason}

### Spec Divergences
- Spec said: {X}. Implemented: {Y}. Reason: {why}. Spec updated: yes/no.

### Stubs
- {function_name} returns {default} — needs Phase {X} for full implementation

### Test Deferrals
- {test description} — deferred to Phase {X} because {reason}

## Patterns Established
{New code patterns, conventions, or utilities introduced that future phases should reuse}
```

### `.agent/session-state.md`

Current system state. Updated (not appended) after each phase. The "Active Architecture" section reflects the CURRENT truth, not a changelog.

```markdown
# Session State

## Current Phase
Phase {N} — complete

## Completed Phases
{One-liner per completed phase with PR link}

## Active Architecture
{Current state of the system — ≤30 lines}

## Carry-Forward Issues
{Open items from previous phases that affect current/future work}

## Established Patterns
{Accumulated list of patterns/utilities created across all phases}
```

### `.agent/codebase-knowledge.md`

Accumulated gotchas and conventions. Each phase appends a new section. Sub-agents receive this in their prompt to avoid repeating mistakes.

```markdown
# Codebase Knowledge

## Phase {N}: {title}
### Gotchas
- {hard-won knowledge that would trip up a fresh session}

### Conventions
- {error handling, async, ID, serialization patterns that emerged}

### Module Changes
- {new directories or modules added}
```

### `.agent/active-request.md`

Tracks which request and phase the harness is working on. Used for crash recovery.

```markdown
# Active Request
Name: {request-name}
Path: overnight-harness/harness-context/Outstanding/{request-name}
Total Phases: {count}
Current Phase: {N}
Started: {date}
```

### `.agent/codebase-profile.md`

Stack, test runner, code style, CI/CD, quality gates, and patterns. Written by `/discover` on first run, updated incrementally as new patterns emerge.

## Rules

- **Session state is authoritative.** When starting a new phase, the sub-agent receives `session-state.md` + prior ledgers + phase plan + product context.
- **Phase ledgers are the canonical source for deviations.** All prior ledgers' Deviations sections are inlined in the sub-agent prompt.
- **Session state is updated, not appended.** The "Active Architecture" section reflects CURRENT state after each phase.
- **The `.agent/` directory is gitignored.** These files are working memory, not project artifacts. Only spec doc updates get committed.
- **Context isolation is structural.** Each phase sub-agent gets a fresh context window via the Agent tool. No `/clear` or `/compact` needed — sub-agent boundaries ARE the context reset.
