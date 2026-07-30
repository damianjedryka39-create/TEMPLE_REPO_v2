#!/bin/bash
# T1 — KONTEKST PRZY AKCJI: podaje regułę w sekundzie, w której ma zadziałać, nie godzinę wcześniej.
# Źródło: T1 z PROOF_BOOST_PLAN + decyzja Fi 2026-07-30 (po cofnięciu PB-2 — ciąć nie wolno, przesuwać moment można).
# Dowód działania mechanizmu: ŻELAZNA #1 leżała w pliku miesiącami i była łamana; zaczęła działać,
# gdy session-inject zaczął ją wstrzykiwać (sesja 17).
#
# ZASADA: hook NIE duplikuje treści reguł — czyta je z SSOT (CO_PILOT.md).
#         Edycja CO_PILOT = zmiana zachowania. Zero split-brain (D9).
# WEJŚCIE: JSON stdin (tool_input.command). WYJŚCIE: JSON z additionalContext. NIE blokuje (exit 0 zawsze).

ROOT="${CLAUDE_PROJECT_DIR:-$(git rev-parse --show-toplevel 2>/dev/null)}"
CP="$ROOT/🅓_SYSTEM/AGENT/CO_PILOT.md"

cmd=$(python3 -c "import json,sys; print(json.load(sys.stdin).get('tool_input',{}).get('command',''))" 2>/dev/null)
[ -z "$cmd" ] && exit 0
[ -f "$CP" ] || exit 0

# ── WYZWALACZ: git commit → polityka commit (CO_PILOT §7) ──────────────────────
# Wąsko: tylko commit. Nie "każdy Bash" — reguła podana za często staje się szumem, którego agent nie czyta.
printf '%s' "$cmd" | grep -qE '(^|[;&|] *)git +(-C +[^ ]+ +)?(-c +[^ ]+ +)*commit' || exit 0

SEKCJA=$(awk '/^## 7\. POLITYKA COMMIT/{f=1} f&&/^## 8\./{exit} f' "$CP" | sed '/^[[:space:]]*$/d')
[ -z "$SEKCJA" ] && exit 0

python3 - "$SEKCJA" <<'PY'
import json, sys
naglowek = '⚡ REGUŁA PRZY AKCJI — commit (źródło: CO_PILOT §7, wstrzyknięte przez context-at-action.sh)\n\n'
stopka = (
    '\n\nZanim wykonasz: czy etap jest DOMKNIĘTY (nie w połowie)? '
    'czy `git add` był na konkretne ścieżki, nie `-A` na katalog (ŻELAZNA #8)? '
    'czy commit wskazuje proof?'
)
print(json.dumps(
    {"hookSpecificOutput": {"hookEventName": "PreToolUse", "additionalContext": naglowek + sys.argv[1] + stopka}},
    ensure_ascii=False))
PY
exit 0
