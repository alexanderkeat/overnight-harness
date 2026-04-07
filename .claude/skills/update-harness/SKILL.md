---
name: update-harness
description: "Update overnight harness skills. Re-syncs the latest skills from overnight-harness/.claude/skills/ to the project root .claude/skills/ after a git pull. Safe to run multiple times. NOTE: For first-time setup after cloning, run `bash overnight-harness/setup.sh` from your terminal first — skills are not yet available in Claude Code before that step."
---

# Update Overnight Harness Skills

Run this after `cd overnight-harness && git pull` to sync the latest skills into your project.

## Steps

### 1. Copy updated skills to the project root

```bash
cp -r overnight-harness/.claude/skills/* .claude/skills/
```

This overwrites existing skill files with the latest versions. Skills are owned by the harness and should never be edited directly in `.claude/skills/` — changes would be overwritten on the next update.

### 2. Verify .gitignore

Read the project root `.gitignore`. If it does not already contain `.agent/`, append:

```
# Harness agent working memory (ephemeral, not committed)
.agent/
```

If it's already there, skip.

### 3. Report

```
Harness updated.

  .claude/skills/   ← N skills synced from overnight-harness
  .gitignore        ← .agent/ present [or: already present, skipped]
```
