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
export OC_ACTOR="test-runner"

# ---- helpers ---------------------------------------------------------------
note()  { printf '%s\n' "$*"; }
ok()    { PASS=$((PASS+1)); note "  ok   - $*"; }
bad()   { FAIL=$((FAIL+1)); note "  FAIL - $*"; }
tool()  { [ -x "$TOOLS_DIR/$1" ] || { bad "missing tool: $1"; return 1; } }
section() { note ""; note "== $1 =="; }
# Fork #453 (2026-09-20): a failing --selftest used to be a dead end — the
# tool's own output went to /dev/null, so a flake left a bare tool name and
# nothing to diagnose. Capture it and surface a BOUNDED tail under the FAIL
# row. The success path prints NOTHING extra: parallel mode re-counts rows by
# prefix (grep -c '^  ok ' / '^  FAIL '), and a green transcript must stay
# byte-identical. Continuation lines are indented under a '| ' marker, which
# matches neither prefix. tail (not head) because a selftest names its failing
# assertion on the way out.
run_capture() { # $1 = label, $2.. = command
  local label="$1"; shift
  local out rc n
  out="$(mktemp)"
  "$@" >"$out" 2>&1; rc=$?
  if [ "$rc" -eq 0 ]; then
    ok "$label"
  else
    bad "$label"
    n="$(wc -l < "$out")"
    [ "$n" -gt 20 ] && note "       | ... $((n - 20)) earlier line(s) omitted"
    tail -n 20 "$out" | sed 's/^/       | /'
  fi
  rm -f "$out"
  return "$rc"
}
run_selftest() {
  local t="$1"
  if [ ! -x "$TOOLS_DIR/$t" ]; then bad "$t missing or not executable"; return 1; fi
  # M2-22 (2026-09-12): the state dir must be removed after the run — this was
  # the volume driver of the /tmp leak (one dir per tool per battery run).
  # A plain `rm -rf` right after the call, NOT a global trap: chunk mode
  # re-extracts and sources the prelude (everything before the first `# ---- N`
  # marker) once per section, so a prelude-level trap would be set N times.
  local sd
  sd="$(mktemp -d)"
  run_capture "$t --selftest" env OC_DEPLOY_STATE_DIR="$sd" "$TOOLS_DIR/$t" --selftest
  rm -rf "$sd"
}

# ---- battery driver: --jobs N parallel mode + internal --chunk mode (v0.4.131)
# Sections are fully isolated (each builds its own mktemp state, no shared
# mutable state), so they run concurrently. --jobs N spawns one chunk per
# section (default 1 = sequential, unchanged). Output is re-aggregated in
# section order so the transcript matches a sequential run line-for-line.
# Chunk mode re-extracts prelude+section from this file and sources it —
# BATTERY_IN_CHUNK guards the re-entry so sourcing the extracted prelude
# (which contains this driver) cannot recurse.
BATTERY_MODE="sequential"
extract_chunk() { # $1 = 1-based section chunk; prints prelude + that section
  awk -v want="$1" '
    /^# ---- [0-9]/ { n++; insec = (n == want); next }
    /^verdict=PASS/ { exit }
    n == 0 || insec { print }
  ' "$0"
}
if [ "${1:-}" = "--chunk" ] && [ -n "${2:-}" ] && [ -z "${BATTERY_IN_CHUNK:-}" ]; then
  export BATTERY_IN_CHUNK=1
  C="$(mktemp)"; extract_chunk "$2" > "$C"
  # shellcheck disable=SC1090
  source "$C"; rm -f "$C"
  exit $(( FAIL > 0 ? 1 : 0 ))
fi

# ---- single-flight lock: ONE battery run at a time (#449) -------------------
# tools/tests/battery-last.json is ONE canonical path shared by every lane, and
# this script writes it from two sites with no lock — so two concurrent runs
# clobber each other's receipt (measured 2026-09-20: commit 284b8456 committed a
# FAIL receipt under a "pass 213, fail 0" message) and the extra load flakes the
# timing-sensitive oc-ship-chain detach-survival pair. The whole run is
# serialized here. The canonical path is KEPT because consumers read it — a
# per-lane receipt path would break them.
#
# Placement is load-bearing: this sits AFTER the --chunk branch above and is
# guarded on BATTERY_IN_CHUNK, because a --chunk child takes its branch and
# exits before reaching this line, and the prelude sourced INSIDE a child sees
# BATTERY_IN_CHUNK=1. Locking any earlier would deadlock every child against
# its own parent. rc 2 = harness condition, never a test verdict.
if [ -z "${BATTERY_IN_CHUNK:-}" ]; then
  BATTERY_LOCK="${OC_BATTERY_LOCK:-${TMPDIR:-/tmp}/oc-battery.lock}"
  BATTERY_LOCK_WAIT="${OC_BATTERY_LOCK_WAIT:-900}"
  exec 9>"$BATTERY_LOCK" || { note "battery: cannot open lock file $BATTERY_LOCK"; exit 2; }
  if ! flock -n 9; then
    note "battery: another run holds $BATTERY_LOCK — waiting up to ${BATTERY_LOCK_WAIT}s"
    if ! flock -w "$BATTERY_LOCK_WAIT" 9; then
      note "battery: lock not released within ${BATTERY_LOCK_WAIT}s — NOT a test failure and NOT a verdict."
      note "battery: re-run once the holder finishes, or raise the budget with OC_BATTERY_LOCK_WAIT=<sec>."
      exit 2
    fi
  fi
fi

JOBS="${OC_BATTERY_JOBS:-$(nproc 2>/dev/null || echo 4)}"
if [ "${1:-}" = "--jobs" ] && [ -n "${2:-}" ]; then JOBS="$2"; shift 2; fi
case "${1:-}" in --jobs=*) JOBS="${1#--jobs=}"; shift ;; esac
emit_summary() {
  local verdict=PASS; [ "$FAIL" -eq 0 ] || verdict=FAIL
  printf '{\n  "path": "%s",\n  "ts": "%s",\n  "pass": %d,\n  "fail": %d,\n  "verdict": "%s",\n  "mode": "%s"\n}\n' \
    "$TOOLS_DIR/tests/battery-last.json" "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$PASS" "$FAIL" "$verdict" "$BATTERY_MODE" \
    > "$TOOLS_DIR/tests/battery-last.json"
  note ""
  note "=============================="
  note "  PASS: $PASS   FAIL: $FAIL   (receipt: tools/tests/battery-last.json = $verdict, mode: $BATTERY_MODE)"
  note "=============================="
  [ "$FAIL" -eq 0 ] || note "tests FAILED (nonzero exit below)"
  return $(( FAIL > 0 ? 1 : 0 ))
}
if [ "${BATTERY_IN_CHUNK:-0}" = "0" ] && [ "$JOBS" -gt 1 ]; then
  BATTERY_MODE="parallel jobs=$JOBS"
  NCH="$(grep -cE '^# ---- [0-9]' "$0")"
  PT="$(mktemp -d -t oc-battery-pt.XXXXXX)"
  RUN_SCRIPT="$(readlink -f "$0" 2>/dev/null || echo "$0")"
  for k in $(seq 1 "$NCH"); do
    ( bash "$RUN_SCRIPT" --chunk "$k" > "$PT/$k.log" 2>&1 ) &
    while [ "$(jobs -rp | wc -l)" -ge "$JOBS" ]; do sleep 0.05; done
  done
  wait
  PASS=0; FAIL=0
  for k in $(seq 1 "$NCH"); do
    [ -f "$PT/$k.log" ] && cat "$PT/$k.log"
    o="$(grep -c '^  ok ' "$PT/$k.log" 2>/dev/null || true)"; f="$(grep -c '^  FAIL ' "$PT/$k.log" 2>/dev/null || true)"
    PASS=$((PASS + ${o:-0})); FAIL=$((FAIL + ${f:-0}))
  done
  rm -rf "$PT"
  emit_summary
  exit $?
fi

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
case "$rc" in --selftest|selftest) rc=0 ;; esac
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
  # M2-21 (2026-09-12): the BARE `selftest` SUBCOMMAND must suppress too.
  # oc-deploy:2976 dispatches `--selftest|selftest) selftest "$@" ;;` as ONE
  # case arm, so a flag-only predicate let a bare-subcommand selftest log every
  # fixture child it spawned into the PRODUCTION tools.log -- 93 rows per run,
  # six phantom shas across two weeks, read back by oc-ship-audit as ORPHANED
  # dispatches (rc=1, gating `oc-ledger commit-pending`).
  L2="$d/tools2.log"
  OC_TOOLS_NOLOG=0 OC_TOOLS_LOG="$L2" "$d/oc-demo" selftest
  [ -s "$L2" ] && bad "bare 'selftest' subcommand logged a row (M2-21)" \
               || ok "bare 'selftest' subcommand suppressed (M2-21)"
  # separate log: a leak in the assertion above must not cascade into this one
  L3="$d/tools3.log"
  OC_TOOLS_NOLOG=0 OC_TOOLS_LOG="$L3" "$d/oc-demo" 0 selftest
  [ "$(wc -l < "$L3")" -eq 1 ] \
    && ok "a 'selftest' VALUE does not suppress a real invocation (M2-21)" \
    || bad "non-first 'selftest' silenced a real invocation (M2-21)"
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

# ---- 00b. lib/oc-embed.sh (F-M5, v0.4.77): direct unit coverage -------------
section "lib/oc-embed.sh (job-name embed decoder)"
if [ -f "$TOOLS_DIR/lib/oc-embed.sh" ]; then
  bash -n "$TOOLS_DIR/lib/oc-embed.sh" && ok "embed-lib syntax (bash -n)" || bad "embed-lib syntax"
  # shellcheck disable=SC1091
  . "$TOOLS_DIR/lib/oc-embed.sh"
  out="$(oc_decode_job_embed "Linux amd64 (aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa, telegram)")"
  [ "$out" = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa|telegram" ] \
    && ok "embed: well-formed job name -> sha|features" || bad "embed decode got: '$out'"
  out="$(oc_decode_job_embed "Linux amd64 (bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb, local-stt,local-tts)")"
  [ "$out" = "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb|local-stt,local-tts" ] \
    && ok "embed: comma feature set survives" || bad "embed comma-set got: '$out'"
  out="$(oc_decode_job_embed "ORDER gates / validate (no embed here)")"
  [ -z "$out" ] && ok "embed: ORDER job without embed -> empty" || bad "embed no-embed got: '$out'"
  out="$(oc_decode_job_embed "Linux amd64 (shortsha, x)")"
  [ -z "$out" ] && ok "embed: non-40-hex parenthetical -> empty" || bad "embed short-sha got: '$out'"
else
  bad "lib/oc-embed.sh missing"
fi

# ---- 00c. lib/oc_claims.py (#313/#314, toolsmith 2fae1230): canonical claim
# ---- predicate — direct unit coverage. Four inlined copies of this predicate
# ---- had drifted apart (two extracted issue tokens as ints, two as strings;
# ---- only one asked WHO authored the closing row), so the module is now the
# ---- single implementation every consumer imports. These cases pin the exact
# ---- properties the drift broke, plus the token-extraction traps (#272).
section "lib/oc_claims.py (canonical claim-closure predicate)"
if [ -f "$TOOLS_DIR/lib/oc_claims.py" ]; then
  # ast.parse, NOT py_compile: py_compile writes a __pycache__ .pyc next to the
  # module, and a synthetic battery run must leave the shared checkout
  # byte-identical (same reason the suite sets OC_TOOLS_NOLOG above).
  python3 -c 'import ast,sys; ast.parse(open(sys.argv[1]).read())' "$TOOLS_DIR/lib/oc_claims.py" 2>/dev/null \
    && ok "oc_claims-lib syntax (ast.parse)" || bad "oc_claims-lib syntax"
  OCT="$(mktemp -d)"
  cat > "$OCT/unit.py" << 'PYEOF'
import sys
sys.dont_write_bytecode = True
sys.path.insert(0, sys.argv[1])
import oc_claims as oc

fails = []
def chk(desc, got, want):
    if got != want:
        fails.append("%s (got %r want %r)" % (desc, got, want))

# --- issue_ref_tokens: TOKEN extraction, never a substring or digit run (#272)
chk("ref #129", oc.issue_ref_tokens("CLAIM #129 — x"), [129])
chk("ref date not an issue", oc.issue_ref_tokens("stamped 2026-09-15"), [])
chk("ref owner handle not an issue", oc.issue_ref_tokens("leshchenko1979/opencrabs#52"), [52])
chk("ref sha prefix not an issue", oc.issue_ref_tokens("commit 262193f67 landed"), [])
chk("ref uuid prefix not an issue", oc.issue_ref_tokens("session 6630dc9a-0eeb"), [])
chk("ref issue N form", oc.issue_ref_tokens("claims issue 94"), [94])
chk("ref issue=N form", oc.issue_ref_tokens("issue=4242 task"), [4242])
chk("ref issue#N form", oc.issue_ref_tokens("issue#77"), [77])
chk("ref multi in first-seen order", oc.issue_ref_tokens("#38, #80 — multi"), [38, 80])
chk("ref 760 is not 76", oc.references("#760", 76), False)
chk("ref 760 matches 760", oc.references("#760", 760), True)

# --- primary_issue_tokens: what a claim CLAIMS (#329). The leading reference
# --- cluster is the address; a reference in the body is a mention, not a claim.
chk("primary single", oc.primary_issue_tokens("CLAIM #129 — x"), [129])
chk("primary prose mention excluded",
    oc.primary_issue_tokens("CLAIM #327 — filed, one live break (#323)"), [327])
chk("primary live phantom n=8226 shape",
    oc.primary_issue_tokens(
        "filed fragility class issue (#327): 14 bodies, one proven live break (#323)"), [327])
chk("primary genuine dual claim survives",
    oc.primary_issue_tokens("CLAIM #193, #205 — harvest packaging"), [193, 205])
chk("primary live dual n=4802", oc.primary_issue_tokens("CLAIM #193, #205"), [193, 205])
chk("primary slash-joined list",
    oc.primary_issue_tokens("CLAIM #1414/#1418 — pair"), [1414, 1418])
chk("primary live n=8034 parenthetical excluded",
    oc.primary_issue_tokens("CLAIM #302 — backfill (supersedes #290, #297)"), [302])
chk("primary live n=1678 upstream mention excluded",
    oc.primary_issue_tokens(
        "md-plane wave lane claims n=1675 PATH-2 execution: upstream issue "
        "adolfousier/opencrabs#1419 filed FIRST"), [1419])
chk("primary non-leading ref is the anchor when no earlier ref exists",
    oc.primary_issue_tokens("Claimed compaction-signal feature: Issue-Ref "
                            "leshchenko1979/opencrabs#29 (mirror of #1256)"), [29])
chk("primary of a ref-less note is empty", oc.primary_issue_tokens("no refs here"), [])
chk("primary never empties a referencing note",
    oc.primary_issue_tokens("x #5 y #6 z"), [5])
chk("primary is a subset of every-ref tokens",
    set(oc.primary_issue_tokens("CLAIM #12 — see #13 and #14"))
    <= set(oc.issue_ref_tokens("CLAIM #12 — see #13 and #14")), True)

# --- type uniformity: the drift bug (str tokens compared to int tokens)
chk("ref tokens are INTEGERS",
    all(isinstance(t, int) for t in oc.issue_ref_tokens("CLAIM #129, issue 94")), True)

# --- actor_key / actor_match
chk("actor full uuid", oc.actor_key("editor 1a63f103-1234-5678-9abc-def012345678"),
    ("uuid", "1a63f103-1234-5678-9abc-def012345678"))
chk("actor short uuid last token", oc.actor_key("toolsmith/2fae1230"), ("uuid", "2fae1230"))
chk("actor label", oc.actor_key("lamp-lane"), ("label", "lamp-lane"))
chk("actor role prefix stripped", oc.actor_key("editor-14"), ("label", "14"))
chk("actor short==full uuid", oc.actor_match("editor 2fae1230",
    "toolsmith 2fae1230-aaaa-bbbb-cccc-dddddddddddd"), True)
chk("actor uuid never matches label", oc.actor_match("editor 2fae1230", "editor-14"), False)
chk("actor different uuids", oc.actor_match("editor 11111111", "editor 22222222"), False)
chk("actor empty label", oc.actor_match("editor-", "editor-"), False)

# --- is_addressed: anchored at the START of what (the #305 fence)
chk("addressed plain", oc.is_addressed("#71 — released", 71), True)
chk("addressed STANDDOWN", oc.is_addressed("STANDDOWN #71 (11111111) — shipped", 71), True)
chk("addressed sweep form", oc.is_addressed("#2 — closed-issue stale claim sweep", 2), True)
# `UNCLAIM #N` is deliberately NOT an address: that ref is the AUTHOR's own
# claim, and the prose after it often names ANOTHER lane — so treating it as an
# address would let a lane's own standdown release a third lane's claim, which
# is exactly the #305 defect. It closes the author's claim by signal 1 instead.
chk("UNCLAIM #N is not an address (#305)", oc.is_addressed("UNCLAIM #72 — stood down in favour of editor lane X", 72), False)
chk("addressed mid-sentence is NOT", oc.is_addressed("note: see #264 for detail", 264), False)
chk("addressed 71 does not address 710", oc.is_addressed("#710 — x", 71), False)

# --- is_unattributed sentinels
chk("sentinel unattributed", oc.is_unattributed("(unattributed)"), True)
chk("sentinel unrostered", oc.is_unattributed("unrostered-actor 6630dc9a"), True)
chk("sentinel real actor", oc.is_unattributed("editor 11111111"), False)

# --- open_claims: the canonical rule, all three signals.
# NB the ledger `n` is the ROW number, not the issue: each case is annotated
# with the issue it claims so the survivors below are readable.
EV = [
  {"n": 1, "t": "t1", "by": "editor 11111111", "kind": "claim", "what": "CLAIM #1 — same-author closure"},
  {"n": 2, "t": "t2", "by": "editor 11111111", "kind": "done", "what": "DONE #1 — own row"},
  {"n": 3, "t": "t3", "by": "editor 22222222", "kind": "claim", "what": "CLAIM #2 — addressed closure by another lane"},
  {"n": 4, "t": "t4", "by": "triage 33333333", "kind": "unclaim", "what": "#2 — closed-issue stale claim sweep"},
  {"n": 5, "t": "t5", "by": "editor 44444444", "kind": "claim", "what": "CLAIM #3 — foreign prose must NOT release"},
  {"n": 6, "t": "t6", "by": "triage 33333333", "kind": "unclaim", "what": "UNCLAIM #99 — stood down in favour of editor lane 44444444"},
  {"n": 7, "t": "t7", "by": "(unattributed)", "kind": "claim", "what": "CLAIM #4 — unattributed"},
  {"n": 8, "t": "t8", "by": "editor 55555555", "kind": "confirm", "what": "CONFIRM #4 — any lane closes an unattributed claim"},
  {"n": 9, "t": "t9", "by": "editor 66666666", "kind": "claim", "what": "CLAIM #5 — non-closing kind must not close"},
  {"n":10, "t": "t10", "by": "editor 66666666", "kind": "note", "what": "NOTE #5 — not a closing kind"},
]
# rows 5 (#3, released only by a foreign prose mention) and 9 (#5, whose only
# later row is a non-closing kind) survive; rows 1, 3, 7 are closed by signals
# 1, 2 and 3 respectively.
open_ns = sorted(c["n"] for c in oc.open_claims(EV))
chk("open_claims survivors", open_ns, [5, 9])
chk("open_claims target filter", sorted(c["n"] for c in oc.open_claims(EV, 3)), [5])
chk("open_claims target filter closed", oc.open_claims(EV, 1), [])
chk("open_claims tokens are ints",
    all(isinstance(t, int) for c in oc.open_claims(EV) for t in c["tokens"]), True)
chk("open_claims skips ref-less claim",
    oc.open_claims([{"n": 1, "by": "editor 11111111", "kind": "claim", "what": "CLAIM without a ref"}]), [])

# --- open_claims targets the ADDRESS, not every reference (#329).
PHA = [{"n": 1, "by": "editor 11111111", "kind": "claim",
        "what": "CLAIM #327 — filed, one proven live break (#323)"}]
chk("#329: phantom claim on the mentioned issue does not exist",
    oc.open_claims(PHA, 323), [])
chk("#329: the addressed issue is still open", sorted(c["tokens"] for c in oc.open_claims(PHA)), [[327]])
chk("#329: structured issues field wins over prose",
    sorted(c["tokens"] for c in oc.open_claims(
        [{"n": 1, "by": "editor 11111111", "kind": "claim",
          "what": "CLAIM #5 — mentions #6", "issues": [5]}])), [[5]])
chk("#329: structured field may carry a genuine dual claim",
    sorted(c["tokens"] for c in oc.open_claims(
        [{"n": 1, "by": "editor 11111111", "kind": "claim",
          "what": "CLAIM #5, #6", "issues": [5, 6]}])), [[5, 6]])
chk("#329: empty structured field falls back to the address",
    sorted(c["tokens"] for c in oc.open_claims(
        [{"n": 1, "by": "editor 11111111", "kind": "claim",
          "what": "CLAIM #5 — x", "issues": []}])), [[5]])
chk("#329: non-numeric structured entries are ignored, not crashed on",
    sorted(c["tokens"] for c in oc.open_claims(
        [{"n": 1, "by": "editor 11111111", "kind": "claim",
          "what": "CLAIM #5 — x", "issues": ["5", None, "junk"]}])), [[5]])

# --- legacy schema fallback: rows carrying note/actor instead of what/by
LEG = [{"n": 1, "actor": "editor 11111111", "type": "claim", "note": "CLAIM #7 — legacy keys"}]
chk("legacy keys parsed", len(oc.open_claims(LEG)), 1)

# --- #307 anchored Issue-Ref resolution: the TRAILER, never prose.
# A commit that merely MENTIONS #N in its subject or body is not work on #N.
# The pre-#307 footprint leg was an unanchored `git log --grep=#N`, so upstream
# commit 1e34378050 (subject `(#478)`, body prose `(#300)`) read as fork work on
# #300 and fenced #291's harvest on files #291 never touched. These cases pin the
# anchored predicate AND the positive twin (a trailer DOES resolve), so a
# resolver that simply always returned [] could not pass.
import tempfile, subprocess as _sp, shutil as _sh
def _g(repo, *a):
    return _sp.run(["git", "-C", repo] + list(a), capture_output=True, text=True)
_fx = tempfile.mkdtemp(prefix="occlaims-")
_g(_fx, "init", "-q", "-b", "main")
_g(_fx, "config", "user.email", "unit@local")
_g(_fx, "config", "user.name", "unit")
with open(_fx + "/base.txt", "w") as f: f.write("b\n")
_g(_fx, "add", "-A"); _g(_fx, "commit", "-q", "-m", "base commit")
# subject prose only, no trailer
with open(_fx + "/prose.txt", "w") as f: f.write("p\n")
_g(_fx, "add", "-A"); _g(_fx, "commit", "-q", "-m", "fix(x): reword the note (#701)")
# body prose only, no trailer
with open(_fx + "/bodyprose.txt", "w") as f: f.write("bp\n")
_g(_fx, "add", "-A"); _g(_fx, "commit", "-q", "-m", "fix(w): plain subject",
                         "-m", "This mentions #704 in the body prose only.")
# the positive twin: a real fork Issue-Ref trailer
with open(_fx + "/anchored.txt", "w") as f: f.write("a\n")
_g(_fx, "add", "-A"); _g(_fx, "commit", "-q", "-m", "fix(y): real work",
                         "--trailer", "Issue-Ref: #702")
# cross-space trap: a trailer naming ANOTHER repo must not fence a fork issue
with open(_fx + "/upstream.txt", "w") as f: f.write("u\n")
_g(_fx, "add", "-A"); _g(_fx, "commit", "-q", "-m", "fix(z): upstream work",
                         "--trailer", "Issue-Ref: adolfousier/opencrabs#703")
_idx = oc.issue_ref_index(_fx)
chk("#307 subject-prose mention resolves to NO commits", oc.resolve_issue_commits(_fx, 701), [])
chk("#307 subject-prose mention resolves to NO files", oc.resolve_issue_files(_fx, 701), [])
chk("#307 body-prose mention resolves to NO commits", oc.resolve_issue_commits(_fx, 704), [])
chk("#307 body-prose mention resolves to NO files", oc.resolve_issue_files(_fx, 704), [])
chk("#307 trailer-anchored issue resolves its own file",
    oc.resolve_issue_files(_fx, 702), ["anchored.txt"])
chk("#307 foreign-slug trailer does not fence a fork issue",
    oc.resolve_issue_files(_fx, 703), [])
chk("#307 only the fork-anchored commit enters the index", len(_idx), 1)
_sh.rmtree(_fx, ignore_errors=True)

if fails:
    for f in fails:
        sys.stderr.write("  unit-fail: %s\n" % f)
    sys.exit(1)
PYEOF
  if python3 "$OCT/unit.py" "$TOOLS_DIR/lib" 2>"$OCT/err"; then
    ok "oc_claims predicate unit cases (tokens/actors/address/signals)"
  else
    bad "oc_claims predicate unit cases"; sed 's/^/    /' "$OCT/err" | head -20
  fi
  rm -rf "$OCT"
else
  bad "lib/oc_claims.py missing"
fi

# ---- 5. oc-post-receipts ----------------------------------------------------
section "oc-post-receipts"
if tool archive/oc-post-receipts; then
  "$TOOLS_DIR/archive/oc-post-receipts" --dry-run --topic 30129 --text "suite-triggered" >/dev/null 2>&1; rc=$?
  map_out="$(OC_FORUM_CHAT_ID=-100777000111 "$TOOLS_DIR/archive/oc-post-receipts" --dry-run --topic 30129 --text "mapping" 2>&1)"
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
  "$TOOLS_DIR/archive/oc-post-receipts" --receipt-artifact --unit oc-restart-suite --dry-run >/dev/null 2>&1; [ $? -eq 0 ] && ok "receipt-artifact dry-run exit 0" || bad "receipt-artifact dry-run failed"
  "$TOOLS_DIR/archive/oc-post-receipts" --bogus >/dev/null 2>&1; [ $? -eq 3 ] && ok "bad args -> 3" || bad "bad args -> expected 3"
fi


# ---- 7. oc-pr-atomicity ----------------------------------------------------
section "oc-pr-atomicity"
run_selftest oc-pr-atomicity
if tool oc-pr-atomicity; then
  "$TOOLS_DIR/oc-pr-atomicity" >/dev/null 2>&1; [ $? -eq 1 ] && ok "no args -> 1 (usage)" || bad "no args -> expected 1"
fi

# ---- 8. oc-ci-parity RETIRED v0.4.117 (owner "3 - ok" 21:44Z: zero live use in 12d, C-H2; three-way-diff check in merge runbook supersedes) ----

# ---- 9. oc-contributors RETIRED v0.4.72 (E2 #1: subset of oc-attrib, zero live callers) ----
# coverage lives in the oc-attrib section; oc-seal-state derives the same list.

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

# ---- 9b2. oc-attrib #407 — novelty filter (re-sha'd + empty commits) ---------
# After a lineage rewrite the deployed range is full of commits whose change is
# ALREADY in the baseline (a rebase re-sha's every commit) plus EMPTY commits
# (which carry no patch-id at all). Both were attributed to their original
# authors, so a post-swap fan-out woke every lane on every ship — 276 of 310
# commits in the measured live range were replays. These legs pin the black-box
# contract: RAW is untouched, --novel drops replayed + empty, --no-novel is
# byte-identical to RAW, and a range whose every commit is filtered out is a
# legitimate EMPTY result at rc 0 (not an error).
section "oc-attrib #407 novelty filter (re-sha'd + empty commits)"
run_selftest oc-attrib
if tool oc-attrib; then
  d="$(mktemp -d)"
  git -C "$d" init -q -b main >/dev/null 2>&1
  git -C "$d" config user.email t@t; git -C "$d" config user.name t
  printf 'base\n' > "$d/base.txt"; git -C "$d" add base.txt; git -C "$d" commit -qm base
  B0="$(git -C "$d" rev-parse HEAD)"
  # the ORIGINAL feature commit on its own branch, absorbed into main — the
  # baseline must CONTAIN the original, or `git cherry` cannot see its patch-id.
  git -C "$d" checkout -q -b src
  printf 'twin\n' > "$d/twin.txt"; git -C "$d" add twin.txt
  git -C "$d" commit -qm "twin

Session-Id: 11111111-1111-1111-1111-111111111111"
  TWIN="$(git -C "$d" rev-parse HEAD)"
  git -C "$d" checkout -q main
  git -C "$d" merge -q --ff-only src
  BASE="$(git -C "$d" rev-parse HEAD)"
  # the tip lineage starts at B0 (the commit BEFORE the original), never at the
  # baseline itself: cherry-picking onto the baseline would be a no-op, and
  # cherry-picking onto a tree that already contains the change commits nothing
  # at all.
  git -C "$d" checkout -q -b tip "$B0"
  # a genuinely NOVEL commit lands FIRST — it also gives the replay a different
  # parent (and tree) than the original, so the cherry-pick yields a NEW sha
  # instead of a byte-identical commit (same author, same message, same second).
  printf 'pre\n' > "$d/pre.txt"; git -C "$d" add pre.txt
  git -C "$d" commit -qm "pre

Session-Id: 22222222-2222-2222-2222-222222222222"
  NOVEL="$(git -C "$d" rev-parse HEAD)"
  # the REPLAY: same patch, new sha — exactly what a rebase produces
  git -C "$d" cherry-pick "$TWIN" >/dev/null 2>&1 || bad "#407 fixture: cherry-pick failed"
  REPLAY="$(git -C "$d" rev-parse HEAD)"
  # an EMPTY commit — no patch-id, so `git cherry` can never match it
  git -C "$d" commit -q --allow-empty -m empty
  EMPTY="$(git -C "$d" rev-parse HEAD)"
  [ "$REPLAY" != "$TWIN" ] && ok "#407 fixture: replay carries a distinct sha" \
    || bad "#407 fixture: replay reproduced the twin sha (no twin to detect)"
  S_TWIN="$(printf '%s' "$TWIN" | cut -c1-7)"
  S_REPLAY="$(printf '%s' "$REPLAY" | cut -c1-7)"
  S_NOVEL="$(printf '%s' "$NOVEL" | cut -c1-7)"
  S_EMPTY="$(printf '%s' "$EMPTY" | cut -c1-7)"
  RAW="$("$TOOLS_DIR/oc-attrib" --repo "$d" --range "$BASE..tip" 2>/dev/null)"
  NOV="$("$TOOLS_DIR/oc-attrib" --repo "$d" --range "$BASE..tip" --novel 2>"$d/nov.err")"; nrc=$?
  [ "$nrc" -eq 0 ] && ok "#407 --novel exits 0" || bad "#407 --novel rc=$nrc want 0"
  [ "$(printf '%s\n' "$RAW" | wc -l)" -eq 3 ] && ok "#407 RAW range keeps all 3 commits (replay+novel+empty)" \
    || bad "#407 RAW rows=$(printf '%s\n' "$RAW" | wc -l) want 3"
  [ "$(printf '%s\n' "$NOV" | wc -l)" -eq 1 ] && ok "#407 --novel keeps exactly the 1 novel commit" \
    || bad "#407 --novel rows=$(printf '%s\n' "$NOV" | wc -l) want 1 (raw=3)"
  printf '%s\n' "$NOV" | grep -q "$S_NOVEL" && ok "#407 --novel keeps the novel commit" || bad "#407 --novel dropped the novel commit"
  printf '%s\n' "$NOV" | grep -q "$S_REPLAY" && bad "#407 --novel KEPT the replayed twin (patch-id equivalence missed)" || ok "#407 --novel drops the replayed twin"
  printf '%s\n' "$NOV" | grep -q "$S_EMPTY" && bad "#407 --novel KEPT the empty commit" || ok "#407 --novel drops the empty commit"
  printf '%s\n' "$RAW" | grep -q "$S_REPLAY" && ok "#407 RAW still shows the replayed twin (filter is opt-in)" || bad "#407 RAW lost the replayed twin"
  grep -q "3 raw, 1 replayed, 1 empty, 1 contributing" "$d/nov.err" && ok "#407 stderr accounting names raw/replayed/empty/contributing" \
    || bad "#407 stderr accounting missing: $(cat "$d/nov.err" 2>/dev/null)"
  NN="$("$TOOLS_DIR/oc-attrib" --repo "$d" --range "$BASE..tip" --no-novel 2>/dev/null)"
  [ "$NN" = "$RAW" ] && ok "#407 --no-novel is byte-identical to RAW" || bad "#407 --no-novel != RAW"
  # an ALL-REPLAYED tip — nothing but a re-sha'd original plus an empty commit,
  # against a baseline that already carries both — must yield ZERO rows at rc 0.
  # This is the case oc-deploy's fan-out has to read as "nothing to notify"
  # rather than as an attrib breakdown (issue #407 instance B).
  git -C "$d" checkout -q -b tip2 "$B0"
  git -C "$d" cherry-pick "$TWIN" >/dev/null 2>&1 || bad "#407 fixture: tip2 cherry-pick failed"
  git -C "$d" commit -q --allow-empty -m "chore: sign tip2"
  ALLF="$("$TOOLS_DIR/oc-attrib" --repo "$d" --range "$BASE..tip2" --novel 2>"$d/allf.err")"; arc=$?
  [ "$arc" -eq 0 ] && [ -z "$ALLF" ] && ok "#407 all-replayed range -> rc 0 with no rows" \
    || bad "#407 all-replayed range rc=$arc rows=$(printf '%s\n' "$ALLF" | wc -l) want rc 0 / 0 rows"
  grep -q "0 contributing" "$d/allf.err" && ok "#407 all-replayed accounting reports 0 contributing" \
    || bad "#407 all-replayed accounting missing: $(cat "$d/allf.err" 2>/dev/null)"
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
  # contributors verb RETIRED (v0.4.91, lens E-2): loud deprecation rc 1, points at oc-attrib.
  # The working TSV projection is covered by oc-attrib --contributors (single shape now).
  OUTK="$(OC_DEPLOY_STATE_DIR="$SD" OC_DEPLOY_ATTRIB="$TOOLS_DIR/oc-attrib" \
    "$TOOLS_DIR/oc-deploy" contributors "$CBASE..$CTIP" --repo "$d/crepo" 2>&1)"; rck=$?
  if [ "$rck" -eq 1 ] && case "$OUTK" in *"RETIRED"*"oc-attrib"*) true ;; *) false ;; esac; then
    ok "contributors: retired verb -> rc1 + loud oc-attrib pointer"
  else
    bad "contributors retired (rc=$rck, want 1 + RETIRED + oc-attrib pointer)"
  fi
  # gh stub: run 222 GREEN (built sha cccc...) + run 666 RED (head from red-head)
  cat > "$SD/gh" <<'GHSTUB'
#!/usr/bin/env bash
SD="$(cd "$(dirname "$0")" && pwd)"
case "$*" in
  *actions/runs/222/jobs*) echo '{"jobs":[{"name":"ORDER gates (cccccccccccccccccccccccccccccccccccccccc)","conclusion":"success"},{"name":"Linux amd64 (cccccccccccccccccccccccccccccccccccccccc, telegram)","conclusion":"success"}]}' ;;
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
# M2-21 (2026-09-12) e2e: the selftest must be LOG-HERMETIC BY CONSTRUCTION,
# not by argv shape. Run the BARE subcommand -- the spelling that slipped the
# flag-only predicate -- with OC_TOOLS_LOG pointed at a temp file and require
# ZERO rows. Pre-fix this wrote 93 rows of fixture dispatches; oc-ship-audit
# read six of them back as ORPHANED and rc=1'd a gate that fronts
# `oc-ledger commit-pending`. OC_TOOLS_NOLOG=0 is REQUIRED: the battery exports
# it as 1 globally (run.sh:21), which would make this assertion vacuous.
LSE="$(mktemp -d)/selftest.log"
run_capture "oc-deploy selftest (bare subcommand)" \
  env OC_TOOLS_NOLOG=0 OC_DEPLOY_STATE_DIR="$(mktemp -d)" OC_TOOLS_LOG="$LSE" \
     "$TOOLS_DIR/oc-deploy" selftest
if [ -s "$LSE" ]; then
  bad "bare selftest leaked $(wc -l < "$LSE") row(s) into OC_TOOLS_LOG (M2-21)"
else
  ok "bare selftest is log-hermetic: 0 rows (M2-21)"
fi
if tool oc-deploy; then
  "$TOOLS_DIR/oc-deploy" >/dev/null 2>&1; [ $? -eq 1 ] && ok "no args -> 1 (usage)" || bad "no args -> expected 1"
  "$TOOLS_DIR/oc-deploy" --bogus >/dev/null 2>&1; [ $? -eq 1 ] && ok "unknown arg -> 1" || bad "unknown arg -> expected 1"
  d="$(mktemp -d)"; printf x > "$d/oc-deploy.kill"
  OC_DEPLOY_STATE_DIR="$d" "$TOOLS_DIR/oc-deploy" poll >/dev/null 2>&1
  [ $? -eq 9 ] && ok "kill file -> 9 (real-mode brake)" || bad "kill file -> expected 9"
  # Duty-6 lens F task 5: --wait validated BEFORE any RED-scan side effects —
  # bad --wait dies rc1 with no fanout/state writes (the kill-file brake sits at
  # the TOP of every real-mode arm, so poll with kill file + bad --wait -> 9,
  # not 1; contract fix ec4706bd moved it there from before arg parsing).
  d2="$(mktemp -d)"
  OC_DEPLOY_STATE_DIR="$d2" OC_DEPLOY_GH=/bin/false "$TOOLS_DIR/oc-deploy" poll --wait abc >/dev/null 2>&1
  [ $? -eq 1 ] && ok "poll bad --wait -> 1 before side effects" || bad "poll bad --wait -> expected 1"
  [ "$(ls -A "$d2" 2>/dev/null)" = "oc-deploy-shadow.log" ] && ok "poll bad --wait: no state writes beyond shadow log" || bad "poll bad --wait wrote state: $(ls "$d2")"
  rm -rf "$d2"
  # Ship-pending law (n=2003 family, v0.4.99): poll --sha S with S already
  # deployed must NOT say "nothing new" — dispatched-sha GREEN = SWAP PENDING.
  # Full-loop dry check: state dir with deployed.sha == the only decodable
  # green run's sha, plus --sha of that same sha -> swap-execute handoff path
  # reached, never rc5 "already deployed". (Uses --execute but stage < S2 in
  # the sandbox, so the loop breaks and lands in the LOCKED plan branch.)
  d3="$(mktemp -d)"; SD3="$d3/state"; mkdir -p "$SD3"
  PEN_SHA="0123456789abcdef0123456789abcdef01234567"
  printf '%s\n' "$PEN_SHA" > "$SD3/deployed.sha"
  printf '{"sha":"%s","features":"telegram","ts":"2026-09-08T00:00:00Z"}\n' "$PEN_SHA" > "$SD3/deployed.meta.json"
  # gh stub: one success run whose job name embeds PEN_SHA (both-shapes decode)
  cat > "$d3/gh" <<GHEOF
#!/usr/bin/env bash
case "\$*" in
  *"/runs?status=success"*) echo '{"workflow_runs":[{"id":111}]}';;
  *"/runs/111/jobs"*) echo '{"jobs":[{"name":"build (0123456789abcdef0123456789abcdef01234567, telegram)"},{"name":"gates (0123456789abcdef0123456789abcdef01234567)"}]}';;
  *) echo '{}';;
esac
GHEOF
  chmod +x "$d3/gh"
  OC_DEPLOY_STATE_DIR="$SD3" OC_DEPLOY_GH="$d3/gh" OC_DEPLOY_NOFANOUT=1 OC_DEPLOY_POLL_INTERVAL=1 \
    "$TOOLS_DIR/oc-deploy" poll --wait 2 --sha "$PEN_SHA" --execute --features telegram >/dev/null 2>&1
  RC3=$?
  grep -q "nothing new" "$d3"/oc-deploy-shadow.log 2>/dev/null && MISSED=1 || MISSED=0
  [ "$RC3" != 5 ] && [ "$MISSED" = 0 ] && ok "poll --sha pending: dispatched-sha GREEN never reports 'already deployed'" || bad "poll --sha pending: rc=$RC3 missed=$MISSED"
  rm -rf "$d3"
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
    "$TOOLS_DIR/oc-deploy" ship --sha "$SHA2" --features telegram >/dev/null 2>&1)
  git -C "$d/repo" checkout -q -B main "$SHA2"
  git -C "$d/repo" push -q -f "$d/remote.git" main~1:refs/heads/main
  OUT2="$(cd "$d/repo" && OC_DEPLOY_STATE_DIR="$SD" OC_DEPLOY_REMOTE="$d/remote.git" \
    OC_DEPLOY_VALIDATE="$SD/tools/val" OC_DEPLOY_GH="$SD/gh" "$TOOLS_DIR/oc-deploy" ship --sha "$SHA2" --features telegram 2>&1)"; rc=$?
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
# #19 (2026-09-12): stamp REFUSES an anonymous row, so the battery fixture
# carries an actor the way a lane's shell does.
OC_LEDGER="$d/state/workers-ledger.json" OC_ACTOR="aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee" "$TOOLS_DIR/oc-ledger" stamp note "battery edge" >/dev/null 2>&1 \
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
  SD_PRC="$(mktemp -d)"   # hermetic: usage() writes .oc-prchecks-rc2 into the state dir (goal C, ts 18:34:19Z leak)
  OC_DEPLOY_STATE_DIR="$SD_PRC" "$TOOLS_DIR/oc-prchecks" >/dev/null 2>&1; [ $? -eq 2 ] && ok "no args -> 2 (usage)" || bad "no args -> expected 2"
  OC_DEPLOY_STATE_DIR="$SD_PRC" "$TOOLS_DIR/oc-prchecks" abc123 >/dev/null 2>&1; [ $? -eq 2 ] && ok "short sha -> 2 (FULL-sha shape gate)" || bad "short sha -> expected 2"
  rm -rf "$SD_PRC"
  [ ! -f "${OC_DEPLOY_STATE_DIR:-/root/.opencrabs/profiles/ops/opencrabs-dev}/.oc-prchecks-rc2" ] || true   # informational; real check: no NEW writes below
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
# (oc-ledger selftest executed in section 11)

# ---- 17. lens-F coverage batch (v0.4.72, F8: tools the battery never ran) ---
section "oc-shadow-rotate"
if tool oc-shadow-rotate; then
  d="$(mktemp -d)"
  OC_DEPLOY_STATE_DIR="$d" "$TOOLS_DIR/oc-shadow-rotate" --dry-run >/dev/null 2>&1; [ $? -eq 0 ] && ok "no live log -> noop rc 0" || bad "no live log -> expected 0"
  printf 'line1\nline2\n' > "$d/oc-deploy-shadow.log"
  OUTS="$(OC_DEPLOY_STATE_DIR="$d" "$TOOLS_DIR/oc-shadow-rotate" --dry-run 2>&1)"; rc=$?
  [ "$rc" -eq 0 ] && case "$OUTS" in *"PLAN: append 2 lines"*) true ;; *) false ;; esac && ok "dry-run PLAN names 2 lines" || bad "dry-run PLAN (rc=$rc, got: $OUTS)"
  OC_DEPLOY_STATE_DIR="$d" "$TOOLS_DIR/oc-shadow-rotate" >/dev/null 2>&1; rc=$?
  [ "$rc" -eq 0 ] && [ ! -s "$d/oc-deploy-shadow.log" ] && grep -q line1 "$d/oc-deploy-shadow.archive.log" \
    && ok "rotate: archive appended + live truncated" || bad "rotate (rc=$rc)"
  OC_DEPLOY_STATE_DIR="$d" "$TOOLS_DIR/oc-shadow-rotate" --bogus >/dev/null 2>&1; [ $? -eq 2 ] && ok "unknown arg -> 2 (usage, C-#3: was 1)" || bad "unknown arg -> expected 2"
  rm -rf "$d"
fi

section "oc-smoke-evidence"
run_selftest oc-smoke-evidence
if tool oc-smoke-evidence; then
  "$TOOLS_DIR/oc-smoke-evidence" --bogus >/dev/null 2>&1; [ $? -eq 2 ] && ok "unknown arg -> 2 (usage)" || bad "unknown arg -> expected 2"
  "$TOOLS_DIR/oc-smoke-evidence" --unit oc-no-such-unit --strings m1 >/dev/null 2>&1; [ $? -eq 3 ] && ok "--strings deprecated alias parses (unit-fail rc 3, E2 #6)" || bad "--strings alias -> expected 3"
  # M2-2: the decoy-path guard. A bare/relative --append-log must resolve to the
  # CANONICAL log (no divergence note); a foreign absolute path must announce itself.
  SED_TMP="$(mktemp -d)"
  OC_DEPLOY_STATE_DIR="$SED_TMP" "$TOOLS_DIR/oc-smoke-evidence" --append-log --unit oc-no-such-unit 2>&1 | grep -q 'NOT the canonical' && bad "bare --append-log diverged from canonical" || ok "bare --append-log -> canonical log (M2-2)"
  OC_DEPLOY_STATE_DIR="$SED_TMP" "$TOOLS_DIR/oc-smoke-evidence" --append-log smoke-verdicts.log --unit oc-no-such-unit 2>&1 | grep -q 'NOT the canonical' && bad "relative --append-log escaped STATE_DIR" || ok "relative --append-log resolves to STATE_DIR, not CWD (M2-2)"
  OC_DEPLOY_STATE_DIR="$SED_TMP" "$TOOLS_DIR/oc-smoke-evidence" --append-log /tmp/oc-elsewhere.log --unit oc-no-such-unit 2>&1 | grep -q 'NOT the canonical' && ok "divergent absolute --append-log announces itself (M2-2)" || bad "divergent --append-log was silent"
  rm -rf "$SED_TMP"
fi

section "oc-issue-log"
run_selftest oc-issue-log
if tool oc-issue-log; then
  "$TOOLS_DIR/oc-issue-log" >/dev/null 2>&1; [ $? -eq 2 ] && ok "no args -> 2 (usage)" || bad "no args -> expected 2"
  OC_ISSUE_LOG_REPO=x/y "$TOOLS_DIR/oc-issue-log" 1 zznotasha --dry-run >/dev/null 2>&1; [ $? -eq 3 ] && ok "bad sha -> 3 (not found)" || bad "bad sha -> expected 3"
fi

section "oc-commit"
run_selftest oc-commit
if tool oc-commit; then
  "$TOOLS_DIR/oc-commit" >/dev/null 2>&1; [ $? -eq 2 ] && ok "no args -> 2 (usage)" || bad "no args -> expected 2"
fi

section "oc-ship-audit"
run_selftest oc-ship-audit
if tool oc-ship-audit; then
  "$TOOLS_DIR/oc-ship-audit" --bogus >/dev/null 2>&1; [ $? -eq 2 ] && ok "unknown arg -> 2 (usage)" || bad "unknown arg -> expected 2"
fi

section "oc-tg-audit"
run_selftest oc-tg-audit
if tool oc-tg-audit; then
  "$TOOLS_DIR/oc-tg-audit" >/dev/null 2>&1; [ $? -eq 2 ] && ok "no args -> 2 (usage)" || bad "no args -> expected 2"
fi

section "oc-harvest-sweep"
run_selftest oc-harvest-sweep
if tool oc-harvest-sweep; then
  "$TOOLS_DIR/oc-harvest-sweep" >/dev/null 2>&1; [ $? -eq 2 ] && ok "no args -> 2 (usage)" || bad "no args -> expected 2"
fi

section "oc-harvest-census"
run_selftest oc-harvest-census
if tool oc-harvest-census; then
  "$TOOLS_DIR/oc-harvest-census" >/dev/null 2>&1; [ $? -eq 2 ] && ok "no args -> 2 (usage)" || bad "no args -> expected 2"
fi

section "oc-rebase-safety"
run_selftest oc-rebase-safety
if tool oc-rebase-safety; then
  "$TOOLS_DIR/oc-rebase-safety" >/dev/null 2>&1; [ $? -eq 2 ] && ok "no args -> 2 (usage)" || bad "no args -> expected 2"
  "$TOOLS_DIR/oc-rebase-safety" overlap >/dev/null 2>&1; [ $? -eq 2 ] && ok "overlap missing args -> 2" || bad "overlap missing args -> expected 2"
  "$TOOLS_DIR/oc-rebase-safety" audit >/dev/null 2>&1; [ $? -eq 2 ] && ok "audit missing args -> 2" || bad "audit missing args -> expected 2"
fi

section "oc-roster"
run_selftest oc-roster
if tool oc-roster; then
  "$TOOLS_DIR/oc-roster" >/dev/null 2>&1; [ $? -eq 2 ] && ok "no args -> 2 (usage)" || bad "no args -> expected 2"
  "$TOOLS_DIR/oc-roster" --no-such-arg >/dev/null 2>&1; [ $? -eq 2 ] && ok "unknown arg -> 2" || bad "unknown arg -> expected 2"
fi

# ---- 18. oc-ship-chain (5→swapped orchestrator, owner GO 16:16Z) -----------
section "oc-ship-chain (5→swapped orchestrator, owner GO 16:16Z)"
run_selftest oc-ship-chain
if tool oc-ship-chain; then
  "$TOOLS_DIR/oc-ship-chain" >/dev/null 2>&1; [ $? -eq 2 ] && ok "no args -> 2 (usage)" || bad "no args -> expected 2"
  "$TOOLS_DIR/oc-ship-chain" --no-such-arg >/dev/null 2>&1; [ $? -eq 2 ] && ok "unknown arg -> 2" || bad "unknown arg -> expected 2"
fi


# ---- battery receipt (oc-ledger sync gate reads this; the file itself rides --
# ---- the skill repo via commit-pending --bundle) ------------------------------
# ---- 60. rc contract: --help exits 0 fleet-wide (C-#3, tools/RC-CONTRACT.md)
section "rc contract --help=0 fleet-wide (C-#3)"
for t in "$TOOLS_DIR"/oc-*; do
  [ -x "$t" ] || continue
  tn="$(basename "$t")"
  OC_TOOLS_NOLOG=1 timeout 20 "$t" --help >/dev/null 2>&1     && ok "$tn --help rc=0" || bad "$tn --help rc!=0 (RC-CONTRACT.md violated)"
done

# ---- 61. oc-notify-fanout: placeholder guard + target validation (HQ ASSIGN 2026-09-09)
section "oc-notify-fanout guards (law1 placeholder + dead-target skip + --roles)"
NF="$TOOLS_DIR/oc-notify-fanout"
# LAW 16 (defect D-1, HQ 2026-09-12): self identity is DERIVED from the
# invoking session and an unresolved self is a HARD ERROR (rc 2) — the old
# hardcoded lane default is gone. So every fixture must name its invoker.
# Resolve the live toolsmith lane; the fallback matches no real lane, which
# keeps 61a/61b about the placeholder guard rather than about exclusion.
NFSELF="$(bash "$TOOLS_DIR/oc-ledger" roster --live --role toolsmith 2>/dev/null | head -1 | awk '{print $1}')"
[ -n "$NFSELF" ] || NFSELF="00000000-0000-4000-8000-00000000dead"
# 61a. placeholder law: dangling token -> every send ABORTed, rc!=0
NFOUT="$(OC_TOOLS_NOLOG=1 OC_FANOUT_SELF="$NFSELF" OC_FANOUT_LEDGER="$HOME/.opencrabs/profiles/ops/opencrabs-dev/workers-ledger.json" timeout 200 bash "$NF" \
  --title "t-battery" --text "dangling {{NOSUCH}} token" --dry-run 2>&1)" \
  && bad "fanout placeholder-guard: rc=0 on token leak" \
  || { printf '%s' "$NFOUT" | grep -q "placeholder-token-survived" \
       && ok "fanout placeholder-guard: dangling token -> send ABORTed (law1)" \
       || bad "fanout placeholder-guard: aborted but no law1 receipt"; }
# 61b. substitution: valid tokens -> DRY briefs, no ABORT, dead uuids skipped
NFOUT="$(OC_TOOLS_NOLOG=1 OC_FANOUT_SELF="$NFSELF" OC_FANOUT_LEDGER="$HOME/.opencrabs/profiles/ops/opencrabs-dev/workers-ledger.json" timeout 200 bash "$NF" \
  --title "t-battery" --text "v{{VERSION}} u{{UUID}}" --dry-run 2>&1)"
printf '%s' "$NFOUT" | grep -q "placeholder-token-survived" \
  && bad "fanout substitution: valid tokens ABORTed (substitution broken)" \
  || ok "fanout substitution: {{UUID}}/{{VERSION}} resolved, 0 ABORTs"
printf '%s' "$NFOUT" | grep -qE "sent=[0-9]+ skipped=[0-9]+ failed=0" \
  && ok "fanout dry-run summary clean (dead targets skipped, none failed)" \
  || bad "fanout dry-run summary has failures"
# 61c. roles filter: --roles toolsmith (self-excluded) -> sent=0
NFOUT="$(OC_TOOLS_NOLOG=1 OC_FANOUT_SELF="$NFSELF" OC_FANOUT_LEDGER="$HOME/.opencrabs/profiles/ops/opencrabs-dev/workers-ledger.json" timeout 200 bash "$NF" \
  --title "t" --text "x" --dry-run --roles toolsmith 2>&1)"
printf '%s' "$NFOUT" | grep -q "sent=0" \
  && ok "fanout --roles filter respected" \
  || bad "fanout --roles filter leaked sends"
# 61d. oc-notify-fanout internal selftest suite
run_selftest "oc-notify-fanout" "$NF"

# ---- 62. oc-health (owner-ordered hourly health & cleanliness sweep, 2026-09-11)
section "oc-health (hourly health & cleanliness sweep)"
HZ="$TOOLS_DIR/oc-health"
# 62a. hermetic selftest: fixture state dir + tmp glob + sqlite DB + git repos,
#      so the reaping cases run without touching live state. The assertion count
#      is read from the selftest's own PASS= line (never hardcoded — a hardcoded
#      count silently goes stale every time a case is added).
HOUT="$(bash "$HZ" --selftest 2>&1)"; HRC=$?
HN="$(printf '%s' "$HOUT" | sed -n 's/.*PASS=\([0-9]*\).*/\1/p' | tail -1)"
[ "$HRC" -eq 0 ] && ok "oc-health --selftest PASS (${HN:-?} assertions)" \
  || bad "oc-health --selftest rc=$HRC: $(printf '%s' "$HOUT" | tail -3)"
# 62b. read-only run must NOT mutate: no --reap, no writes; rc is 0 (clean) or 1
#      (findings) — never 2/3 on a healthy box.
HOUT="$(bash "$HZ" --json 2>&1)"; HRC=$?
case "$HRC" in
  0|1) ok "oc-health read-only rc=$HRC (0 clean / 1 findings)" ;;
  *)   bad "oc-health read-only rc=$HRC (want 0|1)" ;;
esac
printf '%s' "$HOUT" | python3 -c 'import json,sys; json.load(sys.stdin)' 2>/dev/null \
  && ok "oc-health --json parses (stdout is the whole contract)" \
  || bad "oc-health --json not parseable: $(printf '%s' "$HOUT" | head -2)"
# 62c. --help exits 0 (rc-contract row)
bash "$HZ" --help >/dev/null 2>&1 && ok "oc-health --help rc=0" || bad "oc-health --help rc!=0"
# 62d. watcher-window override: 0 = all history must still be a valid measurement
#      (rc 0|1, parseable JSON) — the knob must never turn into a measurement failure.
WOUT="$(OC_HEALTH_WATCHER_WINDOW_H=0 bash "$HZ" --class runtime_procs --json 2>&1)"; WRC=$?
case "$WRC" in
  0|1) ok "oc-health watcher-window override rc=$WRC (0 clean / 1 findings)" ;;
  *)   bad "oc-health watcher-window override rc=$WRC (want 0|1)" ;;
esac
printf '%s' "$WOUT" | python3 -c 'import json,sys; json.load(sys.stdin)' 2>/dev/null \
  && ok "oc-health --class runtime_procs --json parses" \
  || bad "oc-health runtime_procs json not parseable: $(printf '%s' "$WOUT" | head -2)"

# ---- 63. oc-watcher-audit (detached watcher compliance audit, Cycle 5 Review C-2)
section "oc-watcher-audit (detached watcher compliance audit)"
run_selftest oc-watcher-audit
if tool oc-watcher-audit; then
  "$TOOLS_DIR/oc-watcher-audit" --bogus >/dev/null 2>&1; [ $? -eq 2 ] && ok "unknown arg -> 2 (usage)" || bad "unknown arg -> expected 2"
  "$TOOLS_DIR/oc-watcher-audit" --help >/dev/null 2>&1 && ok "oc-watcher-audit --help rc=0" || bad "oc-watcher-audit --help rc!=0"
fi

# ---- 65. oc-start (unified claim, branch, worktree initializer, Cycle c14)
section "oc-start (unified task initializer)"
run_selftest oc-start
if tool oc-start; then
  "$TOOLS_DIR/oc-start" --bogus >/dev/null 2>&1; [ $? -eq 2 ] && ok "unknown arg -> 2 (usage)" || bad "unknown arg -> expected 2"
  "$TOOLS_DIR/oc-start" --help >/dev/null 2>&1 && ok "oc-start --help rc=0" || bad "oc-start --help rc!=0"
fi

# ---- 66. oc-smoke (unified 4-leg smoke verification & verdict row generator, Cycle c14)
section "oc-smoke (unified 4-leg smoke verification)"
run_selftest oc-smoke
if tool oc-smoke; then
  "$TOOLS_DIR/oc-smoke" --bogus >/dev/null 2>&1; [ $? -eq 2 ] && ok "unknown arg -> 2 (usage)" || bad "unknown arg -> expected 2"
  "$TOOLS_DIR/oc-smoke" --help >/dev/null 2>&1 && ok "oc-smoke --help rc=0" || bad "oc-smoke --help rc!=0"
fi

# ---- 64. oc-issue-dispatch (mechanized fork issue dispatch, v0.4.169 Zero-Ack)
section "oc-issue-dispatch (mechanized issue triage dispatch)"
run_selftest oc-issue-dispatch
if tool oc-issue-dispatch; then
  "$TOOLS_DIR/oc-issue-dispatch" --bogus >/dev/null 2>&1; [ $? -eq 2 ] && ok "unknown arg -> 2 (usage)" || bad "unknown arg -> expected 2"
  "$TOOLS_DIR/oc-issue-dispatch" --help >/dev/null 2>&1 && ok "oc-issue-dispatch --help rc=0" || bad "oc-issue-dispatch --help rc!=0"
fi

# ---- 67. oc-lint-laws (markdown law syntax & tool reference linter)
section "oc-lint-laws (law syntax & reference linter)"
run_selftest oc-lint-laws
if tool oc-lint-laws; then
  "$TOOLS_DIR/oc-lint-laws" --bogus >/dev/null 2>&1; [ $? -eq 2 ] && ok "unknown arg -> 2 (usage)" || bad "unknown arg -> expected 2"
  "$TOOLS_DIR/oc-lint-laws" --help >/dev/null 2>&1 && ok "oc-lint-laws --help rc=0" || bad "oc-lint-laws --help rc!=0"
fi

# ---- 68. oc-harvest-dispatch (automated harvest order dispatcher)
section "oc-harvest-dispatch (harvest order dispatcher)"
run_selftest oc-harvest-dispatch
if tool oc-harvest-dispatch; then
  "$TOOLS_DIR/oc-harvest-dispatch" --bogus >/dev/null 2>&1; [ $? -eq 2 ] && ok "unknown arg -> 2 (usage)" || bad "unknown arg -> expected 2"
  "$TOOLS_DIR/oc-harvest-dispatch" --help >/dev/null 2>&1 && ok "oc-harvest-dispatch --help rc=0" || bad "oc-harvest-dispatch --help rc!=0"
fi

# ---- 69. oc-log-search (telemetry-only daemon-log search)
section "oc-log-search (telemetry-only log search)"
run_selftest oc-log-search
if tool oc-log-search; then
  "$TOOLS_DIR/oc-log-search" --bogus >/dev/null 2>&1; [ $? -eq 2 ] && ok "unknown arg -> 2 (usage)" || bad "unknown arg -> expected 2"
  "$TOOLS_DIR/oc-log-search" --help >/dev/null 2>&1 && ok "oc-log-search --help rc=0" || bad "oc-log-search --help rc!=0"
fi

# ---- 70. archive alias integrity (HQ 2026-09-19: 16/16 were DANGLING) -------
section "tools/archive alias integrity"
if [ -d "$TOOLS_DIR/archive" ]; then
  # An archived name is an ALIAS: tools/archive/<old> -> ../<new>. Sixteen of
  # them shipped 2026-09-13 pointing at a BARE name, which the kernel resolves
  # inside tools/archive/ itself and therefore resolves to NOTHING — a
  # directory of links that silently resolve to nothing, dead for six days
  # because nothing ever tested them. Every symlink here must (a) RESOLVE and
  # (b) point one level up, since its target was left behind in tools/ when
  # the name moved into archive/. Both legs are checked; `-e` alone would pass
  # a link that resolved to the wrong thing, and the bare-target leg names the
  # exact mistake so a regression is self-diagnosing.
  arch_n=0; arch_dang=0; arch_bare=0
  for f in "$TOOLS_DIR/archive"/*; do
    [ -L "$f" ] || continue
    arch_n=$((arch_n+1))
    [ -e "$f" ] || { arch_dang=$((arch_dang+1)); note "  dangling: $f -> $(readlink "$f")"; }
    case "$(readlink "$f")" in
      ../*) : ;;
      *) arch_bare=$((arch_bare+1)); note "  bare target: $f -> $(readlink "$f")" ;;
    esac
  done
  [ "$arch_n" -ge 16 ] && ok "archive aliases present ($arch_n)" || bad "only $arch_n archive alias(es); expected >=16"
  [ "$arch_dang" -eq 0 ] && ok "archive aliases all resolve ($arch_n)" || bad "$arch_dang archive alias(es) DANGLING"
  [ "$arch_bare" -eq 0 ] && ok "archive aliases point one level up" || bad "$arch_bare archive alias(es) use a BARE target (resolves inside archive/)"
else
  bad "tools/archive missing"
fi

# ---- 71. oc-census (READ-ONLY pending-branch census) ------------------------
# The selftest builds a throwaway 5-branch fixture repo and asserts the
# decomposition invariant (plus_total == plus_own + plus_untrailered +
# plus_other) plus the tip-lane resolution rule. It never touches the real
# repo, so it costs ~1s and is safe to run in the battery.
section "oc-census (pending-branch census)"
run_selftest oc-census

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
