[2026-09-01T17:41:46Z] NOTE: same-day overwrite of prior version
# Duty 6 / Lens A review — redundancy & contradiction report
Base: `63977f14` (v0.4.78), repo `/root/.opencrabs/profiles/ops/skills/opencrabs-dev/`. Read-only; all quotes verbatim from disk. Tool headers used as ground truth to arbitrate doc-vs-doc drift.

## HIGH

### H1 — The rc register exists TWICE and has already drifted apart (the split was half-done)
v0.4.78 created `tools/RC-CONTRACT.md` and points at it as the register, but SKILL.md's tool table still carries its own full "Exit-coded" column on all 30 rows, and README.md names the SKILL.md table as the authority. Three conflicting source-of-truth claims:

- `SKILL.md:38` — `> Fleet-wide rc conventions (help=0, usage=2, legacy exceptions) + per-tool register: tools/RC-CONTRACT.md (v0.4.78):`
- `README.md:34` — `Full register with rc codes lives in **SKILL.md** — that table is the source of truth.`
- `tools/RC-CONTRACT.md` (header) — `Fleet-wide conventions, then the per-tool register.`

Row-level drift between the two registers (SKILL.md table vs RC-CONTRACT table), arbitrated against tool headers:

| Tool | SKILL.md | RC-CONTRACT.md | tool header (truth) |
|---|---|---|---|
| oc-shadow-rotate | `0 ok-or-noop / 1 usage / 2 io-fail` (SKILL.md:59) | `0 ok-noop / 2 io-fail (usage merged into 2, C-#3)` | `tools/oc-shadow-rotate:28` `Exit: 0 ok/noop | 2 usage-or-io-fail` |
| oc-prchecks | omits rc 6 | has `6 CANCELLED-superseded` | `tools/oc-prchecks:86` `… / 6 CANCELLED-superseded (P4) / 7 carrier-head-unresolvable` |
| oc-seal-state | has `1 invocation` | `usage=2`, no rc 1 | `tools/oc-seal-state:32` `0 OK | 1 invocation | 2 CONTRIBUTOR-SCAN-FAIL | 3 WRITE-FAIL/INVALID` |
| oc-job-verify | full 0–5 | only `0 VERIFIED / 2 IN-FLIGHT` | `tools/oc-job-verify:46` (full 0–5 register) |
| oc-artifact-verify | has rc 4/5 | only `0/2/3` | `tools/oc-artifact-verify:49` `… / 4 SHA/PROVENANCE-MISMATCH / 5 VERSION-MISMATCH` |
| oc-order-validate | has `4 UNKNOWN-REF` | only `0/2/3` | `tools/oc-order-validate:39` `… / 4 UNKNOWN-REF` |
| oc-ledger | full 0…6 | only `0/1` | `tools/oc-ledger:36-38` `… 5 battery gate · 6 version mismatch` |
| oc-review-persist | has `3/4` | only `0 persisted` | tool header `0/2/3 re-read sha256 mismatch/4 write failure` |

Shadow-rotate is sharpest: SKILL.md (the file every role loads) still teaches rc 1 usage, which the tool abolished and CHANGELOG v0.4.78 documents.

### H2 — RC-CONTRACT.md's preamble contradicts its own table ("two legacy exceptions")
Preamble: usage=2 "EXCEPT the two legacy registers (`oc-deploy` 1, `oc-ci-parity` 5)". Same file's table rows: oc-artifact-verify 1, oc-job-verify 1, oc-order-validate 1, oc-pr-atomicity 1, oc-index-worktree 5 — five additional tools with usage≠2 sit in the very table the preamble claims covers the rule. Echoed at SKILL.md:38.

### H3 — oc-seal-state: registers disagree whether rc 1 exists; RC-CONTRACT row has an in-row rc collision
RC-CONTRACT:42 usage column 2 collides with verdict 2 in same row, rc 1 dropped; SKILL.md:46 keeps rc 1, no usage merge; tool header (truth): `0 OK | 1 invocation | 2 CONTRIBUTOR-SCAN-FAIL | 3 WRITE-FAIL/INVALID`. Both registers incomplete in different directions.

## MED

- **M1 — oc-ledger rc 6 (C8 sync-gate) absent from the "authoritative" register; rc 1 mislabeled** (RC-CONTRACT omits rc 3/4/5/6; `sync` gate dies rc 6 per tools/oc-ledger:36-38; README/ship-discipline step 5 rests on it).
- **M2 — README.md stale by two versions, contradicts v0.4.78 split in 4 places:** "Current: v0.4.76" (repo at v0.4.78), layout table missing RC-CONTRACT.md / review-lenses.md / editor-phase7-rules.md, oc-deploy selftest count stale (148 vs 159), "30 executables" vs 29 live + 1 archived. v0.4.77's "README truth fix (B20)" already false again — no ship-discipline step updates README on bump.
- **M3 — oc-pr-atomicity: three different shapes across the three registers** (SKILL.md `0/2/4` omits rc 1; RC-CONTRACT `0/1` omits rc 4; tool header truth `0 ATOMIC | 1 invocation | 2 NON-ATOMIC | 4 PR not found`).

## LOW

- **L1 —** verbatim sentence duplicated supervisor.md:133 ↔ review-lenses.md header (Duty-6 split echo); family map stated 3×.
- **L2 —** SKILL.md:290 glossary still resolves Lens to supervisor.md only, not review-lenses.md.
- **L3 —** RC-CONTRACT overclaims battery asserts usage-line+register; battery (run.sh:559) only asserts rc=0, output discarded.
- **L4 —** broken markdown table in SKILL.md §Shared war stories (blank line at :563 terminates it; last 4 rows render as pipe-text).
- **L5 —** same-code naming drift across registers (marker-missing ×3 spellings; NOT-FOUND vs RUN-NOT-FOUND; ledger rc-3 name ×3).

## Verified CLEAN
editor.md Phase 7 ↔ editor-phase7-rules.md split clean (B11/B12 landed correctly); supervisor.md ↔ review-lenses.md split clean; battery section exists; 29-tool register matches disk.

**Bottom line:** the C-#3 split created the duplicate-register condition Lens A exists to catch — two rc tables + README pointing at the older one, 8/30 rows drifted, one internal contradiction (H2). Cure direction: RC-CONTRACT.md sole full register; collapse SKILL.md Exit column to verdict-only/pointer; fix README source-of-truth + version facts in same batch.
