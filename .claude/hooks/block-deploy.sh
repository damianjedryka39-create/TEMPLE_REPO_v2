#!/bin/bash
# STRAŻNIK: blokada akcji deploy/produkcyjnych (Bash). Źródło: Hooks_Audit #1 + feedback_no_auto_deploy.
# Wejście: JSON stdin (tool_input.command). Obejście: świeży marker /tmp/ALLOW_DEPLOY (<2 min).
cmd=$(python3 -c "import json,sys; print(json.load(sys.stdin).get('tool_input',{}).get('command',''))" 2>/dev/null)
if [ -f /tmp/ALLOW_DEPLOY ] && [ $(( $(date +%s) - $(stat -c %Y /tmp/ALLOW_DEPLOY) )) -lt 120 ]; then exit 0; fi
if printf '%s' "$cmd" | grep -qE 'nginx +-s +reload|nginx .*reload|certbot|systemctl +(start|stop|restart|reload)|docker +push'; then
  echo "🚀 BLOKADA: akcja deploy/produkcyjna (nginx/certbot/systemctl/docker push). Wymaga jawnej komendy Fi (feedback_no_auto_deploy). Jeśli autoryzował: 'touch /tmp/ALLOW_DEPLOY' i powtórz w 2 min." >&2
  exit 2
fi
exit 0
