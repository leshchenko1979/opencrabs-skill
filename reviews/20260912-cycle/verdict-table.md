# Duty-6 verdict table — cycle 20260912 (Reviewer I, META-REVIEW)

**Cycle:** 20260912 · **Lens run:** I (META-REVIEW) · **Owner order:** "Run lens I now" (2026-09-12 12:49:38Z)
**Report:** `reports/skill-review-I-20260912.md` — 16,870 B · sha256 `7da3a97fe4b8c48e8fad0b3e341014a6a1bd90892ffdaec2a24ac67c06366ed0`
**Index receipt:** `reports/skill-review-index.log` @ 2026-09-12T12:58:02Z
**Method:** hq.md §Duty 6 step 4 — poll triple-check (disk truth / evidence / coherence) on every finding.

---

## 1. Findings verdict

| # | Sev | Finding | Verdict | Disk truth (verified this turn) |
|---|---|---|---|---|
| **I-6.1** | HIGH | Cycle-spawn coverage is unowned — **the coverage COUNT was read from the wrong corpus; see §5 CORRECTION** | **ACCEPT** (remediation re-scoped; premise partially retracted) | ~~`reviews/20260911-cycle/reports/` holds exactly **4** `skill-review-*.md` (A, E, F, brain-scrub) vs **10** in `20260910-cycle`~~ — **RETRACTED §5**: that dir is the SKILL repo's HQ-side mirror, not the 09-11 Duty-6 cycle. The real cycles (`20260911-c5..c8`) live in the STATE repo and ran **10 of 11** lenses each |
| **I-6.2** | LOW | Enumeration drift: `SKILL.md:51` reads *"ten-lens skill review … = ELEVEN reviewers"* | **ACCEPT** | verbatim confirmed at `SKILL.md:51`; `review-lenses.md:3` says *"eleven Duty-6 review lenses (A–J + standing brain-scrub)"* — the two disagree on the unit |
| **I-7.1** | MED→LOW | No boundary clause between Reviewer J and ARTIFACTS (D/H) | **ACCEPT** | J brief (`review-lenses.md:99-134`) carries **BOUNDARY vs C only**; no D/H text; neither D's nor H's brief mentions J |
| **I-7.2** | LOW | brain-scrub brief lives in `fleet-directives.md`, not the catalog | **KERNEL** | deliberate, documented split (`review-lenses.md:6` names the location). Moving it duplicates a brief across two files — violates one-concept-one-home. Reason recorded, no action |

## 2. Remediation re-scoping — I-6.1

I proposed two remedies. **One of them is itself the defect class the owner named today.**

| Remedy | Verdict | Why |
|---|---|---|
| (1) *"Add an explicit mandate to Reviewer I's brief … mandatory Census Check"* | **REJECTED** | "Did every catalog lens run this cycle?" is a **pure function of state on disk** (`ls reviews/<cycle>/reports/` vs the catalog). Assigning it to a reviewer's memory is agent-memory-as-gate-input — the exact thing owner ruling 2026-09-12 (*"that should be purely mechanical"*) created lens J to kill. The meta-lens proposed the anti-pattern it exists to catch |
| (2) *"Automated pre-verdict gate: `oc-review-persist check-cycle <dir>`"* | **ACCEPTED** — tool half | Belongs to Toolsmith. Blocks Duty-6 close unless every catalog lens has a non-empty persisted report or a recorded waiver |

## 3. HQ additions the report did not carry

1. **The gap is worse than omission — the cycles never closed.** I counted only missing *reports*. On disk, `20260907-duty46` and `20260907-duty46-cycle2` each carry a `verdict-table.md`; **`20260909`, `20260910` and `20260911` carry NONE.** A missing verdict table means Duty-6 step 4 (poll triple-check) and step 7 (lens census) never ran — so no per-lens census has been computed for three consecutive cycles. Verified by direct file test this turn.
2. **A nearest-owner already exists and was not cited.** `hq.md` §Duty 6 step 7 carries the **LENS CENSUS** (v0.4.81) — but it computes *yield / overlap / cost* from **already-persisted** reports, is HQ-side prose, is not a gate, and evidently was not applied at 0910/0911. So the correct statement is not "unowned" but "**owned by prose that is not a gate and did not fire**".
3. **Reviewer-performance lesson (hq.md step 7) — the meta-reviewer's own corpus table is unverified.** §0 reports line counts for six files; **five are wrong against disk**:

| File | I's §0 claim | Actual (`wc -l`) |
|---|---|---|
| `SKILL.md` | 179 | **554** |
| `CHANGELOG.md` | 1,420 | **876** |
| `tools/oc-review-persist` | 108 | **127** |
| `hq.md` | 315 | **317** |
| `README.md` | 34 | **76** |
| `review-lenses.md` | 255 | 255 ✔ |

   Also `20260907-duty46-cycle2` reports: claimed **38**, actual **39** `.md`. A report that measures *others'* quote-or-no-finding discipline at 32/32 while its own §0 provenance is 1/6 correct is the I-4.1 rule applied to everyone but itself. Fold into the brief: **the corpus table's counts are themselves evidence and must be tool-read, not estimated.**

## 4. Disposition

- **Law edits HELD under the CPU pause** — I-6.2 (`SKILL.md:51` one-line fix) and I-7.1 (J↔D/H boundary clause) are written, ready, and ship with the next version batch on the owner's word. They are NOT shipped now: a law edit without a bump leaves an unsynced second drift window on top of the open 0.4.161↔0.4.159 one.
- **Tool half DISPATCHED** — `oc-review-persist check-cycle` (I-6.1 remedy 2) + the "close the cycle" gate → Toolsmith lane.
- **I-7.2 closed as KERNEL** with reason on record.
---

## 5. CORRECTION (2026-09-12, post-dispatch) — I-6.1 premise partially retracted; one new finding

Toolsmith's `check-cycle` delivery (`834ce6ca`) carried a correction to **this table**, and it is right. Verified first-hand this turn, both directions.

### 5.1 The coverage count was read from the wrong corpus — RETRACTED

**What I claimed:** `reviews/20260911-cycle` holds 4 reports vs 10 in `20260910-cycle`, so "6 of 10 lenses absent, no alarm".

**Why it was wrong:** there are **two review corpora** and I read the wrong one.

| Corpus | Path | 09-11 cycles | Report naming |
|---|---|---|---|
| **STATE repo** | `opencrabs-dev/reviews/20260911-c5..c8` | the **real Duty-6 cycles** | `review-lens-<L>.md`, `lens-<L>-<date>.md`, combined `lens-B-C-D-E-<date>.md` |
| **SKILL repo** | `skills/opencrabs-dev/reviews/20260911-cycle` | an **HQ-side mirror** (4 reports) | `skill-review-<L>-<date>.md` |

**Disk truth:** `reviews/20260911-c8/reports/` holds ten `review-lens-*.md`; `git log` for it reads *"record Duty 6 Cycle 8 reviews (**10 lenses**)"* (`f2b3c58e`). `check-cycle` on c8 → **MISSING 1 of 11 (lens J only)**; on c7 → **1 (lens J)**; on c6 → **1 (lens J)**. **The 09-11 cycles ran 10 of 11 — the one absent lens is J, which did not exist yet.** My "6 silently absent" reading is **false** and is retracted.

### 5.2 What survives — and it is a better finding than the retracted one

The corpus is **unaddressable**: two repos, four report-naming conventions, and closing artifacts that disagree (`verdict-table.md` in the skill repo's 0907 cycles vs `review-cN-summary.md` in the state repo's c6/c7; **c8 has neither**). That is *why* the lens whose entire job is auditing this machinery read the wrong directory and published a false number. Restated:

- **I-6.1 (corrected):** the defect is **not** "lenses silently skipped" — it is **"coverage cannot be computed without a rule for where to look."** `check-cycle` derives the **catalog** at gate time (good, and it works), but the **corpus root is still the caller's word**. A gate handed the wrong directory answers the question wrongly — the same false-clean/false-alarm failure mode the gate was built to prevent, inverted. **Mechanical, same family as M2-1.**

### 5.3 Second correction: "no census for three consecutive cycles" was also wrong

§3 claim 1 is **partially retracted**. `reviews/20260911-c6/review-c6-summary.md` and `...-c7/review-c7-summary.md` both exist and both carry a *"Tally by lens"* section — i.e. a census **was** computed for c6 and c7. What is genuinely absent is the **`verdict-table.md` closing artifact** in the state repo (c8 has none; c1–c5 have none) — a *naming/artifact* gap, not a census gap. Restated as: **the closing artifact is not standardised, so "did the cycle close?" is not decidable from the tree.**

### 5.4 NEW FINDING (ship-chain) — `oc-ship-audit` reports FALSE ORPHANS from selftest contamination

Toolsmith flagged 6 ORPHANED dispatch rows. Reproduced (`oc-ship-audit --grace 120`, rc=1) — but the attribution is different, and worse:

**`56f892a` is not a duplicate stamp and not a real dispatch. It is `oc-deploy`'s own selftest fixture, written into the PRODUCTION `tools.log`.**

Evidence (all same-turn reads):
- 23 rows in the single second `2026-09-12T01:16:5xZ`, **21 of them `oc-deploy`**, every one `"actor":"unknown"`, `secs` 0.0–0.2.
- The argv set is the selftest's `check_rc` matrix: `ship --bogus`→1, `contributors`→1, `ship`→2, `--wait 30`→2, `--notify-session aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa`→2 (placeholder UUID), `--features code-graph,telegram`→0.
- Row `ship --sha 4c0115ba9aa052f5cfeda01383c0d20be9e2392e` exit 1 — **that is `oc-deploy:694 local PHANTOM=`, the selftest's phantom-sha constant, verbatim.**
- `SHA2` is `git -C "$T/repo" rev-parse HEAD` — a **temp-repo** commit, which is why no swap journal exists: the sha never existed in production.
- `deployed.sha` = `234c0d51…`, unrelated.

**Mechanism (for Toolsmith to confirm):** `lib/oc-log.sh` suppresses only when argv carries the **`--selftest` flag** (`case " $OC_LOG_ARGS " in *" --selftest "*)`). `oc-deploy:2976` dispatches **both** `--selftest` **and** the bare **`selftest`** subcommand — the latter does **not** match, so no `OC_TOOLS_NOLOG` export happens and every child fixture invocation logs to the real log. `tools/tests/run.sh:21` exports `OC_TOOLS_NOLOG=1` globally, which **masks this in the battery** — the leak only appears when the selftest is invoked outside it.

**Impact:** `oc-ship-audit` returns rc=1 (false ORPHANED) → gates `oc-ledger commit-pending`. A gate that cries wolf on phantom dispatches is the "gate gets ignored" failure mode, here caused by a tool's selftest polluting production telemetry. **Dispatched to Toolsmith.**

*`f1ee470` / `b252509` (09-11 19:28Z) are single rows, same shape — likely the same origin, not yet confirmed.*

