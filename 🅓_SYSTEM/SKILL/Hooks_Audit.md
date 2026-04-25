---
name: Hooks_Audit
trigger: "audyt hooków|hookify|gdzie hooki|automatyzacja safeguards|claude code hooks|zaproponuj hooki"
purpose: Audyt projektu pod kątem hooków Claude Code — gdzie wprowadzić blokady, automatyzacje, gate'y. Output = priorytetyzowana lista hooków z gotowymi snippetami do `settings.json`
output: HOOKS REPORT — 3-7 propozycji hooków (CRITICAL/IMPORTANT/NICE) + gotowy JSON do wklejenia + plan testów
agents: [Claude]
cross_link: [Knowledge_Manager.md, Workflow_Edit.md, Reflect.md, Preflight.md]
ecosystem: {{NAZWA_PROJEKTU}}
---

# HOOKS AUDIT — Gdzie projekt potrzebuje nadzorcy

> Hook = skrypt odpalany automatycznie na zdarzenie Claude Code (PreToolUse, PostToolUse, UserPromptSubmit, Stop, SessionStart). Ten skill mapuje **realne ryzyka i powtarzane błędy** w projekcie na konkretne hooki — nie generyczne best practices.

---

## KIEDY URUCHAMIAĆ

- Fi pyta "gdzie wstawić hooki", "zaproponuj hooki", "/hookify"
- Po 3+ powtórzonych korektach Fi → systemowa egzekucja > pamięć agenta
- Po incydencie (deploy bez komendy, leak sekretu, niezamierzone `git add -A`, force-push) → audyt pod prewencję
- Co 5-10 sesji przeglądowo (powiązane z Context_Forge / Reflect)

---

## PRE-CHECK (przed startem audytu)

| # | Pytanie | Jeśli NIE |
|---|---------|-----------|
| 1 | Czy znam strukturę projektu (rehydrate done)? | → wykonaj rehydrate |
| 2 | Czy znam procedurę deploy + komendy które są nieodwracalne? | → przeczytaj AGENTS.md §Deploy + STATE blockers |
| 3 | Czy znam plik LESSONS.md (lekcje powtórzone, ŻELAZNE reguły)? | → przeczytaj |
| 4 | Czy znam pamięć user-feedback (`/root/.claude/projects/.../memory/`)? | → przeczytaj MEMORY.md |
| 5 | Czy znam aktualny `settings.json` Claude Code (jakie hooki już są)? | → `cat .claude/settings.json` + global `~/.claude/settings.json` |

---

## FLOW — 5 kroków

### KROK 1 — Inwentaryzacja projektu (BIAŁA strona)

Zbierz fakty z projektu:

```
1. Deploy: jakie komendy są nieodwracalne?
   (np. nginx -s reload, certbot, systemctl, docker push, git push --force)
2. Sekrety: gdzie żyją? (.env, ~/.bashrc, secrets/, credentials.json)
3. Pliki workflow agenta: które są ŚWIĘTE? (AGENTS.md, CO_PILOT.md,
   STATE_OF_SYSTEM.md, DECISIONS.md, LESSONS.md, INIT.md)
4. Pliki produkcyjne: które edytuje agent regularnie?
   (np. landing/index.html, scraper.py)
5. Stack toolów: prettier? eslint? black? pytest?
6. Cron / długie zadania: które mogą kolidować z agentem?
7. Gdzie w drzewie repo siedzi outer .git? (zagnieżdżone repo = ryzyko
   pomyłkowego git add -A, patrz incydent 2026-04-22 GOFANS×TEMPLE)
```

### KROK 2 — Inwentaryzacja sygnałów (CZERWONA strona)

Mapuj **realne błędy/korekty** z historii projektu na klasy zdarzeń:

```
A) LESSONS.md — które lekcje są POWTÓRZONE (⚠️/🔴 ŻELAZNE)?
   Każda powtórzona = kandydat na hook (pamięć nie wystarcza).
   Przykłady z TEMPLE_REPO_v2:
   - L4: Reflect PRZED sync_state (powtórzona 3×) → hook PreToolUse Bash
     blokujący commit "SYNC_STATE" jeśli LESSONS nie modyfikowany
   - L11: Handoff do CHECKLIST → hook Stop sprawdza czy CHECKLIST.md
     edytowany w sesji, ostrzega jeśli nie
   - L12: Status po ludzku → trudne do zhookowania (treść), pomiń
   - L14: Nie chowaj narzędzi → trudne do zhookowania (decyzje), pomiń

B) memory/feedback_*.md — które reguły dotyczą AKCJI agenta (nie języka)?
   Każda akcja-feedback = kandydat na hook.
   Przykłady:
   - feedback_no_auto_deploy → hook PreToolUse Bash blokujący nginx/certbot/
     systemctl jeśli prompt nie zawiera "deploy"
   - feedback_pytaj_o_assety → trudne do zhookowania
   - feedback_zero_manual → meta-zasada, nie hook

C) DECISIONS.md — które decyzje wymagają systemowej egzekucji?
   Np. D17 (skille zostają w SKILL/) → hook PreToolUse blokujący git mv
   na 🅓_SYSTEM/SKILL/*.md

D) Sekrety — czy istnieją pliki .env / credentials?
   → hook PreToolUse Read blokujący czytanie tych ścieżek (tylko Bash
   z explicit komendą może je ruszyć)

E) Zagnieżdżone repo — czy projekt leży w outer git repo?
   → hook PreToolUse Bash blokujący "git add -A" / "git add ." gdy
   pwd różne od git rev-parse --show-toplevel
```

### KROK 3 — Mapowanie na eventy Claude Code

Claude Code emituje 5 typów eventów. Dobierz event do problemu:

| Event | Kiedy | Idealne dla |
|-------|-------|-------------|
| `PreToolUse` | PRZED użyciem narzędzia (Bash/Edit/Write/Read) | Blokady, walidacja inputu |
| `PostToolUse` | PO użyciu narzędzia | Auto-format, auto-test, auto-log |
| `UserPromptSubmit` | Po wysłaniu promptu Fi | Wstrzyknięcie kontekstu, intent detection |
| `Stop` | Koniec odpowiedzi agenta | Przypomnienia (sync_state pending), summary |
| `SessionStart` | Początek sesji | Wstrzyknięcie status, rehydrate enforce |

Hook ma 4 składniki:
1. **Matcher** — który tool/zdarzenie (regex na tool name lub command)
2. **Skrypt** — bash/python który decyduje
3. **Exit code** — `0` = pass, `2` = block z komunikatem do agenta, inne = ostrzeżenie
4. **Output** — co agent dostaje (stderr → wraca do agenta jako feedback)

### KROK 4 — Propozycja hooków (priorytetyzacja)

Wynik: tabela 3-7 hooków z trzema poziomami.

```
🔴 CRITICAL — wdroż NATYCHMIAST (ryzyko: utrata danych, leak, deploy bez komendy)
🟡 IMPORTANT — wdroż w tej sesji (ryzyko: powtarzające się błędy, tarcie)
🟢 NICE-TO-HAVE — wdroż gdy będzie czas (komfort, automatyzacja powtórzeń)
```

**Każdy hook musi mieć:**

```
NAZWA: krótka, opisowa
PRIORYTET: 🔴/🟡/🟢
EVENT: PreToolUse / PostToolUse / etc.
MATCHER: na co reaguje (regex)
ŹRÓDŁO: która lekcja/feedback/decyzja go uzasadnia
CO ROBI: 1 zdanie
JSON: gotowy snippet do .claude/settings.json
TEST: jak zweryfikować (komenda + oczekiwany output)
RYZYKO REGRESJI: co może się popsuć
```

### KROK 5 — Output

```markdown
# HOOKS AUDIT REPORT — {{NAZWA_PROJEKTU}}
> Data: <timestamp> | Sesji przeanalizowano: <N>

## STAN OBECNY
- Hooków zainstalowanych: <N> (lista z settings.json)
- Pokrycie ryzyk z LESSONS: <X>/<Y>
- Pokrycie ryzyk z feedback memory: <X>/<Y>

## REKOMENDACJE (priorytetyzowane)

### 🔴 CRITICAL
[hook 1 — pełen szablon]
[hook 2]

### 🟡 IMPORTANT
[hook 3]
[hook 4]

### 🟢 NICE-TO-HAVE
[hook 5]

## INSTALACJA — JEDNYM POLECENIEM
[gotowy JSON merge do .claude/settings.json]

## PLAN TESTU
1. [test hook 1: input → expected output]
2. ...

## CO POMINIĘTO i DLACZEGO
- [klasy ryzyk niemożliwe do zhookowania — np. styl języka]
```

Raport zapisz do `🅔_STRATEGIA/PROOFS/HOOKS_AUDIT_<YYYYMMDD>.md`.

---

## SZABLONY HOOKÓW (kanonowy katalog)

### 1. Anti-deploy bez komendy

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "bash -c 'cmd=\"$1\"; if echo \"$cmd\" | grep -qE \"nginx -s reload|certbot|systemctl (start|stop|restart|reload)|docker push|git push --force\"; then if ! echo \"$CLAUDE_USER_PROMPT\" | grep -qiE \"deploy|wdróż|wdroż|push\"; then echo \"BLOKADA: deploy/restart wymaga jawnej komendy Fi (deploy/wdróż). Patrz feedback_no_auto_deploy\" >&2; exit 2; fi; fi' _ \"$CLAUDE_COMMAND\""
          }
        ]
      }
    ]
  }
}
```

### 2. Anti-leak sekretów

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Read",
        "hooks": [
          {
            "type": "command",
            "command": "bash -c 'p=\"$1\"; if echo \"$p\" | grep -qE \"\\.env$|\\.env\\.|credentials\\.json|secrets/|\\.pem$|id_rsa\"; then echo \"BLOKADA: czytanie sekretów (.env/credentials/keys) zabronione. Użyj Bash z explicit komendą jeśli musisz.\" >&2; exit 2; fi' _ \"$CLAUDE_FILE_PATH\""
          }
        ]
      }
    ]
  }
}
```

### 3. Reflect-gate przed SYNC_STATE

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "bash -c 'cmd=\"$1\"; if echo \"$cmd\" | grep -qE \"git commit.*SYNC_STATE\"; then mod=$(git diff --cached --name-only | grep -E \"LESSONS\\.md|VOICE\\.md\" | wc -l); if [ \"$mod\" -eq 0 ]; then echo \"BLOKADA: commit SYNC_STATE bez Reflect (LESSONS.md / VOICE.md nie modyfikowany w staged). Patrz L4. Wykonaj Reflect najpierw albo dopisz uzasadnienie skip do commit message.\" >&2; exit 2; fi; fi' _ \"$CLAUDE_COMMAND\""
          }
        ]
      }
    ]
  }
}
```

### 4. Anti zagnieżdżony git add -A

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "bash -c 'cmd=\"$1\"; if echo \"$cmd\" | grep -qE \"git add (-A|\\.|--all)\"; then top=$(git rev-parse --show-toplevel 2>/dev/null); cwd=$(pwd); inner_git=$(find \"$cwd\" -maxdepth 3 -type d -name .git 2>/dev/null | head -1); if [ -n \"$inner_git\" ] && [ \"$(dirname \"$inner_git\")\" != \"$top\" ]; then echo \"BLOKADA: git add -A w katalogu z zagnieżdżonym repo ($inner_git). Ryzyko commitowania nie tych plików (incydent 2026-04-22 GOFANS×TEMPLE). Użyj git add <konkretne pliki> albo cd do właściwego repo.\" >&2; exit 2; fi; fi' _ \"$CLAUDE_COMMAND\""
          }
        ]
      }
    ]
  }
}
```

### 5. Auto-format po edycji landing

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "bash -c 'p=\"$1\"; case \"$p\" in *.html|*.css|*.js) command -v prettier >/dev/null && prettier --write \"$p\" 2>/dev/null;; *.py) command -v black >/dev/null && black -q \"$p\" 2>/dev/null;; esac' _ \"$CLAUDE_FILE_PATH\""
          }
        ]
      }
    ]
  }
}
```

### 6. Stop przypomnienie sync_state

```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "bash -c 'changes=$(git status --porcelain 2>/dev/null | wc -l); if [ \"$changes\" -gt 5 ]; then echo \"📋 SYNC_STATE PENDING — masz $changes zmienionych plików, rozważ sync_state przed końcem sesji.\"; fi'"
          }
        ]
      }
    ]
  }
}
```

### 7. SessionStart — pokaż blockery

```json
{
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "bash -c 'state=\"🅒_NOW/STATE_OF_SYSTEM.md\"; if [ -f \"$state\" ]; then echo \"=== TOP-3 BLOCKERS ===\"; awk \"/^## TOP-3 BLOCKERS/,/^## /\" \"$state\" | head -20; fi'"
          }
        ]
      }
    ]
  }
}
```

---

## REGUŁY (NIE ŁAMAĆ)

1. **Hook = systemowa egzekucja konkretnej zasady, nie generic best-practice.** Każdy hook MUSI mieć źródło w LESSONS / feedback / DECISIONS / incydencie. Brak źródła = brak hooka.
2. **Exit code 2 = blokada z komunikatem do agenta.** Komunikat musi mówić DLACZEGO + JAK ominąć (jeśli się da). „BLOKADA: X" bez kontekstu = frustracja.
3. **Hook NIE może być cichy.** Cichy hook = niewidzialny błąd. Zawsze loguj na stderr lub do pliku.
4. **Test hook przed instalacją.** Hook + zła regex = block legit work. Test = uruchom hook ręcznie z mock inputem.
5. **Settings.json scope:** projektowy (`.claude/settings.json`) > user (`~/.claude/settings.json`). Audyt mówi gdzie wsadzić — projektowy dla projekt-specific, user dla globalnych zasad Fi.
6. **Po instalacji:** dopisz `.claude/settings.json` do CHECKLIST jako proof + dopisz krótki opis hooka do `🅔_STRATEGIA/PROOFS/HOOKS_AUDIT_<YYYYMMDD>.md`.

---

## ANTI-PATTERNS

| Błąd | Dlaczego źle | Poprawnie |
|------|-------------|-----------|
| Hook bez źródła ("dobra praktyka") | Generic hooki frustują, blokują legit work | Każdy hook = mapuje na lekcję/feedback/incydent |
| Hook na każdy event | Spowolnienie + szum | Tylko zdarzenia z REALNYM ryzykiem |
| `exit 1` zamiast `exit 2` | Agent dostaje "error" zamiast "block" — gubi komunikat | `exit 2` + opis na stderr |
| Cichy hook (`>/dev/null 2>&1`) | Działa lub nie — brak diagnozy | Loguj decyzję (stderr lub plik) |
| Hook który modyfikuje treść | Niedeterministyczne behavior agenta | Hook decyduje TAK/NIE, nie zmienia treści |
| Brak testu po instalacji | Hook może blokować legit work | Test plan = część output skilla |
| Hook globalny dla zasad project-specific | Drift — globalna zasada w jednym projekcie | Settings.json projektowy dla project-specific |

---

## CROSS-LINK

- `Knowledge_Manager.md` — gdy źródło wiedzy o hookach przyniesione przez Fi (artykuł, link)
- `Workflow_Edit.md` — gdy hook wymaga zmian w strukturze plików workflow
- `Reflect.md` — po incydencie który mógł być zhookowany → lekcja → kandydat na hook w następnym audycie
- `Preflight.md` — przed deployem hooki działają jak gate; Preflight to manualny gate, hook to automatyczny

---

## OUTPUT (do CHAT, krótko)

```
HOOKS AUDIT: DONE
─────────────────────────────────
Projekt:        {{NAZWA_PROJEKTU}}
Sesji audyt:    <N>
Hooków obecnie: <N>
Propozycji:     <X> 🔴 + <Y> 🟡 + <Z> 🟢
Pokrycie ryzyk: <%>
Raport:         🅔_STRATEGIA/PROOFS/HOOKS_AUDIT_<YYYYMMDD>.md
─────────────────────────────────
Wdrażam <CRITICAL>? (T/N)
```
