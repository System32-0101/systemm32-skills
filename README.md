# systemm32-skills

Agent skills by [Systemm32](https://github.com/System32-0101), for Claude Code and other agents that support the `SKILL.md` format.

## Skills

| Skill | What it does |
|---|---|
| [`p32-track`](skills/p32-track/SKILL.md) | Mirrors the coding work of a chat into a live P32 task: offers tracking when a dev task starts, picks the right teams, creates a well-written task, moves each team's subtask through the board as work advances, and attaches commits, PRs and progress comments. |
| [`p32-import`](skills/p32-import/SKILL.md) | Migrates a whole existing project into P32: analyzes the repo/docs, proposes a plan (teams, milestones, tasks with per-team subtasks), waits for confirmation, creates it all through the P32 MCP, then asks "¿Con qué continuamos?" (trámite, solicitud, revisión, invitar miembros, vincular repo…). |

## Install

```bash
pnpm dlx skills add System32-0101/systemm32-skills
```

or copy a folder from `skills/` into `~/.claude/skills/`.

## p32-track requirements

- The **P32 MCP server** connected to your agent (authorize it with `/mcp`). The skill uses its task, team, reference and comment tools. Without `split_task`, `add_task_reference` and `add_task_comment` it falls back to one task per team.
- Optional: a `SessionStart` hook that offers tracking automatically in repos already linked to P32. Copy [`hooks/session-start.sh`](skills/p32-track/hooks/session-start.sh) to `~/.claude/hooks/p32-track-session.sh` and register it in `~/.claude/settings.json`:

  ```json
  "hooks": {
    "SessionStart": [
      {
        "matcher": "startup|clear|resume",
        "hooks": [{ "type": "command", "command": "bash \"$HOME/.claude/hooks/p32-track-session.sh\"" }]
      }
    ]
  }
  ```

- Add `.claude/p32-track.state.json` to the `.gitignore` of repos where you use it (it holds the task currently tracked).

First time in a repo, run `/p32-track`: it links the repo to its P32 project and stores the mapping in `.claude/p32-track.json`.

## p32-import requirements

- The **P32 MCP server** connected to your agent with write access (`/mcp`). Run `/p32-import` inside the project you want to bring (repo, docs or notes); it never creates anything until you confirm the plan.

## License

MIT
