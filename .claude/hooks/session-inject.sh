#!/bin/bash
# STRAŻNIK: detekcja urwanej sesji + wstrzyknięcie reguł ŻELAZNE + blockerów na starcie (SessionStart).
# Źródła: D19 (inject ŻELAZNE — reguła w pliku ≠ przestrzegana), D22 (czujka urwanej sesji).
# stdout SessionStart trafia do kontekstu agenta. Zawsze exit 0.
ROOT=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
LES="$ROOT/LESSONS.md"
STATE="$ROOT/🅒_NOW/STATE_OF_SYSTEM.md"
MARKER="$ROOT/.claude/.session_active"

# Czujka: marker żyje od startu sesji do czystego sync_state (który go gasi: rm -f).
# Marker zastany na starcie = poprzednia sesja NIE domknęła sync_state (crash / zamknięcie bez zapisu).
if [ -f "$MARKER" ]; then
  echo "=== ⚠️ POPRZEDNIA SESJA URWANA (brak sync_state) ==="
  echo "Poprzednia sesja zakończyła się bez SYNC_STATE — lekcja/postęp mogły NIE zostać zapisane."
  echo "ZANIM ruszysz dalej: odpal skill Reflect (wyciągnij lekcje z urwanej sesji), potem sync_state."
fi
touch "$MARKER" 2>/dev/null || true   # zapal lampkę „sesja żyje"

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
