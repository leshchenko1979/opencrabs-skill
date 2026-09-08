# lib/oc-notify.sh — shared session-wake contract (E-F4, v0.4.97)
#
# Single owner of the session-notify wake logic previously duplicated between
# oc-deploy (notify_session, fanout path) and oc-waiter (resolve_notify_bin +
# notify_lane). Both consumers now source this file and delegate.
#
# Exit-code contract enforced here (src/cli/session_notify.rs):
#   0 delivered / 2 no_route (dead uuid, permanent) /
#   3 refused_in_flight (target mid-turn — retry ONCE with --interrupt; a
#     mid-turn target MUST be woken or the verdict is lost) / 4 transport.
#
# Consumers may override via env BEFORE sourcing (or as documented args):
#   OC_NOTIFY_BIN      notify binary path (default: $NOTIFY_BIN, then
#                      /usr/local/bin/opencrabs, then PATH lookup)
#   OC_NOTIFY_PROFILE  --profile value (default ops)

oc_notify_resolve_bin() { # -> echoes binary path, rc 1 if unresolvable
  local b="${OC_NOTIFY_BIN:-${NOTIFY_BIN:-}}"
  if [ -n "$b" ]; then [ -x "$b" ] && { echo "$b"; return 0; }; return 1; fi
  if [ -x /usr/local/bin/opencrabs ]; then echo /usr/local/bin/opencrabs; return 0; fi
  command -v opencrabs 2>/dev/null
}

oc_notify_session() { # $1=bin $2=profile $3=sender $4=uuid $5=title $6=text
  # -> 0 delivered / rc passthrough of the session-notify contract
  local bin="$1" profile="$2" sender="$3" uuid="$4" title="$5" text="$6"
  local nrc=0 rrc=0
  "$bin" session notify --profile "$profile" --sender "$sender" \
    --title "$title" --text "$text" "$uuid" >/dev/null 2>&1 || nrc=$?
  if [ "$nrc" = 3 ]; then   # refused_in_flight: mid-turn target — MUST be woken
    "$bin" session notify --profile "$profile" --sender "$sender" \
      --title "$title" --text "$text" --interrupt "$uuid" >/dev/null 2>&1 || rrc=$?
    nrc=$rrc
  fi
  return "$nrc"
}
