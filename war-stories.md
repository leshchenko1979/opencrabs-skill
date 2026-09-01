# War stories — incident histories behind the hard rules

Disclosed from SKILL.md §Shared war stories, v0.4.80 (lens B F6): history is
reference, not procedure — load only when a rule's WHY is in question.
Version-level record: CHANGELOG.md.

| Rule | Incident |
|------|----------|
| Inputs from branch YAML, verify headSha | run #4 dispatched blind; run #2 built main |
| Distrust watcher exit codes | watchers reported success on failed runs, 3× |
| Foreign-WIP diff vs merge-base | branch carried another agent's dropped WIP |
| User-unit awareness | system-scope queries found nothing; wrong restart path nearly used |
| Inner-match exhaustiveness | E0004 cost one full CI cycle (run #5 fixed it) |
| Build fork `main`, record headSha at dispatch | 2026-08-25: swapped a binary built from pre-merge `ebf44f69` while the session-notify merge (`10c73644`) landed on fork main mid-build — feature absent from the running bot |
| `source_ref` = FULL 40-char sha, never short | run #32882515561: short sha → checkout fetched a branch literally named `<sha>*`, dead in 51 s |
| Conflict-quality gate before push | run #32879949542: a hand-merge shipped E0308 red CI (full prose: `editor.md` Phase 6) |
| Rebase-port, never resurrect duplicates | 2026-08-26: maintainer absorbed 4 of our PRs overnight (#1207/#1208/#1214/flood-governors); a literal 40-commit rebase would have replayed duplicate implementations against his reviewed rework — classification dropped 20+, ported 9 |
| ORDER-era triggers + bounded ROLE_EXCEPTION | 2026-08-26 07:20 UTC: compiler authored the governor.rs E0308 fix while its author (61161247) slept through the owner's night window — a silent role breach. Now builds fire only via `oc-deploy ship` or owner word (sim-validated — sim = ORDER/queue simulation, paired-seed 600 reps, run 2026-08-26), and the breach is legal only as the bounded ROLE_EXCEPTION (archived: `tools/archive/compiler.md` Step 2) |
| Two-file ledger drift | 2026-08-29: `oc-deploy` default LEDGER hit a skill-dir copy while supervisor stamped canonical; the "stale duplicate" deletion proved LIVE (fresh swap stamp + fan-out reads) — restored in 6 min, zero data lost. Fix A (v0.4.38) points every tool at canonical; Reviewer D born from this |
| Telegram surface law | 2026-08-28 audit: ~1.3k telegram_send calls/day traced across lanes — every destination was the sender's own surface, but tool sends escaping the own topic read as board-wide broadcast |
| Live-API verdict settlement | 2026-08-26 cycle-18: run 32999957533 concluded failure while a Compiler ACK still called it in_progress — contradictory incoming verdicts settle via the live GH API, never memory |
| Daemon PID via MainPID | 2026-08-26 cycle-18: pgrep caught the old family daemon (Aug-25 boot) instead of the ops unit — disk-vs-proc split until MainPID settled it |
| Single-flight sha+set ordering | 2026-08-26: cycle-19 vs cycle-19b ordered the same sha with different sets — same sha, different set = DISTINCT build |

*Source of truth for procedure = these skill files. AGENTS.md carries only the pointer.*
