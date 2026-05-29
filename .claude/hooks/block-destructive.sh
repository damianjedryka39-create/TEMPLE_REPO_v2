#!/bin/bash
# STRAŻNIK: blokada komend niszczących (Bash). Źródło: ochrona przed bezpowrotną utratą pracy.
# Wejście: JSON stdin (tool_input.command). Obejście: świeży marker /tmp/ALLOW_DESTRUCTIVE (<2 min).
cmd=$(python3 -c "import json,sys; print(json.load(sys.stdin).get('tool_input',{}).get('command',''))" 2>/dev/null)
if [ -f /tmp/ALLOW_DESTRUCTIVE ] && [ $(( $(date +%s) - $(stat -c %Y /tmp/ALLOW_DESTRUCTIVE) )) -lt 120 ]; then exit 0; fi
if printf '%s' "$cmd" | grep -qE 'rm +-[a-z]*r[a-z]*f|rm +-[a-z]*f[a-z]*r|git +reset +--hard|git +push +.*(--force|-f)( |$)|git +checkout +\.|git +clean +-[a-z]*f|mkfs|> +/dev/sd'; then
  echo "💥 BLOKADA: komenda niszcząca (rm -rf / reset --hard / force-push / clean). Kasuje pracę bezpowrotnie. Jeśli Fi to autoryzował: 'touch /tmp/ALLOW_DESTRUCTIVE' i powtórz w 2 min." >&2
  exit 2
fi
exit 0
