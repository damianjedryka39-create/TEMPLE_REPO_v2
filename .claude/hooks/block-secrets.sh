#!/bin/bash
# STRAŻNIK: blokada czytania sekretów (Read). Źródło: Hooks_Audit #2 — ryzyko leak.
# Wejście: JSON na stdin (tool_input.file_path). Block = exit 2 + stderr.
fp=$(python3 -c "import json,sys; print(json.load(sys.stdin).get('tool_input',{}).get('file_path',''))" 2>/dev/null)
if printf '%s' "$fp" | grep -qE '\.env($|\.)|credentials\.json|secrets/|\.pem$|id_rsa|id_ed25519|\.key$|\.p12$'; then
  echo "🔒 BLOKADA: próba odczytania sekretu ($fp). Jeśli naprawdę trzeba — użyj Bash z jawną komendą po zgodzie Fi." >&2
  exit 2
fi
exit 0
