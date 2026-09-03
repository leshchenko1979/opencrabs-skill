#!/usr/bin/env bash
# =============================================================================
# lib/oc-log.sh — unified tool log (KERNEL batch D0, 2026-08-28, owner order:
# "all tools save also to a single log file we will analyse in future").
#
# Every oc-* tool sources this lib and calls:
#     oc_log_init "<toolname>" "$@"      # right after set -u / arg parse
#     trap 'oc_log_finish $?' EXIT       # merge with any existing EXIT trap
#
# ONE JSONL line per invocation is appended at exit to $OC_TOOLS_LOG
# (default: /root/.opencrabs/profiles/ops/opencrabs-dev/tools.log):
#     {"ts":"…Z","tool":"oc-x","actor":"<uuid>","args":"…","exit":0,"secs":1.2,"extra":{}}
#
# actor — $OC_ACTOR (a session/role uuid) when set, else "unknown". Every
# oc-* invocation must carry OC_ACTOR=<session-uuid> (owner rule 2026-08-30)
# so floods/behavior stay attributable after the fact (ledger-beats-memory
# guard); an unset tool logs "unknown" so gaps are visible, never silent.
#
# Filterable/searchable by design — jq recipes live in SKILL.md §Unified
# tools log. Per-tool journals (the logging law) are UNTOUCHED: journals stay
# the durable step-by-step record, this file is the cross-tool analysis
# aggregate.
#
# Suppression: argv contains --selftest (also exported to child invocations)
# or OC_TOOLS_NOLOG=1 (the battery sets this so suites stay silent).
# Degrades to silence (never breaks the host tool): no jq, no line, no write.
# =============================================================================

OC_LOG_ENABLED=0
OC_LOG_TOOL=""
OC_LOG_ARGS=""
OC_LOG_EXTRA="{}"
OC_LOG_START=""

oc_log_init() {
  OC_LOG_TOOL="${1:-unknown}"
  shift 2>/dev/null || true
  OC_LOG_ARGS="$*"
  case " $OC_LOG_ARGS " in
    *" --selftest "*) export OC_TOOLS_NOLOG=1 ;;  # recursive selftest children stay silent too
    *" --no-log "*)   export OC_TOOLS_NOLOG=1 ;;  # lib-level suppression (E-B1, 2026-08-31): tools no longer pre-scan argv
  esac
  if [ "${OC_TOOLS_NOLOG:-0}" = "1" ]; then
    OC_LOG_ENABLED=0
    return 0
  fi
  OC_LOG_ENABLED=1
  OC_LOG_START="$(date +%s.%N)"
  oc_log_flood_guard
  # Signal honesty (#74, A3-lane report 2026-09-03): an async kill left $? at
  # the last COMPLETED command (usually 0), so the EXIT trap journaled an
  # exit-0 success row for an interrupted invocation. Trap TERM/INT/HUP and
  # exit 128+N: the EXIT trap then logs the true kill status, and extra.signal
  # names the signal — "interrupted" can never read as "success".
  trap 'oc_log_extra "signal" "TERM"; exit 143' TERM
  trap 'oc_log_extra "signal" "INT";  exit 130' INT
  trap 'oc_log_extra "signal" "HUP";  exit 129' HUP
  return 0
}

# oc_log_flood_guard — C-F1 (lens C 2026-08-31, owner "Go all"): a runaway
# lane re-invoking a failing tool in a loop (evidence: 140-row storm, one
# night) is refused at init. Counts PRIOR failed invocations with identical
# tool+args in the last 120s; >=4 prior failures -> the 5th attempt exits 8
# with a loud stderr banner. Bypass: OC_NO_FLOODGUARD=1 (selftests always
# bypass — a selftest replaying failures must not trip its own guard).
# Known limit (F-L4, v0.4.77): the guard matches IDENTICAL tool+args only —
# varying-arg storms (timestamps/run-ids interpolated into args) never trip
# rc 8; identical-args loops do.
oc_log_flood_guard() {
  [ "${OC_NO_FLOODGUARD:-0}" = "1" ] && return 0
  case " $OC_LOG_ARGS " in *" --selftest "*) return 0 ;; esac
  command -v jq >/dev/null 2>&1 || return 0
  local logf="${OC_TOOLS_LOG:-/root/.opencrabs/profiles/ops/opencrabs-dev/tools.log}"
  [ -f "$logf" ] || return 0
  local cutoff n
  cutoff="$(($(date +%s) - 120))"
  n="$(tail -n 300 "$logf" 2>/dev/null | jq -R -r \
    --arg tool "$OC_LOG_TOOL" --arg args "${OC_LOG_ARGS:0:500}" --argjson cutoff "$cutoff" '
    fromjson? | select(.tool == $tool and .args == $args and ((.exit // 0) != 0))
    | ((.ts // "" | fromdateiso8601? // 0)) | select(. >= $cutoff)' 2>/dev/null | wc -l)"
  if [ "${n:-0}" -ge 4 ]; then
    echo "FLOOD-GUARD (rc 8): $OC_LOG_TOOL with identical args already failed ${n}x in the last 120s — refusing to run again." >&2
    echo "  Fix the underlying failure, change the args, or set OC_NO_FLOODGUARD=1 to bypass (and say why in the lane journal)." >&2
    exit 8
  fi
  return 0
}

# oc_log_extra <key> <value> — add a string field to the invocation's extra{}
oc_log_extra() {
  [ "${OC_LOG_ENABLED:-0}" = "1" ] || return 0
  command -v jq >/dev/null 2>&1 || return 0
  OC_LOG_EXTRA="$(jq -cn --argjson e "${OC_LOG_EXTRA:-{\}}" --arg k "${1:-}" --arg v "${2:-}" \
    '$e + {($k): $v}' 2>/dev/null)" || OC_LOG_EXTRA="{}"
  return 0
}

# oc_log_finish <exit-code> — append the JSONL line. Never fails, never
# changes the host tool's exit code.
oc_log_finish() {
  local rc="${1:-0}"
  [ "${OC_LOG_ENABLED:-0}" = "1" ] || return 0
  command -v jq >/dev/null 2>&1 || return 0
  local end secs line logf
  end="$(date +%s.%N)"
  secs="$(awk -v s="${OC_LOG_START:-$end}" -v e="$end" 'BEGIN { printf "%.1f", e - s }' 2>/dev/null)"
  [ -n "$secs" ] || secs="0.0"
  line="$(jq -cn \
    --arg ts "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
    --arg tool "$OC_LOG_TOOL" \
    --arg actor "${OC_ACTOR:-unknown}" \
    --arg args "${OC_LOG_ARGS:0:500}" \
    --argjson exit "$rc" \
    --arg secs "$secs" \
    --argjson extra "${OC_LOG_EXTRA:-{\}}" \
    '{ts:$ts, tool:$tool, actor:$actor, args:$args, exit:$exit, secs:($secs|tonumber), extra:$extra}' 2>/dev/null)" || return 0
  [ -n "$line" ] || return 0
  logf="${OC_TOOLS_LOG:-/root/.opencrabs/profiles/ops/opencrabs-dev/tools.log}"
  mkdir -p "$(dirname "$logf")" 2>/dev/null
  if command -v flock >/dev/null 2>&1; then
    ( flock -x 9; printf '%s\n' "$line" >>"$logf" ) 9>>"$logf.lock" 2>/dev/null \
      || printf '%s\n' "$line" >>"$logf" 2>/dev/null
  else
    printf '%s\n' "$line" >>"$logf" 2>/dev/null
  fi
  return 0
}
