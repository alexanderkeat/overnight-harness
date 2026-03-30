# Autonomous Build Harness

Provide one command. The harness executes all defined development phases end-to-end.

---

## Required file structure
```
/product-context
  architecture.md        # full technical architecture for the build
  user-stories.md        # all user stories, fully written out
  build-phases.md        # all phases for this development run
  PRD.md                 # full product requirements document

  /UX-UI                 # optional — include if you have UI/UX specs

  /phases
    phase-01.md          # Title, Status, Goal, Deliverables, Acceptance Criteria,
                         # Related User Stories (full copies), Architecture References
    phase-02.md
    phase-03.md
```

---

## Starting a run

1. Ask Claude to clone in this harness, replacing your existing `claude.md`.
2. Verify the file schema to confirm the clone was successful.
3. Ask Claude to check for required dependencies — MCP servers, CLIs, etc. — and flag any missing configuration.
4. Clear context.
5. Start the run with a prompt like:
   > "Begin building the project. Use the `claude.md` file and all skills. Be slow and methodical — run each step of each phase without skipping."
6. **Optional — skill-use logging:** To generate a log of skill invocations, start the run with:
   > "Begin building the project following the loop in `claude.md`. Be slow and methodical — run each step of each phase without skipping. At the end, append a `skill-use-log.md` with a row for each skill used: `PhaseNumber`, `SkillInvoked`, `ByWhom`, `Outcome`."
