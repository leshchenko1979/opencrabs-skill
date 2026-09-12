Lens: **J — MECHANICAL ENFORCEMENT (law that should be a tool)** · Cycle **20260912** · Date **2026-09-12** · Read-only pass, no writes.

---

## 1. Scope actually covered

**Corpus under review — read in full this session** (root: `/root/.opencrabs/profiles/ops/skills/opencrabs-dev/`):

| File | Lines |
|---|---|
| `SKILL.md` | 555 |
| `fleet-directives.md` | 651 |
| `editor.md` | 633 |
| `editor-upstream-pr.md` | 227 |
| `hq.md` | 317 |
| `triage.md` | 245 |
| `toolsmith.md` | 105 |
| `tools/RC-CONTRACT.md` | 113 |
| `review-lenses.md` (lens catalog / my brief) | 264 |
| `/root/.opencrabs/profiles/ops/opencrabs-dev/mechanical-audit-20260912.md` (prior M2 audit) | read in full |

**Method disclosure (required honesty):** I am a READ-ONLY sub-agent with no shell, so `wc -l` was not runnable. The counts above are the **tool's own file-length report**, obtained as a side effect of `read_file` (`Start line 100000 exceeds file length N`). They are not estimates, but they are not `wc -l` output either.

**`tools/` surface skimmed (to know what could host a finding)** — grepped, never executed: `oc-commit`, `oc-ship-chain`, `oc-prchecks`, `oc-ledger`, `oc-smoke-evidence`, `oc-deploy`, `oc-harvest-sweep`, `oc-harvest-dispatch`, `oc-rebase-safety`, `oc-branch-sweep`, `oc-upstream-delta`, `oc-health`, `oc-watcher-audit`, `lib/oc-snap.sh`, `lib/oc-log.sh`, `tools/archive/compiler.md`. All greps used `regex=true` (the built-in `grep` matches literally otherwise — a false-negative trap; see the law it is a corollary of, `fleet-directives.md §Verification-discipline additions`).

**No M2 finding is re-filed here.** Where I concur with an M2 item I say so by number.

---

## 2. THE TEST (quoted verbatim from `review-lenses.md:101-133`, the Reviewer J brief)

> **is this decision a pure function of state on disk?** If it is, the rule is a TOOL SPEC THAT HAS NOT BEEN WRITTEN YET and the finding names the tool half. Owner principle (2026-09-12, verbatim): *"that should be purely mechanical"* — law must not assign to an agent any decision a tool can settle from the tree, the ledger, the journal, git, or an API.
>
> **T1** the decision is a pure function of state on disk (no human judgement, no owner taste) · **T2** a tool already touches that state, or an existing tool is the natural host · **T3** the rule currently asks an AGENT to remember, derive, or re-check that state by hand. **T3 is the tell:** a rule phrased as an instruction to a reader (*"always verify…"*, *"never forget to…"*, *"run X before Y"*, *"re-derive the set"*) is the defect class. Failing T3 = already mechanical, the prose is descriptive, NO ACTION. Failing T1 = a GATE (owner/design/verdict) and prose is its correct home — automating it would delete the human, which is the point of the gate; a gate is NEVER a J finding.
>
> EVIDENCE FORMAT — each finding carries (a) the law site, file + verbatim quote, (b) the state the decision reads, (c) the tool that should own it and its single-command interface, (d) the cost already paid (incident, ledger row, run id) or the word `unpriced`. **A finding with no (c) is not a finding** — it is the rule restated in other words, and HQ REJECTS it.

Boundaries applied: **vs C** — object is law text → J, object is a procedure → C. **vs D/H** — the ARTIFACT and its verdict belong to D/H; J owns the LAW SENTENCE that assigns the decision. **NOT this lens** — whether a law-cited verb/flag *exists* (phantom-verb class, M2-18, now the real tool `oc-lint-laws`).

---

## 3. Findings

### J-1 — The pre-PR `--fast` prohibition has no enforcement path, and no receipt records the gate MODE

**(a) Law site** — `fleet-directives.md:268` `## Full-Gate Pre-PR Testing Law (v0.4.149, owner order 2026-09-12) [LANE]`:

- `:270` — "**Full CI Suite Mandatory for Upstream PRs**: The `--fast` flag (`fast=true`, lint/clippy only) is strictly permitted for internal Daytime Split-Gate merging (`oc-ship-chain`), but is **STRICTLY PROHIBITED** for final pre-PR verification."
- `:271` — "**Upstream Triad Verification**: Before opening any upstream PR (`editor-upstream-pr.md` Phase 7 / 7c), editors MUST run the full test suite (`cargo test --all-features` + fmt + clippy) via `oc-prchecks` full gate:"
- `:276` — "**PR Citation**: The resulting GREEN run URL from the full CI run MUST be cited in the upstream PR body alongside the behavioral smoke test evidence."

**(b) State the decision reads** — the GATE MODE (`fast` dispatch input) of the run behind the URL cited in the PR body. It is API state, readable after the fact; today no artifact distinguishes a fast run from a full one.

**(c) Tool half** — `oc-prchecks` already owns the dispatch *and already branches on the mode*: `tools/oc-prchecks:470` `--fast)    FAST_MODE=1 ;;` and `:636` `[ "$FAST_MODE" -eq 1 ] && DISPATCH_ARGS+=(-f "fast=true")`. `oc-ship-chain` defaults to fast — `:174` `--fast)            FAST_GATE=1; shift ;;`, `:579` `[ "$FAST_GATE" -eq 1 ] && PRCHECKS_CALL+=(--fast)`. So the mode exists only inside the process; nothing persists it.
Single command: `tools/oc-harvest-sweep <pr-branch> --require-full-gate <run-id>` → **rc 0 FULL-GATE-CONFIRMED / rc 1 FAST-GATE-REFUSED** naming the mode; plus have `oc-prchecks` stamp `fast=<0|1>` onto its own tools.log row so the mode is decidable from the record.

**(d) Cost** — `unpriced` (no incident named; the law shipped the day it was written). The standing exposure is structural: the fast gate and the full gate (`~30 min`, `tools/oc-ship-chain:22`) leave **identical downstream receipts**, so "I ran the full gate" is unverifiable after the fact — the T3 tell ("MUST run", "STRICTLY PROHIBITED") with no tool behind it.

---

### J-2 — L4 packaging-sha stamps: the packaging tip is re-derived by hand, and the smoke row never carries it

**(a) Law site** — `fleet-directives.md:327` `### L4 — Smoke stamps cite the PACKAGING sha`:

- `:329` — "Every `smoke-verdicts.log` row's `sha=` MUST be the sha actually under test — for a harvest candidate that is the **packaging tip** (the branch head being filed), never an ancestor it was built from. A row citing an ancestor does not cover the packaging sha and cannot back a PR filing."
- `:331` — "Worked example: the #172 row at 01:56:01Z cited `3b095f27` while the packaging tip was `f45d6323` — the stamp never covered the candidate, so a fresh row was required after the full gate. When the packaging sha moves, the row is SUPERSEDED: append a new row, never edit the old one."

**(b) State the decision reads** — the packaging tip (`git rev-parse <branch>` in the fork repo) versus the sha the row actually carries.

**(c) Tool half** — `oc-smoke-evidence` writes the row (`tools/oc-smoke-evidence:180` `append_log "$APPEND_LOG" "$OUT" || die 3 "append-log failed: $APPEND_LOG"`) and already resolves its own shas (`:118-124`: `SRC_SHA="$(jq -r '.sha // ""' "$STATE_DIR/deployed.meta.json")"`, `DEPLOYED_SHA="$(head -1 "$STATE_DIR/deployed.sha" 2>/dev/null || echo '')"`) — but it never resolves the branch tip under test, so the "does this row cover the packaging sha" question is left entirely to the lane.
Single command: `tools/oc-smoke-evidence --append-log --packaging-tip <branch>` → resolves the tip in-repo and refuses (**rc 1 ANCESTOR-ONLY**, naming tip and row sha); the Phase-7 pre-gate gains `tools/oc-harvest-sweep <branch> --require-smoke` → **rc 0 SMOKE-COVERS-TIP / rc 1 ANCESTOR-ONLY**.

**(d) Cost** — the #172 row at 01:56:01Z (cited `3b095f27`, tip `f45d6323`), quoted in the law; a fresh row was required after the full gate.

**Boundary** — M2-7 files the *pre-filing 4-leg coverage* check on `oc-ship-chain`. This is the *packaging-sha keying of the row itself*; the verdict on any given smoke row stays D/H's.

---

### J-3 — Base-freshness at filing time: the tested upstream base sha is recorded by hand

**(a) Law site** — `editor-upstream-pr.md:126` (§Phase 7), verbatim across `:126-130`:

> "- **BASE-FRESHNESS AT FILING TIME (Triage lesson n=2083, v0.4.111):** the
>   sweep and every gate run are valid against a NAMED upstream base — record
>   the `adolfousier/main` sha the verification was tested against; a census/
>   gate CLEAN result that does not name its base sha is not a CLEAN receipt
>   (stale-base CLEANs masked #1451's CONFLICTING for hours)."

**(b) State the decision reads** — the live `adolfousier/main` tip sha versus the base sha named in the CLEAN receipt. Both are `git rev-parse` output.

**(c) Tool half** — `oc-harvest-sweep` already resolves the base itself: `tools/oc-harvest-sweep:26` `BASE="adolfousier/main"; REPO="$HOME/opencrabs"` and `:63-64` `git -C "$REPO" rev-parse --verify -q "$BRANCH" >/dev/null || die 3 …` / `git -C "$REPO" rev-parse --verify -q "$BASE"   >/dev/null || die 3 "base ref not found…"`. `oc-harvest-census` owns the census registry for the same lifecycle.
Single command: `tools/oc-harvest-sweep <pr-branch> --stamp-base` → emits/stamps `base=<sha>` into its own receipt and returns **rc 1 STALE-BASE** (naming recorded vs live tip) when the receipt's base is not the current `adolfousier/main`.

**(d) Cost** — Triage lesson **n=2083**; stale-base CLEANs masked **#1451**'s CONFLICTING for hours (both quoted in the law).

---

### J-4 — State-repo destructive git ops: the deployed-state dirtiness check is manual

**(a) Law site** — `fleet-directives.md:556` `## Deployed-state markers and state-repo hygiene (owner incident #2066, ruled 2026-09-08 ~16:4xZ)`, `:558`:

> "- **NO `git stash`/`checkout`/`clean` inside the opencrabs-dev STATE repo** without first checking for uncommitted deployed-state files (`deployed.sha`, `deployed.meta.json`, `baseline.json`). oc-deploy writes swap markers as working-tree changes; they are committed only by oc-ledger's next state commit. Stashing reverts deployed-state to a stale sha while the box runs the new binary — smoke-evidence then reports MISMATCH on a CORRECT deploy. Origin: HQ stash at 16:06:54Z during a cleanliness check reverted #134 swap markers (n=2066)."

**(b) State the decision reads** — the state repo's working-tree dirty set (`git status --porcelain`), restricted to the three paths the law names literally.

**(c) Tool half** — `oc-ledger` already owns this repo (it is the tool that commits the state stamps), and the directory is parameterised (`OC_DEPLOY_STATE_DIR`, the same variable `oc-smoke-evidence` resolves at `:52`).
Single command: `tools/oc-ledger state-guard` → **rc 0 CLEAN / rc 3 DEPLOYED-STATE-DIRTY** naming the dirty path, called by the hygiene step before any stash/checkout/clean — or a `tools/oc-state-git stash|checkout|clean` wrapper that refuses the three verbs outright. Verified this session: **no tool reads that dirty set** — a `tools/`-wide grep for `symbolic-ref|detached|HEAD` matches only `oc-commit`'s detached-HEAD gate (below), and no destructive-git guard exists anywhere in `tools/`.

**(d) Cost** — **n=2066** (HQ stash at 16:06:54Z reverting #134 swap markers), quoted in the law. The follow-on damage is named in the same sentence: a stale marker makes `oc-smoke-evidence` report MISMATCH on a correct deploy.

**Boundary** — M2-5 files the missing guard in `oc-commit` for *generic dirty-path staging* in the source repo. This is a different repo, a different law, and a fixed three-path set.

---

### J-5 — Atomic-write mode preservation: `chmod --reference` is an instruction to the writer, with no tool

**(a) Law site** — `fleet-directives.md:616` `## Atomic Write Executable Preservation Law (v0.4.142)`, `:618-620`:

> "When modifying executable scripts (`tools/oc-*`, bash helpers) via temporary staging files (`temp + mv` atomic write pattern), **never assume default permissions**:
> - Standard temp file creation (`touch`, `tempfile`) defaults to mode `0644`. `mv` preserves the source inode permissions, stripping the `+x` bit on the target executable.
> - **Mandatory rule:** Always explicitly apply `chmod --reference="$target" "$temp"` (or `chmod 755 "$temp"`) prior to moving the temp file over the target."

**(b) State the decision reads** — the mode bits of the target versus the staging file. Both on disk, both readable by one `stat` / `chmod --reference`.

**(c) Tool half** — none exists: a `tools/`-wide grep for `chmod --reference|chmod --ref` returns **no matches**. The natural host is the atomic-write wrapper the sibling law already demands — `fleet-directives.md:590` `## In-flight script rewrite is a hazard — write tools/ atomically` (`:601`: "If the write cannot wait, write a temp file **in the same directory** and `mv` it over the target").
Single command: `tools/oc-safe-write <path>` → stages a temp file in the same directory, applies `chmod --reference="$target" "$temp"`, then `mv`s it over — **rc 0 written / rc 1 IN-FLIGHT-REFUSED** (naming pid + etime).

**(d) Cost** — `unpriced` (the law text names no incident). Residual load-bearing value: the in-flight mirror guard deliberately **falls back to running direct** when it cannot build its mirror — `tools/lib/oc-snap.sh:51` `printf 'oc-snap: cannot create %s — running direct (EXPOSED)\n'` and `:65` `printf 'oc-snap: copy failed — running direct (EXPOSED)\n'` — so the atomic-write path this law describes is still the belt-and-braces, and today it is prose only.

---

## 4. Checked and found CLEAN (already mechanical — NO ACTION, with the evidence)

1. **Detached-HEAD law** (`editor.md` Phase 4: confirm `git symbolic-ref -q HEAD` resolves BEFORE committing + signing) — **already mechanical in the `oc-commit` path**: `tools/oc-commit:111` `# gate 1: HEAD attached (incident class: commits landing nowhere)`, `:112` `$G symbolic-ref -q HEAD >/dev/null 2>&1 \`, `:113` `|| { echo "gate-fail: DETACHED HEAD in $REPO — attach a branch first" >&2; exit 3; }`. CLEAN for the wrapper path.
2. **Ledger claim read-back** (`editor.md` Phase 1 step 4) — **already mechanical**: `tools/oc-ledger:341` `# read-back self-verify (Duty-6 lens C2, 2026-08-31): never trust the write —`, `:349` `echo "stamped n=$n kind=$k (read-back ok)"`, and `:266` `# M2-24 (2026-09-12): the value derive_by PRODUCES must be round-trippable.` CLEAN — I judged this a **deliberate non-finding**: the surviving lane-side half ("does the row carry MY uuid/issue/branch") is a semantic judgement, not state-derivable, so it fails T1.
3. **Smoke-log path (M2-2)** — fixed and verified in `tools/oc-smoke-evidence:22-27`, `:52` (`CANON_LOG="$STATE_DIR/smoke-verdicts.log"   # M2-2: the ONLY sanctioned target`), `:59-67` (bare → canonical / absolute → honoured / relative → STATE_DIR), `:101-103` (divergent target announced LOUDLY). CLEAN; not re-filed.
4. **Selftest log suppression (M2-21)** — fixed by Toolsmith `ba44e481`; documented in `tools/RC-CONTRACT.md §Unified tools log`. CLEAN; not re-filed.
5. **Corpus lint (M2-18)** — now a real tool, `tools/oc-lint-laws` (phantom-flag / phantom-verb / unknown-tool classes, `--strict`, `--show-citations`). CLEAN; not re-filed.
6. **In-flight script rewrite** (`fleet-directives.md:590-601`, fork #167) — the law's **tool half has LANDED**: `tools/lib/oc-snap.sh` (mirror + `oc_snap_guard`, full `cp -a` copy so symlinked siblings cannot re-open the hole; `oc_snap_reap` for dead mirrors), wired into all four long-running tools — `tools/oc-ship-chain:96-98`, `tools/oc-job-verify:26-28`, `tools/oc-deploy:131-133`, `tools/oc-prchecks:54-56` — and reaped by health (`tools/oc-health:480-481` sources the lib). The law's manual `ps -eo pid,etime,args | grep -E …` step is therefore **superseded prose** (the hazard it guards is now closed in-tool for exactly the four tools it names). Not a J finding — the tool already owns the decision; **flagged for HQ as a candidate retirement** of the hand-check paragraph, not for Toolsmith.
7. **Merge-base / ancestry laws** — all tool-backed: `tools/oc-rebase-safety:135`, `tools/oc-deploy:218,225,1467,2691,2747`, `tools/oc-branch-sweep:57`, `tools/oc-harvest-dispatch:85`, `tools/oc-upstream-delta:199`. CLEAN.
8. **The M2 §3 "already mechanical" set** — I concur on inspection of `tools/RC-CONTRACT.md`: features-compat gate, swap mutex (`host-swap.lock`), rebase-aware lineage monotonicity, merge serialization, carrier coalescence/ancestry matching, stray-path sweep (rc 7), Gate 4 UNSIGNED, poll floor/ceiling, `oc-review-persist` re-read sha256 verify, `oc-health` rotating classes + SAFE-only `--reap`, `oc-watcher-audit` interval law. No new J finding.
9. **FLAGGED, not filed — smoke-verdict uniqueness** (`SKILL.md:502`: "ONE formal SMOKE verdict per editor-feature lane: exactly one PASS/FAIL; duplicate confirmations are noise (#1227 lane double-report, 2026-08-26).") — the append path (`oc-smoke-evidence:180`) cannot enforce this because the **row carries no lane key**: the evidence block (`:118-127`) emits `pid`, `exe_path`, `exe_sha256`, `artifact_sha256`, `source_sha`, `deployed.sha`, `run_id`, `swapped_at`, `identity`, markers, `VERDICT` — and a grep of the tool for `dup|already|existing` returns **no matches**. I did **not** file it: the law is a prohibition, not an instruction to re-derive state, so T3 fails; but the **row-key gap is worth HQ's eye** (a uniqueness law keyed on a field the artifact cannot express).
10. **Carried from the M2 audit §6, not re-filed** — `oc-review-persist`'s `LENSES` whitelist and its `[A-I]` case-globs end at `I`, so a **J report may be refused rc 2** until Toolsmith lands that fix. This report is therefore written to be persisted verbatim by whatever path HQ has available.

---

## 5. GATES — fail T1, explicitly NOT findings (the test, applied)

These decisions are owner/design/verdict functions; automating them would delete the human, which is the point of the gate:

- Owner design gate + fix-approval (`fleet-directives.md:124-129`); stage-entry consent (`:137`); no auto-rollback on smoke FAIL (`:141`); parked-issues owner standdown (`:246`); HQ rulings / ownership arbitration (`hq.md` Duty 5); Decision Rollcall (`:431`); `brain-scrub` lens (`:477`); L3 owner-verdict timing (`:321`); the `PARKED-OWNER-EYE` release decision (`:298-312`); cross-lane delivery urgency call quiet/turn-end/now (`:400`); the "what now/next" block (`:427`).
- **M2-13 concurrence, not re-filed** — Guard-Flag Escalation Law routing (`:333`) is already the M2 audit's prose-routing item.
- **M2 §4 concurrence** — verification scoped by load-bearing, attribution guard, owner-dependent smoke legs, brain-scrub: judgement, stays prose.

---

## 6. What I did NOT check (scope limits)

- Not read: `CHANGELOG.md`, `README.md`, `war-stories.md`, `upstream-merge-runbook.md`, `editor-phase7-rules.md`, `s2-swap-journal-spec.md`, `tools/HEALTH-CHECKS.md`, `tools/HEALTH-CLASSES.md`, the `reviews/` report corpus, `tools/tests/run.sh` + `battery-last.json`, and the `tools/archive/*` surfaces.
- **No tool was executed** (read-only sub-agent, no shell) — so every tool-half claim above is a *code-read* of the tool, not a run receipt, and no selftest output is cited.
- **No ledger / journal / tools.log row was read.** Every cost figure (n=2066, n=2083, #1227, #1451, #167, #172, #1514) is quoted from law text or the M2 audit — **none was re-derived from the live record**.
- Line counts came from `read_file`'s own length errors, **not `wc -l`** (no shell available).
- Long table rows in `RC-CONTRACT.md` / `fleet-directives.md` that `read_file` rendered with "[line truncated: N chars total, showing first 2000]" were **not quoted** — I quote only text I saw rendered in full this session.

**Bottom line:** five fresh mechanical findings (J-1 … J-5), none of them an M2 re-file; three of the five (`J-2`, `J-3`, `J-4`) already have a natural host tool at the exact point in the procedure where the lane currently does the work by hand. The strongest evidence in this pass is also the most useful for HQ: **the in-flight-rewrite law's tool half has landed** (`oc-snap`), so that law's manual check is now dead prose — a retirement candidate, not a new defect.
