#!/usr/bin/env python3
"""oc_claims.py — THE canonical claim-closure predicate (issues #305, #313, #314).

ONE implementation, imported by every tool that asks "is this claim still open?".

WHY THIS FILE EXISTS. Four copies of this predicate had drifted apart across
`oc-harvest-dispatch` (#305), `oc-issue-dispatch` (#309), `oc-roster` and
`oc-ledger` (#313). They did not merely differ in style:

  * two copies extracted issue tokens as INTEGERS, two as STRINGS, and each
    compared tokens against its own type — so on a ledger mixing both, one
    copy's `tok in e['tokens']` was silently always-False (a claim could never
    close) while another's was silently always-True-able;
  * only one copy asked WHO authored the closing row. The others treated any
    lane's closing event that merely MENTIONED `#N` in prose as closing every
    lane's claim on `#N` — which reported an ACTIVE lane as IDLE and bypassed
    the in-flight fencing that stops a patrol double-dispatching live work
    (#305);
  * conversely, a CROSS-LANE standdown addressed to `#N` (`STANDDOWN #269
    (52058a75)`, stamped by Triage) closed nothing at all, so a shipped,
    stood-down claim stayed OPEN until its claimant hand-stamped a redundant
    closure row (#313, live row n=7803 / n=8055).

Import from a tool (bash-embedded python included):

    sys.path.insert(0, os.path.join(
        os.path.dirname(os.path.abspath(__file__)), 'lib'))
    import oc_claims as oc

THE CANONICAL RULE — a claim on `#N` is CLOSED by a LATER event whose kind is
in CLOSING_KINDS and which satisfies ANY of:

  1. it is authored by the SAME lane as the claim, and references `#N`; or
  2. it is ADDRESSED to `#N` — its `what` begins `#N` (optionally after the
     `STANDDOWN ` keyword). Administrative sweeps
     (`#N — closed-issue stale claim sweep`) and a lane's own `#N COMPLETE`
     rows take this form, and their author is by design NOT the claimant; or
  3. the claim's author is UNATTRIBUTED (the `(unattributed` /
     `unrostered-actor` sentinels) — there is no actor to discriminate on, so
     ANY later closer referencing `#N` closes it.

Signal 2 is deliberately NARROW: `what` must BEGIN with the reference. A
foreign lane's closing row that merely mentions `#N` in prose — `UNCLAIM #264 —
stood down in favour of editor lane X` — must NOT close another lane's claim.
That row releases its AUTHOR's own claim, and by naming X it in fact confirms X
still holds it (#305).

NO REGEX OVER `what` AS A WHOLE. Issue references are extracted by TOKEN, never
by substring and never by "first run of digits": a date (`2026-09-15`), the
owner handle (`leshchenko1979`), a commit sha or a session-uuid prefix must not
be read as an issue number (#272), and `claims 76` must not match a claim on
`#760` (c6b1a539 residual).

WHAT A CLAIM CLAIMS (#329). Reference extraction answers TWO different
questions, and one token list must not serve both:

  * "does this row REFERENCE `#N`?" — every reference counts. A closing row's
    prose mention of `#N` is part of signal 1 (same author, references `#N`),
    so :func:`issue_ref_tokens` deliberately keeps them all.
  * "does this row CLAIM `#N`?" — only the row's ADDRESS counts. A `what` is a
    SENTENCE: the issues it cites while explaining itself are context, not
    claims. Live instance — row `n=8226` claims #327 and its note ends `...
    one proven live break (#323)`; reading that mention as a claim registered a
    PHANTOM claim on #323, which then made `oc-ledger sweep-closed-claims` want
    to write a false unclaim row and made `oc-issue-dispatch` report an OPEN
    issue as taken. 13 such phantoms existed fleet-wide.

:func:`primary_issue_tokens` is that second predicate: the leading reference
CLUSTER — starting at the first reference and continuing while further
references are joined only by list punctuation (`,`, `/`, `+`, `&`) or
whitespace. Prose separates, list punctuation does not, so a genuine
multi-issue claim survives (`CLAIM #193, #205 — harvest packaging`) while a
citation in the body drops out. Measured over the live ledger: of the 37 claim
rows carrying more than one reference, 35 change target under this rule, NONE
becomes target-less, and the one deliberate dual claim is preserved.

NEW ROWS CARRY THE ANSWER. `oc-ledger claim`/`stamp claim` records the targets
as a structured `issues` array on the row, so a claim written from now on is
never re-derived from prose at all; :func:`primary_issue_tokens` is the
fallback for rows written before that field existed.

READ-ONLY. This module never writes the ledger; the sweep's write path lives in
`oc-ledger` and goes through the sanctioned `stamp` verb.

WRITE-TIME CONSUMER. `oc-ledger`'s own `_issue_ref_tokens` shell helper now
delegates here rather than carrying a fifth copy of the pattern. That one sits
on the WRITE path (`stamp claim`'s dead-letter guard, and `claim-ref`, which
derives an issue from the very text `claims` scans), so a drifting copy there
does not merely mis-report — it lets the tool write a claim the scanner cannot
see, or derive an issue the scanner never wrote. Agreement is the point.
"""

import re

#: The only event kinds that can close a claim (v1 vocabulary).
CLOSING_KINDS = ("close", "confirm", "reject", "done", "unclaim")

# Accepted issue-reference forms: `#N`, `issue N`, `issue=N`, `issue#N`.
_REF_RE = re.compile(r"(?:#[0-9]+|issue[ \t=#]*[0-9]+)", re.IGNORECASE)
_DIGITS_RE = re.compile(r"[0-9]+")

# A claim's ADDRESS: consecutive references joined ONLY by list punctuation or
# whitespace. Anything else (prose, a separator, a bracket) ends the address and
# begins the body — see the module docstring, "WHAT A CLAIM CLAIMS".
_CLUSTER_RE = re.compile(
    r"^(?:[,\s/+&]*(?:#[0-9]+|issue[ \t=#]*[0-9]+))+", re.IGNORECASE)

# Actor forms observed live in the ledger's free-text `by` field:
#   'editor <uuid>', '<short-uuid>', 'editor-<short-uuid>',
#   'toolsmith/<short-uuid>', 'unrostered-actor <short-uuid>',
#   'editor lane (session <short-uuid>)', bare labels ('lamp-lane', 'supervisor').
_FULL_UUID_RE = re.compile(r"([0-9a-f]{8}(?:-[0-9a-f]{4}){3}-[0-9a-f]{12})", re.IGNORECASE)
_SHORT_UUID_RE = re.compile(r"([0-9a-f]{8})(?![0-9a-f-])", re.IGNORECASE)
# NB: a single character class, NOT '[-:/]?'. The alternation form mis-parses
# 'editor-1a63f103' by consuming the uuid into the role and losing the identity.
_ROLE_PREFIX_RE = re.compile(
    r"^(unrostered-actor|editor|triage|supervisor|hq|toolsmith|carrier|lane)\s*[-:/]?\s*",
    re.IGNORECASE)

# Sentinels meaning "no resolvable actor" (see derive_by in oc-ledger).
UNATTRIBUTED_PREFIXES = ("(unattributed", "unrostered-actor")


def issue_ref_tokens(text):
    """Every issue reference in ``text``, as INTEGERS, in first-seen order.

    Integers, not strings: the four drifted copies disagreed on this and one of
    them therefore compared a str token against int tokens forever-falsely.
    """
    if not text:
        return []
    out = []
    for match in _REF_RE.findall(str(text)):
        for num in _DIGITS_RE.findall(match):
            value = int(num)
            if value not in out:
                out.append(value)
    return out


def references(text, iss):
    """True when ``text`` references issue number ``iss`` (token match)."""
    return int(iss) in issue_ref_tokens(text)

def primary_issue_tokens(text):
    """The issue(s) a claim row CLAIMS — its leading reference cluster.

    Distinct from :func:`issue_ref_tokens`, which returns EVERY reference: this
    one answers "what is this row a claim ON?" and must not read a body citation
    as a second claim (#329 — see the module docstring).

    The cluster begins at the FIRST reference and extends while further
    references are joined only by list punctuation (`,`, `/`, `+`, `&`) or
    whitespace, so ``CLAIM #193, #205 — harvest packaging`` claims BOTH while
    ``CLAIM #327 — ... one proven live break (#323)`` claims only #327.

    Never empty when the text carries any reference at all (the cluster always
    contains the first one), so a caller may use it as the claim's target list
    and treat ``[]`` as "no reference anywhere".
    """
    if not text:
        return []
    s = str(text)
    first = _REF_RE.search(s)
    if not first:
        return []
    cluster = _CLUSTER_RE.match(s[first.start():])
    return issue_ref_tokens(cluster.group(0) if cluster else first.group(0))

def _targets_of(raw, what):
    """A claim row's targets: the structured field when present, else the prose.

    Rows written since #329 carry ``issues`` — a list of ints the writer
    recorded at stamp time, so the target is a FACT rather than an inference.
    Rows written before that field fall back to :func:`primary_issue_tokens`.
    """
    structured = raw.get("issues")
    if isinstance(structured, (list, tuple)):
        out = []
        for value in structured:
            try:
                num = int(value)
            except (TypeError, ValueError):
                continue
            if num not in out:
                out.append(num)
        if out:
            return out
    return primary_issue_tokens(what)


def actor_key(by):
    """Collapse a free-text ledger actor into a comparable key.

    Returns ``('uuid', <hex>)`` when any identity token is present, else
    ``('label', <slug>)``. Short 8-hex forms are kept short and compared by
    prefix in :func:`actor_match`, so no roster lookup is needed here.
    """
    s = str(by or "").strip()
    match = _FULL_UUID_RE.search(s)
    if match:
        return ("uuid", match.group(1).lower())
    shorts = _SHORT_UUID_RE.findall(s)
    if shorts:
        return ("uuid", shorts[-1].lower())  # last token: '<role> <uuid>'
    return ("label", _ROLE_PREFIX_RE.sub("", s).strip().lower())


def actor_match(a, b):
    """True when two ledger actor strings denote the SAME lane.

    uuid-vs-uuid compares by prefix (an 8-hex short form is a prefix of the
    full uuid); label-vs-label compares by exact slug. A uuid NEVER matches a
    label: `editor-14` and a bare 8-hex token are different lanes, and guessing
    between them is exactly what let a foreign lane close another lane's claim.
    """
    ka, kb = actor_key(a), actor_key(b)
    if ka[0] == "uuid" and kb[0] == "uuid":
        return ka[1] == kb[1] or ka[1].startswith(kb[1]) or kb[1].startswith(ka[1])
    if ka[0] == "label" and kb[0] == "label":
        return ka[1] != "" and ka[1] == kb[1]
    return False


def is_unattributed(by):
    """True for the 'no resolvable actor' sentinels written by derive_by."""
    s = str(by or "")
    return any(s.startswith(p) for p in UNATTRIBUTED_PREFIXES)


def is_addressed(what, iss):
    """True when ``what`` is ADDRESSED to issue ``iss`` (begins `#N`).

    Tolerates the `STANDDOWN ` keyword: `STANDDOWN #269 (52058a75) — ...`.
    Anchored at the start on purpose — a mere mention mid-sentence is not an
    address (#305).
    """
    return bool(re.match(r"^\s*(?:STANDDOWN\s+)?#%d\b" % int(iss), str(what or "").strip()))


def parse_events(events):
    """Normalise raw ledger events for the predicate.

    Each row gains ``by``/``kind``/``what`` as strings, ``tok`` as a LIST OF
    INTS — one type, so no consumer can compare across types by accident — and
    ``targets``, the issue(s) the row CLAIMS (structured ``issues`` field when
    present, else the leading reference cluster; see #329).
    """
    rows = []
    for idx, e in enumerate(events or []):
        what = e.get("what")
        if what is None:
            what = e.get("text", e.get("summary", e.get("note")))
        what = str(what or "")
        rows.append({
            "idx": idx,
            "n": e.get("n"),
            "by": str(e.get("by") or e.get("actor") or e.get("role") or ""),
            "kind": str(e.get("kind") or e.get("type") or ""),
            "t": str(e.get("t") or e.get("ts") or ""),
            "what": what,
            "tok": issue_ref_tokens(what),
            "targets": _targets_of(e, what),
        })
    return rows


def claim_is_closed(rows, idx, actor, iss):
    """Has the claim at ``rows[idx]`` been closed for issue ``iss``?

    ``rows`` is :func:`parse_events` output; ``iss`` is an int. Implements the
    canonical rule in the module docstring (signals 1-3).
    """
    unattributed = is_unattributed(actor)
    for later in rows[idx + 1:]:
        if later["kind"] not in CLOSING_KINDS:
            continue
        if unattributed or actor_match(actor, later["by"]):
            if iss in later["tok"]:
                return True
        if is_addressed(later["what"], iss):
            return True
    return False


def open_claims(events, target_issue=None):
    """Every still-OPEN claim row, as dicts (``idx``/``n``/``by``/``t``/``what``/``tokens``).

    ``target_issue`` restricts the scan to one issue number (int or str).
    A claim whose ``what`` carries no issue reference is skipped: every
    consumer keys on the reference, so such a row is a dead letter (and is
    refused at write time since the #19 / dead-letter residual).

    The row's targets are :func:`primary_issue_tokens` (or its structured
    ``issues`` field) — NOT every reference in the note. A claim that merely
    MENTIONS another issue in prose does not claim it (#329), which is what
    produced 13 phantom open claims and a false dispatch refusal.
    """
    rows = parse_events(events)
    target = int(target_issue) if target_issue is not None else None
    out = []
    for idx, claim in enumerate(rows):
        if claim["kind"] != "claim" or not claim["targets"]:
            continue
        if target is not None and target not in claim["targets"]:
            continue
        check = [target] if target is not None else sorted(claim["targets"])
        unclosed = [t for t in check if not claim_is_closed(rows, idx, claim["by"], t)]
        if unclosed:
            out.append({
                "idx": idx,
                "n": claim["n"],
                "by": claim["by"],
                "t": claim["t"],
                "what": claim["what"],
                "tokens": unclosed,
            })
    return out
