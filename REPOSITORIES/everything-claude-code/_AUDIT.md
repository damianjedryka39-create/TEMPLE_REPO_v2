# 🔍 AUDIT — everything-claude-code

- **Source:** https://github.com/affaan-m/everything-claude-code
- **Author:** Affaan Mustafa (Anthropic Hackathon Winner)
- **License:** MIT
- **Data importu:** 2026-04-25
- **Version:** v1.10.0 (Apr 2026)
- **Werdykt:** 🟡 **INSPIRATION** (za duży do hurtowej adopcji, podpatruj konkretne perły)

---

## 📌 Co to jest po ludzku

Gotowy plugin / pakiet narzędzi do Claude Code (i Codex/Cursor/Gemini) zbudowany przez gościa który wygrał hackathon Anthropic. Zawiera **38 agentów + 156 skilli + 72 komendy + hooki + reguły bezpieczeństwa**. 10 miesięcy realnego użycia. Jak gotowa kuchnia w pełnym wyposażeniu — możesz wziąć wszystko, lub wyjąć kilka rondli i włożyć do swojej.

Filozofia (z `SOUL.md` + `RULES.md`):
- **Agent-First** — deleguj specjalistom (planner/reviewer/security)
- **Test-Driven** — testy przed kodem
- **Security-First** — input validation, secret protection
- **Plan Before Execute** — duże zmiany w fazach

---

## 🎯 Co daje TOBIE — 5 konkretnych pereł

### 🟢 Realnie warto podpatrzeć

1. **`/tdd` slash-command** + agent `tdd-guide.md` — Test-Driven Development workflow (Red → Green → Refactor). Bezpośrednio aplikowalne dla MALING (Python scraper) i ECC2 jeśli kiedyś.

2. **`hooks/` katalog** — session persistence (auto save/load kontekstu między sesjami). To dokładnie temat o który pytałeś przy Hooks_Audit.md. Konkretne wzorce do zapożyczenia.

3. **Agenty `code-reviewer.md`, `security-reviewer.md`, `refactor-cleaner.md`, `silent-failure-hunter.md`** — gotowe specjalizowane subagenty. Pomysł na Twoje TEMPLE: dorzucić 2-3 takie wertykalne specjalizacje do `🅓_SYSTEM/SKILL/`.

4. **`/learn` + `/skill-create`** — auto-extract patterns z sesji + generowanie skilli z git history. Bezpośrednio pasuje do Twojego `Reflect.md` workflow.

5. **`AgentShield` (npm pkg)** — security scanning agentowych setupów. Wartościowe gdyby kiedyś rozważać produkcyjne udostępnianie skilli.

### 🔴 Pomijać

- **156 skilli + 38 agentów hurtowo** — overload, większość specyficzna dla web/JS/Python full-stack które nie są Twoim światem
- **Cross-harness portability** (Codex/Cursor/Gemini) — Ty pracujesz głównie Claude Code, niepotrzebne
- **ECC 2.0 alpha (Rust control-plane)** — eksperymentalne, alfa, pomijaj
- **Dashboard Tkinter** — niepotrzebny przy CLI workflow

---

## ⚠️ Konflikt konwencji

ECC używa innej struktury niż Twoja:
- ECC: `skills/<name>/SKILL.md` (subfolder per skill)
- Ty: `🅓_SYSTEM/SKILL/<Name>.md` (jeden plik per skill)

**Konsekwencja:** kopiuj treści, nie strukturę. Każda perła którą bierzesz idzie do Twojego formatu (1 plik md w `🅓_SYSTEM/SKILL/`) z atrybucją autora w komentarzu.

---

## 🚀 Kolejność użycia (jeśli chcesz wziąć perły)

1. Najpierw `/tdd` + `tdd-guide.md` agent → adopcja jako 1 nowy skill `TDD_Guide.md`
2. Potem `hooks/session-persistence` → analiza pod kątem Hooks_Audit.md (gdy go odpalimy w GOFANS)
3. Na końcu `/learn` workflow → integracja z istniejącym `Reflect.md`

NIE adoptuj wszystkiego naraz. Jeden składnik na sesję, test w realu, decyzja.

---

## 🔗 Powiązania

- Skill który będzie korzystać: `🅓_SYSTEM/SKILL/Hooks_Audit.md` (sekcja hooks z ECC jako źródło wzorców)
- Skill który ewentualnie powstanie z tej inspiracji: `TDD_Guide.md` lub podobny
- Komplementarny: `REPOSITORIES/prompt-master/` (prompty AI tooli; ECC = workflow agentowy)

---

## 📝 Zasada dla kolejnego agenta

Przed wzięciem dowolnej perły z ECC:
1. Otwórz konkretny plik (np. `agents/tdd-guide.md`)
2. Sprawdź licencję (cały repo MIT, ale czytaj plik — czasem są atrybucje innych)
3. Skopiuj treść do Twojego formatu (`🅓_SYSTEM/SKILL/`)
4. Dodaj atrybucję autora w komentarzu na początku
5. Dostosuj do Twojego workflow (TEMPLE konwencji frontmatter, polski język w opisach gdzie ma sens)

NIE rób `cp -r ecc/skills/ 🅓_SYSTEM/SKILL/` — to byłoby chowanie 156 plików których nie używasz.
