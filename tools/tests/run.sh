#!/usr/bin/env bash
# =============================================================================
# tools/tests/run.sh — repeatable test suite for the oc-* CLI tools.
#
# One command to run the whole suite:
#     bash tools/tests/run.sh
#
# Each tool gets its own --selftest AND a dedicated edge-case test that proved
# fatal during the build. Exit 0 only if EVERY test passes; any failure prints
# a line and exits nonzero (1 = test failed, 2 = harness error/tool missing).
#
# The oc-seal-state IFS-join regression here is the one that silently dropped
# pipe operators between jq filters (fix 2026-08-26) — if it ever comes back,
# this suite goes red before anyone trusts a seal.
# =============================================================================
set -u
TOOLS_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PASS=0 FAIL=0
# Battery stays silent in the unified tools log: every suite invocation is a
# synthetic run, not fleet activity (KERNEL batch D0, 2026-08-28).
export OC_TOOLS_NOLOG=1

# ---- helpers ---------------------------------------------------------------
note()  { printf '%s\n' "$*"; }
ok()    { PASS=$((PASS+1)); note "  ok   - $*"; }
bad()   { FAIL=$((FAIL+1)); note "  FAIL - $*"; }
tool()  { [ -x "$TOOLS_DIR/$1" ] || { bad "missing tool: $1"; return 1; } }
section() { note ""; note "== $1 =="; }
run_selftest() {
  local t="$1"
  if [ ! -x "$TOOLS_DIR/$t" ]; then bad "$t missing or not executable"; return 1; fi
  if "$TOOLS_DIR/$t" --selftest >/dev/null 2>&1; then ok "$t --selftest"; else bad "$t --selftest"; fi
}

# ---- 00. lib/oc-log.sh (unified tools log, KERNEL batch D0) -----------------
section "lib/oc-log.sh (unified tools log)"
if [ -f "$TOOLS_DIR/lib/oc-log.sh" ]; then
  bash -n "$TOOLS_DIR/lib/oc-log.sh" && ok "lib syntax (bash -n)" || bad "lib syntax"
  d="$(mktemp -d)"
  mkdir -p "$d/lib"; cp "$TOOLS_DIR/lib/oc-log.sh" "$d/lib/"
  cat > "$d/oc-demo" <<'DEMO'
#!/usr/bin/env bash
set -u
source "$(dirname "$0")/lib/oc-log.sh"
oc_log_init "oc-demo" "$@"
trap 'oc_log_finish $?' EXIT
rc="${1:-0}"
case "$rc" in --selftest) rc=0 ;; esac
exit "$rc"
DEMO
  chmod +x "$d/oc-demo"
  L="$d/tools.log"
  OC_TOOLS_NOLOG=0 OC_TOOLS_LOG="$L" "$d/oc-demo" 0
  OC_TOOLS_NOLOG=0 OC_TOOLS_LOG="$L" "$d/oc-demo" 7 --some-arg
  OC_TOOLS_NOLOG=0 OC_TOOLS_LOG="$L" "$d/oc-demo" --selftest
  [ -f "$L" ] && [ "$(wc -l < "$L")" -eq 2 ] && ok "exactly 2 lines: exit0 + exit7 (--selftest suppressed)" \
    || bad "expected 2 lines, got $([ -f "$L" ] && wc -l < "$L" || echo none)"
  jq -e 'select(.tool=="oc-demo" and .exit==0)' "$L" >/dev/null 2>&1 && ok "JSONL valid, exit-0 line" || bad "exit-0 line malformed"
  jq -e 'select(.tool=="oc-demo" and .exit==7 and (.args|contains("--some-arg")))' "$L" >/dev/null 2>&1 \
    && ok "exit-7 line carries args" || bad "exit-7 line wrong"
  jq -e 'select(has("ts") and has("secs") and has("extra"))' "$L" >/dev/null 2>&1 \
    && ok "schema fields ts/secs/extra present" || bad "schema fields missing"
  # suppression via env alone (no --selftest)
  OC_TOOLS_NOLOG=1 OC_TOOLS_LOG="$L" "$d/oc-demo" 3
  [ "$(wc -l < "$L")" -eq 2 ] && ok "OC_TOOLS_NOLOG=1 suppresses" || bad "env suppression failed"
  rm -rf "$d"
else
  bad "lib/oc-log.sh missing"
fi

# ---- 00b. unified-log WIRE test (real tool -> tmp OC_TOOLS_LOG) -------------
section "unified-log wire (real tool -> tmp log)"
if tool oc-attrib; then
  wd="$(mktemp -d)"
  WL="$wd/tools.log"
  OC_TOOLS_NOLOG=0 OC_TOOLS_LOG="$WL" "$TOOLS_DIR/oc-attrib" --repo /root/opencrabs --deployed >/dev/null 2>&1
  wrc=$?
  # rc=0 normal; rc=4 = empty range (prev_sha==deployed or no commits in range) —
  # tool-correct on degenerate live marker state (seen 2026-08-31, double swap-execute)
  case $wrc in 0|4) wrc_ok=1;; *) wrc_ok=0;; esac
  wjq='select(.tool=="oc-attrib" and .exit=='"$wrc"' and (.args|contains("--deployed")))'
  [ $wrc_ok -eq 1 ] && [ -f "$WL" ] && [ "$(wc -l < "$WL")" -eq 1 ] \
    && jq -e "$wjq" "$WL" >/dev/null 2>&1 \
    && ok "wire: 1 JSONL line, tool/exit/args correct" || bad "wire test: rc=$wrc lines=$([ -f "$WL" ] && wc -l < "$WL" || echo none)"
  rm -rf "$wd"
fi

# ---- 1. oc-order-validate --------------------------------------------------
section "oc-order-validate"
run_selftest oc-order-validate
if tool oc-order-validate; then
  "$TOOLS_DIR/oc-order-validate" --no-such-arg >/dev/null 2>&1; [ $? -eq 1 ] && ok "unknown arg -> 1 (usage)" || bad "unknown arg -> expected 1"
fi

# ---- 02. oc-job-verify -----------------------------------------------------
section "oc-job-verify"
run_selftest oc-job-verify

# ---- 03. oc-artifact-verify ------------------------------------------------
section "oc-artifact-verify"
run_selftest oc-artifact-verify

# ---- 04. oc-seal-state -----------------------------------------------------
# The REGRESSION test: multi-filter merges must keep the pipe operators.
# The fix was IFS='|' (was IFS=' | ' which joined with a space, dropping the
# pipes between jq filters -> silent data loss on .sha + .feature_presence).
section "oc-seal-state (incl. IFS-join regression)"
run_selftest oc-seal-state
if tool oc-seal-state; then
  d="$(mktemp -d)"
  printf '{"sha":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","run_id":1,"name":"keep-me"}' > "$d/b.json"
  printf '{"orders":[]}' > "$d/o.json"
  S="bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"
  OUT="$("$TOOLS_DIR/oc-seal-state" --baseline "$d/b.json" --orders "$d/o.json" \
    --sha "$S" --run-id 42 --marker width=1600 --found 1 --dry-run)"
  rc=$?
  [ "$rc" -eq 0 ] || { bad "seal merge exit=$rc (expected 0)"; rm -rf "$d"; }
  # multi-filter: BOTH .sha AND .feature_presence must survive the join
  sha_ok="$(printf '%s' "$OUT" | jq -r '.sha==$e' --arg e "$S")"
  fp_ok="$(printf '%s' "$OUT" | jq -r '.feature_presence["width=1600"].found == 1')"
  [ "$sha_ok" = "true" ] && [ "$fp_ok" = "true" ] && ok "IFS multi-filter merge: sha + feature_presence both applied" \
    || bad "IFS multi-filter merge regressed (sha=$sha_ok fp=$fp_ok)"
  rm -rf "$d"
fi

# ---- 5. oc-post-receipts ----------------------------------------------------
section "oc-post-receipts"
if tool oc-post-receipts; then
  "$TOOLS_DIR/oc-post-receipts" --dry-run --topic 30129 --text "suite-triggered" >/dev/null 2>&1; rc=$?
  map_out="$(OC_FORUM_CHAT_ID=-100777000111 "$TOOLS_DIR/oc-post-receipts" --dry-run --topic 30129 --text "mapping" 2>&1)"
  case "$map_out" in
    *"chat_id=-100777000111 -d message_thread_id=30129"*)
      ok "topic->chat/message_thread mapping (defect fix: bare topic as chat_id => Telegram 400)" ;;
    *) bad "topic->chat mapping broken or absent in dry-run output" ;;
  esac
  case "$map_out" in
    *"-d chat_id=30129"*) bad "STILL maps topic into chat_id" ;;
    *) ok "no bare-topic-as-chat_id regression" ;;
  esac
  [ $rc -eq 0 ] && ok "dry-run topic exit 0" || bad "dry-run topic exit $rc (expected 0)"
  "$TOOLS_DIR/oc-post-receipts" --receipt-artifact --unit oc-restart-suite --dry-run >/dev/null 2>&1; [ $? -eq 0 ] && ok "receipt-artifact dry-run exit 0" || bad "receipt-artifact dry-run failed"
  "$TOOLS_DIR/oc-post-receipts" --bogus >/dev/null 2>&1; [ $? -eq 3 ] && ok "bad args -> 3" || bad "bad args -> expected 3"
fi

# ---- 6. oc-index-worktree --------------------------------------------------
section "oc-index-worktree"
run_selftest oc-index-worktree
if tool oc-index-worktree; then
  "$TOOLS_DIR/oc-index-worktree" >/dev/null 2>&1; [ $? -eq 5 ] && ok "no args -> 5 (bad-input)" || bad "no args -> expected 5"
fi

# ---- 7. oc-pr-atomicity ----------------------------------------------------
section "oc-pr-atomicity"
run_selftest oc-pr-atomicity
if tool oc-pr-atomicity; then
  "$TOOLS_DIR/oc-pr-atomicity" >/dev/null 2>&1; [ $? -eq 1 ] && ok "no args -> 1 (usage)" || bad "no args -> expected 1"
fi

# ---- 8. oc-ci-parity -------------------------------------------------------
section "oc-ci-parity"
run_selftest oc-ci-parity
if tool oc-ci-parity; then
  "$TOOLS_DIR/oc-ci-parity" --bogus >/dev/null 2>&1; [ $? -eq 5 ] && ok "unknown arg -> 5" || bad "unknown arg -> expected 5"
fi

# ---- 9. oc-contributors ----------------------------------------------------
section "oc-contributors"
run_selftest oc-contributors
if tool oc-contributors; then
  d="$(mktemp -d)"
  git -C "$d" init -q -b main
  git -C "$d" config user.email suite@test; git -C "$d" config user.name suite
  cm() { printf '%s\n' "$1" > "$d/f"; git -C "$d" add f; printf '%s' "$2" > "$d/.m"; git -C "$d" commit -q -F "$d/.m"; }
  M1='first

Session-Id: aaaaaaaa-0000-0000-0000-000000000001
Issue-Ref: #11'
  M2='second, same lane dup

Session-Id: aaaaaaaa-0000-0000-0000-000000000001'
  M3='third lane

Session-Id: bbbbbbbb-0000-0000-0000-000000000002'
  M4='unsigned orphan commit'
  cm f1 "$M1"; cm f2 "$M2"; cm f3 "$M3"; cm f4 "$M4"
  OUT="$("$TOOLS_DIR/oc-contributors" --repo "$d" --range main)"; rc=$?
  [ $rc -eq 0 ] && ok "fixture range exit 0" || bad "fixture exit=$rc"
  echo "$OUT" | awk -F'\t' '$1=="aaaaaaaa-0000-0000-0000-000000000001" && $2==2 && $3=="#11" {f=1} END{exit !f}' \
    && ok "dup session merged: 2 commits + issue kept" || bad "dedup row wrong"
  echo "$OUT" | awk -F'\t' '$1=="bbbbbbbb-0000-0000-0000-000000000002" && $2==1 {f=1} END{exit !f}' \
    && ok "second session present" || bad "second session missing"
  echo "$OUT" | awk -F'\t' '$1=="(unsigned)" && $2==1 {f=1} END{exit !f}' \
    && ok "unsigned commit NOT silently dropped" || bad "(unsigned) bucket missing"
  [ "$(echo "$OUT" | wc -l)" -eq 3 ] && ok "exactly 3 dedup rows" || bad "row count wrong"
  J="$("$TOOLS_DIR/oc-contributors" --repo "$d" --range main --json)"
  echo "$J" | jq -e 'map(select(.session=="aaaaaaaa-0000-0000-0000-000000000001")) | .[0].commits == 2 and .[0].issues == ["#11"]' >/dev/null \
    && ok "--json shape valid" || bad "--json malformed"
  "$TOOLS_DIR/oc-contributors" >/dev/null 2>&1; [ $? -eq 2 ] && ok "no args -> 2 (usage)" || bad "no args -> expected 2"
  "$TOOLS_DIR/oc-contributors" --repo "$d" --range main..main >/dev/null 2>&1; [ $? -eq 4 ] && ok "empty range -> 4" || bad "empty range -> expected 4"
  rm -rf "$d"
fi

# ---- 9b. oc-attrib -----------------------------------------------------------
section "oc-attrib"
run_selftest oc-attrib
if tool oc-attrib; then
  d="$(mktemp -d)"
  git -C "$d" init -q -b main >/dev/null 2>&1
  git -C "$d" config user.email t@t; git -C "$d" config user.name t
  ca() { printf '%s' "$1" > "$d/f.txt"; git -C "$d" add f.txt; printf '%s' "$2" > "$d/.msg"; git -C "$d" commit -q -F "$d/.msg"; }
  SA='dddddddd-0000-0000-0000-00000000000a'
  ca x1 "#1221 fix

Session-Id: $SA
Issue-Ref: #11"
  ca x2 "no trailer drop"
  printf '{"workers":[{"uuid":"%s","role":"editor","topic_id":30090,"feature":"echo-lane"}]}\n' "$SA" > "$d/wl.json"
  OUT="$("$TOOLS_DIR/oc-attrib" --repo "$d" --range main --ledger "$d/wl.json")"; rc=$?
  [ $rc -eq 0 ] && ok "attrib exit 0" || bad "attrib exit=$rc"
  echo "$OUT" | awk -F'\t' -v s="$SA" '$1==s && $2=="30090" && $3=="echo-lane" && $4=="#11" {f=1} END{exit !f}' \
    && ok "mapped row joins topic+feature+issue" || bad "mapped row wrong"
  echo "$OUT" | grep -q '(unsigned)' && ok "(unsigned) visible in rows" || bad "(unsigned) dropped"
  J="$("$TOOLS_DIR/oc-attrib" --repo "$d" --range main --ledger "$d/wl.json" --json)"
  echo "$J" | jq -e --arg s "$SA" 'map(select(.session==$s))[0].lane.topic_id == 30090' >/dev/null \
    && ok "--json lane object numeric topic_id" || bad "--json lane wrong"
  "$TOOLS_DIR/oc-attrib" >/dev/null 2>&1; [ $? -eq 2 ] && ok "no args -> 2" || bad "no args -> expected 2"
  "$TOOLS_DIR/oc-attrib" --repo "$d" --range main..main >/dev/null 2>&1; [ $? -eq 4 ] && ok "empty range -> 4" || bad "empty range -> expected 4"
  rm -rf "$d"
fi

# ---- 9c. oc-consent-check — RETIRED 2026-08-28 (owner order 18:50Z: consent
#         process eliminated; tool archived to tools/archive/). Tests removed.
section "oc-consent-check (RETIRED — skipped)"

# ---- 9d. oc-seal-state orders vocabulary/purge ---------------------------------
section "oc-seal-state orders"
run_selftest oc-seal-state
if tool oc-seal-state; then
  d="$(mktemp -d)"; O="$d/orders.json"
  printf '{"orders":[{"sha":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa","features":"telegram","status":"queued"},{"order_sha":"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb","status":"dispatched","run_id":"7"}]}\n' > "$O"
  "$TOOLS_DIR/oc-seal-state" --orders "$O" --mark-order aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa --status deployed --order-evidence "PID 1 disk==proc" >/dev/null 2>&1
  [ $? -eq 0 ] && ok "status-only mark accepted" || bad "status-only mark rejected"
  [ "$(jq -r '.orders[0].status' "$O")" = "DEPLOYED" ] && ok "vocabulary uppercased + stored" || bad "status not DEPLOYED"
  [ "$(jq -r '.orders[0].evidence' "$O")" = "PID 1 disk==proc" ] && ok "per-row evidence stored" || bad "evidence missing"
  "$TOOLS_DIR/oc-seal-state" --orders "$O" --mark-order bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb --with-run 99 >/dev/null 2>&1
  [ "$(jq -r '.orders[1].run_id' "$O")" = "99" ] && ok "legacy order_sha row markable" || bad "legacy row missed"
  [ "$(jq -r '.orders[1].status' "$O")" = "DISPATCHED" ] && ok "default status DISPATCHED" || bad "default status wrong"
  "$TOOLS_DIR/oc-seal-state" --orders "$O" --mark-order aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa --status BOGUS >/dev/null 2>&1
  [ $? -eq 1 ] && ok "invalid vocabulary -> 1" || bad "BOGUS accepted"
  "$TOOLS_DIR/oc-seal-state" --orders "$O" --purge-order bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb >/dev/null 2>&1
  [ "$(jq '.orders|length' "$O")" -eq 1 ] && ok "purge removes matching row" || bad "purge failed"
  "$TOOLS_DIR/oc-seal-state" --orders "$O" --purge-order bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb >/dev/null 2>&1
  [ $? -eq 1 ] && ok "purge unknown sha -> 1" || bad "purge miss not refused"
  rm -rf "$d"
fi

# ---- 9e. oc-carrier-features (KERNEL C1) -----------------------------------
section "oc-carrier-features"
run_selftest oc-carrier-features
if tool oc-carrier-features; then
  "$TOOLS_DIR/oc-carrier-features" --bogus >/dev/null 2>&1; [ $? -eq 2 ] && ok "unknown arg -> 2 (usage)" || bad "unknown arg -> expected 2"
fi

# ---- 9f. oc-issue-sweep (KERNEL C3) -----------------------------------------
section "oc-issue-sweep"
run_selftest oc-issue-sweep
if tool oc-issue-sweep; then
  "$TOOLS_DIR/oc-issue-sweep" >/dev/null 2>&1; [ $? -eq 2 ] && ok "no args -> 2 (usage)" || bad "no args -> expected 2"
fi

# ---- 9g. oc-skew-scan (KERNEL C4) -------------------------------------------
section "oc-skew-scan"
run_selftest oc-skew-scan
if tool oc-skew-scan; then
  "$TOOLS_DIR/oc-skew-scan" --bogus >/dev/null 2>&1; [ $? -eq 2 ] && ok "unknown arg -> 2 (usage)" || bad "unknown arg -> expected 2"
fi

# ---- 9h. oc-ping-proof (B25) -------------------------------------------------
section "oc-ping-proof"
run_selftest oc-ping-proof
if tool oc-ping-proof; then
  "$TOOLS_DIR/oc-ping-proof" >/dev/null 2>&1; [ $? -eq 2 ] && ok "no args -> 2 (usage)" || bad "no args -> expected 2"
fi

# ---- 9i. oc-watchdog-check — RETIRED v0.4.65 (lens E A1: pure passthrough to oc-deploy watch) ----

# ---- 9k. oc-deploy contributors + fanout (issue #24) -------------------------
# Black-box battery checks for the #24 mechanical notify fan-out, invoking the
# ABSOLUTE tool path (selftest re-invokes via $0 — a different code path):
# contributors over the REAL oc-attrib; GREEN leg with a dead-session skip;
# RED leg blame attribution over a real git fixture; idempotence; usage rc.
# Stubs are heredocs: the original printf form corrupted the JSON quotes
# (bash printf eats \" in the format string) and silently rc-3'd the GREEN
# leg. Suspect cc / unowned / zero-site fallback / dry-run / drill
# suppression are covered by the full oc-deploy --selftest in section 10.
section "oc-deploy contributors + fanout (#24)"
if tool oc-deploy; then
  d="$(mktemp -d)"; SD="$d/state"; mkdir -p "$SD/tools"
  # contributors: real oc-attrib over a trailer fixture -> uuid + issue + sha7
  git init -q -b main "$d/crepo"
  git -C "$d/crepo" config user.email t@t; git -C "$d/crepo" config user.name t
  git -C "$d/crepo" commit -q --allow-empty -m base
  CBASE="$(git -C "$d/crepo" rev-parse HEAD)"
  git -C "$d/crepo" commit -q --allow-empty -m "feat: battery trailer

Session-Id: 99999999-8888-7777-6666-555555555555
Issue-Ref: #77"
  CTIP="$(git -C "$d/crepo" rev-parse HEAD)"
  OUTK="$(OC_DEPLOY_STATE_DIR="$SD" OC_DEPLOY_ATTRIB="$TOOLS_DIR/oc-attrib" \
    "$TOOLS_DIR/oc-deploy" contributors "$CBASE..$CTIP" --repo "$d/crepo" 2>&1)"; rck=$?
  if [ "$rck" -eq 0 ] && case "$OUTK" in *"99999999-8888-7777-6666-555555555555"*#77*) true ;; *) false ;; esac; then
    ok "contributors: uuid+issue-ref in TSV (real oc-attrib)"
  else
    bad "contributors chain (rc=$rck, want 0 + uuid + #77)"
  fi
  # gh stub: run 222 GREEN (built sha cccc...) + run 666 RED (head from red-head)
  cat > "$SD/gh" <<'GHSTUB'
#!/usr/bin/env bash
SD="$(cd "$(dirname "$0")" && pwd)"
case "$*" in
  *actions/runs/222/jobs*) echo '{"jobs":[{"name":"ORDER gates"},{"name":"Linux amd64 (cccccccccccccccccccccccccccccccccccccccc, telegram)"}]}' ;;
  *actions/runs/222*) echo '{"status":"completed","conclusion":"success"}' ;;
  *actions/runs/666/jobs*) echo '{"jobs":[{"name":"Linux amd64 (build)","conclusion":"failure","check_run_url":"https://api.github.com/repos/leshchenko1979/opencrabs/check-runs/9001"}]}' ;;
  *check-runs/9001/annotations*) echo '[{"path":"bad.txt","start_line":3}]' ;;
  *actions/runs/666*) echo "{\"status\":\"completed\",\"conclusion\":\"failure\",\"head_sha\":\"$(cat "$SD/red-head" 2>/dev/null)\"}" ;;
  *) echo '{}' ;;
esac
GHSTUB
  chmod +x "$SD/gh"
  printf 'cccccccccccccccccccccccccccccccccccccccc\n' > "$SD/deployed.sha"
  printf '{"prev_sha":"0000000000000000000000000000000000000000","features":"telegram"}' > "$SD/deployed.meta.json"
  # two sessions: aaaaaaaa live, bbbbbbbb dead (notify shim exits 2) -> skipped=1
  cat > "$SD/tools/attrib-stub" <<'ATTRSTUB'
#!/usr/bin/env bash
printf 'aaaaaaaa-1111-2222-3333-444444444444\t#77\tabc1234\n'
printf 'bbbbbbbb-1111-2222-3333-444444444444\t#78\tdef5678\n'
ATTRSTUB
  chmod +x "$SD/tools/attrib-stub"
  cat > "$SD/notify" <<NOTIFYSHIM
#!/usr/bin/env bash
case "\$*" in *bbbbbbbb*) exit 2 ;; esac
echo "\$*" >> "$d/notify.log"; exit 0
NOTIFYSHIM
  chmod +x "$SD/notify"
  : > "$d/notify.log"
  OUTK="$(OC_DEPLOY_STATE_DIR="$SD" OC_DEPLOY_GH="$SD/gh" OC_DEPLOY_ATTRIB="$SD/tools/attrib-stub" \
    OC_DEPLOY_NOTIFY="$SD/notify" "$TOOLS_DIR/oc-deploy" fanout --run 222 2>&1)"; rck=$?
  if [ "$rck" -eq 0 ] && case "$OUTK" in *"notified=1 skipped=1"*) true ;; *) false ;; esac; then
    ok "fanout GREEN: notified=1 skipped=1"
  else
    bad "fanout GREEN leg (rc=$rck, want 0 + 'notified=1 skipped=1'; got: $OUTK)"
  fi
  grep -q "aaaaaaaa-1111" "$d/notify.log" && ok "fanout GREEN: verb shim called" || bad "fanout GREEN: no verb call"
  grep -q "bbbbbbbb-1111" "$d/notify.log" && bad "dead uuid logged by shim (should be refused rc 2)" || ok "dead uuid: shim refused, not logged"
  jq -e '.runs["222"]' "$SD/fanout.state" >/dev/null 2>&1 && ok "fanout GREEN: state marked" || bad "fanout GREEN: state unmarked"
  grep -q '"reason":"dead"' "$SD"/oc-deploy/journal/fanout-222-*.jsonl 2>/dev/null && ok "dead uuid: skip journaled" || bad "dead uuid: no skip journal line"
  OUTK="$(OC_DEPLOY_STATE_DIR="$SD" OC_DEPLOY_GH="$SD/gh" OC_DEPLOY_ATTRIB="$SD/tools/attrib-stub" \
    OC_DEPLOY_NOTIFY="$SD/notify" "$TOOLS_DIR/oc-deploy" fanout --run 222 2>&1)"; rck=$?
  [ "$rck" -eq 0 ] && case "$OUTK" in *"reason=done"*) true ;; *) false ;; esac \
    && ok "fanout idempotent rerun: reason=done" || bad "fanout idempotent rerun (rc=$rck)"
  # RED leg: culprit commit (trailer cccccccc-1111) blamed at bad.txt:3
  git init -q --bare -b main "$d/red1.git"
  git init -q -b main "$d/redc1"; git -C "$d/redc1" config user.email t@t; git -C "$d/redc1" config user.name t
  printf 'l1\nl2\nv1\nl4\n' > "$d/redc1/bad.txt"
  git -C "$d/redc1" add bad.txt; git -C "$d/redc1" commit -qm base
  git -C "$d/redc1" push -q "$d/red1.git" HEAD
  git clone -q "$d/red1.git" "$d/redw1"; git -C "$d/redw1" config user.email t@t; git -C "$d/redw1" config user.name t
  sed -i 's/^v1$/v2/' "$d/redw1/bad.txt"
  git -C "$d/redw1" add bad.txt
  git -C "$d/redw1" commit -qm "feat: culprit change

Session-Id: cccccccc-1111-2222-3333-444444444444"
  git -C "$d/redw1" push -q "$d/red1.git" HEAD
  git -C "$d/redw1" rev-parse HEAD > "$SD/red-head"
  OUTK="$(OC_DEPLOY_STATE_DIR="$SD" OC_DEPLOY_GH="$SD/gh" OC_DEPLOY_REPO="$d/redc1" OC_DEPLOY_REMOTE="$d/red1.git" \
    OC_DEPLOY_NOTIFY="$SD/notify" "$TOOLS_DIR/oc-deploy" fanout --run 666 2>&1)"; rck=$?
  if [ "$rck" -eq 0 ] && case "$OUTK" in *"notified=1 skipped=0 unowned=0"*) true ;; *) false ;; esac; then
    ok "fanout RED: blamed culprit notified=1"
  else
    bad "fanout RED leg (rc=$rck, want 0 + 'notified=1 skipped=0 unowned=0'; got: $OUTK)"
  fi
  grep -q "cccccccc-1111" "$d/notify.log" && ok "fanout RED: culprit verb call" || bad "fanout RED: culprit not notified"
  FJR="$(ls "$SD"/oc-deploy/journal/fanout-666-*.jsonl 2>/dev/null | head -1)"
  if [ -n "$FJR" ] && grep -q '"step":"attributed"' "$FJR" && grep '"step":"attributed"' "$FJR" | grep -q "cccccccc-1111"; then
    ok "fanout RED: attributed journal blames culprit"
  else
    bad "fanout RED: attributed line missing/wrong"
  fi
  jq -e '.runs["666"].notified == 1' "$SD/fanout.state" >/dev/null 2>&1 && ok "fanout RED: state marked" || bad "fanout RED: state unmarked"
  OUTK="$(OC_DEPLOY_STATE_DIR="$SD" "$TOOLS_DIR/oc-deploy" fanout 2>&1)"; rck=$?
  [ "$rck" -eq 2 ] && ok "fanout without --run -> 2 (usage)" || bad "fanout usage (rc=$rck, want 2)"
  rm -rf "$d"
fi

# ---- 10. oc-deploy -----------------------------------------------------------
# Regression pinned here (2026-08-27): after a diverged remote round-trip, the
# non-FF fetch refspec silently rejected the update and the ref-first fallback
# resurrected a STALE refs/oc-deploy/main — FF check saw a ghost "rebase needed".
section "oc-deploy"
run_selftest oc-deploy
if tool oc-deploy; then
  "$TOOLS_DIR/oc-deploy" >/dev/null 2>&1; [ $? -eq 1 ] && ok "no args -> 1 (usage)" || bad "no args -> expected 1"
  "$TOOLS_DIR/oc-deploy" --bogus >/dev/null 2>&1; [ $? -eq 1 ] && ok "unknown arg -> 1" || bad "unknown arg -> expected 1"
  d="$(mktemp -d)"; printf x > "$d/oc-deploy.kill"
  OC_DEPLOY_STATE_DIR="$d" "$TOOLS_DIR/oc-deploy" poll >/dev/null 2>&1
  [ $? -eq 9 ] && ok "kill file -> 9 (first-line brake)" || bad "kill file -> expected 9"
  rm -rf "$d"
  # stale pinned ref: diverge remote -> ship --execute (pins div tip) -> restore
  # remote -> plan MUST report FF ok (old code: rc 2 via resurrected stale ref)
  d="$(mktemp -d)"; SD="$d/state"; mkdir -p "$SD/tools"
  printf '#!/usr/bin/env bash\nexit 0\n' > "$SD/tools/val"; chmod +x "$SD/tools/val"
  printf '#!/usr/bin/env bash\nexit 0\n' > "$SD/gh"; chmod +x "$SD/gh"
  git init -q --bare -b main "$d/remote.git"
  git init -q -b main "$d/repo"
  git -C "$d/repo" config user.email t@t; git -C "$d/repo" config user.name t
  echo one > "$d/repo/f1"; git -C "$d/repo" add f1; git -C "$d/repo" commit -qm one
  echo two > "$d/repo/f2"; git -C "$d/repo" add f2; git -C "$d/repo" commit -qm two
  SHA2="$(git -C "$d/repo" rev-parse HEAD)"
  git -C "$d/repo" push -q "$d/remote.git" HEAD~1:refs/heads/main
  (cd "$d/repo" && OC_DEPLOY_STATE_DIR="$SD" OC_DEPLOY_REMOTE="$d/remote.git" \
    OC_DEPLOY_VALIDATE="$SD/tools/val" OC_DEPLOY_GH="$SD/gh" \
    "$TOOLS_DIR/oc-deploy" ship --sha "$SHA2" --features telegram >/dev/null 2>&1)
  git -C "$d/repo" checkout -qb div HEAD~1
  echo div > "$d/repo/f3"; git -C "$d/repo" add f3; git -C "$d/repo" commit -qm div
  git -C "$d/repo" push -q -f "$d/remote.git" HEAD:refs/heads/main
  (cd "$d/repo" && OC_DEPLOY_STATE_DIR="$SD" OC_DEPLOY_REMOTE="$d/remote.git" \
    "$TOOLS_DIR/oc-deploy" ship --sha "$SHA2" --features telegram --execute >/dev/null 2>&1)
  git -C "$d/repo" push -q -f "$d/remote.git" HEAD~1:refs/heads/main
  OUT2="$(cd "$d/repo" && OC_DEPLOY_STATE_DIR="$SD" OC_DEPLOY_REMOTE="$d/remote.git" \
    OC_DEPLOY_GH="$SD/gh" "$TOOLS_DIR/oc-deploy" ship --sha "$SHA2" --features telegram 2>&1)"; rc=$?
  if [ "$rc" -eq 0 ] && case "$OUT2" in *"FF ok"*) true ;; *) false ;; esac; then
    ok "stale pinned ref: FF ok after diverge/restore round-trip"
  else
    bad "stale pinned ref regression (rc=$rc, want 0 + 'FF ok' line)"
  fi
  rm -rf "$d"
fi

# ---- 11. oc-ledger (KERNEL C1–C5 + item-2(b) commit-pending sweep) ---------
section "oc-ledger"
run_selftest oc-ledger
d="$(mktemp -d)"; mkdir -p "$d/state"
printf '{"current_skill_version":"0.0.1","meta":{"skill_version":"0.0.1","current_skill_version":"0.0.1"},"updated_at":"x","workers":[],"events":[]}' > "$d/state/workers-ledger.json"
OC_LEDGER="$d/state/workers-ledger.json" "$TOOLS_DIR/oc-ledger" stamp note "battery edge" >/dev/null 2>&1 \
  && [ "$(jq '.events[-1].n' "$d/state/workers-ledger.json")" = "1" ] \
  && ok "empty-events fixture: first stamp -> n=1" || bad "empty-events fixture stamp"
OC_LEDGER="$d/state/workers-ledger.json" "$TOOLS_DIR/oc-ledger" frobnicate >/dev/null 2>&1
[ $? -eq 2 ] && ok "unknown subcommand -> 2 (usage)" || bad "unknown subcommand -> expected 2"
rm -rf "$d"

# ---- 12. oc-review-persist (ghost-incident cure: reports on disk) ----------
section "oc-review-persist"
run_selftest oc-review-persist
d="$(mktemp -d)"
"$TOOLS_DIR/oc-review-persist" A "battery edge report" --dir "$d" >/dev/null 2>&1; rc=$?
if [ "$rc" -eq 0 ] && [ -s "$d/skill-review-A-$(date -u +%Y%m%d).md" ] && [ -s "$d/skill-review-index.log" ]; then
  ok "persist + index receipt on disk"
else
  bad "persist edge (rc=$rc)"
fi
rm -rf "$d"

# ---- 13. oc-prchecks (KERNEL C5 — one-command PR lint gate) ----------------
section "oc-prchecks"
run_selftest oc-prchecks
if tool oc-prchecks; then
  "$TOOLS_DIR/oc-prchecks" >/dev/null 2>&1; [ $? -eq 2 ] && ok "no args -> 2 (usage)" || bad "no args -> expected 2"
  "$TOOLS_DIR/oc-prchecks" abc123 >/dev/null 2>&1; [ $? -eq 2 ] && ok "short sha -> 2 (FULL-sha shape gate)" || bad "short sha -> expected 2"
fi

# ---- 14. oc-upstream-delta (KERNEL C6 — watch-cycle arithmetic) ------------
section "oc-upstream-delta"
run_selftest oc-upstream-delta
if tool oc-upstream-delta; then
  "$TOOLS_DIR/oc-upstream-delta" --repo /nonexistent-repo-path >/dev/null 2>&1; [ $? -eq 2 ] && ok "bad repo path -> 2" || bad "bad repo path -> expected 2"
fi

# ---- 15. oc-wt (KERNEL C7 — worktree add/remove, un-skippable index chain) -
section "oc-wt"
run_selftest oc-wt
if tool oc-wt; then
  "$TOOLS_DIR/oc-wt" add "Bad_Slug" some-branch >/dev/null 2>&1; [ $? -eq 2 ] && ok "bad slug -> 2 (usage)" || bad "bad slug -> expected 2"
fi

# ---- 16. lens-C tool builds (v0.4.58, owner Go 2026-08-31 04:20Z) -----------
section "oc-drift-check"
run_selftest oc-drift-check
if tool oc-drift-check; then
  "$TOOLS_DIR/oc-drift-check" u1 0.4 >/dev/null 2>&1; [ $? -eq 2 ] && ok "bad version shape -> 2" || bad "bad shape -> expected 2"
fi

section "oc-toolaccum"
run_selftest oc-toolaccum
if tool oc-toolaccum; then
  "$TOOLS_DIR/oc-toolaccum" --log /nonexistent.log u1 >/dev/null 2>&1; [ $? -eq 3 ] && ok "missing log -> 3" || bad "missing log -> expected 3"
fi

section "oc-branch-sweep"
run_selftest oc-branch-sweep
if tool oc-branch-sweep; then
  "$TOOLS_DIR/oc-branch-sweep" >/dev/null 2>&1; [ $? -eq 2 ] && ok "no repo -> 2 (usage)" || bad "no repo -> expected 2"
fi

section "oc-pr-fault-scope"
run_selftest oc-pr-fault-scope
if tool oc-pr-fault-scope; then
  "$TOOLS_DIR/oc-pr-fault-scope" 1 >/dev/null 2>&1; [ $? -eq 2 ] && ok "missing --run -> 2 (usage)" || bad "missing --run -> expected 2"
fi

section "oc-ledger confirm + derive_by"
run_selftest oc-ledger

# ---- battery receipt (oc-ledger sync gate reads this; the file itself rides --
# ---- the skill repo via commit-pending --bundle) ------------------------------
verdict=PASS; [ "$FAIL" -eq 0 ] || verdict=FAIL
printf '{\n  "path": "%s",\n  "ts": "%s",\n  "pass": %d,\n  "fail": %d,\n  "verdict": "%s"\n}\n' \
  "$TOOLS_DIR/tests/battery-last.json" "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$PASS" "$FAIL" "$verdict" \
  > "$TOOLS_DIR/tests/battery-last.json"

# ---- summary ----------------------------------------------------------------
note ""
note "=============================="
note "  PASS: $PASS   FAIL: $FAIL   (receipt: tools/tests/battery-last.json = $verdict)"
note "=============================="
[ "$FAIL" -eq 0 ] || note "tests FAILED (nonzero exit below)"
[ "$FAIL" -eq 0 ]
