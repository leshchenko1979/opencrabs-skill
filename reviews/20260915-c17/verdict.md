# Duty 6 Combined Review Verdict: Cycle 20260915-c17
**Timestamp:** 2026-09-15 14:04 UTC (17:04 MSK)  
**Target:** OpenCrabs Skill `opencrabs-dev` (base version `v0.4.183`, commit `9a4afe21`)  
**State:** `opencrabs-dev/` (ledger boundary `n=6253`, cadence `42/5 FIRE`)

---

## 1. Executive Summary

Duty 4+6 review completed across all 11 lenses via 3 cohorts. All 11 lenses executed and delivered receipted findings.

- **Docs Family (Lenses A, B, G)**: Completed.
- **Tools & Mechanics Family (Lenses C, E, F, J)**: Completed.
- **Artifacts, Meta & Brain Scrub (Lenses D, H, I, BS)**: Completed.

---

## 2. Comprehensive Findings & Action Plan

### Family 1: Tools & Mechanics (Lenses C, E, F, J)
1. **[C-1 HIGH] Missing test battery coverage for `oc-log-search`**: Add section in `tools/tests/run.sh` asserting `--selftest`, `--help -> 0`, invalid flags `-> 2`.
2. **[C-2 MED] Missing test battery coverage for `oc-waiter`**: Add assertions in `run.sh` for `--help -> 0` and subcommands `-> 1`.
3. **[E-1 HIGH] Hardcoded `/root/` in `oc-skew-scan:75`**: Replace with dynamic `${OC_SKILL_DIR:-$HOME/...}/SKILL.md`.
4. **[E-2 MED] Hardcoded fallback in `oc-watcher-audit:530`**: Replace with dynamic `expanduser("~")`.
5. **[E-3 MED] Hardcoded `CANONICAL_LEDGER` in `oc-deploy:157`**: Replace with dynamic `${STATE_DIR}/workers-ledger.json`.
6. **[F-1 HIGH] Misattributed actor defaulting in `oc-smoke:242`**: Check `OC_ACTOR` / `OPENCRABS_SESSION_ID` and fallback to deployed commit's `Session-Id` trailer instead of `.workers[-1].uuid`.
7. **[F-2 MED] `oc-start:122` exits 2 on mid-loop `--help`**: Fix to exit 0.
8. **[J-1 HIGH] Format discrepancy in `oc-smoke:293`**: Format verdict row with explicit `run=`, `sha=`, `actor=`, `issue=`, `target=`, `evidence=` key tokens.
9. **[J-2 MED] Missing active claim check in `oc-start:135`**: Check `oc-ledger claims "$ISSUE"` and return code 3 if already actively claimed.
10. **[J-3 LOW] Branch prefix whitelist in `oc-start:128`**: Add `docs` and `refactor` to branch regex.

### Family 2: Documentation & Structure (Lenses A, B, G)
1. **[A-1 / B-1 MED] Subsumed Procedure Pruning**: Remove lingering manual worktree & carrier dispatch instructions from `fleet-directives.md`.
2. **[G-1 MED] Missing `DONE = ...` formulas**: Add checkable completion formulas across role files.

### Family 3: Artifacts, Meta & Brain Scrub (Lenses D, H, I, BS)
1. **[BS-1 MED] Brain file boundary**: Align git uncommitted check ownership into `AGENTS.md`.
2. **[BS-2 LOW] Brain file scrub**: Prune date parentheticals in `USER.md` and historical hex IDs in `AGENTS.md`.
3. **[D-1 MED] State hygiene**: Remove stale locks and archive `.bak` files older than 24h.
4. **[H-1 / I-1 PASS] Monotonicity & Version Parity**: Ledger validated monotonic and triad in sync.

---

## 3. Status
Verdict: **READY FOR CODIFICATION (v0.4.184)**
