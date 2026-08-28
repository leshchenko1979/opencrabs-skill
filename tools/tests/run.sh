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

# ---- helpers ---------------------------------------------------------------
note()  { printf '%s\n' "$*"; }
ok()    { PASS=$((PASS+1)); note "  ok   - $*"; }
bad()   { FAIL=$((FAIL+1)); note "  FAIL - $*"; }
tool()  { [ -x "$TOOLS_DIR/$1" ] || { bad "missing tool: $1"; return 1; } }

# ---- 1. oc-order-validate --------------------------------------------------
section() { note ""; note "== $1 =="; }
run_selftest() {
  local t="$1"
  if [ ! -x "$TOOLS_DIR/$t" ]; then bad "$t missing or not executable"; return 1; fi
  if "$TOOLS_DIR/$t" --selftest >/dev/null 2>&1; then ok "$t --selftest"; else bad "$t --selftest"; fi
}

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

# ---- 9c. oc-consent-check ------------------------------------------------------
section "oc-consent-check"
run_selftest oc-consent-check
if tool oc-consent-check; then
  d="$(mktemp -d)"; L="$d/wl.json"
  printf '{"consents":[{"t":"T0","from":"Alexey","chat":"forum","topic":"29947","message_id":"1238-relay","quote":"GO relayed","lane":"mermaid","kind":"swap-go"}]}\n' > "$L"
  HIT="$("$TOOLS_DIR/oc-consent-check" --ledger "$L" --check --msgid 1238-relay)"
  if [ $? -eq 0 ] && echo "$HIT" | grep -q '"swap-go"'; then ok "check hit cites registered kind"; else bad "check miss on seeded entry"; fi
  "$TOOLS_DIR/oc-consent-check" --ledger "$L" --check --msgid 404 >/dev/null 2>&1
  [ $? -eq 3 ] && ok "unknown msgid -> 3 (grep chat first)" || bad "unknown -> expected 3"
  "$TOOLS_DIR/oc-consent-check" --ledger "$L" --add --msgid 33198 --topic 31847 --quote "#1234 swap GO" >/dev/null 2>&1
  [ "$(jq '.consents|length' "$L")" -eq 2 ] && ok "add appends real-key entry" || bad "add failed"
  "$TOOLS_DIR/oc-consent-check" --ledger "$L" --add --msgid 33198 --topic x --quote dup >/dev/null 2>&1
  [ "$(jq '.consents|length' "$L")" -eq 2 ] && ok "duplicate add idempotent no-op" || bad "duplicate appended"
  printf 'garbage{' > "$d/bad.json"
  "$TOOLS_DIR/oc-consent-check" --ledger "$d/bad.json" list >/dev/null 2>&1; [ $? -eq 4 ] && ok "malformed register -> 4" || bad "malformed -> expected 4"
  "$TOOLS_DIR/oc-consent-check" --ledger "$d/nix.json" list >/dev/null 2>&1; [ $? -eq 4 ] && ok "missing register -> 4" || bad "missing -> expected 4"
  LIST="$("$TOOLS_DIR/oc-consent-check" --ledger "$L" list --json)"
  echo "$LIST" | jq -e 'type=="array" and length==2' >/dev/null && ok "list --json returns consents[]" || bad "list json wrong"
  rm -rf "$d"
fi

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
    "$TOOLS_DIR/oc-deploy" ship --sha "$SHA2" >/dev/null 2>&1)
  git -C "$d/repo" checkout -qb div HEAD~1
  echo div > "$d/repo/f3"; git -C "$d/repo" add f3; git -C "$d/repo" commit -qm div
  git -C "$d/repo" push -q -f "$d/remote.git" HEAD:refs/heads/main
  (cd "$d/repo" && OC_DEPLOY_STATE_DIR="$SD" OC_DEPLOY_REMOTE="$d/remote.git" \
    "$TOOLS_DIR/oc-deploy" ship --sha "$SHA2" --execute >/dev/null 2>&1)
  git -C "$d/repo" push -q -f "$d/remote.git" HEAD~1:refs/heads/main
  OUT2="$(cd "$d/repo" && OC_DEPLOY_STATE_DIR="$SD" OC_DEPLOY_REMOTE="$d/remote.git" \
    OC_DEPLOY_GH="$SD/gh" "$TOOLS_DIR/oc-deploy" ship --sha "$SHA2" 2>&1)"; rc=$?
  if [ "$rc" -eq 0 ] && case "$OUT2" in *"FF ok"*) true ;; *) false ;; esac; then
    ok "stale pinned ref: FF ok after diverge/restore round-trip"
  else
    bad "stale pinned ref regression (rc=$rc, want 0 + 'FF ok' line)"
  fi
  rm -rf "$d"
fi

# ---- summary ----------------------------------------------------------------
note ""
note "=============================="
note "  PASS: $PASS   FAIL: $FAIL"
note "=============================="
[ "$FAIL" -eq 0 ] || note "tests FAILED (nonzero exit below)"
[ "$FAIL" -eq 0 ]