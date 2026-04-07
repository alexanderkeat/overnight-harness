# Overnight Harness

An autonomous build harness for Claude Code. Describe what you want built, queue it as a request, and let Claude execute every phase overnight — planning, coding, testing, and opening PRs — without human input.

The harness is **fully self-contained in skills**. It does not require any changes to your project's `CLAUDE.md`.

---

## How it works

1. You describe a feature in Claude Code chat
2. `/new-request` turns your description into structured spec docs
3. `/run` executes every phase autonomously: plan → build → test → ship
4. Each phase opens a PR. Completed requests move to `Complete/` automatically.

---

## Getting started

### Step 1 — Clone into your project root

Open a terminal at your project root:

```bash
git clone https://github.com/alexanderkeat/overnight-harness overnight-harness
```

This creates `overnight-harness/` inside your project. Nothing else is touched.

---

### Step 2 — Run the setup script

```bash
bash overnight-harness/setup.sh
```

This copies the harness skills into your project's `.claude/skills/` so Claude Code can load them, and adds `.agent/` to your `.gitignore`. That's all it does — your `CLAUDE.md` is not modified.

```
Setting up overnight-harness...

  .claude/skills/   ← 21 skills copied
  .gitignore        ← .agent/ added

Done. Open Claude Code and:
  1. Describe your feature in chat
  2. Run /new-request <name>
  3. /clear
  4. /run <name>
```

After setup, your project structure:

```
your-project/
├── overnight-harness/
│   ├── harness-context/
│   │   ├── Outstanding/    ← your requests go here
│   │   └── Complete/       ← finished requests land here
│   └── setup.sh
└── .claude/
    └── skills/             ← harness skills now here, loaded by Claude Code
```

---

### Step 3 — Open Claude Code and describe your feature

Start a Claude Code session. Talk through what you want to build — requirements, architecture, phases, edge cases. The more context you share, the better the generated docs.

---

### Step 4 — Create a request

```
/new-request <name>
```

The skill reads your conversation and generates a fully populated request folder:

```
overnight-harness/harness-context/Outstanding/my-feature/
├── PRD.md              ← requirements, goals, non-goals
├── architecture.md     ← data models, API contracts, key decisions
├── user-stories.md     ← stories with acceptance criteria
├── build-phases.md     ← phase overview
└── phases/
    ├── phase-01.md     ← deliverables + acceptance criteria, fully written
    └── phase-02.md
```

Sections the skill couldn't confidently infer are marked `[inferred]`. Review those before running.

---

### Step 5 — Start the run

Clear context first (the harness needs a full context budget):

```
/clear
```

Then start:

```
/run my-feature
```

Claude executes every phase autonomously — `/phase-plan` → `/phase-execute` → `/phase-test` → `/phase-ship` → `/phase-compact` — opening a PR per phase. When all phases are done, the request moves to `Complete/`.

---

## Running multiple requests

**All outstanding, alphabetical order:**
```
/run
```

**Specific order:**
```
/run auth-system,search-api,dashboard-ui
```

Prefix folder names with `01-`, `02-` to control alphabetical order.

---

## Crash recovery

The harness writes `.agent/active-request.md` before every context compaction. If interrupted, start a new session and run `/run` — it resumes from exactly where it left off.

---

## Updating the harness

```bash
cd overnight-harness && git pull && cd ..
```

Then in Claude Code:

```
/update-harness
```

---

## Skill reference

| Skill | Purpose |
|-------|---------|
| `/new-request <name>` | Generate a populated request from the current conversation |
| `/run [name\|a,b,c]` | Start the harness in a fresh context |
| `/update-harness` | Re-sync skills after `git pull` |
