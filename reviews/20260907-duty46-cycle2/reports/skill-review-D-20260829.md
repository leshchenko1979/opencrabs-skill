# Skill review — Lens D (DELETION SAFETY), 2026-08-29, skill v0.4.39

Run by the SUPERVISOR directly (sub-agent skill-review-D failed twice with
phantom tool-call text; two-strike precedent from 2026-08-28 = supervisor
runs the lens itself). Method: enumerate stale-looking artifacts, grep
tools/ + tests/ + skill md files for readers/writers, classify
DELETE-SAFE / ARCHIVE / KEEP with the reference list as evidence.

## Verdicts

### KEEP (live — verified readers)
1. `deployed.sha` — read by oc-deploy, oc-attrib, oc-watchdog-check, tests/run.sh, SKILL.md.
2. `deployed.meta.json` — read by oc-deploy, oc-attrib, tests/run.sh, SKILL.md.
3. `fanout.state` — read/written by oc-deploy fanout, tests/run.sh, SKILL.md.
4. `oc-deploy/journal/` — append-only audit trail (journal law); read by oc-deploy poll/fanout.
5. `s2-swap-journal-spec.md` — referenced by live oc-deploy source; not stale.
6. `oc-deploy-shadow.log` — referenced by live oc-deploy + editor.md.
7. `backups/` dir + `tools/archive/` — the designated archive locations; contents are archived history (SKILL.md.pre0419, supervisor.md.pre0419, oc-consent-check).
8. `/root/.opencrabs/profiles/ops/opencrabs-dev/tools.log` — live unified log (v0.4.36).
9. `compiler.md` — retired role file, KEPT as archive by policy (v0.4.34/S3 decision).

### ARCHIVE (no live readers; rollback/historical value; move to backups/ or oc-work/archive/)
10. `tools/oc-deploy.2026-08-28T152108.bak` — v0.4.34-era snapshot; zero readers.
11. `tools/oc-deploy.2026-08-28T212439.bak` — same.
12. `tools/oc-deploy.2026-08-29T002950.bak` — same.
13. `tools/oc-deploy.2026-08-29T022237.bak` — pre-#24-fanout snapshot.
14. `tools/oc-deploy.2026-08-29T0232Z.post-issue24.bak` — post-#24 snapshot.
15. `tools/oc-deploy.2026-08-29T0734Z.pre-v0438.bak` — newest; KEEP-UNTIL-STABLE then ARCHIVE.
16. `tools/oc-deploy.pre-S2` — pre-S2 snapshot; zero live references (grep pre-S2 = empty).
17. `tools/oc-consent-check.pre-S2` — pre-S2 snapshot of a tool already archived in tools/archive/.
18. `SKILL.md.*.bak` x5, `editor.md.*.bak` x5, `compiler.md.2026-08-28T152108.bak` (loose in skill dir, 2026-08-28 15:21–15:26) — v0.4.34-batch snapshots; zero readers; move to backups/.
19. `/root/oc-work/skill-bak-20260829T0815Z/` (SKILL.md, editor.md, supervisor.md) — today's v0.4.39 batch backup; keep until next batch lands.
20. `/root/oc-work/*.md` batch docs + work dirs (kernel-cli-*, task-plan-issue23/24, s2-*, swap-design/runbook, issue24-*, order-*, fix-s2-*, carrier-fix/, fmt-*/, clippy-20260827/, clone.git) — completed-batch history; move to /root/oc-work/archive/ (exists).

### DELETE-SAFE (no readers, no rollback value, findings persisted elsewhere)
21. `tools/_probe` — 20 bytes, `echo hi`, 2026-08-26; zero references found.
22. `/tmp/skill-review-{A,B,C}-20260826.md` + `/tmp/skill-review-*-20260828*.md` (10 files) — mined: verdicts live in ledger provenance entries; /tmp is ephemeral by nature.
23. `/tmp/dbg-fetch.sh`, `/tmp/dbg-red.sh`, `/tmp/dbg-red2.sh` — disposable repro scripts (owner-marked disposable 2026-08-29).
24. `/root/oc-work` scratch scripts once archived: `classify*.sh/txt`, `delbatch-*`, `bpids*.txt`, `append-seq.py`, `clone.log`, `collisions.txt` — one-off sweep tooling of closed Aug-27 batches.

## Summary
24 artifacts classified: 9 KEEP, 11 ARCHIVE groups, 4 DELETE-SAFE groups.
Zero live readers on any backup file. Nothing deleted in this review —
deletions ride the mechanical batch after owner word.
