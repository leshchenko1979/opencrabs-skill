# Duty-6 Review — **Lens B** (LLM EFFICIENCY + RESPONSIBILITY CREEP) · cycle **20260912** · date **2026-09-12**

Reviewer: **B** (DOCS family; carries the EFFICIENCY family's SKILL.md size budget — lens B F3/F18). Read-only sub-agent: no file was edited, created, or deleted.

## How the line counts were obtained (method note)

This registry has **no shell** (reads/search/web only), so `wc -l` could not be run. Every line count below is the count the read tool itself reported when asked for a line beyond EOF (`Invalid input: Start line 100000 exceeds file length N`) — an on-disk per-file count, never an estimate. Byte figures come from `ls -detailed` and from the reader's own truncation report. A ±1 trailing-newline difference vs `wc -l` is possible.

## Scope actually covered

| File | Lines (real, this session) | How read |
|---|---|---|
| `SKILL.md` | **555** | full body (delivered by the skill gate on first corpus grep, which injects the whole file) + line-numbered greps |
| `fleet-directives.md` | **651** | read to the reader's 50 kB truncation (≈ first half); line-numbered greps over the whole file. **Tail not read.** |
| `editor.md` | **633** | full |
| `hq.md` | **317** | full |
| `triage.md` | **245** | full |
| `toolsmith.md` | **105** | full |
| `editor-upstream-pr.md` | **227** | full |
| `review-lenses.md` | **264** | full |
| `README.md` | **76** | full |
| `tools/RC-CONTRACT.md` | **113** | full, but several long rows were clipped by the reader's per-line truncation |
| `CHANGELOG.md` | **887** | first 40 lines + line-numbered greps only |
| `war-stories.md` / `upstream-merge-runbook.md` / `s2-swap-journal-spec.md` / `editor-phase7-rules.md` | 112 / 220 / 99 / 33 | **not read** — counts only |

Also: `ls tools/` (**39 files named `oc-*`**, plus `archive/`, `lib/`, `tests/`, `HEALTH-CHECKS.md`, `HEALTH-CLASSES.md`, `RC-CONTRACT.md`); targeted greps into `tools/oc-watcher-audit`, `tools/oc-prchecks`, `tools/oc-ship-audit`; existence checks on `tools/archive/compiler.md`, `tools/HEALTH-*.md`, `skills/writing-for-agents/SKILL.md`; prior-cycle artifacts `reviews/20260907-duty46-cycle2/verdict-table.md`, `reports/skill-review-B-20260907.md`, `reports/skill-review-B2-20260907.md`, `reports/skill-review-G-20260907.md`, `reviews/20260910-cycle/reports/skill-review-A-20260910.md`.

---

## FINDINGS

### B-1 [MED] — SKILL.md's 4x router still carries the full flag vocabulary of the tool fleet, and that cache has already rotted

- **(a) Severity:** MED
- **(b) Law site + verbatim quote:**
  - Budget rule — `review-lenses.md:203-209`:
    > `- **SKILL.md BUDGET RULE:** SKILL.md is the always-loaded router — every`
    > `  line costs 4x (all four roles re-read it IN FULL under the RELOAD LAW).`
    > `  It carries: hard rules, ontology/glossary, tool-table PURPOSE-only rows,`
    > `  role routing, load paths. Executable procedure, verb vocabularies, and`
    > `  step-by-step mechanics belong in the owning role file or reference page`
    > `  (RC-CONTRACT.md = SOLE tool register).`
  - The site — `SKILL.md:88` (one of 40 such rows, lines 86–125):
    > ``| `./tools/oc-artifact-verify <artifact-path> [--source <sha>] [--run-id <id>] [--markers m1,m2] [--expect-sha <sha256>] [--expect-version <v>] [--repo R] [--json]` | EXECUTION SANITY SIGNAL + FEATURE-PRESENCE CHECK |``
  - Proof of rot at the same table — `SKILL.md:112`:
    > ``| `./tools/oc-watcher-audit [--json\|--kill-stale]` | detached watcher compliance and sleep-loop audit across active sessions |``
    against the tool's own surface — `tools/oc-watcher-audit:42`:
    > `  echo "usage: $PROG [--since <ts>] [--json] [--dir <dir>] | --selftest" >&2`
    A grep of the whole `tools/` tree for `kill-stale` returns **no matches**.
- **(c) State/artifact it concerns:** `SKILL.md` §Canonical tooling, table lines 86–125 = **40 of 555 lines (7.2%)** of the always-loaded file, which all four role files re-read in full (`editor.md:5`, `hq.md:3`, `triage.md:3`, `toolsmith.md:3` all carry the RELOAD LAW naming `SKILL.md`). The rows are keyed on the invocation signature; `tools/RC-CONTRACT.md:22` shows the register's own columns are `| Tool | help | usage | Verdict codes |`, so these signatures are not a duplicate of the register — they are a second copy of each tool's `--help`.
- **(d) Cost already paid:** the remedy was ordered and only partly executed — `reviews/20260907-duty46-cycle2/verdict-table.md:11`: *"B-F3/F18: SKILL.md 50,357B is a 4x multiplier under RELOAD LAW; no budget guard. Fix: budget rule in review-lenses + register cuts."* and `reports/skill-review-B2-20260907.md:3`: *"Fix per F5: cut tool register to purpose-only rows."* The rc codes were cut (`SKILL.md:82`: *"rows below carry purpose only"*); the flag vocabularies were not, and one has since gone stale (`--kill-stale`). The rot itself is **unpriced** — no incident row cites a lane acting on the dead flag.
- **(e) Remedy:** finish the ordered cut — leave each row as `tool name + purpose` (the router's job is "which tool", not "which flags"), and let invocation shape live in the register row or the tool's own `--help`. Do not word-trim: 40 lines is a disclosure decision, not a style one.

### B-2 [LOW] — the load-cost warning carries a file-size figure that is ~1.8x stale

- **(a) Severity:** LOW
- **(b) Law site + verbatim quote:** `fleet-directives.md:5`:
  > `EXCEPTION (v0.4.96, lens B-F1): HQ re-reads THIS ENTIRE FILE IN FULL (~54 kB and growing — exact size varies per cycle; it owns and rules on the directives; the other three roles may use the thematic-index minimum for non-[LANE] sections):`
- **(c) State/artifact:** `fleet-directives.md` measured this session at **99,870 bytes** (`ls -detailed`; the reader returned 97,823 bytes of content) over 651 lines — roughly **2x** the stated ~54 kB. The figure sits inside the sentence whose whole purpose is to price the HQ reload.
- **(d) Cost already paid:** **unpriced** (no incident or ledger row). Note the number was already present in the 20260910 snapshot of the same header, so it has been drifting unnoticed for at least two cycles.
- **(e) Remedy:** delete the parenthetical number and keep the rule ("HQ re-reads this file IN FULL; the other three roles may use the thematic-index minimum"). A size that changes every cycle is a lookup, not law; if a figure is wanted, derive it (`du -h`) rather than cache it.

### B-3 [LOW] — the tool-fleet counts in the two routing files disagree with the directory

- **(a) Severity:** LOW
- **(b) Law sites + verbatim quotes:**
  - `README.md:24`: ``| `tools/` | The `oc-*` tool fleet (29 executables) + `lib/` + `tests/` |``
  - `README.md:55`: ``29 executables in `tools/` (31 − `oc-toolaccum` v0.4.110 − `oc-ci-parity` v0.4.117; owner-ordered additions 2026-09-01) — full inventory in `tools/RC-CONTRACT.md`.``
  - `editor.md:175`: ``the role-DAILY subset, not the inventory — the full tool list (38 tools)``
  - `editor.md:233`: ``inventory, all 38 tools) + SKILL.md tool table.``
- **(c) State/artifact:** `ls tools/` this session returns **39 files named `oc-*`**. The two files that route readers into the tool fleet state 29 and 38. This is exactly the CACHE class: a count is a one-command lookup (`ls tools/`) that cannot go stale in the environment and has gone stale twice in the docs.
- **(d) Cost already paid:** the class was already found — `reviews/20260910-cycle/reports/skill-review-A-20260910.md:175` (A-9, LOW) reported the same discrepancy when the numbers read 29/29; the count has since drifted to 38 while the directory moved to 39. **unpriced** as an incident.
- **(e) Remedy:** drop the numeral from both files and point at the register ("full inventory in `tools/RC-CONTRACT.md`"); the enumeration-consistency dimension itself is lens A's, noted here so HQ can attribute on first-finder grounds.

### B-4 [LOW] — a dead ordinal pointer in editor.md, created by a previous round's accepted fix

- **(a) Severity:** LOW
- **(b) Law site + verbatim quote:** `editor.md:174-177`:
  > `5. **Tool discovery (owner order 2026-09-07, v0.4.94):** the table below is`
  > `   the role-DAILY subset, not the inventory — the full tool list (38 tools)`
  > `   lives in `tools/RC-CONTRACT.md` (every tool: invocation, rc register,`
  > `   selftest owner). Before hand-rolling any check (item 11), grep`
- **(c) State/artifact:** the section the pointer names — `editor.md` §CI-wait discipline & actor attribution — has items **1–9** (lines 90, 95, 99, 106, 113, 118, 123, 129, 139); no list in `editor.md` reaches item 10 or 11, and a corpus-wide grep for `item 11` finds no referent outside this line, the CHANGELOG history, and prior-cycle reports. A reader (or a model) hunting "item 11" finds nothing.
- **(d) Cost already paid:** the pointer *is* the prior round's remedy — `reviews/20260907-duty46-cycle2/verdict-table.md:17`: *"A-3/G-3 editor:141 self-cite → item 11"*, and `reports/skill-review-G-20260907.md:4`: *"G-3: editor.md:141 item 10 cites itself as the waiter rule (intended item 11)."* The accepted fix moved the reference to an ordinal that was later trimmed out of the list. **unpriced** since.
- **(e) Remedy:** replace the ordinal with the section name (`Before hand-rolling any check, grep RC-CONTRACT.md …`) — the same cure lens A proposed in cycle-2 for the sibling site (`triage.md` "editor items 14/15").

### B-5 [LOW] — an archived role's runbook still occupies the always-read HQ file

- **(a) Severity:** LOW
- **(b) Law site + verbatim quote:** `hq.md:122-125`:
  > `Inbox discipline for any (re-enabled) build lane: ORDERs / red-run handoffs /`
  > `owner directives only; ACK bookkeeping stays ledger-internal. *(Historical:`
  > `the compiler role was RETIRED 2026-08-28 — builds fire via `oc-deploy ship`;`
  > `this paragraph is kept only as the runbook for any future re-enabled lane.)*`
- **(c) State/artifact:** `hq.md` is one of the three files HQ re-reads **IN FULL** at every compaction (`hq.md:3`). The paragraph governs an inbox that no longer exists: the Compiler role is RETIRED, `SKILL.md` §Hard rules fixes BUILD TRIGGERS at exactly two, and no lane owns a build inbox. The text is honestly labelled historical, so this is load, not a lie.
- **(d) Cost already paid:** **unpriced**.
- **(e) Remedy:** move the paragraph to `war-stories.md` / `CHANGELOG.md` and leave a one-line pointer if the re-enable context matters. This is the responsibility-creep dimension of the brief ("duties migrating across HQ/Editor scope lines (Compiler archived)") — the duty is gone; its runbook is still on the reload path.

### B-6 [LOW] — the same four cross-role boundaries are restated in two role files, in two wordings

- **(a) Severity:** LOW
- **(b) Law sites + verbatim quotes:**
  - `triage.md:28`: `- **Skill file authoring**: Exclusively owned by HQ (SKILL.md §Hard rules census). Triage captures skill feedback and ideas as `IDEA:` and `QUIRK:` ledger entries for HQ batch processing.`
    `triage.md:30`: `- **Protocol governance**: Binding protocol rulings are owned by HQ (hq.md Duty 5); protocol disputes escalate to HQ.`
    `triage.md:31`: `- **Owner reporting**: Owner-facing verdict batches are compiled and delivered by HQ (Duty 4 / hq.md §Duty 7 discipline).`
  - `toolsmith.md:24`: `- **Skill Documentation:** Skill markdown, role files, and `fleet-directives.md` are authored strictly by HQ. Tooling gaps requiring skill documentation leave as `IDEA:` items to Triage.`
    `toolsmith.md:26`: `- **Rulings & Decisions:** Protocol disputes and binding rulings escalate to HQ (Duty 5).`
    `toolsmith.md:27`: `- **Owner Communication:** HQ owns owner-facing verdict batches; Toolsmith reports status to HQ/Triage or the operator when queried.`
- **(c) State/artifact:** both blocks restate the same four facts, which `SKILL.md` §Hard rules already states as the role-intersection law every lane re-reads in full. Each lane therefore pays for the same boundary set twice per reload (its own role file + SKILL.md), and the two copies differ only in wording.
- **(d) Cost already paid:** **unpriced** (no incident row).
- **(e) Remedy:** keep one canonical boundary list (SKILL.md §Hard rules census, or a single shared list) and reduce both role-file blocks to a one-line pointer. **Boundary note for HQ:** duplication across files is lens A's object — I raise it on the load-weight dimension (each lane re-reads its own file IN FULL under the RELOAD LAW); if A claims it, attribute there and treat this as convergence evidence.

---

## What I checked and found CLEAN

- **Progressive disclosure, where applied, works.** I followed three pointers to their targets and all resolve and carry the material: `SKILL.md:133-138` §Unified tools log → `tools/RC-CONTRACT.md` §Unified tools log (present, with path/schema/suppression/recipes); `SKILL.md:551-555` §Shared war stories → `war-stories.md` (exists, 112 lines); `editor.md` §Phase 7 → `editor-upstream-pr.md` (exists, 227 lines, and states its own on-demand load contract at line 3-5). `tools/archive/compiler.md`, `tools/HEALTH-CHECKS.md`, `tools/HEALTH-CLASSES.md` and `skills/writing-for-agents/SKILL.md` (the vocabulary reference named in my own brief) all exist — no dead load-path pointer found.
- **The 4x premise is real, not assumed:** all four role files carry a RELOAD LAW that re-reads `SKILL.md` in full (`editor.md:5`, `hq.md:3`, `triage.md:3`, `toolsmith.md:3`).
- **The delivery-modes table** in `SKILL.md:166-198` was already collapsed to a failsafe pointer + pointer-only row by lens B-F15 (v0.4.96) and names `fleet-directives.md` as canonical. Checked, left alone — no re-litigation.
- **Lens census consistency (efficiency-relevant, since HQ re-reads it):** `SKILL.md` HQ row, `hq.md` Duty 6 step 2 and `review-lenses.md:3` all read ELEVEN reviewers (A–J + brain-scrub). The v0.4.162 I-6.2 "ten-lens/ELEVEN" drift is genuinely fixed.
- **`SKILL.md` §Shared environment facts (lines 363–430, 68 lines) re-weighed against the budget rule and the CACHE test — kept.** It is predominantly the unwritten-convention/gotcha cache the vocabulary endorses (the `source_ref` short-sha glob incident, the dispatch `-f features=<set>` convention, the `systemctl --user` gotcha, the box-law pointer). Only the enumerated build command line is a marginal cache, and it carries the `profile ci` rationale no config confesses. **No finding raised.**
- **Considered and deliberately NOT raised:** (1) the 21-path compiled-in exclusion list in `fleet-directives.md §Docs-Only LEG1 Gate Skip` — the owner ruling (v0.4.161, *"that should be purely mechanical"*) already struck the re-derivation `grep`, declares the list illustrative, and dispatches the tool half as defect #20; re-flagging would re-litigate an owner ruling. (2) `CHANGELOG.md` newest-FIRST vs `README.md`'s "newest entry LAST" — still open, but previously reported (cycle-2 G-8, 20260907) and an A/G file-order contract, not a load claim. (3) the lens family map appearing in `SKILL.md`, `hq.md` Duty 6 and `review-lenses.md` — ~2 lines, A's enumeration dimension.

## What I did NOT check (scope limits)

- **No shell in this registry:** `wc -l`, `du`, `git`, and the tools themselves could not be run. All counts are the reader's own file-length report; byte sizes are `ls`/reader reports. I did not execute any `oc-*` tool, so no runtime behavior was observed.
- **Not read at all:** `war-stories.md`, `upstream-merge-runbook.md`, `s2-swap-journal-spec.md`, `editor-phase7-rules.md` (counts only); `CHANGELOG.md` beyond its first 40 lines and grep hits; `reviews/**` beyond the five artifacts cited; `tools/` code beyond three greps (`oc-watcher-audit`, `oc-prchecks`, `oc-ship-audit`).
- **Partially read:** `fleet-directives.md` — content only to the reader's 50 kB truncation (≈ first half of 651 lines); my findings there rest on line 5 plus whole-file greps. `tools/RC-CONTRACT.md` — several long rows were clipped by per-line truncation, so its rows were not fully compared against the tools.
- **Out of scope by brief:** tool-code correctness and phantom-verb/flag existence as a verdict class (F / the `oc-lint-laws` corpus lint, audit M2-18), recurring-procedure automation (C), interface merges (E), artifact deletion verdicts (D/H), ledger health (H), law-as-tool decisions (J), role-file organization verdicts (G), ontology/redundancy ownership (A), and the review machinery itself (I). I claim only the load/weight, cache, no-op, negation and progressive-disclosure dimensions.
- **One line I did not re-verify:** `editor.md:176`'s parenthetical that `tools/RC-CONTRACT.md` carries every tool's *"invocation, rc register, selftest owner"* — the register's columns (`RC-CONTRACT.md:22`) are `help | usage | Verdict codes`, so the "invocation" claim is at best partial; I folded this into B-1's evidence rather than raising it separately, as the register-gap half is F/A territory.
