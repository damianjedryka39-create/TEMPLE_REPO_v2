---
name: Knowledge_Manager
trigger: "link|artykuł|przeczytaj|obczaj|źródło|wiedza|ingest|lint wiedzy|sprawdź wiedzę"
purpose: Pełne zarządzanie wiedzą domenową — wykrywanie źródeł, kompilacja, audyt, integracja z Reflect
output: Strony KNOWLEDGE/ + index + log | LINT REPORT | INGEST CANDIDATES
agents: [Claude]
cross_link: [Reflect.md, Context_Forge.md]
ecosystem: TEMPLE_REPO
---

# KNOWLEDGE MANAGER — Jeden skill, pełna wiedza

> Agent czyta TEN JEDEN plik i wie wszystko o zarządzaniu wiedzą domenową.
> Zastępuje osobne Ingest.md + Knowledge_Lint.md — łączy oba w spójny flow.

---

## ARCHITEKTURA WIEDZY

```
3 warstwy pamięci agenta (ORTOGONALNE — nigdy nie mieszaj):

DECISIONS.md    → CO zdecydowano        → update: sesja decyzyjna
LESSONS.md      → JAK agent się zachowuje → update: Reflect
KNOWLEDGE/      → CO agent WIE o temacie → update: TEN SKILL
```

### Struktura KNOWLEDGE/

```
🅓_SYSTEM/KNOWLEDGE/
├── index.md        ← spis treści (agent utrzymuje automatycznie)
├── log.md          ← append-only log operacji
└── {temat}.md      ← strony wiedzy (kompilowane ze źródeł)
```

---

## KIEDY SIĘ AKTYWUJĘ

### Auto-detect (agent rozpoznaje SAM — user NIE musi mówić "ingest"):

| Sygnał | Akcja |
|--------|-------|
| User wkleja link / plik / screenshot / artykuł | → TRYB INGEST |
| User mówi cokolwiek w stylu "obczaj to", "co o tym sądzisz" + treść | → TRYB INGEST |
| User mówi "sprawdź wiedzę", "lint", "audyt wiedzy" | → TRYB LINT |
| Reflect flaguje INGEST CANDIDATE z sesji | → TRYB INGEST (po potwierdzeniu) |
| Co 5-10 sesji (agent sam inicjuje) | → TRYB LINT |

### NIE aktywuj gdy:

- User pyta o opinię bez nowego źródła (to rozmowa, nie ingest)
- User podaje korektę zachowania agenta (to Reflect → LESSONS)
- User podaje decyzję projektową (to DECISIONS.md)

---

## TRYB INGEST — Kompilacja wiedzy

### Krok 1: Czytaj źródło

1. Przeczytaj źródło w całości (link, plik, tekst, screenshot).
2. Wyciągnij kluczowe fakty, koncepty, dane, wnioski.
3. Zidentyfikuj TEMAT — jedna nazwa strony (krótka, opisowa, snake_case).
4. Sprawdź `KNOWLEDGE/index.md`:
   - Strona istnieje → **UPDATE**
   - Strona nie istnieje → **CREATE**

### Krok 2: Preview (ZAWSZE — zero auto-zapisu)

Pokaż userowi:

```
INGEST PREVIEW
─────────────────────────────
Źródło:       {{nazwa/link}}
Temat:        {{proponowana nazwa strony}}
Tryb:         CREATE / UPDATE
Top fakty:
  1. ...
  2. ...
  3. ...
Backlinki:    [[X]], [[Y]] (lub: brak)
Sprzeczności: TAK ({{jakie}}) / NIE
─────────────────────────────
OK? Zmienić temat/zakres?
```

**Czekaj na potwierdzenie.** Bez OK = nie zapisuj.

### Krok 3: Kompiluj stronę

**CREATE — nowa strona** `KNOWLEDGE/{temat}.md`:

```markdown
---
title: {{Temat}}
created: {{YYYY-MM-DD}}
last_updated: {{YYYY-MM-DD}}
source_count: 1
status: active
tags: [{{tag1}}, {{tag2}}]
---

# {{Temat}}

## Summary
{{1 paragraf, max 3 zdania — esencja tematu}}

## Kluczowe fakty
- {{Fakt 1}} [Source: {{nazwa źródła}}]
- {{Fakt 2}} [Source: {{nazwa źródła}}]

## Szczegóły
{{Skompilowana wiedza — WŁASNYMI SŁOWAMI agenta, nie copy-paste}}

## Źródła
| # | Nazwa | Typ | Data |
|---|-------|-----|------|
| 1 | {{nazwa}} | {{link/plik/tekst}} | {{data}} |

## Backlinki
- [[strona_powiązana]] — {{dlaczego powiązane}}
```

**UPDATE — istniejąca strona:**

1. Przeczytaj istniejącą stronę.
2. DODAJ nowe fakty (nie nadpisuj starych bez powodu).
3. Zaktualizuj: `last_updated`, `source_count += 1`, tabelę źródeł, summary, backlinki.
4. Jeśli nowe źródło **PRZECZY** istniejącym faktom:

```markdown
> CONTRADICTION: {{stary fakt}} [Source: X] vs {{nowy fakt}} [Source: Y]
> Status: unresolved — user decyduje
```

### Krok 4: Update index + log

**index.md** — dodaj/zaktualizuj wiersz w tabeli Strony + Statystyki.

**log.md** — dopisz wpis:

```markdown
### {{YYYY-MM-DD HH:MM UTC}} | INGEST
- **Strona:** {{temat}}.md
- **Akcja:** CREATED / UPDATED
- **Źródło:** {{nazwa_źródła}}
- **Delta:** {{co dodano — 1 linia}}
- **Agent:** {{model}}
```

### Krok 5: Backlinki zwrotne

Dla każdej strony wymienionej w Backlinkach → otwórz tamtą stronę → dodaj backlink zwrotny (jeśli go tam nie ma). NIE zmieniaj nic innego.

### Output

```
INGEST: DONE
Strona: {{temat}}.md (CREATE/UPDATE)
Fakty: +{{N}} | Backlinki: {{lista}} | Sprzeczności: {{N}}
Index: stron {{total}}
CONF: 0.XX
```

---

## TRYB LINT — Audyt spójności

### Kiedy

- Co 5-10 sesji (agent sam inicjuje)
- User mówi "sprawdź wiedzę" / "lint"
- Po serii Ingestów (>3 nowe strony bez audytu)

### Pre-check

Jeśli KNOWLEDGE/ ma 0 stron → SKIP (nic do audytu).

### 6 kryteriów audytu

| # | Kryterium | Co sprawdzam |
|---|-----------|-------------|
| 1 | **SPRZECZNOŚCI** | Nierozwiązane `> CONTRADICTION:` + dwie strony twierdzące coś przeciwnego |
| 2 | **ORPHANS** | Strony bez backlinków / w folderze ale nie w index / w index ale nieistniejące |
| 3 | **BRAKUJĄCE CYTATY** | Fakty bez `[Source: ...]` / strony z `source_count: 0` |
| 4 | **STALENESS** | `last_updated` > 30 dni / status `draft` > 14 dni |
| 5 | **LUKI** | Tematy referencjonowane w backlinkach ale nieistniejące jako strony |
| 6 | **OVERSIZE** | Strony > 500 linii / index > 100 wpisów |

### Output

```
KNOWLEDGE LINT
══════════════════════════════
Stron: {{N}} | Źródeł: {{N}}

SPRZECZNOŚCI:    {{N}} {{lista}}
ORPHANS:         {{N}} {{lista}}
BRAKUJĄCE CYTATY:{{N}} {{lista}}
STALE:           {{N}} {{lista}}
LUKI:            {{N}} {{lista}}
OVERSIZE:        {{N}} {{lista}}

HEALTH: {{X}}/6 CLEAN
══════════════════════════════
```

Dla każdego problemu → propozycja naprawy do zatwierdzenia.
**NIE naprawiaj automatycznie** — pokaż tabelę, czekaj na OK.

Po naprawach → log entry `LINT` do log.md.

---

## INTEGRACJA Z REFLECT

Reflect na koniec sesji skanuje rozmowę. Jeśli padły **fakty domenowe** (nie lekcje, nie korekty):

```
Reflect → flaguje: "INGEST CANDIDATE: {{temat}}"
       → proponuje: "Odpalić Knowledge_Manager?"
       → User: "ok" → agent odpala TRYB INGEST
```

Reflect **NIE tworzy stron** sam. Tylko sygnalizuje.

---

## ZASADY ŻELAZNE

1. **KOMPILUJ, nie kopiuj** — własne słowa agenta z cytatami `[Source: ...]`
2. **ZERO auto-zapisu** — PREVIEW → potwierdzenie → zapis
3. **Fakty ≠ lekcje ≠ decyzje** — wiedza domenowa TYLKO tu. Korekty → LESSONS. Decyzje → DECISIONS
4. **Flaguj sprzeczności ZAWSZE** — user rozstrzyga, nie agent
5. **Max 500 linii/stronę** — podziel na podtematy
6. **Max ~100 stron** — przy 100 zasugeruj bazę wektorową
7. **NIE w rehydrate** — za duże. Agent czyta index.md on-demand
8. **NIE usuwaj stron bez potwierdzenia** — archiwizuj
9. **Context_Forge NIE optymalizuje KNOWLEDGE/** — osobna warstwa

---

## BOOTSTRAP (pierwszy raz w projekcie)

Jeśli `🅓_SYSTEM/KNOWLEDGE/` nie istnieje:

1. Utwórz folder `🅓_SYSTEM/KNOWLEDGE/`
2. Utwórz `index.md` z pustą tabelą + statystykami (0 stron)
3. Utwórz `log.md` z nagłówkiem + template wpisu
4. Kontynuuj normalny flow INGEST

---

## COMPOSABILITY

```
Knowledge_Manager  → tworzy/audytuje KNOWLEDGE/
Reflect.md         → flaguje kandydatów do INGEST z sesji
Context_Forge      → NIE optymalizuje KNOWLEDGE/ (osobna warstwa)
LESSONS.md         → lekcje o agencie (inna warstwa, nie mieszaj)
DECISIONS.md       → decyzje projektowe (inna warstwa, nie mieszaj)
```
