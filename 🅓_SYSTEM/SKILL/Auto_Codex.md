---
name: Auto_Codex
trigger: "kodowanie >20 linii|>1 plik|implementacja|refaktor|testy|scaffold|boilerplate"
purpose: Automatyczna delegacja kodowania do Codex CLI — Claude buduje prompt, Codex koduje, Claude review, max 2 rundy
output: Kod zaimplementowany przez Codex + review Claude + raport do Fi
agents: [Claude, Codex]
cross_link: [Preflight.md, Reflect.md]
ecosystem: {{NAZWA_PROJEKTU}}
---

# AUTO CODEX — Zero-touch delegacja kodowania

> Claude = architekt + reviewer. Codex = koder. Fi = gate przed commit.
> Zastępuje manualną delegację kodowania. Agent deleguje SAM — Fi nie musi nic robić.

---

## KIEDY DELEGOWAĆ (auto-trigger)

Agent ocenia KAŻDE zadanie kodowania:

```
                   ┌─ > ~20 linii LUB > 1 plik?
                   │     TAK → DELEGUJ DO CODEX
  Zadanie ────────►│
  kodowania        │     NIE → CLAUDE ROBI SAM
                   └─────────────────────────────
```

**TAK — deleguj:**
- Implementacja z jasnym AC (feature, endpoint, komponent)
- Refaktor mechaniczny (rename, extract, reorganize)
- Bug fix z jasnym reproduce
- Testy do istniejącego kodu
- Scaffold / boilerplate
- Zmiany w wielu plikach naraz

**NIE — Claude sam:**
- < ~20 linii w 1 pliku (overhead delegacji > wartość)
- Decyzje architektoniczne (Codex nie decyduje)
- Praca wymagająca kontekstu rozmowy z Fi
- Edycja plików workflow (AGENTS, CO_PILOT, STATE, DECISIONS)

---

## FLOW

```
CLAUDE OPUS                              CODEX CLI
───────────                              ─────────
1. Ocenia zadanie (> 20 linii?)
2. Buduje PROMPT (inline)
3. ──────────────────────────────►  4. codex exec --full-auto
                                    5. Implementuje
                                    6. Zwraca output
7. ◄──────────────────────────────
8. REVIEW (diff + testy)
   ├─ PASS → raport do Fi → czeka na OK → commit
   └─ FAIL → poprawia prompt ──────►  RUNDA 2
                                       ├─ PASS → raport → gate
                                       └─ FAIL → Claude przejmuje
```

**Zasady:**
- Max **2 rundy** Codex na task. Po 2x FAIL → Claude robi sam.
- Claude **ZAWSZE** review output przed raportem do Fi.
- **COMMIT tylko po OK od Fi** (safety gate).
- Codex **NIE commituje** — tylko koduje.

---

## BUDOWANIE PROMPTU

Claude buduje prompt wg tego szablonu. Każde pole MUSI być wypełnione.

### Template

```
ZADANIE: {1 zdanie — co ma powstać}

PROJEKT: {ścieżka root projektu}

PLIKI DO ZMIANY:
- {ścieżka/plik1} — {co w nim zmienić, 1 zdanie}
- {ścieżka/plik2} — {co w nim zmienić}

PLIKI DO CZYTANIA (kontekst, nie zmieniaj):
- {ścieżka/plik_ref} — {dlaczego Codex powinien to przeczytać}

CO ZROBIĆ:
1. {Konkretna zmiana 1 — kopiowalna, nie interpretacyjna}
2. {Konkretna zmiana 2}
3. {Konkretna zmiana 3}

ACCEPTANCE CRITERIA:
- [ ] {Sprawdzalne TAK/NIE — np. "endpoint /api/x zwraca 200"}
- [ ] {AC 2}
- [ ] {AC 3}

ZAKAZ:
- NIE zmieniaj plików poza listą
- NIE dodawaj nowych zależności bez instrukcji
- NIE commituj
- NIE {scope guard specyficzny dla zadania}

TEST (uruchom po zakończeniu):
{dokładna komenda — np. python3 -m pytest tests/ -v}

STYL KODU:
- {konwencje projektu — np. snake_case, 2-space indent, type hints}
```

### Zasady budowania promptu

| Reguła | Dlaczego |
|--------|----------|
| **Ścieżki PEŁNE** od root projektu | Codex nie zna cwd |
| **Zmiany KONKRETNE** — co dodać/usunąć/zmienić | "Popraw X" = vague = słaby output |
| **AC SPRAWDZALNE** — każdy punkt TAK/NIE | "Powinno działać" = niesprawdzalne |
| **ZAKAZ ZAWSZE** — minimum: nie commituj, nie zmieniaj poza listą | Bez tego Codex rozszerzy scope |
| **TEST EXECUTABLE** — komenda, nie opis | Claude odpala po review |
| **NIE wklejaj zawartości plików** — Codex czyta sam z dysku | Oszczędność tokenów |
| **PLIKI DO CZYTANIA osobno** — context vs target | Codex wie co zmienić, co tylko przeczytać |

---

## WYKONANIE

### Komenda

```bash
cd {root_projektu}
codex exec --full-auto "{prompt}"
```

**WAŻNE:** prompt przekazuj jako string w cudzysłowie. Dla długich promptów użyj heredoc:

```bash
cd {root_projektu}
codex exec --full-auto "$(cat <<'CODEX_PROMPT'
{treść promptu}
CODEX_PROMPT
)"
```

### Równoległe taski

```bash
# TYLKO gdy taski dotyczą RÓŻNYCH plików (zero kolizji)
codex exec --full-auto "{prompt_1}" &
codex exec --full-auto "{prompt_2}" &
wait
```

---

## REVIEW (Claude po wykonaniu Codex)

### Checklist review

| # | Sprawdź | Jeśli FAIL |
|---|---------|-----------|
| 1 | Diff — czy zmiany odpowiadają AC? | Popraw prompt → runda 2 |
| 2 | Scope — czy Codex nie zmienił nic poza listą? | Cofnij nadmiarowe zmiany |
| 3 | Testy — odpal komendę TEST | Popraw prompt → runda 2 |
| 4 | Jakość — czy senior by to zaakceptował? | Popraw sam (drobne) lub runda 2 |

### Runda 2 (jeśli FAIL)

Claude buduje **poprawiony prompt** dodając:
- Co poszło źle w rundzie 1 (konkretny błąd)
- Dodatkowy kontekst którego brakowało
- Ostrzejsze ZAKAZ jeśli Codex wyszedł poza scope

### Po 2x FAIL

```
Claude przejmuje zadanie i robi sam.
Raport do Fi:
  CODEX FAIL (2/2): {co nie zadziałało}
  CLAUDE PRZEJĄŁ: {co zrobił}
  LEKCJA: {co poprawić w przyszłych promptach}
```

→ Lekcja trafia do LESSONS.md (sekcja Codex Delegation)

---

## RAPORT DO FI (przed commit)

```
AUTO CODEX: DONE
────────────────────────────────
Zadanie:  {cel}
Rundy:    {1 lub 2}/2
Pliki:    {lista zmienionych}
AC:       {N}/{N} PASS
Test:     PASS ✓
Diff:     {krótki opis zmian}
────────────────────────────────
OK do commit?
```

**Czekaj na OK.** Bez OK = nie commituj.

---

## PRE-CHECK (Claude przed budową promptu)

| # | Pytanie | Jeśli NIE |
|---|---------|-----------|
| 1 | Czy > ~20 linii / > 1 plik? | → Zrób sam, nie deleguj |
| 2 | Czy mogę wylistować KONKRETNE zmiany? | → Doprecyzuj z Fi lub zbadaj kod |
| 3 | Czy AC jest sprawdzalne komendą? | → Napisz test command |
| 4 | Czy ZAKAZ chroni scope? | → Dodaj guardy |
| 5 | Czy przeczytałem pliki które Codex ma zmienić? | → Przeczytaj najpierw |

---

## ANTI-PATTERNS

| Błąd | Dlaczego źle | Poprawnie |
|------|-------------|-----------|
| "Popraw ten plik" | Vague — Codex zgaduje | "W pliku X, funkcja Y: zmień Z na W" |
| Wklejanie 500 linii kodu w prompt | Token waste — Codex czyta sam | Daj ścieżkę + co zmienić |
| Brak ZAKAZ | Codex rozszerzy scope | Min: nie commituj, nie zmieniaj poza listą |
| AC: "powinno działać" | Niesprawdzalne | AC: "pytest zwraca 0 exit code" |
| 5 tasków w 1 prompcie | Za szeroki scope = słaby output | 1 prompt = 1 cel |
| Auto-commit bez gate | Ryzyko — Codex nie jest nieomylny | ZAWSZE czekaj na OK od Fi |
