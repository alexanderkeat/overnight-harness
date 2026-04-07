# Contributing to Overnight Harness

This file is for **overnight-harness contributors**, not users.

If you are using the harness in your project, see `README.md`. The harness is fully self-contained in its skills — no configuration files to edit.

---

## Repository structure

```
overnight-harness/
├── .claude/skills/           # All harness skills (copied to project root by setup.sh)
│   ├── run/                  # Orchestration — the full execution loop lives here
│   ├── new-request/          # Scaffold request docs from conversation
│   ├── update-harness/       # Re-sync skills after git pull
│   ├── phase-plan/           # Steps 2-3: analyze + decompose
│   ├── phase-execute/        # Step 4: tracer bullet + parallel sub-agents
│   ├── phase-test/           # Step 5: review + behavioral tests
│   ├── phase-ship/           # Step 7: quality gates + PR
│   ├── phase-compact/        # Step 8: deviations + state + /compact
│   └── ...                   # Supporting skills
├── harness-context/
│   ├── Outstanding/          # Request queue (.gitkeep; content gitignored)
│   └── Complete/             # Finished requests (.gitkeep; content gitignored)
├── setup.sh                  # One-time bootstrap (copies skills, patches .gitignore)
├── README.md                 # User-facing docs
└── CONTRIBUTING.md           # This file — dev guide only
```

## Design principle

The harness is **fully self-contained in skills**. No root CLAUDE.md import is required in the user's project. The `/run` skill contains the complete execution loop and all operating rules. Adding a new feature means editing a skill — not this file.

## Contributing

- Edit skills in `.claude/skills/*/SKILL.md`
- `setup.sh` handles first-time user setup — keep it minimal (skills + .gitignore only)
- `harness-context/` content is gitignored — only `.gitkeep` files are committed
- `.agent/` is gitignored — agent working memory is ephemeral
