#!/usr/bin/env bash
# Overnight Harness — one-time setup
# Run from your project root: bash overnight-harness/setup.sh

set -e

HARNESS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$HARNESS_DIR")"

echo "Setting up overnight-harness..."
echo ""

# ── 1. Copy skills ────────────────────────────────────────────────────────────
mkdir -p "$PROJECT_ROOT/.claude/skills"
cp -r "$HARNESS_DIR/.claude/skills/"* "$PROJECT_ROOT/.claude/skills/"
SKILL_COUNT=$(ls "$HARNESS_DIR/.claude/skills/" | wc -l | tr -d ' ')
echo "  .claude/skills/   ← $SKILL_COUNT skills copied"

# ── 2. Patch .gitignore ───────────────────────────────────────────────────────
GITIGNORE="$PROJECT_ROOT/.gitignore"
if [ -f "$GITIGNORE" ]; then
  if grep -q "\.agent/" "$GITIGNORE"; then
    echo "  .gitignore        ← .agent/ already present, skipped"
  else
    printf "\n# Harness agent working memory (ephemeral, not committed)\n.agent/\n" >> "$GITIGNORE"
    echo "  .gitignore        ← .agent/ added"
  fi
else
  printf "# Harness agent working memory (ephemeral, not committed)\n.agent/\n" > "$GITIGNORE"
  echo "  .gitignore        ← created with .agent/ entry"
fi

# ── Done ──────────────────────────────────────────────────────────────────────
echo ""
echo "Done. Open Claude Code and:"
echo "  1. Describe your feature in chat"
echo "  2. Run /new-request <name>"
echo "  3. /clear"
echo "  4. /run <name>"
