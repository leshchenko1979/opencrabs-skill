LENS=F (tools-code) | reviewer e44f80a4 | 2026-09-05 ~22:5xZ | scope: oc-waiter/oc-issue-log/oc-review-persist/RC-CONTRACT/lib-oc-embed/oc-ledger-concurrency
SUMMARY: 8 findings - 1 HIGH, 3 MED, 4 LOW. No-findings areas: oc-embed decoder pure+safe, oc-ledger atomic_jq/with_lock correct, flood-guard sound, kill-file rc9 battery-covered, sampled SKILL.md register rows match real flags/rc.
HIGH F1-F3 cluster (oc-waiter): printf-built JSON records with unescaped free-text --label/--ref -> one double-quote silently orphans the waiter (parse fail -> sweep skips forever, no verdict no notify). F-5 rec_upd swallows jq failure (returns rm rc 0) + /tmp cross-device mv non-atomic.
MED: F-4 same printf class in journal fragments. F-8 "report of record" oc-review-persist defaults to /tmp - reboot between persist and Duty-7 read-back reproduces the ghost incident the tool was built to kill.
LOW: F-6 mktemp bodies without EXIT trap (oc-issue-log, oc-drift-check fixtures); F-7 RC-CONTRACT register incomplete for oc-review-persist (missing rc 3/4) + usage errors answering 4/1 where contract says 2.
RESOLUTIONS (reviewer-proposed): jq -n --arg construction for waiter records; mktemp beside target + rc-honest rec_upd; OC_REVIEW_DIR default to state dir; EXIT traps; register completion.
PRIORITY NOTE: oc-waiter defects are load-bearing (HQ continuation doc lists waiter-arming; #74 proposes canonicalizing it) - fix before canonicalization.
PERSISTED-BY: HQ d72bd52d; full report in subagent status file e44f80a4.json
