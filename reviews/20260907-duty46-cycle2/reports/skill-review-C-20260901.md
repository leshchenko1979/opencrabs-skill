[2026-09-01T17:41:46Z] NOTE: same-day overwrite of prior version
# Duty 6 / Lens C review — v0.4.78 (base 63977f14), evidence/verification discipline

Battery last receipt on disk: tools/tests/battery-last.json = {"ts": "2026-09-01T15:26:48Z", "pass": 138, "fail": 0, "verdict": "PASS"}.

## HIGH-1 — "usage = 2 everywhere except oc-deploy/oc-ci-parity" is false on disk: 5 more tools never migrated, RC-CONTRACT.md contradicts itself

RC-CONTRACT.md:12-15 prose says usage→2 "EXCEPT the two legacy registers (oc-deploy 1, oc-ci-parity 5)". Same file's register lists FIVE additional non-2 usage codes, unflagged as legacy:
- RC-CONTRACT.md:22 `oc-artifact-verify | 0 | 1` — impl :82 `usage; exit 1`
- RC-CONTRACT.md:31 `oc-index-worktree | 0 | 5` — impl :64 `usage; exit 5`
- RC-CONTRACT.md:34 `oc-job-verify | 0 | 1` — impl :74 `usage; exit 1`
- RC-CONTRACT.md:36 `oc-order-validate | 0 | 1` — impl :66 `usage; exit 1`
- RC-CONTRACT.md:38 `oc-pr-atomicity | 0 | 1` — impl :65

Battery CEMENTS the contradiction (tests/run.sh sections 1/6/7 assert unknown-arg→1 / no-args→5 as correct). CHANGELOG C-#3 admits it migrated only "12 more tools" by name. So C-#3 delivered --help=0 fleet-wide (true, battery green) but "usage exit 2 except 2 legacy registers" is actually "except 7". Any lane keyed on uniform usage=2 misreads 5 tools. Fix: migrate the 5 or amend prose to list 7 legacy registers.

## MED-1 — `poll --notify-session` asserts the wake without verifying delivery: notify rc discarded, no journal, failure path untested

notify_session contract (oc-deploy:853: "verb rc (0 delivered)"; dead uuid → rc 2, gateway → rc 4). All three poll call sites (1567, 1586, 1601 — timeout, already-deployed, HANDOFF) discard the rc — no warn, no journal, no re-read. Supervisor sleeping on --notify-session can be silently never woken while poll exits verdict rc as if handoff happened. Contrast: fanout path DOES check rc + journal (battery asserts `"reason":"dead"` grep). Selftest 10b only exercises always-succeeding notify shim. Scope-(3) class: verdict emitted without durable evidence of the side effect it claims.

## MED-2 — C-#1 "prints WHY" is contract convention, but bare rc-2 parse sites survive (rc=2-storm class still unprotected)

Unprotected sites (unknown flag → bare rc 2, no diagnostic, no backoff): oc-wt:52/180 (`usage()` takes no reason), oc-attrib:49, oc-tg-audit:70, oc-carrier-features:37. Contrast compliant: oc-branch-sweep:37 `die 2 "unknown flag '$1'"`, oc-prchecks reason-taking usage() with 2s..10s backoff. Storm class (silent sub-second rc=2 tight loop, 2026-08-31 20:51Z) only mechanically closed for oc-prchecks.

## MED-3 — `--notify-session` missing value silently disables the wake (asymmetric with `--wait`)

oc-deploy:1468 `--notify-session) NOTIFY_SESSION="${2:-}"; shift ;;` — trailing flag (missing value) = empty var accepted silently; every wake site no-ops on `[ -n ... ]`. Same tool validates --wait properly (:1558 integer check). Same flag family, one guarded one not — the unguarded one is the "you'll be woken" promise.

## MED-4 — oc-attrib header promises rc 2 for "bad range syntax"; code exits 3; battery never tests it

Header :23 `2 usage / bad range syntax`; code :124 bad-range → exit 3. Battery 9b tests no-args→2 and empty-range→4 only — split invisible to suite. Related: `--repo) REPO="${2:-}"; shift ;;` (:41) eats missing value, surfaces later as exit 3 "not a git repo" — usage error masquerading as git-fail.

## LOW

- LOW-1 — scope-(2): all four new v0.4.78 flags ARE selftested (fault-scope shim case; --contributors 3-col check; --create 13/13b/13c; poll 10b/10c/10d) but (a) no dedicated black-box battery rows, (b) oc-prchecks DEFAULT fault-tool wiring never exercised (selftest overrides via OC_PRCHECKS_FAULT_SCOPE — broken default path would pass green), (c) notify-failure leg of MED-1 untested.
- LOW-2 — oc-wt reuses verdict 3 out-of-vocabulary for branch-create/worktree failures (register reserves 3 for path-exists-dirty; lane decoding rc 3 gets wrong remediation advice).

## Verified green
--help=0 genuinely fleet-honored (battery section 60, PASS 138/0 at 15:26:48Z post-v0.4.78). Good exemplars: oc-review-persist help register; oc-wt remove --force journaling destroyed listing BEFORE removal.

## Not covered (time)
editor.md/supervisor.md prose rituals beyond the notify finding; full oc-deploy selftest line-by-line; tools/archive/.
