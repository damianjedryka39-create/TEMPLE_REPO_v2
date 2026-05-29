#!/bin/bash
# STRAŻNIK: bramka Reflect przed SYNC_STATE (Bash). Źródło: Hooks_Audit #3, L4 (łamane 4×).
# Wejście: JSON stdin (tool_input.command). Block gdy commit SYNC_STATE bez LESSONS/VOICE w staged.
# Obejście: dopisz 'SKIP_REFLECT' do treści commita gdy świadomie pomijasz.
cmd=$(python3 -c "import json,sys; print(json.load(sys.stdin).get('tool_input',{}).get('command',''))" 2>/dev/null)
if printf '%s' "$cmd" | grep -qE 'git +commit.*SYNC_STATE'; then
  if printf '%s' "$cmd" | grep -q 'SKIP_REFLECT'; then exit 0; fi
  mod=$(git diff --cached --name-only 2>/dev/null | grep -cE 'LESSONS\.md|VOICE\.md')
  if [ "$mod" -eq 0 ]; then
    echo "🔁 BLOKADA: commit SYNC_STATE bez śladu Reflect (LESSONS.md/VOICE.md nie w staged — L4, łamane 4×). Wykonaj Reflect, albo dopisz 'SKIP_REFLECT' do treści commita, jeśli świadomie pomijasz." >&2
    exit 2
  fi
fi
exit 0
