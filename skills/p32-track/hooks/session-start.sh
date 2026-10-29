#!/usr/bin/env bash
# Optional SessionStart hook for the p32-track skill. Silent unless the repo is linked to P32
# (.claude/p32-track.json). Its stdout is added to the session context.
dir="${CLAUDE_PROJECT_DIR:-$PWD}/.claude"
[ -f "$dir/p32-track.json" ] || exit 0

if [ -f "$dir/p32-track.state.json" ] && grep -q '"taskId": *"[a-f0-9]\{24\}"' "$dir/p32-track.state.json"; then
  echo "P32 tracking is ACTIVE in this repo (.claude/p32-track.state.json). When the user continues that work, load the p32-track skill and keep updating the tracked task; do not offer tracking again."
else
  echo "This repo is linked to a P32 project (.claude/p32-track.json). When the user's first request in this chat is development work (build/fix/refactor code, not a question or a trivial tweak), load the p32-track skill BEFORE starting and ask whether to track the work in P32."
fi
