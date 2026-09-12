*Bwoop.* Corpus read, nine findings banked, all line-cites re-pinned this turn. Emitting the deliverable.

---

# Skill-review report — Reviewer G (ROLE-FILE STRUCTURE / DOCS family)

**Lens:** G · **Cycle:** 20260912 · **Date:** 2026-09-12 · **Session role:** READ-ONLY reviewer (Duty-6)
**Skill root:** `/root/.opencrabs/profiles/ops/skills/opencrabs-dev/` · **Skill version at review time:** `SKILL.md` frontmatter `version: 0.4.162`
**Persisted path (proposed):** `reviews/20260912-cycle/reports/skill-review-G-20260912.md`

## Method note (read-restricted registry, #1173 — no shell)

This session had no shell: `wc -l` and `bash` were unavailable. Line counts were derived by two tool-native means, and the method is stated per file:
1. `grep` with `regex:true`, `pattern:"^"`, `limit:3000` — the **last** reported `file:LINE:` number is the count (footers that read `(N shown, M total)` under a limit are NOT counts — a `limit:1` run reported "(1 matches shown, 2 total)" for a 317-line file);
2. `read_file` with a deliberately out-of-range `start_line` — the error message reports the true file length (e.g. `Start line 100000 exceeds file length 633`).

The two methods were used interchangeably and agree where both were applied. No count below is estimated.

---

## Scope actually covered

### Files read in full or substantially, with verified counts

| File | Count | Method / notes |
|---|---|---|
| `SKILL.md` | **555** | grep last-line. Full body also obtained via skill-gate injection. Census at **L463-471**. |
| `fleet-directives.md` | **651** | `read_file` length error. **Body NOT read** (grep-truncated at 50000 B twice). Headers only. |
| `editor.md` | **633** | `read_file` length error. Heading map + targeted regions read; body past L370 truncated on whole-file grep. |
| `hq.md` | **317** | grep last-line. |
| `triage.md` | **245** | grep last-line. |
| `toolsmith.md` | **105** | grep last-line. |
| `README.md` | **76** | grep last-line. |
| `review-lenses.md` | **264** | grep last-line. |
| `editor-upstream-pr.md` | **227** | grep last-line. |
| `editor-phase7-rules.md` | **33** | grep last-line. Read in full. |
| `CHANGELOG.md` | **887** | `read_file` length error. **Body NOT read**; grep hits only. |
| `tools/RC-CONTRACT.md` | **113** | `read_file` length error. Body read (small). |
| `tools/HEALTH-CHECKS.md` | **187** | grep last-line. Read in full. |
| `tools/HEALTH-CLASSES.md` | **174** | grep last-line. Read in full. |
| `reviews/20260912-cycle/verdict-table.md` | read in full | Reviewer I's META-REVIEW — see "already owned elsewhere". |
| `reviews/20260912-cycle/reports/` | dir listing | `skill-review-I-20260912.md`, `skill-review-index.log` → G's canonical sibling name is `skill-review-G-20260912.md`. |
| `tools/` | dir listing | **39 `oc-*` executables** enumerated, plus `HEALTH-CHECKS.md`, `HEALTH-CLASSES.md`, `RC-CONTRACT.md`, dirs `archive/ lib/ tests/`. |
| `tools/oc-health` | targeted greps | Confirms its spec citation (see F7). |

**Object list re-derived at spawn time per G's own rule** (count not hardcoded — lens G-F8 v0.4.89): root `.md` files = CHANGELOG, README, SKILL, editor-phase7-rules, editor-upstream-pr, editor, fleet-directives, hq, review-lenses, s2-swap-journal-spec, toolsmith, triage, upstream-merge-runbook, war-stories (**14**), plus subdirs `reviews/ run/ tools/`.

---

## Findings

### F1 — MED — The single-writer census is provably incomplete (3 real skill files absent)

**(a) Severity:** MED — real gap, bounded blast radius (the census is the authority for "who may write", and it silently excludes three existing files).

**(b) Law site:** `SKILL.md:463-466`, verbatim:

```
- ONLY HQ edits skill files — census (G7, v0.4.84; `triage.md` added v0.4.86; `toolsmith.md` added + `tools/**` carve-out v0.4.87; `README.md` + `tools/RC-CONTRACT.md` added v0.4.96, lens A15; `CHANGELOG.md` added v0.4.116, lens G-9): `SKILL.md` /
  `editor.md` / `hq.md` / `triage.md` / `toolsmith.md` / `review-lenses.md` / `fleet-directives.md` /
  `upstream-merge-runbook.md` / `editor-phase7-rules.md` / `war-stories.md` /
  `s2-swap-journal-spec.md` / `README.md` / `CHANGELOG.md` / `tools/RC-CONTRACT.md` — including all worker lanes AND the TRIAGE lane AND the TOOLSMITH lane (decision 7,
```

**(c) State/artifact:** the census enumerates **14 paths** (counted by reading the list, not by pattern). The skill tree holds **14 root `.md` files** (enumerated above) plus **3 `tools/*.md` pages**. The census covers 13 root files + `tools/RC-CONTRACT.md`. **Absent: `editor-upstream-pr.md`, `tools/HEALTH-CHECKS.md`, `tools/HEALTH-CLASSES.md`.**

- `editor-upstream-pr.md` line 1 reads verbatim: `# Editor upstream PR procedure — Phase 7 + 7b (split from editor.md, v0.4.131)`. The census was edited **twice since** (v0.4.96 → README/RC-CONTRACT; v0.4.116 → CHANGELOG) and never absorbed it. `SKILL.md`'s own §Upstream relations table cites it (row 4: `| **4. Upstream PR Lifecycle** | Editor | Phase 7b / Phase 7c (\`oc-harvest-dispatch\`) | \`editor-upstream-pr.md\` |`) — so the census contradicts another line of the same file.
- The two HEALTH pages were created **2026-09-12 16:28** (hours before this cycle) and are cited from `tools/RC-CONTRACT.md:34` and `tools/oc-health:5`, but from **no role file**.

**(d) Cost:** `unpriced` — no incident or ledger row located this session.

**(e) Remedy:** extend the census list with `editor-upstream-pr.md` + `tools/HEALTH-CHECKS.md` + `tools/HEALTH-CLASSES.md`. **Prefer the mechanical half** (owner order 2026-09-12, "that should be purely mechanical"): the census is a set-derivable fact (`ls *.md` + `ls tools/*.md` vs the list) — a lens-J-class candidate for a lint that fails when a skill `.md` is absent from the census, so this class cannot recur by forgetfulness.

---

### F2 — LOW–MED — `editor-phase7-rules.md`'s load trigger points at a heading that no longer holds the rule

**(a) Severity:** LOW–MED — the pointer's target name is wrong; reachability survives (mitigated), so blast radius is a confusing load path, not a lost rule.

**(b) Law site:** `editor-phase7-rules.md:1-6`, verbatim:

```
# editor-phase7-rules.md — Phase 7 reference rules (B12 split, v0.4.78)

Reference detail behind editor.md §Phase 7 (progressive disclosure — reviewer
G, Duty-6 2026-09-01: in-skill steps stay inline, load-bearing reference moves
here behind a one-line pointer). Load when harvesting onto an upstream base
or writing text for upstream surfaces (Note: PR-FREEZE law in editor-upstream-pr.md
```

**(c) State/artifact:** `editor.md:622` now reads `## Phase 7 + 7b — upstream PR → \`editor-upstream-pr.md\`` — i.e. `editor.md`'s Phase-7 heading is a **forwarding pointer**; the Phase-7 law lives in `editor-upstream-pr.md` (split at v0.4.131). The load path this file names (`editor.md §Phase 7`) no longer holds the rule.

**Mitigating fact (state plainly):** the file is **not orphaned** — `editor-upstream-pr.md:127` (`Full checklist: \`editor-phase7-rules.md\` (same dir).`) and `editor-upstream-pr.md:145` (`Incident + rationale: \`editor-phase7-rules.md\`.`) both cite it, so the new home points at it correctly. The defect is the **one-way pointer's target name**, not reachability.

**(d) Cost:** `unpriced`.

**(e) Remedy:** one-line edit to `editor-phase7-rules.md:3` — retarget the load trigger to `editor-upstream-pr.md §Phase 7`. (Read-only: proposed, not made.)

---

### F3 — LOW — `SKILL.md` cites a heading that does not exist (`editor.md` §Ship)

**(a) Severity:** LOW — nit; a dangling cross-reference, no operational consequence.

**(b) Law site:** `SKILL.md:91`, verbatim:

```
| `./tools/oc-deploy <mode>` | the ship path itself — `ship` / `poll` / `swap-execute` / `status [--json]` / `watch [--with-delta]` / `fanout` / `contributors` RETIRED (use `oc-attrib --contributors`). Editor S3 path: `editor.md` §Ship. Verdict codes + wait semantics: RC-CONTRACT.md |
```

**(c) State/artifact:** `editor.md` contains **no heading** matching `§Ship`. The real heading is `## Phase 5 — Ship (\`oc-ship-chain\`)` at `editor.md:460`.

**(d) Cost:** `unpriced`. **Prior-cycle history:** the same class was filed by lens G on 2026-09-01 as finding #11 against the old heading "§Phase 6a — Ship — oc-deploy (S3 path)" — i.e. **never fixed, re-shelved by a rename** (the v0.4.132 ship-sediment collapse renamed the heading).

**(e) Remedy:** retarget to `editor.md` §Phase 5.

---

### F4 — LOW — Phase numbering has a hole (no Phase 6, no Phase 6a)

**(a) Severity:** LOW — nit (navigational), unless the dead names are read as live law.

**(b) Law sites** (`editor.md` header map, verbatim headings with line numbers, read this session):

```
editor.md:460  ## Phase 5 — Ship (`oc-ship-chain`)
editor.md:485  ### Failure Modes, Tool Automations & Agent Recovery Protocol (v0.4.145)
editor.md:520  ## Phase 6b — Smoke-test-on-notify (your features, after any swap)
editor.md:594  ## Phase 6c — Fix request from a RED run (red build or failed smoke)
editor.md:622  ## Phase 7 + 7b — upstream PR → `editor-upstream-pr.md`
editor.md:630  ## CI Watcher Discipline & Throttling (v0.4.143)
```

**(c) State/artifact:** `CHANGELOG.md` records the collapse ("SHIP SEDIMENT COLLAPSE: editor.md Phase 5, Phase 6, and Phase 6a collapsed into a single, authoritative Phase 5 — Ship (`oc-ship-chain`)"). Two live tool comments still reference the dead names: `tools/oc-deploy:2660` ("# F-1 fusion (v0.4.97, editor.md Phase 6a lens E promise): --wait N on an") and `tools/oc-deploy:2794` ("# dispatched — editor.md Phase 6a lens E F-1 promise.").

**(d) Cost:** `unpriced`.

**(e) Remedy:** either renumber 6b/6c → 6/7 (expensive: cross-refs) **or** add a one-line tombstone at the top of the phase run explaining the gap — **preferred, the cheaper ladder move first** (per the G brief).

---

### F5 — MED — Tool-count drift: two live law files disagree by 9

**(a) Severity:** MED — a reader cannot tell how many tools exist from the corpus; both numbers are stated as fact.

**(b) Law sites, verbatim:**

- `editor.md:175` — `   the role-DAILY subset, not the inventory — the full tool list (38 tools)`
- `editor.md:233` — `inventory, all 38 tools) + SKILL.md tool table. The`
- `README.md:24` — `| \`tools/\` | The \`oc-*\` tool fleet (29 executables) + \`lib/\` + \`tests/\` |`
- `README.md:55` — `  29 executables in \`tools/\` (31 − \`oc-toolaccum\` v0.4.110 − \`oc-ci-parity\` v0.4.117; owner-ordered additions 2026-09-01) — full inventory in \`tools/RC-CONTRACT.md\`.`

**(c) State/artifact:** `README.md` was last modified 2026-09-12 12:13 and still says 29; `editor.md` says 38. **Disk enumeration this session (`ls tools/`) listed 39 `oc-*` names.** Under either reading `README.md` is stale. The two counts disagree; I state both and the method rather than publishing a single exact disk number.

**(d) Cost:** `unpriced`. **Prior-cycle history:** `reviews/20260910-cycle/reports/skill-review-A-20260910.md:175` already flagged this class.

**(e) Remedy:** reconcile to one source — `tools/RC-CONTRACT.md` is the SOLE register, so both `editor.md` and `README.md` should carry a pointer, not a number (or a mechanically-derived count).

**Boundary note:** enumeration consistency is **lens A's** checklist item (d) per `review-lenses.md:31` — A holds first-finder claim if A filed it. G's angle is the **cross-file reference integrity**: README points at a count its own sibling file contradicts.

---

### F6 — LOW — `README.md`'s layout table is missing three files and carries a stale phase range

**(a) Severity:** LOW — nit (README is a map, not law), but it is the first thing a new reader opens.

**(b) Law site:** `README.md:12-28` layout table (rows: `SKILL.md`, `editor.md`, `hq.md`, `review-lenses.md`, `editor-phase7-rules.md`, `war-stories.md`, `fleet-directives.md`, `upstream-merge-runbook.md`, `s2-swap-journal-spec.md`, `CHANGELOG.md`, `tools/`, `tools/lib/`, `tools/RC-CONTRACT.md`, `tools/tests/run.sh`, `tools/archive/compiler.md`).

**(c) State/artifact:** **no row** for `editor-upstream-pr.md` (a root-level role-file sibling, split v0.4.131 — confirmed absent: a directory-wide grep for `editor-upstream-pr` returned hits in `editor.md`, `SKILL.md`, `CHANGELOG.md` and `reviews/*`, **zero in `README.md`**) and **no rows** for `tools/HEALTH-CHECKS.md` / `tools/HEALTH-CLASSES.md`. Additionally `README.md:15` reads verbatim: `| \`editor.md\` | EDITOR role procedure — Phases 0–7b (issue claim → worktree → edit → gate → commit → ship → upstream PR) |` — stale: Phases 7/7b/7c now live in `editor-upstream-pr.md`, and Phase 7c is not covered by "0–7b".

**(d) Cost:** `unpriced`.

**(e) Remedy:** add the three rows; correct the phase range. (`README.md`'s tool-fleet section is toolsmith-writable per the v0.4.87 carve-out; the rest is HQ-only.)

---

### F7 — LOW–MED — Two Toolsmith-owned spec pages are disclosed by no role file (LOAD-PATH MANDATE, inverse case)

**(a) Severity:** LOW–MED — the files are reachable from tool surfaces, but the role that owns them never names them; the load path a Toolsmith actually walks misses its own spec.

**(b) Law sites, verbatim:**

- `tools/HEALTH-CHECKS.md:3-5` — `**Owner order 2026-09-11.** Toolsmith owns the cleanup/health process. This file is the operational runbook and remediation catalog mechanized by \`tools/oc-health\` (see \`tools/HEALTH-CLASSES.md\` for the 8-class architecture and CLI contract).`
- `tools/HEALTH-CLASSES.md:3-5` — `**Owner order 2026-09-11.** Toolsmith owns the cleanup/health process. This document defines the 8-class rotating system object health catalog, mechanized by \`tools/oc-health\`.`

**(c) State/artifact:** both are reachable from `tools/RC-CONTRACT.md:34` and `tools/oc-health:5` — but **NOT** from `SKILL.md`, `README.md`, `hq.md`, `triage.md`, `toolsmith.md`, or `fleet-directives.md`. `toolsmith.md` (the lane that owns cron health / cleanup — `toolsmith.md:33-38`, "**Cron liveness audit ownership:**") never names them.

**LOAD-PATH MANDATE quote (the rule this violates):** *"nothing a role loads by habit (HQ duties, editor phases) lands only in a file that role never opens"* — here the inverse: a Toolsmith-owned spec page the Toolsmith's own role file never opens.

**(d) Cost:** `unpriced`.

**(e) Remedy:** one-line pointer in `toolsmith.md` §Duty TM1 (beside the cron-liveness bullet).

**CRITICAL METHOD NOTE carried into this report:** my first pass used the literal-mode alternation `HEALTH-CHECKS|HEALTH-CLASSES` and got **"No matches found"** — a FALSE NEGATIVE. The single pattern `HEALTH` then found plenty. This is the exact trap lens D documented (`reviews/20260907-duty46-cycle2/reports/skill-review-D2-20260907.md:2`): *"Future lenses: treat zero-hit claims from |-pattern greps as unverified."* → **every negative-existence claim in this report quotes its query and scope.**

---

### F8 — MED — `toolsmith.md` carries pre-Direct-Dispatch routing law that the rest of the corpus retired

**(a) Severity:** MED — a lane reading only its own role file would route core daemon defects through a retired relay hop.

**(b) Law sites, verbatim:**

- `toolsmith.md:25` — `- **Daemon Source & Builds:** Daemon source (\`~/opencrabs\`), carrier dispatches, and binary swaps belong strictly to Editor lanes. Daemon defects leave as \`QUIRK:\`/\`IDEA:\` items to Triage.`
- `toolsmith.md:52-53` — `1. ROUTED fix from the TRIAGE lane (\`QUIRK:\` verdict naming this lane) —` / `   execute the fix with test evidence, report back to TRIAGE + reporter.`

**Contradicting live law (quoted):**

- `editor.md:70-75` — `- Tool PROBLEMS (QUIRK:) → the active **TOOLSMITH** lane directly (v0.4.130 Direct Dispatch Law; v0.4.133):` … `Core daemon bugs go directly to GitHub fork issues.`
- `triage.md:60-63` — `**Scope note (owner order 2026-09-10 ~02:4xZ & 14:3xZ, fleet-directives §Direct dispatch):** Triage` / `is an AUDITOR, not a relay hub. Direct dispatch mandates that workers report tool anomalies directly` / `to the active **TOOLSMITH** lane … while core anomalies are filed directly as GitHub fork issues. Triage does NOT relay quirk tickets.`
- ops `AGENTS.md` §Tool anomaly routing — `Report tool-use anomalies in \`tools/oc-*\` … directly to the active **Toolsmith** role via \`session_notify\` … — never relay through Triage or HQ.`

**(c) State/artifact:** a Toolsmith lane reading only its own role file would route core daemon defects **through Triage** — the relay hop the Direct Dispatch law (v0.4.130/133, fleet-directives §Direct dispatch, "no relay hops") retired. `toolsmith.md:24` (skill-documentation → `IDEA:` to Triage) is **CONSISTENT** with live law (`editor.md:63-65`, `triage.md` §Duty T1) — do NOT flag that line.

**(d) Cost:** `unpriced`.

**Boundary note:** stale-ref/routing staleness may also be claimed by lens A (first finder gets attribution — `review-lenses.md:22`). Stated honestly.

**(e) Remedy:** rewrite `toolsmith.md:25`'s routing clause to the direct-dispatch form (core daemon/carrier defects → GitHub fork issues, or route to an editor lane directly; `tools/oc-*` quirks → this lane). Optionally re-word `toolsmith.md:52` intake shape 1 to "direct dispatch from a worker lane (or Triage audit referral)".

---

### F9 — LOW — `SKILL.md`'s `oc-health` row understates the interface `tools/HEALTH-CLASSES.md` defines

**(a) Severity:** LOW — presentation/consistency nit; the register is `RC-CONTRACT.md`, which is correct.

**(b) Law sites, verbatim:**

- `SKILL.md` tool table — `| \`./tools/oc-health [--json|--summary]\` | daily & pre-flight health audit of worktrees, watchers, and cron consistency |`
- `tools/HEALTH-CLASSES.md:153` — `oc-health [--class <name>|--all] [--rotate] [--status] [--reap] [--json] [--quiet] [--selftest]`

**(c) State/artifact:** the `SKILL.md` row omits `--selftest` (the battery-relevant flag), `--reap` (the only remediating flag), `--rotate`, `--class`, `--status`. Note `SKILL.md` rows are declared "purpose only" and `tools/RC-CONTRACT.md` is the SOLE register (and it *does* carry the full flag set) — so this is a **presentation/consistency** nit, not a missing register.

**(d) Cost:** `unpriced`. **Boundary:** F (tool code) / A (enumeration) may hold first-finder.

**(e) Remedy:** none required (the register is complete); if tightened, collapse the `SKILL.md` row to purpose-only with a pointer.

---

## What I checked and found CLEAN

1. **`hq.md` Duty 2 → `triage.md` §Duty T6 pointer resolves; no restatement.** `hq.md:63-67` verbatim: `**Ownership only — full schema, write rules, and seed law live in triage.md §Duty T6** (lens B-F10 v0.4.96 cross-role move; A-M1 v0.4.116 pointer collapse — this file no longer restates the field list).` — and `triage.md:178` `## Duty T6 — Registry writes: schema + seed rules (moved from hq.md Duty 2, lens B-F10 v0.4.96)` exists with the schema. ✅
2. **RELOAD LAW present and role-correct in all four role files (4/4).** `editor.md:5-11` (`> **RELOAD LAW (v0.4.96, lens B-F2/G-5):** after ANY context compaction or` / `> session spawn — not only at claim time (Phase 1 step 0) — re-read from disk,` / `> IN FULL: \`SKILL.md\` + this file + \`fleet-directives.md\``), `hq.md:3-8`, `triage.md:3-7` (`**RELOAD LAW (v0.4.95, owner order 2026-09-07 19:47Z):** after compaction or spawn, re-read from disk: \`SKILL.md\` + \`triage.md\` + \`fleet-directives.md\``), `toolsmith.md:3-8`. The prior cycle's G-5 fix is in place. ✅
3. **`editor-upstream-pr.md` is a clean on-demand split with an intact load path.** Header `editor-upstream-pr.md:3-5` verbatim: `> Single home for the upstream-PR phases. Loaded ON DEMAND when a feature` / `> reaches COMPLETE (Phase 7 trigger) or an owned PR needs lifecycle action` / `> (Phase 7b) — NOT part of the every-reload editor.md.` — and `editor.md:622` correctly points at it. Deliberate exclusion from the every-reload set is consistent, not a gap. ✅
4. **`editor.md`'s phase ORDER matches the actual work sequence:** 0 fresh base (L258) → 1 claim (L275) → 2 worktree (L323) → 3 explore (L384) → 4 shape (L398) → 5 ship (L460) → 6b smoke (L520) → 6c fix (L594) → 7 PR (L622). ✅
5. **`toolsmith.md` structure:** boundaries (L21) → duties TM1 (L29) / TM2 (L81) → escalation (L91). Ordering sound. ✅
6. **`triage.md` T1→T7 ordering sound:** intake (T1, L33) → tool-anomaly audit (T2, L58) → editor creation (T3, L70) → patrols (T4, L78) → issue sweep (T5, L130) → registry (T6, L178) → rollcall (T7, L200) → escalation (L233). ✅
7. **`SKILL.md` §-map is router-shaped** (STEP ZERO → canonical tooling → unified tools log → session-notify loop → notify mechanics → Telegram surface law → test ontology → glossary → red-run heuristics → shared env facts → upstream relations → hard rules → war-stories pointer) — consistent with the **SKILL.md BUDGET RULE** at `review-lenses.md:203-209` ("SKILL.md is the always-loaded router — every line costs 4x … RC-CONTRACT.md = SOLE tool register"). ✅
8. **`tools/RC-CONTRACT.md` §Remote topology (L64) and §Unified tools log (L86)** are correctly homed there — the latter's own header records the move: `## Unified tools log (moved from SKILL.md v0.4.131)` — and `SKILL.md` points at it rather than restating ("Every tool in `tools/` appends ONE JSONL line on exit … Path, schema, suppression rules, and verified jq recipes: `tools/RC-CONTRACT.md` §Unified tools log."). ✅
9. **`tools/HEALTH-CHECKS.md` / `tools/HEALTH-CLASSES.md` are NOT orphans in the absolute sense** — cited from `tools/RC-CONTRACT.md:34` and `tools/oc-health:5`. (F7 is about **role-file** load paths only.) ✅

---

## Already owned elsewhere — NOT re-filed (boundary discipline)

- **`SKILL.md:51` reads "ten-lens skill review … = ELEVEN reviewers"** — already filed by Reviewer I as **I-6.2** in `reviews/20260912-cycle/verdict-table.md` (ACCEPTED, fix held for the next version batch). G does not duplicate.
- **Review-corpus coverage counting / cycle-closing artifacts** — **I-6.1** (corrected) + **I-6.2**. Not G's.
- **Reviewer J ↔ ARTIFACTS (D/H) boundary clause** — **I-7.1**.
- **brain-scrub brief living in `fleet-directives.md`** — **I-7.2** (KERNEL, deliberate).
- **`oc-ship-audit` FALSE ORPHANS from `oc-deploy` selftest contamination** — `verdict-table.md §5.4`, already dispatched to Toolsmith (F-family, not G).

## One G-side observation worth a line

`reviews/20260912-cycle/verdict-table.md` (Reviewer I's own correction table) lists `review-lenses.md` as **255** lines; the file measured **264** lines this session — the correction table is itself stale by 9 (Reviewer J's brief, added v0.4.161, grew it). This *supports* the verdict table's own lesson verbatim: *"the corpus table's counts are themselves evidence and must be tool-read, not estimated."* Also `SKILL.md` measured **555** here vs the verdict table's **554** — a 1-line discrepancy; both numbers and the method are stated rather than asserting one.

---

## What I did NOT check (scope limits)

- **`fleet-directives.md` body** — headers mapped (67 `##`/`###`); body not read (grep truncated at 50000 B twice, and the skill-gate interception swallowed one grep result).
- **`CHANGELOG.md` body** — grep hits only.
- **`editor.md` full body** — whole-file grep truncated at 50000 B after ~L370; regions past that read only by targeted greps. Full count (633) obtained via `read_file` length error, not by reading every line.
- **`war-stories.md`**, **`s2-swap-journal-spec.md`**, **`upstream-merge-runbook.md`**, **`tools/archive/compiler.md`** — not read this session.
- **The `tools/` shell code** (39 executables) — only `tools/oc-health` (targeted greps) and `tools/oc-deploy:2660/:2794` (grep hits for F4) were touched. No tool logic reviewed.
- **The full `[LANE]`-tag census across all four role files** — not swept (would be lens B territory in part).
- **Prior-cycle reports** other than the two cited (`skill-review-D2-20260907`, `skill-review-A-20260910`).
- **No brain files pre-injected**; `load_brain_file` was not consulted — conventions were taken from the corpus itself (`SKILL.md` §Hard rules, `review-lenses.md`).

---

## Assumption stated (headless session)

Per the spawn prompt, this session had no answer channel; the one reasonable assumption made is that the report's **canonical name/path is `reviews/20260912-cycle/reports/skill-review-G-20260912.md`** (inferred from the sibling `skill-review-I-20260912.md` and the index log), and that persistence is HQ's act via `oc-review-persist` — this session is read-only and cannot persist it.

**Files modified: NONE.** Every tool call was `read_file`, `grep`, or `ls`.

*Bip — nine findings, all with verbatim quotes; three MED (F1, F5, F8), the rest LOW/LOW–MED. No padding, no duplications.*
