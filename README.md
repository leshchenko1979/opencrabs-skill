# opencrabs-dev

Operational skill for **OpenCrabs source work** on `~/opencrabs`: the fork
(`leshchenko1979/opencrabs`), upstream contact (`adolfousier/opencrabs`, PRs only),
CI carrier lanes, artifact builds, and binary swaps to `/usr/local/bin/opencrabs`.

Skill entry point: `SKILL.md` — invoked as `/opencrabs-dev`.
This README is the repo map; **SKILL.md is the law.** Where they disagree, SKILL.md wins.

## Layout

| Path | What it is |
|---|---|
| `SKILL.md` | Main entry: roles, hard rules, tool register, ship path, glossary |
| `editor.md` | EDITOR role procedure — Phases 0–7b (issue claim → worktree → edit → gate → commit → ship → upstream PR) |
| `supervisor.md` | SUPERVISOR role — worker roster, duty cadence, CI-wait & waiter discipline, review lenses |
| `review-lenses.md` | Full Duty-6 lens briefs (A–G) — split from supervisor.md v0.4.78 |
| `editor-phase7-rules.md` | Phase-7 reference rules disclosed from editor.md (v0.4.78) |
| `war-stories.md` | Incident histories behind the hard rules (disclosed from SKILL.md, v0.4.80) |
| `fleet-directives.md` | Binding owner directives (sync policy, PR law, builds, gates, triage) — re-homed from ops AGENTS.md/MEMORY.md, 2026-09-02 |
| `upstream-merge-runbook.md` | Procedure for the merge-on-arrival policy: gates, roles, conflict classes, migration-union rule |
| `s2-swap-journal-spec.md` | Journal vocabulary spec for the oc-deploy swap leg |
| `CHANGELOG.md` | Version history, **newest entry LAST** |
| `tools/` | The `oc-*` tool fleet (30 executables) + `lib/` + `tests/` |
| `tools/lib/` | Shared shell libs: `oc-log.sh` (journal + rc register + flood guard), `oc-embed.sh` (job-embed decoder) |
| `tools/RC-CONTRACT.md` | SOLE per-tool rc register: fleet conventions + verdict codes (v0.4.78) |
| `tools/tests/run.sh` | Battery: full selftest suite + coverage sections. Receipt → `tools/tests/battery-last.json` |
| `tools/archive/compiler.md` | ARCHIVED runbook for the retired COMPILER role (re-enable = load this file) |

## Roles

| Role | State | Runs |
|---|---|---|
| **EDITOR** | live | Fork issues, per-task worktrees, CI gates, signed commits, `oc-deploy ship`, upstream PRs |
| **SUPERVISOR** | live | Worker ledger, duty cadence, multi-lens code/structure reviews |
| **COMPILER** | **RETIRED 2026-08-28** (S3 cutover) | duties absorbed by `tools/oc-deploy` (ship / poll / swap-execute) |

## Tool fleet (quick index)

Full register with rc codes lives in **`tools/RC-CONTRACT.md`** — that file is the source of truth (v0.4.79; SKILL.md carries purpose rows only).
Highlights:

- `oc-deploy` — ship / poll / swap-execute / fanout (selftest 165 checks, v0.4.79)
- `oc-ledger` — worker ledger: claims, sync, version stamps, cadence
- `oc-prchecks` — CI-wait on `pr-checks.yml` (poll, resume-before-dispatch, lane gates)
- `oc-commit` / `oc-issue-log` — signed commits + tracked-issue receipts
- `oc-seal-state` — order rows (QUEUED…VOID lifecycle)
- `tests/run.sh` — run everything: `bash tools/tests/run.sh`

## Ship discipline (per version bump)

1. Edit → verify → commit (one logical change per commit, `Issue-Ref:` trailer).
2. Battery GREEN: `bash tools/tests/run.sh` → receipt reads `PASS`.
3. `CHANGELOG.md` gets a `## vX.Y.Z` entry (appended at the END).
4. Bump `version:` in `SKILL.md`, commit, tag `vX.Y.Z`.
5. `tools/oc-ledger sync --version X.Y.Z --why "..."` (gates on the battery receipt + changelog entry).
6. Push skill mirror (main + tag); state mirror parity sweep.

## Conventions

- **Bare `#N` is fork-issue space.** On any upstream surface, qualify: `leshchenko1979/opencrabs#N`.
- **CHANGELOG is newest-LAST.**
- **Every tool journals.** State changes write timestamped lines to `tools.log` via `oc-log.sh` before the next step; a run unreconstructable from durable state is not done.
- `battery-last.json` is committed on purpose — it is the durable ship receipt.

## Repo status

Mirrored to `leshchenko1979/opencrabs-skill` (pushed on owner word; state repo `leshchenko1979/opencrabs-dev-state`).
Current version: **`SKILL.md` frontmatter `version:`** — single source of truth, never stale (lens A M2, v0.4.79). Tag history: `git tag --list 'v0.4.*'`.
