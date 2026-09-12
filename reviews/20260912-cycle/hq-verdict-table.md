# Duty-6 Skill Review — Cycle 20260912 — HQ Consolidated Verdict Table

**Cycle:** 20260912 · **Method:** `hq.md` §Duty 6 — eleven read-only reviewer sub-agents
(A–J + standing brain-scrub), one per lens, `read_only=true` `allow_nested=false`.
**Coverage:** `./tools/oc-review-persist check-cycle reviews/20260912-cycle`
→ **rc=0 — `OK (11 persisted, 0 waived, 0 unreceipted)`**.
**Findings filed:** **73** across 11 lenses.
**Verdict basis:** poll triple-check per finding — disk truth / evidence / coherence.
**Sibling artifact:** `verdict-table.md` (Reviewer I's own META table + §5 CORRECTION — unchanged by this pass).
**Date:** 2026-09-12 · **Author:** HQ (session `d72bd52d`)

---

## §1 — Lens census (per-lens yield / overlap)

| Lens | Family | Findings | Accepted | KERNEL | REJECT | Convergence (filed by >=2 lenses) |
|---|---|---|---|---|---|---|
| A | DOCS | 13 | 12 | 1 | 0 | 3 |
| B | DOCS | 6 | 6 | 0 | 0 | 1 |
| C | TOOLS | 4 | 4 | 0 | 0 | 2 |
| D | ARTIFACTS | 8 | 7 | 1 | 0 | 1 |
| E | TOOLS | 5 | 4 | 1 | 0 | 1 |
| F | TOOLS | 6 | 5 | 1 | 0 | 2 |
| G | DOCS | 9 | 9 | 0 | 0 | 2 |
| H | ARTIFACTS | 7 | 7 | 0 | 0 | 1 |
| I | META | 4 | 3 | 1 | 0 | 0 |
| J | MECHANICAL | 5 | 5 | 0 | 0 | 1 |
| brain-scrub | (standing) | 6 | 6 | 0 | 0 | 0 |
| **TOTAL** | | **73** | **68** | **5** | **0** | |

**Zero REJECTs.** Five KERNELs — each is a finding whose object is already covered by a live
rule or a prior ruling; the KERNEL row names that home rather than dropping the finding.

---

## §2 — Convergence map (the strongest signal)

A finding filed independently by **three or more lenses** is the cycle's highest-confidence
defect class — independent eyes, same object.

| Defect | Filed by | Count |
|---|---|---|
| `oc-roster --selftest` assertion count contradicts across registers | **A-F3 · E-2 · F-1 · F-6** | **4** |
| `oc-smoke-evidence` row: "never appends / hand-typed" vs the SANCTIONED `--append-log` | **A-F4 · C-1 · F-2** | **3** |
| RETIRED surface still advertised as live (`oc-waiter` / `oc-wt` index chain / `oc-index-worktree`) | **A-F2 · C-3 · D-1 · E-1 · F-5** | **5** |
| Tool/enumeration count drift between live law files | **A-F1 · B-3 · G-F5** | **3** |
| Pre-Direct-Dispatch routing law still present-tense | **A-F12 · G-F8** | 2 |
| Retired `modum` taught as live (brain files) | **brain-scrub-2 · brain-scrub-3** | 2 |

**Ground truth settled for the top row:** ran the tool —
`./tools/oc-roster --selftest` → **`oc-roster — 44 passed, 0 failed`** (rc=0),
and `./tools/oc-roster-selftest` → identical `44 passed, 0 failed`.
**`SKILL.md:125` ("44 checks") is CORRECT; `tools/RC-CONTRACT.md:48` ("31 offline fixture checks") is STALE.**
Fix direction is one-sided: repair RC-CONTRACT, do not touch SKILL.md.

---

## §3 — Verdict rows

### Lens A — DOCS (13)

| # | Sev | Finding | Verdict | Home / reason |
|---|---|---|---|---|
| A-F1 | MED | Enumeration consistency — one tool register, four numbers | **ACCEPT** | converges B-3 · G-F5. HQ batch: reconcile to the live `tools/` directory |
| A-F2 | MED | RETIRED concept still described present-tense | **ACCEPT** | converges D-1 · E-1 · F-5. HQ batch |
| A-F3 | MED | Contradiction — `oc-roster --selftest` count | **ACCEPT** | ground truth **44**; fix RC-CONTRACT:48 only |
| A-F4 | MED | "never appends" vs the sanctioned append verb | **ACCEPT** | converges C-1 · F-2. HQ batch (retire `fleet-directives.md:27` sentence) |
| A-F5 | MED | REDUNDANCY — same rule at N sites, each declaring a single home | **ACCEPT** | HQ batch — dedupe, keep the declared canonical home |
| A-F6 | MED | ONE CONCEPT = ONE NAME — night window has three names + a stale heading | **ACCEPT** | HQ batch (ontology law) |
| A-F7 | MED | Undefined coinage + spelling split — "four-leg smoke rubric" | **ACCEPT** | HQ batch — codify the term in the Glossary |
| A-F8 | LOW | POST-MIGRATION PATH SWEEP not run — `smoke-verdicts.log` written bare | **KERNEL** | already covered: `fleet-directives.md:27` QUIRK carries the ABSOLUTE-path rule + the decoy retirement (2026-09-12) |
| A-F9 | LOW | False negative claim — "no war-story entry exists" | **ACCEPT** | HQ batch — the negative claim needs its query+scope stated |
| A-F10 | LOW | Duty-4 destination carries two names | **ACCEPT** | HQ batch |
| A-F11 | LOW | Glossary conformance — load-bearing terms absent | **ACCEPT** | HQ batch |
| A-F12 | LOW | Dead dispatch rule kept present-tense in the re-homed lessons | **ACCEPT** | converges G-F8 |
| A-F13 | LOW | PROVENANCE SEDIMENT in live rule text | **ACCEPT** | HQ batch — rule text keeps the rule, history goes to `war-stories.md` |

### Lens B — DOCS (6)

| # | Sev | Finding | Verdict | Home / reason |
|---|---|---|---|---|
| B-1 | MED | SKILL.md's 4x router still carries the full flag vocabulary of the tool fleet; that cache has already rotted | **ACCEPT** | HQ batch — router points at `RC-CONTRACT.md`, does not restate flags (BUDGET RULE) |
| B-2 | LOW | The load-cost warning carries a file-size figure ~1.8x stale | **ACCEPT** | HQ batch |
| B-3 | LOW | Tool-fleet counts in the two routing files disagree with the directory | **ACCEPT** | converges A-F1 · G-F5 |
| B-4 | LOW | A dead ordinal pointer in `editor.md`, created by a previous round's accepted fix | **ACCEPT** | HQ batch — direct evidence the loop works |
| B-5 | LOW | An archived role's runbook still occupies the always-read HQ file | **ACCEPT** | HQ batch — move to `tools/archive/` |
| B-6 | LOW | The same four cross-role boundaries restated in two role files, in two wordings | **ACCEPT** | HQ batch — one home + pointer |

### Lens C — TOOLS (4)

| # | Sev | Finding | Verdict | Home / reason |
|---|---|---|---|---|
| C-1 | **HIGH** | The smoke-verdict row is still "hand-typed" by law while the tool that appends it is already SANCTIONED | **ACCEPT** | converges A-F4 · F-2. **This cycle's sharpest law-adoption gap.** HQ batch + Toolsmith confirm the flag |
| C-2 | MED | Worktree removal is a follow-up the agent must remember; no tool will do it | **ACCEPT** | **Toolsmith** — `oc-ship-chain --rm-worktree` or `oc-wt gc --merged` |
| C-3 | MED | `oc-index-worktree` is law-orphaned but still registered | **ACCEPT** | handed to D (YAGNI evidence). Toolsmith: mark register rows RETIRED |
| C-4 | LOW | The two-remote push ritual is one action dressed as two | **ACCEPT** | LOW, not pressed — HQ batch may collapse to one command; J may claim the sentence half |

### Lens D — ARTIFACTS (8)

| # | Sev | Finding | Verdict | Home / reason |
|---|---|---|---|---|
| D-1 | MED | `README.md` advertises the RETIRED `oc-waiter` as a live tool | **ACCEPT** | converges A-F2 · F-5. HQ batch — `README.md:48` verified present-tense |
| D-2 | MED | `CHANGELOG.md` carries a verbatim DUPLICATE entry (lines 768 and 772) | **ACCEPT** | HQ batch — dedupe |
| D-3 | MED | `tools/archive/oc-post-receipts` ARCHIVE verdict held by battery section 5 (**4th consecutive cycle**) | **ACCEPT** | **4th repeat = the loop is not closing.** Toolsmith: either land the archive or retire the holding check |
| D-4 | LOW | Empty directory `reviews/20260909-cycle/` in the skill repo | **ACCEPT** | HQ batch — remove |
| D-5 | LOW | State `archive/disabled-crons-20260911.json` is a 0-byte placeholder | **ACCEPT** | state-repo hygiene |
| D-6 | LOW | Orphan wave lock `run/wave-230f0db95dea.lock` (no `.sent` twin) | **ACCEPT** | state-repo hygiene |
| D-7 | LOW | 2026-09-12-dated `.bak` duplicates in the state dir (8 files) | **ACCEPT** | state-repo hygiene |
| D-8 | INFO | Three stores a prior cycle listed as present are ABSENT from the live state dir | **KERNEL** | INFO, no action — a prior cycle's listing is not a live-state claim |

### Lens E — TOOLS (5)

| # | Sev | Finding | Verdict | Home / reason |
|---|---|---|---|---|
| E-1 | MED | `oc-wt`'s retired index chain is still advertised on the highest-traffic surfaces | **ACCEPT** | converges C-3 · D-1. Toolsmith (header, `--help`, SKILL.md, RC register) |
| E-2 | MED | `oc-roster-selftest` is a second top-level executable that exists only to serve `oc-roster`; its register count contradicts the other register | **ACCEPT** | converges A-F3 · F-1 · F-6. Toolsmith: fold or reconcile |
| E-3 | LOW | Three interfaces answer the version-state question (re-filed with the prior ruling named) | **KERNEL** | prior ruling exists and is named in the finding — no action |
| E-4 | MED | STANDING EXTRA — `oc-upstream-delta --json` silently drops the per-commit census rows the TSV mode carries | **ACCEPT** | **Toolsmith** — a silent field-drop between two modes of one tool |
| E-5 | LOW | `oc-upstream-delta`'s `emit_commits` carries a dead `$2=tag` parameter | **ACCEPT** | Toolsmith (F-adjacent) |

### Lens F — TOOLS (6)

| # | Sev | Finding | Verdict | Home / reason |
|---|---|---|---|---|
| F-1 | MED | RC-CONTRACT and SKILL.md give two different assertion counts for `oc-roster --selftest` | **ACCEPT** | converges A-F3 · E-2 · F-6. Ground truth **44** — fix RC-CONTRACT:48 |
| F-2 | MED | SKILL.md's `oc-smoke-evidence` row advertises the DEPRECATED alias as canonical and hides the sanctioned append flag | **ACCEPT** | converges A-F4 · C-1 |
| F-3 | LOW | `oc-log-search --help` truncates its own header before the exit-code block (**repeat of F-20260911 L1, unfixed**) | **ACCEPT** | **repeat — the loop is not closing.** Toolsmith |
| F-4 | LOW | Help-header extraction is inconsistent across tools: five window sizes, one tool that does not strip the `#` prefix | **ACCEPT** | Toolsmith — mechanical |
| F-5 | LOW | `oc-waiter` still bypasses the unified tools log (**repeat of F-20260911 L3, unfixed**) | **KERNEL** | the tool is RETIRED (v0.4.135) — D-1's fix removes the last live reference; no code change owed |
| F-6 | LOW | RC-CONTRACT's `oc-roster-selftest` row contradicts itself on the usage rc | **ACCEPT** | converges F-1 family. Toolsmith |

### Lens G — DOCS (9)

| # | Sev | Finding | Verdict | Home / reason |
|---|---|---|---|---|
| G-F1 | MED | The single-writer census is provably incomplete (3 real skill files absent) | **ACCEPT** | HQ batch — `SKILL.md` §Hard rules census + README layout table |
| G-F2 | LOW–MED | `editor-phase7-rules.md`'s load trigger points at a heading that no longer holds the rule | **ACCEPT** | HQ batch — one-way pointer target |
| G-F3 | LOW | `SKILL.md` cites a heading that does not exist (`editor.md` §Ship) | **ACCEPT** | HQ batch |
| G-F4 | LOW | Phase numbering has a hole (no Phase 6, no Phase 6a) | **ACCEPT** | HQ batch — or record the deliberate gap |
| G-F5 | MED | Tool-count drift: two live law files disagree by 9 | **ACCEPT** | converges A-F1 · B-3 |
| G-F6 | LOW | `README.md`'s layout table is missing three files and carries a stale phase range | **ACCEPT** | HQ batch |
| G-F7 | LOW–MED | Two Toolsmith-owned spec pages are disclosed by no role file (LOAD-PATH MANDATE, inverse case) | **ACCEPT** | Toolsmith owns `HEALTH-*.md`; the pointer fix is `toolsmith.md` → HQ batch |
| G-F8 | MED | `toolsmith.md` carries pre-Direct-Dispatch routing law that the rest of the corpus retired | **ACCEPT** | converges A-F12. HQ batch |
| G-F9 | LOW | `SKILL.md`'s `oc-health` row understates the interface `tools/HEALTH-CLASSES.md` defines | **ACCEPT** | HQ batch |

### Lens H — ARTIFACTS (7)

| # | Sev | Finding | Verdict | Home / reason |
|---|---|---|---|---|
| H-1 | **HIGH** | CLAIM LIFECYCLE — the closure contract is a dead letter: 4 of its 5 closer kinds cannot exist, and the one that can lands in an array `cmd_claims` never reads | **ACCEPT** | **VERIFIED FIRST-HAND** (§4). **Toolsmith** — this cycle's highest-impact tool defect |
| H-2 | MED | CADENCE/VERSION SYNC — the bump series has a hole at 0.4.160 | **ACCEPT** | Toolsmith (`oc-ledger sync` catch-up emits one row for N versions) + HQ note in CHANGELOG |
| H-3 | MED | RECEIPT COMPLETENESS — the `LEG3 NON-FF` chain-death mode is chronic; rows carry no disposition | **ACCEPT** | **Toolsmith** — terminal-disposition row on every chain exit |
| H-4 | LOW | A skill-bump row with an empty provenance field | **ACCEPT** | Toolsmith — require `--why` on every `sync`, not only `--catch-up` |
| H-5 | MED | One mutable battery receipt serves every bump, so the citation is unfalsifiable | **ACCEPT** | **Toolsmith** — per-version receipt copy or inline `pass`/`fail` |
| H-6 | MED | CONTRADICTION PAIR — a ledger row asserts defect #20 landed while the shipped law text says it has not | **ACCEPT** | HQ batch — the v0.4.162 CHANGELOG entry must record the #20 landing (it landed as ship-chain LAW 16 `d6cb9b9a`) |
| H-7 | LOW | PHANTOM FAMILY — a row claiming a live probe with no receipt | **ACCEPT** | HQ/Toolsmith — fold the probe line into the substantive row |

### Lens I — META (4)

Verdicted in `verdict-table.md` (Reviewer I's own table). Restated for the consolidated record:

| # | Sev | Finding | Verdict |
|---|---|---|---|
| I-6.1 | HIGH | Cycle-spawn coverage unowned — **premise retracted, finding restated as "corpus root is the caller's word"** | **ACCEPT** (re-scoped) |
| I-6.2 | LOW | `SKILL.md:51` "ten-lens … ELEVEN reviewers" | **ACCEPT** — **SHIPPED v0.4.162** (`26f19d62`) |
| I-7.1 | LOW | No J↔ARTIFACTS boundary clause | **ACCEPT** — **SHIPPED v0.4.162** (`26f19d62`) |
| I-7.2 | LOW | brain-scrub brief in `fleet-directives.md` | **KERNEL** — deliberate, documented split |

### Lens J — MECHANICAL (5)

| # | Sev | Finding | Verdict | Home / reason |
|---|---|---|---|---|
| J-1 | — | The pre-PR `--fast` prohibition has no enforcement path, and no receipt records the gate MODE | **ACCEPT** | Toolsmith — record the gate mode in the receipt |
| J-2 | — | L4 packaging-sha stamps: the packaging tip is re-derived by hand; the smoke row never carries it | **ACCEPT** | Toolsmith — derive + stamp mechanically |
| J-3 | — | Base-freshness at filing time: the tested upstream base sha is recorded by hand | **ACCEPT** | Toolsmith |
| J-4 | — | State-repo destructive git ops: the deployed-state dirtiness check is manual | **ACCEPT** | Toolsmith — a guard at the destructive verb |
| J-5 | — | Atomic-write mode preservation: `chmod --reference` is an instruction to the writer, with no tool | **ACCEPT** | Toolsmith |

### Lens brain-scrub — ops brain files (6)

| # | Sev | Finding | Verdict | Home / reason |
|---|---|---|---|---|
| BS-1 | **HIGH** | `AGENTS.md:242` prescribes a SECOND ack row — the exact family the v0.4.159 law was written to kill | **ACCEPT** | ops brain (HQ-side edit) — the brain file contradicts the skill's own duplicate-ack law |
| BS-2 | **HIGH** | `TOOLS.md:487` teaches the RETIRED `modum check` (**repeat offender: BS-H4, 2026-09-11**) | **ACCEPT** | ops brain — 2nd consecutive cycle on the same line |
| BS-3 | MED | `TOOLS.md` carries opencrabs-dev process law, not just tool mechanics | **ACCEPT** | ops brain — process law routes to the skill |
| BS-4 | MED | `AGENTS.md:35,37,43` duplicate near-verbatim law whose canonical home is `fleet-directives.md`; `:35` has DRIFTED (lists 3 bash-isms, canonical lists 4 — `${var:0:110}` missing) | **ACCEPT** | ops brain — an **incomplete** restatement of a safety rule |
| BS-5 | MED | `MEMORY.md` carries discipline laws, each already canonical in the skill | **ACCEPT** | ops brain — MEMORY.md is passive, never auto-loaded |
| BS-6 | LOW–MED | `BOOT.md` points at an `AGENTS.md` section that does not exist | **ACCEPT** | ops brain — dangling pointer |

---

## §4 — First-hand verification receipts (load-bearing findings only)

Per the scoping law (verify what you will act on or report), HQ re-derived only the findings
that change an action. All four are same-turn reads.

| Finding | Quote verified at | Verdict |
|---|---|---|
| **H-1** closure contract | `tools/oc-ledger:1551-1553` — *"A claim on #N is OPEN unless a LATER event … kind in (close\|confirm\|reject\|done\|unclaim)"* | **CONFIRMED** |
| **H-1** the kind register | `tools/oc-ledger:140` `KINDS=" … claim confirm swap-result … "` — **no `close`, no `done`, no `unclaim`, no `reject`** | **CONFIRMED** |
| **H-1** the scan target | `tools/oc-ledger:1563-1566` scans **`.events`** (top level) | **CONFIRMED** |
| **H-1** the one real closer | `tools/oc-ledger:1500-1502` `cmd_confirm` appends to **`.workers[].events`** — an array `cmd_claims` never scans | **CONFIRMED — the contract cannot be honoured** |
| **C-1 / A-F4 / F-2** | `fleet-directives.md:27` — *"`oc-smoke-evidence` PRINTS a leg and never appends — the write is hand-typed"* **vs** `tools/RC-CONTRACT.md:55` — *"the SANCTIONED append path … a WRONG path is unrepresentable"* — both dated 2026-09-12 | **CONFIRMED — live contradiction** |
| **A-F3 / F-1** ground truth | `./tools/oc-roster --selftest` → `oc-roster — 44 passed, 0 failed` (rc=0); `./tools/oc-roster-selftest` → same | **CONFIRMED — SKILL.md right, RC-CONTRACT:48 stale** |
| **D-1** | `README.md:48` — *"`oc-waiter` — lane wake service: arm/_run/sweep/list, systemd transient scopes"* present-tense, while `RC-CONTRACT.md:59` marks it **RETIRED in v0.4.135** | **CONFIRMED** |
| **F-2** | `SKILL.md:101` — the `oc-smoke-evidence` row names `[--unit …] [--strings …] [--negative-control …]` and **never mentions `--append-log`** | **CONFIRMED** |

**Not re-verified (accepted on the reviewer's receipt, not load-bearing for an HQ action):**
H-2…H-7 ledger row reads, D-2…D-8 state-dir artifacts, G-F1…G-F9 cross-file pointers,
E-4/E-5 tool-body reads, J-1…J-5. Each is dispatched to the lane that owns it, and that lane
verifies before acting.

---

## §5 — Dispatch plan

### 5.1 → Toolsmith lane (tool code — Toolsmith owns `tools/**`)

| Item | Finding | Why it matters |
|---|---|---|
| **Claim-closure contract** | **H-1 (HIGH)** | The `verify-unclaimed` dispatch gate reads shipped work as CLAIMED (#150, #191 both shipped, both read OPEN). A gate that never closes is a gate that gets ignored |
| `--append-log` reachability | C-1 / F-2 | The sanctioned verb exists but the law and the register disagree on whether it is used |
| `oc-roster` count + `oc-roster-selftest` | A-F3 · E-2 · F-1 · F-6 | Four lenses, one object; ground truth 44 |
| `oc-wt` retired index chain on live surfaces | E-1 · C-3 | Retired purpose still advertised |
| `oc-upstream-delta --json` silent field drop | E-4 | Two modes of one tool disagree on payload |
| Chain terminal disposition rows | H-3 | 11 `LEG3 NON-FF` deaths carry no disposition |
| `sync` provenance + receipt per version | H-2 · H-4 · H-5 | The bump series has a hole at 0.4.160; one mutable receipt serves every bump |
| `oc-post-receipts` archive (**4th cycle**) | D-3 | A holding verdict that has not moved in four cycles |
| Help-header consistency (**2 repeats**) | F-3 · F-4 | F-20260911 L1/L3 unfixed |
| J-1…J-5 mechanical enforcement | J | Law that should be a tool — the owner's own ruling |

### 5.2 → HQ version batch (skill markdown — HQ-only authorship)

Mechanical fixes (dedup, wording, terminology, dead refs) land as **ONE version batch** per
`hq.md` §Duty 6 step 5: A-F1/A-F2/A-F5/A-F6/A-F7/A-F9/A-F10/A-F11/A-F12/A-F13 · B-1…B-6 ·
D-1/D-2/D-4 · G-F1…G-F9 · H-6.

**Anything SEMANTIC goes to the owner as a proposal — a review never widens HQ's own authority.**
Candidates for the owner gate: A-F5 (redundancy consolidation changes where a rule lives),
G-F1 (single-writer census widening), BS-1/BS-3/BS-5 (brain-file restructuring).

### 5.3 → ops brain files (HQ-side edit, this profile)

BS-1 … BS-6 — `AGENTS.md`, `TOOLS.md`, `MEMORY.md`, `BOOT.md`.
**Two are HIGH and both are repeats/contradictions of already-shipped law:**
`AGENTS.md:242` prescribes the duplicate ack the v0.4.159 law killed; `TOOLS.md:487` teaches
the retired `modum check` for the **second consecutive cycle**.

### 5.4 KERNEL rows (no action — home named)

A-F8 (`fleet-directives.md:27` QUIRK) · D-8 (INFO) · E-3 (prior ruling named in the finding) ·
F-5 (`oc-waiter` RETIRED — D-1's fix removes the last reference) · I-7.2 (deliberate split).

---

## §6 — Reviewer-performance loop (`hq.md` §Duty 6 step 7)

### 6.1 Brief defects found BY the reviewers (fix in the next version batch)

| Brief | Defect | Found by |
|---|---|---|
| **C's brief** | prescribes *"official surfaces are `oc-waiter arm` and one-shot `gh run view`"* — **`oc-waiter` is RETIRED** (v0.4.135). The brief names a dead surface | Reviewer C (self-reported) |
| **H's brief** | names `oc-waiter-sweep` as a slice tool — **no such file exists** in `tools/`; `oc-waiter-sweep` is a law-carrying **cron** named in `triage.md` | Reviewer H (self-reported) |

Both are the **same root cause**: the briefs were written before v0.4.135 retired `oc-waiter`,
and nothing re-derives a brief's tool list against the live `tools/` directory at spawn time.
**Fix:** briefs name the *capability*, not a frozen tool name, and Duty-6 spawn re-derives the
object list from the skill root (already the anti-rule in `hq.md` step 7 — this cycle shows why).

### 6.2 The `grep` literal-mode trap — 2 lenses, same near-miss

**Reviewer G** used the literal-mode alternation `HEALTH-CHECKS|HEALTH-CLASSES` → "No matches found"
(a **FALSE NEGATIVE** on a real reference). **Reviewer brain-scrub** did the same on
`opencrabs-dev|fleet-directives|…` → "No matches found" on a file carrying 18 hits; it caught
itself and logged it. Both are the exact trap codified in `AGENTS.md:43`.

**Fix (brief-level, mechanical):** every lens brief that can produce a negative-existence claim
must require the query **and** its scope to be quoted beside the claim. G adopted this mid-report
and it worked — that clause is promoted into the shared evidence-format section of
`review-lenses.md`.

### 6.3 Reviewer I's own provenance table — 1 of 6 correct

`verdict-table.md §3.3` records that I's §0 line counts were wrong for 5 of 6 files
(`SKILL.md` 179 vs **554**; `CHANGELOG.md` 1,420 vs **876**; `oc-review-persist` 108 vs **127`;
`hq.md` 315 vs **317**; `README.md` 34 vs **76**). Reviewer I audits *others'* citation
discipline; its own corpus table was estimated, not tool-read. Already folded into the brief.

### 6.4 Standing triggers evaluated

| Trigger | State | Action |
|---|---|---|
| clean x2 cycles → automate the lens's mechanical half or shrink the brief | **not met** — this cycle produced 73 findings, 68 accepted | none |
| convergence with another lens x2 → merge or sharpen the boundary | **MET for the count-drift family** (A-F1 · B-3 · G-F5 — 3 lenses, second cycle) | sharpen: enumeration consistency is **lens A's** checklist item (d); B and G cite A rather than re-filing |
| object list stale at spawn → re-brief BEFORE spawning | **MET** — C's and H's briefs both named retired `oc-waiter` | re-brief C and H (see 6.1) |
