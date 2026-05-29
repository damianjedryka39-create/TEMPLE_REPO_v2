# HOOKS AUDIT REPORT — TEMPLE_REPO_v2

> Data: 2026-05-29 (sesja 15 cz.3) | Trigger: po code-review (3 recenzentów) → luka "0 wdrożonych hooków" | Skill: Hooks_Audit

## STAN OBECNY (przed)
- Hooków projektowych w TEMPLE: **0** (brak `.claude/`)
- Hooków globalnych: 1 (`governance_limits.sh` — raportuje rozmiary, nic nie blokuje)
- Pokrycie ryzyk z LESSONS/feedback przez egzekucję: **0%** — wszystko na "dobrej woli" agenta
- Dowód luki: L12 łamane 3×, L4 4× mimo zapisu w plikach

## WDROŻONO — PAKIET 6 (zatwierdzony przez Fi)

Lokalizacja: `TEMPLE_REPO_v2/.claude/settings.json` + `.claude/hooks/*.sh`. Ścieżki przez `$CLAUDE_PROJECT_DIR` → propagują się przy forku (cp -r) i auto-dostosowują.

| # | Strażnik | Event | Źródło | Block / obejście |
|---|----------|-------|--------|------------------|
| 1 | block-secrets | PreToolUse:Read | Hooks_Audit #2 | exit 2; brak (użyj Bash po zgodzie) |
| 2 | block-destructive | PreToolUse:Bash | utrata pracy | exit 2; `touch /tmp/ALLOW_DESTRUCTIVE` <2min |
| 3 | block-git-add-all | PreToolUse:Bash | L15, incydent 22.04 | exit 2 gdy >1 .git w poddrzewie; `git add <ścieżki>` |
| 4 | block-deploy | PreToolUse:Bash | feedback_no_auto_deploy | exit 2; `touch /tmp/ALLOW_DEPLOY` <2min |
| 5 | reflect-gate | PreToolUse:Bash | L4 (4×) | exit 2 gdy commit SYNC_STATE bez LESSONS/VOICE w staged; `SKIP_REFLECT` w msg |
| 6 | session-inject | SessionStart | D19, sesja 14 | wstrzykuje 8 reguł ŻELAZNE + TOP-3 blockers do kontekstu |

## TEST — 16/16 PASS
Każdy strażnik testowany mock-inputem (JSON stdin): blokady wyzwalają exit 2, legalne komendy exit 0, obejścia (markery, SKIP_REFLECT) działają. session-inject poprawnie ekstrahuje sekcję ŻELAZNE + blockery.

## CO POMINIĘTO i DLACZEGO
- **self-check języka (L12)** — Fi nie wybrał; języka nie da się zhookować regexem (treść, nie akcja). Najczęściej łamana reguła pozostaje poza egzekucją mechaniczną — kandydat na miękki Stop-nudge jeśli problem wróci.
- **przypomnienie sync_state, ochrona SKILL/** — Fi nie wybrał; niskie ryzyko / komfort.
- **auto-format (#5 katalogu)** — TEMPLE to repo docs, nie kod; bez sensu.

## SCOPE
Hooki w TEMPLE = szablon + propagacja do forków. **NIE są aktywne w bieżącej sesji** (sesja działa w workspace GOFANS, settings są w TEMPLE/.claude). Aktywują się przy sesji otwartej w TEMPLE lub w forku. Opcja rozszerzenia na global `~/.claude/settings.json` (chroniłaby GOFANS/MALING/MCP od razu) — do decyzji Fi.
