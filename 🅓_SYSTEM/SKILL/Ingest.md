---
name: Ingest
trigger: "nowe źródło|przeczytaj to|dodaj do wiedzy|ingest|przetwórz źródło|link do przetworzenia"
purpose: Przetwarzanie nowych źródeł wiedzy domenowej — czytaj, dyskutuj, kompiluj do KNOWLEDGE/
output: Nowa/zaktualizowana strona w KNOWLEDGE/ + update index + log entry
agents: [Claude]
cross_link: [Knowledge_Lint.md, Reflect.md, Context_Forge.md]
ecosystem: TEMPLE_REPO
---

# SKILL: INGEST — Kompilacja wiedzy domenowej

---

## PRE-CHECK

Przed uruchomieniem sprawdź:
1. Czy user wskazał źródło (link, plik, tekst, screenshot)?
2. Czy `🅓_SYSTEM/KNOWLEDGE/` istnieje? Jeśli NIE — utwórz folder + index.md + log.md z szablonów.
3. Czy index.md ma < 100 stron? Jeśli >= 100 → STOP, zasugeruj migrację do bazy wektorowej.

---

## KROK 1: CZYTAJ ŹRÓDŁO

1. Przeczytaj źródło w całości (plik, link, tekst wklejony w chat).
2. Wyciągnij kluczowe fakty, koncepty, dane, wnioski.
3. Zidentyfikuj TEMAT — jedna nazwa dla strony wiedzy (krótka, opisowa).
4. Sprawdź w `KNOWLEDGE/index.md` czy strona o tym temacie JUŻ istnieje.
   - TAK → tryb UPDATE (krok 3B)
   - NIE → tryb CREATE (krok 3A)

---

## KROK 2: DYSKUSJA Z USEREM

Przedstaw userowi:

```
INGEST PREVIEW:
- Źródło: {{nazwa/link}}
- Temat: {{proponowana nazwa strony}}
- Tryb: CREATE / UPDATE
- Kluczowe fakty (top 5):
  1. ...
  2. ...
- Backlinki do istniejących stron: [[X]], [[Y]] (lub: brak)
- Sprzeczności z istniejącą wiedzą: TAK ({{jakie}}) / NIE

Kontynuować? Zmienić temat/zakres?
```

Poczekaj na potwierdzenie. Jeśli user chce zmienić zakres — dostosuj.

---

## KROK 3: KOMPILACJA STRONY

### 3A: CREATE (nowa strona)

1. Utwórz plik `🅓_SYSTEM/KNOWLEDGE/{{temat}}.md`.
2. Wypełnij:
   - YAML frontmatter: `title`, `created`, `last_updated`, `source_count: 1`, `status: active`, `tags`
   - Summary (1 paragraf, max 3 zdania)
   - Kluczowe fakty z cytatami `[Source: ...]`
   - Szczegóły — skompilowane ze źródła, NIE copy-paste
   - Źródła — tabela z metadanymi
   - Backlinki — do istniejących stron KNOWLEDGE/ (jeśli powiązane)

### 3B: UPDATE (istniejąca strona)

1. Przeczytaj istniejącą stronę.
2. DODAJ nowe fakty (nie nadpisuj starych bez powodu).
3. Zaktualizuj: `last_updated`, `source_count += 1`, tabelę źródeł, summary (jeśli istotna zmiana), backlinki.
4. Jeśli nowe źródło PRZECZY istniejącym faktom:
   - Dodaj sekcję SPRZECZNOŚCI:
   - `> CONTRADICTION: {{stary fakt}} [Source: X] vs {{nowy fakt}} [Source: Y]`
   - Status: `unresolved` — user decyduje co jest prawdą

---

## KROK 4: UPDATE INDEX

1. Otwórz `🅓_SYSTEM/KNOWLEDGE/index.md`.
2. CREATE → dodaj nowy wiersz do tabeli Strony.
3. UPDATE → zaktualizuj kolumny: Źródła, Ostatnia aktualizacja, Backlinki.
4. Zaktualizuj Statystyki (page_count, source count, ostatni ingest).
5. Dodaj/zaktualizuj Kategorie jeśli nowy temat nie pasuje do istniejących.

---

## KROK 5: LOG

Dopisz wpis do `🅓_SYSTEM/KNOWLEDGE/log.md`:

```markdown
### {{YYYY-MM-DD HH:MM UTC}} | INGEST
- **Strona:** {{temat}}.md
- **Akcja:** CREATED / UPDATED
- **Źródło:** {{nazwa_źródła}}
- **Delta:** {{co dodano/zmieniono — 1 linia}}
- **Agent:** {{model}}
```

---

## KROK 6: BACKLINKI ZWROTNE

Dla KAŻDEJ strony wymienionej w Backlinkach nowej/zaktualizowanej strony:
1. Otwórz tamtą stronę.
2. Dodaj backlink zwrotny do nowej strony (jeśli go tam nie ma).
3. NIE zmieniaj nic innego w tamtej stronie.

---

## OUTPUT

```
INGEST: DONE
Strona: {{temat}}.md ({{CREATE/UPDATE}})
Źródło: {{nazwa}}
Fakty: +{{N}} nowych
Backlinki: {{lista}} (lub: brak)
Sprzeczności: {{N}} (lub: 0)
Index: zaktualizowany (stron: {{total}})
CONF: 0.XX
```

---

## ANTI-PATTERNS

- NIE kopiuj źródła verbatim — KOMPILUJ (własne słowa agenta, z cytatami)
- NIE twórz stron bez źródła — każdy fakt musi mieć `[Source: ...]`
- NIE ignoruj sprzeczności — flaguj ZAWSZE, user rozstrzyga
- NIE twórz stron > 500 linii — podziel na podtematy
- NIE modyfikuj źródeł usera — KNOWLEDGE/ to kompilat, nie edycja oryginałów
- NIE dodawaj do rehydrate — KNOWLEDGE/ jest on-demand (za duże)
- NIE twórz > 100 stron — przy 100 zasugeruj bazę wektorową

---

## COMPOSABILITY

```
Ingest.md        → tworzy/aktualizuje strony KNOWLEDGE/
Knowledge_Lint   → audytuje spójność KNOWLEDGE/
Reflect.md       → może flagować kandydatów do INGEST z sesji
Context_Forge    → NIE optymalizuje KNOWLEDGE/ (osobna warstwa)
Check_Me         → może triggernąć Ingest jeśli user przynosi nowe źródło
```
