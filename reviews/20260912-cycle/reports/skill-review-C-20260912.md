Citations pinned, decoy settled, adoption-check scope established. Report follows.

---

# Duty-6 Skill Review — Lens C (CLI-AUTOMATION + USAGE GAPS)

**Cycle:** 20260912 · **Lens:** C (TOOLS family) · **Date:** 2026-09-12 · **Reviewer:** C — read-only (tool registry #1173: reads + search only; **no shell, no writes**)

## Scope actually covered

Corpus root: `/root/.opencrabs/profiles/ops/skills/opencrabs-dev/`

| File | Lines | Read how |
|---|---|---|
| `SKILL.md` | 555 | full (auto-injected by skill gate on first `tools/` touch) |
| `fleet-directives.md` | 651 | full (truncated at 50 kB) + ranged reads + section map |
| `editor.md` | 633 | full |
| `hq.md` | 317 | full |
| `triage.md` | 245 | full |
| `toolsmith.md` | 105 | full + `grep '^'` cross-check |
| `editor-upstream-pr.md` | 227 | full |
| `review-lenses.md` | 264 | full (C's own brief + all 11 lens briefs) |
| `tools/RC-CONTRACT.md` | 113 | full (several register rows arrive reader-truncated mid-row) |
| `tools/oc-*` | 42 scripts | **`ls` only — bodies NOT read** (Reviewer F's object) |
| state-dir `tools.log` | 17,207 | per-tool sweeps |
| state-dir `tmp/detached/` | ~300 `*.json` | **listed only — contents NOT read** (see scope limits) |

**Method note (disclosed, not papered over):** the brief says obtain line counts via `wc -l` — **not executable here**: this sub-agent has no shell. Counts came from the `read_file` length-probe (`start_line` out of range returns the tool's own `…exceeds file length N`). Post-compaction I re-verified *citations* by live `grep` this turn; every cited line number is ≤ its file's count (consistency check passes). The counts themselves were established earlier in this session and are not re-derived here (per the "a compaction summary is a snapshot, not live state" law — the work was done, not pending).

**Live-state corrections made this pass** (snapshot was stale on both): the usage log now holds **≥84** `oc-index-worktree` rows, not 61, and its newest row is **2026-09-09T19:28:24Z**, not 2026-09-06. See C-3.

---

## Findings

### C-1 — The smoke-verdict row is still "hand-typed" by law while the tool that appends it is already SANCTIONED (HIGH)

**(a) Severity:** HIGH — two same-day law statements contradict; one of them tells every lane to hand-type a path the tool already guarantees, which is the exact procedure that lost rows.

**(b) Law sites + verbatim quotes:**

`fleet-directives.md:27` (end of the QUIRK bullet):
> `oc-smoke-evidence` PRINTS a leg and never appends — the write is hand-typed, which is why the path must be copied, never resolved.

`fleet-directives.md:145`:
> the DRIVING lane appends its verdict to the smoke ledger file (`opencrabs-dev/smoke-verdicts.log` — the canonical state dir; `oc-smoke-evidence` prints the boilerplate row) in the SAME turn as the verdict

`tools/RC-CONTRACT.md:55` (`oc-smoke-evidence` register row), **same date**:
> **`--append-log <path>` (2026-09-12, defect #13, lane c10cd97b)**: the SANCTIONED append path for state smoke-verdicts.log — appends the evidence block newline-safely … plain shell `>>` is what glued c10cd97b's rows — do not use it · **M2-2 (2026-09-12, toolsmith)**: the path ARGUMENT is now optional and a WRONG path is unrepresentable — a bare `--append-log` targets the canonical ABSOLUTE `$STATE_DIR/smoke-verdicts.log` … (it used to land in the CALLER'S CWD — a decoy that looks right and holds none of the evidence; 2 rows lost)

Both statements are dated 2026-09-12. `fleet-directives.md:27` says the write is **hand-typed**; `RC-CONTRACT.md:55` says the write is **the SANCTIONED append path** and a wrong path is **unrepresentable**. The law was not retired when the tool changed — a pure **law-adoption gap**, C's exact class: a recurring multi-step manual ritual that is already one CLI command.

**(c) State/artifact:** `smoke-verdicts.log` (canonical state dir, 183,577 B) — gates upstream PR filing (`editor-upstream-pr.md` Phase 7c: "Never file unsmoked PRs") and the §Full-Gate Pre-PR Testing Law.

**(d) Cost already paid:** the law names it — **2 rows** silently captured by the decoy path (`c10cd97b 22:38:00Z`; `6cd8175f 09:09:39Z BLOCKED-INFRA`). Both were superseded in canonical, so net harm was zero; the *mechanism* is the defect, not the outcome.

**(e) Proposed remedy:** retire the hand-typed sentence in the same version batch, and have the law read: *the row is APPENDED by `oc-smoke-evidence --append-log` (bare = canonical absolute); a hand-typed row is a procedure violation.* Interface already exists:
```
oc-smoke-evidence --append-log          # bare → canonical $STATE_DIR/smoke-verdicts.log
```
**Boundary vs J:** object is a PROCEDURE (hand-typing into a path) → C, not J. ✅

---

### C-2 — Worktree removal is a follow-up the agent must *remember*, and no tool will do it (MED)

**(a) Severity:** MED — bounded blast radius (stale worktrees, disk, `oc-roster` liveness noise) but it recurs on **every** lane ship.

**(b) Law sites + verbatim quotes:**

`editor.md:497` (Phase 5, "Exit codes & Lane action"):
> - **Exit 0 — SWAPPED:** The new binary is running live on the host (`opencrabs-ops` user unit). Worktree can now be removed (`tools/oc-wt remove <task>`). Proceed immediately to Phase 6b (Smoke-test-on-notify).

`editor.md:617` (Phase 6c step 4, fenced):
> `# 4. on exit 0 SWAPPED, remove the worktree — job done`

`editor.md:357` (Phase 2 lifecycle):
> `DELETE immediately after a verified clean push:`

`tools/RC-CONTRACT.md:34` (`oc-health` row — the fleet's own carve-out):
> worktrees are NEVER auto-removed (`oc-wt remove` has a dirty-tree gate a sweep must not bypass)

The chain knows its terminal verdict (rc 0 SWAPPED); the removal is assigned to agent memory; the one tool that sweeps stale state explicitly refuses to touch worktrees. So nobody deletes them.

**(c) State/artifact:** per-task worktrees `~/oc-wt-*` + the `oc-wt` registry. `oc-roster` reads worktree dirty state as a LIVENESS signal (`tools/RC-CONTRACT.md` `oc-roster` row: "joins ledger `events[kind=claim]` (INTENT) + `oc-wt list` dirty (EVIDENCE) + session-DB liveness"), so a leaked worktree pollutes classification.

**(d) Cost:** `unpriced` — no incident cited in law; the `oc-health` carve-out shows the gap was noticed and deliberately deferred.

**(e) Proposed remedy:** make the terminal state the trigger.
```
oc-ship-chain --sha <S> --branch <B> --rm-worktree <task>    # default ON at the SWAPPED tail
```
or a new `oc-wt gc --merged` (sweeps worktrees whose branch is contained in `origin/main` **and** whose tree is clean — keeps the dirty-tree gate inside `oc-wt`, where it lives).

**Boundary vs E (flagged, not fought):** `oc-ship-chain` → `oc-wt remove` is also an *interface chain* (E's object). C's claim is the PROCEDURE (a remembered follow-up); E's would be the INTERFACE (two tools that always run in sequence). If HQ wants one home, E's brief wins on chainable interfaces, C's on manual-ritual-becomes-one-command. **Boundary vs J:** procedure, not a state-derivable decision → C. ✅

---

### C-3 — `oc-index-worktree` is law-orphaned but still registered (MED — YAGNI evidence, handed to Reviewer D)

**(a) Severity:** MED as YAGNI evidence for Reviewer D; C does not own the DELETE/KEEP verdict.

**(b) Law sites + verbatim quotes:**

`fleet-directives.md:643` / `:646`:
> ## Code-Structure Exploration & Scoutgraph Indexing Law (v0.4.143)
> - **Per-worktree `.codegraph` indexing is RETIRED**: Worktrees do NOT run `oc-index-worktree` or maintain separate `.codegraph.db` SQLite instances.

`editor.md:328`:
> `# Per-worktree indexing is RETIRED (v0.4.143): code-structure exploration is handled`

`tools/RC-CONTRACT.md:35` and `:60` — the tool and its rc arm are still registered live:
> | oc-index-worktree | 0 | 5 | 0 OK / 4 index-failed |
> | oc-wt | 0 | 2 | 0 ok / 3 path-exists-dirty / 4 index-failed / 5 repo-branch-missing / 6 behind-base |

**(c) Artifact:** `tools/oc-index-worktree` + its register rows + `oc-wt`'s rc-4 arm.

**(d) Usage-log evidence (live, this turn):** newest invocation in `tools.log` —
```
{"ts":"2026-09-09T19:28:24Z","tool":"oc-index-worktree","actor":"1a63f103-b899-4ad2-a5b3-c89f2902bf97","args":"/root/oc-wt-119-fold-num","exit":0,"secs":36.3,"extra":{}}
```
(tools.log:6781) — i.e. no invocation in the ~3 days to the review date, and the law retired the tool's purpose at v0.4.143. Cost: `unpriced`. Runtime cost while live was high (`secs` 35–133 s/call).
**Honest caveat on the count:** the limit-70 sweep reported "70 matches shown, 71 total", but a 2026-09-06→09-09 window sweep returned **29** rows, **14 of them past the 70th** — so the file holds **≥84** rows and the tool's own "total" field is **not** a true count. I assert no exact total. (This is the "a count taken by a pattern is not a count of items" family.)

**(e) Remedy:** hand to Reviewer D as YAGNI evidence. The *script* is a DELETE-SAFE candidate after D's reference grep; the *register rows* are stale doc surface and should be marked RETIRED with a date regardless.
**Do not over-read a zero:** `oc-roster-selftest` has **0** rows in `tools.log` — that is EXPECTED (selftest invocations are suppressed by design), not evidence.

---

### C-4 — The two-remote push ritual is one action dressed as two (LOW — one line, may be J-adjacent)

`tools/RC-CONTRACT.md:64` / `:66` / `:75`:
> ## Remote topology — `mirror2` and `origin` are ONE repository (verified 2026-09-12)
> The "push `mirror2` first, then `origin`" ritual buys **no redundancy**.
> after `git push mirror2 main` succeeded, `git push origin main` reported **"Everything up-to-date"**

with `fleet-directives.md:22`: "the skill repo's canonical push remote is `mirror2`". The ritual is a recurring multi-step procedure that collapses to one command (or one push), but the law consciously keeps it ("the push order still stands as process"), and retiring a sentence is law-text-shaped. Cost: `unpriced`. **C's honest read: file LOW, do not press** — collapse to `oc-skill-push` *or* drop the second push from the ritual text; J may claim the sentence-retirement half.

---

## What I checked and found CLEAN

- **`oc-waiter` retirement is correctly recorded.** `tools/RC-CONTRACT.md:59`: *"RETIRED in v0.4.135: replaced by native detached bash execution (background: true); --help returns 0, subcommands return 1"* — retired tool, retired interface.
- **The smoke-log decoy self-heals.** Verified live this turn: `/root/.opencrabs/profiles/ops/smoke-verdicts.log` and the canonical `…/opencrabs-dev/smoke-verdicts.log` return an **identical first line** — consistent with the law's "old path now SYMLINKS to canonical" claim (`fleet-directives.md:27`). A wrong-path write now lands in canonical instead of being lost.
- **`oc-health --reap`'s worktree carve-out is deliberate and documented** (`RC-CONTRACT.md:34`) — the gap is known, not accidental (it is C-2's remedy target, not a fresh defect).
- **C's usage-log duty** produced ground truth no prose review can: per-tool rc distributions, the `oc-index-worktree` orphan (C-3), and the corrected counts above.

## What I did NOT check (scope limits)

- **`tools/oc-*` bodies** — not read (Reviewer F's object). C reviewed *procedures* + the *usage log*, not implementations.
- **`CHANGELOG.md`** (192,687 B) — grepped only; **`war-stories.md`**, **`s2-swap-journal-spec.md`**, **`upstream-merge-runbook.md`**, **`editor-phase7-rules.md`**, **`README.md`** — length-probed only, not read in full.
- **`workers-ledger.json`** (1.3 MB) — existence/size only, no row-level read (Reviewer H's object).
- **`oc-deploy/journal/*.jsonl`** — not read.
- **ADOPTION-COMPLIANCE CHECK — INCOMPLETE, reported as such (not as clean).** The check requires reading `tmp/detached/*.json` (the registry `oc-watcher-audit` scans) and flagging any `gh run watch` / hand-rolled `nohup` CI poller / `oc-prchecks --wait`-as-verdict-waiter. `oc-watcher-audit` is a **CLI I cannot run** (no shell in this registry). I **listed** `tmp/detached/` (~300 `*.json`) but read **none**, so I cannot certify the one-watcher law for this pass.

**Brief defect (staleness — Reviewer I owns brief correctness; flagged here because it is C-adjacent):** C's brief prescribes *"official surfaces are `oc-waiter arm` and one-shot `gh run view`"* — but `oc-waiter` is **RETIRED** (`RC-CONTRACT.md:59`). The brief names a dead surface. The live official surfaces are native detached execution (`background: true`) and one-shot `gh run view`, with `oc-prchecks wait` for the blocking gate. The brief's adoption-check clause needs the same v0.4.135 correction.

---

*No files were created, edited, or deleted. Nothing is uncommitted; nothing needs reverting. All quotes above were read from the named files in this session.*
