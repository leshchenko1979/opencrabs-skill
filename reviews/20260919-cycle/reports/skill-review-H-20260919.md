# Lens H - cycle 20260919-cycle
## Verdict: Ledger is coherent on claim lifecycle and contradiction handling (retractions present), but its three authoritative version fields are stale by one version — 0.4.204 while SKILL.md and CHANGELOG read 0.4.205, with no skill-bump row and 14+ workers already acked at 0.4.205.

## Findings

**[HIGH] v0.4.205 shipped and acked, never stamped — three version fields stale**
locator: `workers-ledger.json` lines 4 / 1056 / 1077 + row n=8618
QUOTE (L4): `"current_skill_version": "0.4.204",` — against `SKILL.md:17` `version: 0.4.205` and `CHANGELOG.md:3` `## v0.4.205 (2026-09-18)`. No `"kind": "skill-bump"` row exists for 0.4.205; the only 0.4.205 row is n=8618, kind `note`: `"Ledger version fields still MISMATCH at 0.4.204."`
why: the ledger's own version truth contradicts the skill it registers and the 16 ack rows at 0.4.205 (n=8609, 8612-8616, 8619, 8622, 8630, 8668, 8671, 8681, 8683, 8701, 8707, 8708 all read "acked 0.4.205"). `oc-ledger check-version` compares SKILL.md to the 3 fields and returns rc 1 mismatch; cadence has no skill-bump anchor for the newest version.
fix: the recorded blocker is gone — n=8650 records `"#307 CLOSED 21:42Z (fix 5bde725f/1a0ca40d)"`. Run `oc-ledger sync --version 0.4.205 --why <text>` and let it stamp the skill-bump row; if split plan 0117dd29 Task 10 ("Notify the lanes per the skill-change law", per n=8717) still holds, stamp the HOLD as its own row so the mismatch is dated rather than silent.

**[MED] Row n=51512 mis-cites its own sweep rows**
locator: ledger row n=51512
QUOTE: `"Sweep rows: #330 n=8335, #331 n=8333, #339 n=8332, #340 n=8337, #324 n=8338, #302 n=8339, #299 n=8340, #297 n=8341."`
why: n=8337 is not a dispatch — it is the v0.4.203 skill-bump row (`"what": "v0.4.203 — Law-text drift corrected..."`). #340's dispatch row is n=8331 (`"what": "Triage dispatch issue #340 to editor 63d775f9 — wire zero-ack claim-first"`), which the list omits entirely; the sweep actually spans n=8331-8341 (11 rows) but the list names 8. A correction row that mis-cites row numbers propagates the very defect it documents.
fix: HQ stamps a correction naming n=8331 for #340; sweep-row citations should be emitted by the tool, never hand-assembled.

**[MED] Unrostered actor writes the dispatch family**
locator: ledger rows n=8331-8341 (+ ~40 more)
QUOTE: `"by": "unrostered-actor c32f43ee-8f15-487f-8935-0deaded77159"` with `"what": "Triage dispatch issue #340 to editor 63d775f9 — wire zero-ack claim-first"`
why: c32f43ee appears as a `"uuid":` in NO roster row (roster runs d18ce16a, c6b1a539 ... 127429e6), yet writes rows labelled "Triage dispatch" — an unrostered writer plus misattribution to the Triage lane 530c29ec, the class the roster-retire/sign gate exists to prevent. n=51512 confirms the actor is the harvest cron: `"Wire-row actor = cron lane c32f43ee (oc-harvest-dispatch-4h id 73158e43)"`.
fix: enroll c32f43ee (or have the tool stamp its cron role) and label its rows "harvest-patrol", not "Triage".

**[LOW] START rows carry a corrupted branch name**
locator: ledger rows n=8601, 8627, 8674, 8691, 8734
QUOTE n=8601: `"START sha=6a83afd4ebf088b76ab9e0870f9bf085c310763f branix/341-cron-credential-resolution"` against its own pre-flight row n=8600 `"branch fix/341-cron-credential-resolution and sha 6a83afd4ebf088b76ab9e0870f9bf085c310763f present"`
why: the START row mangles "branch fix/" into "branix/" (and n=8734 into "brant/"), so the journal's own branch citation contradicts its sibling row; a reader reconstructing the ship from START alone reads a branch that does not exist.
fix: correct the oc-ship-chain START format string; the START row should carry the same branch literal as pre-flight.

## Coverage
Read: `review-lenses.md` §Reviewer H (FAMILY ARTIFACTS + neighbours in TOOLS/MECHANICAL/META); `workers-ledger.json` header+version fields (L1-5, L1040-1079), `workers[]` roster (L6-1040, 33 uuids), `consents[]` head (L53830-53900), `events[]` in full across n=8331-8341 and n=8597-8735, plus spot rows at L1867/L1902, L2231/L2245, L26601-26658, n=51512, n=52446, n=53003, L53736; `SKILL.md` frontmatter + version greps; `CHANGELOG.md` head (v0.4.203-205); `fd-split-20260918/BASELINE.md`; directory listing of state dir, `journal/`, `reviews/`, fd-split receipts.
Did NOT read: `tools.log` (9.7MB), `oc-deploy/journal/*.jsonl`, `smoke-verdicts.log`, `events[]` n=1246-8330 (sequence contiguity verified only inside sampled windows), any git/gh artifact; no `oc-ledger` verb was executed (read-restricted registry), so no cadence/check-version/roster tool stdout is cited.
