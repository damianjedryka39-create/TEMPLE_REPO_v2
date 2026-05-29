#!/bin/bash
# STRAŻNIK: blokada 'git add -A/./--all' przy zagnieżdżonych repo (Bash). Źródło: L15, incydent 22.04 GOFANS×TEMPLE.
# Wejście: JSON stdin (tool_input.command). Block gdy >1 .git w poddrzewie głębokości 3.
cmd=$(python3 -c "import json,sys; print(json.load(sys.stdin).get('tool_input',{}).get('command',''))" 2>/dev/null)
if printf '%s' "$cmd" | grep -qE 'git +add +(-A|\.|--all)( |$)'; then
  n=$(find . -maxdepth 3 -type d -name .git 2>/dev/null | wc -l)
  if [ "$n" -gt 1 ]; then
    echo "📦 BLOKADA: 'git add -A' przy zagnieżdżonych repo ($n × .git w poddrzewie). Ryzyko commitu do złego repo (L15, incydent 22.04). Użyj 'git add <konkretne ścieżki>'." >&2
    exit 2
  fi
fi
exit 0
