[2026-09-01T17:41:46Z] NOTE: same-day overwrite of prior version
# Duty 6 / Lens F — tooling/code drift review (base 63977f14, v0.4.78)

## HIGH-1 — issue #63 CONFIRMED: `oc-deploy poll` fatal-exits rc 2 on an unparseable job name; no skip-on-unparseable, no run fallback

tools/oc-deploy:1574-1577 (inside the poll `--wait` loop — one bad run kills the whole blocked loop):
```
      JOB_NAME="$("$GH" api "repos/$FORK/actions/runs/$RUN_ID/jobs" 2>/dev/null \
        | jq -r '[.jobs[] | select(.name | test("\\([0-9a-f]{40}"))][0].name // empty')"
      B_SHA="$(oc_decode_job_embed "$JOB_NAME" | cut -d'|' -p1)"   # shared decoder (E2 v0.4.77)
      [ -n "$B_SHA" ] || die 2 "cannot decode built sha from job name: $JOB_NAME"
```
Root cause = filter/decoder strictness mismatch:
- jq pre-filter only requires `\([0-9a-f]{40}` (open-paren + 40-hex, NO comma required).
- shared decoder tools/lib/oc-embed.sh:15 demands full `(<sha>, <features>)`: `sed -nE 's/.*\(([0-9a-f]{40}),[[:space:]]*([^)]*)\).*/\1|\2/p'`.
Any job name carrying `(sha)` without comma passes jq, decodes empty → die 2. The class is admitted in-fleet: tools/oc-artifact-verify:138 "the ORDER gates job has no comma after the sha, so it decodes empty". Poll fetches 3 runs but only attempts `.workflow_runs[0].id` — no fallback row. Skip-unparseable absent.

Drift evidence (correct skip-loop exists elsewhere): oc-job-verify:117-122 (iterates ALL jobs, breaks on first decode, fails only after exhaustion, documents legacy-format tolerance at :128); oc-artifact-verify:141-144 same. oc-deploy does jq-select-first + one decode + die. Poll ALSO inlines instead of calling its own decode_built_sha helper (oc-deploy:877-884 — identical loose+strict shape): two copies of the defect in one file.

Selftest blind spot: gh stub feeds only new-format names + bare "ORDER gates" with no embed — the production `(sha)`-no-comma shape can never surface in selftest. Why 145/0 green coexists with two live strikes.

## HIGH-2 — GREEN fan-out: tail wiring IS present at this sha (lane 462181e9's mechanism claim refuted), but silent loss on direct swap-execute is REAL via three subshell paths

Verified wiring: GREEN leg at swap-execute tail oc-deploy:1317-1319 (post-verify-match, non-drill); RED piggyback at poll:1546-1552; standalone:1619-1621. NO GREEN fan-out on poll path; CHANGELOG v0.4.37 confirms tail wiring. Lane's "rides the POLL path" NOT supported by base-sha disk (unless 16:13Z swap ran from stale checkout — unverifiable read-only).

Three real loss paths for direct swap-execute:
1. Same root cause as HIGH-1 inside fanout subshell — oc-deploy:1069-1070: `decode_built_sha` loose-jq+strict-sed → `(sha)`-no-comma run dies rc 3 in subshell; swap stands, ledger stamped fanout=rc=3, fanout.state never marked, no notify — exactly the observed gap (fanout.state max 11:48Z vs GREEN swap 16:13:24Z unmarked).
2. Mismatched `--sha`/`--run` on direct invocation — oc-deploy:1071-1075: `[ "$bsha" != "$dep" ]` → reason=not-deployed-yet, returns WITHOUT marking done — permanently silent GREEN leg.
3. Failure surfacing stderr-only — oc-deploy:1320 (echo to stderr; under systemd-run transient unit it lands in unit journal; nothing retries, nothing notifies). Alternative hypothesis to rule out from ledger event text: `fanout=skipped` ⇒ OC_DEPLOY_NOFANOUT=1 exported around the direct invocation.

Diagnostic sub-note: caller discards decode_built_sha's rc (line 1069 no `||` guard) — gh-API failure (`|| return 3` at :880) mislabeled "cannot decode" in journal.

## MED-1 — Same fatal-parse family in `oc-ping-proof`: one unparseable roster stamp kills the whole wake scan
oc-ping-proof:82 `EP="$(to_epoch "$st")" || { … exit 4; }` over EVERY worker event timestamp — single malformed `.at` ⇒ that worker's verdict permanently rc 4 instead of WOKEN/SILENT. Should skip bad stamp, keep scanning (#63 defect class).

## MED-2 — RC-CONTRACT.md prose contradicts its own register table
Preamble "two legacy registers" vs table registering SEVEN non-2 usage codes (oc-deploy 1, oc-ci-parity 5, oc-artifact-verify 1, oc-job-verify 1, oc-order-validate 1, oc-pr-atomicity 1, oc-index-worktree 5) — code↔table agree; prose stale; battery only asserts --help=0 so usage-code prose unguarded.

## LOW
- LOW-1 — GREEN leg conflates oc-attrib failure with empty output (oc-deploy:918; attrib piped through `|| true`, rc lost; empty range vs broken marker both die rc 3 in subshell → silent unmarked fan-out).
- LOW-2 — poll duplicates the decode instead of reusing decode_built_sha (1574-1577 vs 877-884) — fix must land twice; the drift condition that produced #63.

**One-line summary:** #63 real, rooted in loose-jq/strict-sed strictness mismatch with die-instead-of-skip at oc-deploy:1577; GREEN fan-out IS wired at swap-execute tail (lane's mechanism claim refuted) but silently dies on the SAME decode defect inside its subshell (oc-deploy:1070), fully explaining the missing 16:13Z fanout.state row.
