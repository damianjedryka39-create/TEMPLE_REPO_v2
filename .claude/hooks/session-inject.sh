#!/bin/bash
# STRAŻNIK: wstrzyknięcie reguł ŻELAZNE + blockerów na starcie sesji (SessionStart). Źródło: D19, sesja 14
# (reguła w pliku ≠ przestrzegana). stdout SessionStart trafia do kontekstu agenta. Zawsze exit 0.
ROOT=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
LES="$ROOT/LESSONS.md"
STATE="$ROOT/🅒_NOW/STATE_OF_SYSTEM.md"
echo "=== ⚡ REGUŁY ŻELAZNE (egzekwowane na starcie — pełny kontekst: LESSONS.md) ==="
if [ -f "$LES" ]; then
  awk '/## ⚡ ŻELAZNE/{f=1} f&&/^## L1 /{f=0} f' "$LES" | grep -E '^[0-9]+\. '
else
  echo "(brak LESSONS.md §ŻELAZNE w $ROOT)"
fi
if [ -f "$STATE" ]; then
  echo "=== TOP-3 BLOCKERS ==="
  awk '/## TOP-3 BLOCKERS/{f=1;next} f&&/^## /{f=0} f' "$STATE" | grep -E '^\| *[0-9]' | head -5
fi
exit 0
