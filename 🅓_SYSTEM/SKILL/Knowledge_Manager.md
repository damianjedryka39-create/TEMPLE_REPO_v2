---
name: Knowledge_Manager
trigger: "link|artykuł|przeczytaj|obczaj|źródło|wiedza|ingest|lint wiedzy|sprawdź wiedzę"
purpose: Pełne zarządzanie wiedzą domenową — wykrywanie źródeł, kompilacja, audyt, integracja z Reflect
output: Strony KNOWLEDGE/ + index + log | LINT REPORT | INGEST CANDIDATES
agents: [Claude]
cross_link: [Reflect.md, Context_Forge.md]
ecosystem: {{NAZWA_PROJEKTU}}
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

### Typy stron (wzorzec LLM Wiki — Karpathy, via @NainsiDwiv50980 2026-05-15)

KNOWLEDGE/ NIE jest workiem na "strony o tematach". Każda strona ma **typ** w frontmatter — różne typy mają różne zadania.

| Typ | Frontmatter `type:` | Czemu służy | Przykład |
|-----|--------------------|-------------|----------|
| **summary** | `summary` | Streszczenie tematu/konceptu — esencja co wiem | `rag_vs_llm_wiki.md`, `prompt_caching.md` |
| **entity** | `entity` | Profil osoby/narzędzia/firmy/projektu — kim/czym jest, co robi, gdzie ma swoje miejsce | `karpathy_andrej.md`, `defuddle_cli.md`, `claude_code.md` |
| **contradiction** | `contradiction` | Sprzeczność między źródłami — A mówi X, B mówi Y, status: rozwiązane/otwarte | `rag_persistent_vs_stateless.md` |
| **open_question** | `open_question` | Pytanie na które nie mam odpowiedzi — czeka na nowe źródło / decyzję | `czy_llm_wiki_skaluje_powyzej_100_stron.md` |

**Reguła:** każda strona MUSI mieć `type:` w frontmatter. Bez tego = ingest nie kończy się — agent wraca i pyta.

**Cross-link między typami:** `entity` linkuje do `summary` (Karpathy → LLM Wiki). `contradiction` linkuje do 2+ `summary`. `open_question` linkuje do `summary` którego dotyczy.

**Refinement counter:** każda strona ma `times_refined: N` w frontmatter — ile razy była zaktualizowana po stworzeniu (nie licząc CREATE). Strona z `times_refined: 0` = świeża albo zapomniana. Strona z `times_refined: 10+` = dojrzała, sprawdzona przez wiele źródeł.

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

> Filozofia: nowy dokument NIE jest "dodawany". Jest **integrowany** — wpływa na N istniejących stron + tworzy 0-1 nowych. Append-only ingest = źle. Update propagation = dobrze.

### Krok 1: Czytaj źródło + scan istniejących

1. Przeczytaj źródło w całości (link, plik, tekst, screenshot).
2. Wyciągnij kluczowe fakty, koncepty, dane, wnioski.
3. Zidentyfikuj **wszystkie tematy/encje** które źródło dotyka (nie tylko jeden "główny temat").
4. **Scan KNOWLEDGE/index.md** — dla każdego tematu/encji sprawdź:
   - Istnieje strona o tym → kandydat do **UPDATE**
   - Brak strony → kandydat do **CREATE** (typ: summary/entity/contradiction/open_question)
5. **Detekcja sprzeczności:** dla każdej kandydatki UPDATE — porównaj nowe fakty z istniejącymi. Sprzeczność = osobna strona `contradiction` LUB sekcja `> CONTRADICTION:` w istniejącej.
6. **Detekcja otwartych pytań:** czy źródło stawia pytanie bez odpowiedzi? → kandydat strony `open_question`.
7. **Pętla zamykania pytań (uczenie):** przejrzyj sekcję `## Otwarte pytania` w `index.md`. Dla KAŻDEGO otwartego pytania sprawdź czy NOWE źródło je zamyka → jeśli tak, kandydat: `open_question` → `resolved` (dopisz odpowiedź + status `resolved`, lub przekształć w `summary`). To mechanizm dojrzewania grafu — agent mądrzeje gdy pytania się domykają.

**Rezultat kroku 1:** lista akcji `(strona, typ, CREATE/UPDATE/CONTRADICTION/OPEN_QUESTION/RESOLVE)` — nie pojedyncza strona.

### Krok 2: Preview (ZAWSZE — zero auto-zapisu)

Pokaż userowi propagację — co się stanie po integracji:

```
INGEST PREVIEW (propagacja)
─────────────────────────────
Źródło: {{nazwa/link}}

DO ZAKTUALIZOWANIA (existing pages):
  1. {{strona_X.md}} ({{type}}) — delta: {{co dodaje}}, times_refined +1
  2. {{strona_Y.md}} ({{type}}) — delta: {{co dodaje}}, times_refined +1

NOWE STRONY:
  1. {{strona_Z.md}} (type: {{summary/entity/contradiction/open_question}})

SPRZECZNOŚCI:
  - {{stara teza}} [Source: A] vs {{nowa teza}} [Source: tu] → page: contradiction_X.md (CREATE/UPDATE)

OTWARTE PYTANIA:
  - {{pytanie}} → page: question_X.md (CREATE)

Index po: stron {{przed}} → {{po}} | dotkniętych {{N}} | nowych {{M}}
─────────────────────────────
OK? Zmienić zakres? Pominąć którąś akcję?
```

**Czekaj na potwierdzenie.** Bez OK = nie zapisuj nic.

**Reguła append vs propagation:** jeśli źródło dotyka tematu który już mamy — DOMYŚLNIE update istniejącej + bumpuje `times_refined`. Tworzenie nowej strony "obok" istniejącej tylko gdy temat jest realnie inny (np. nowa encja vs istniejący summary).

### Krok 3: Kompiluj stronę

**CREATE — nowa strona** `KNOWLEDGE/{temat}.md`:

```markdown
---
title: {{Temat}}
type: {{summary|entity|contradiction|open_question}}
created: {{YYYY-MM-DD}}
last_updated: {{YYYY-MM-DD}}
times_refined: 0
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

**Sekcje per typ** (oprócz standardowych powyżej):

- `type: entity` → dodaj sekcje **Rola** (czym się zajmuje), **Powiązane koncepty** (linki do `summary`), **Znaczące cytaty/teksty**
- `type: contradiction` → dodaj sekcje **Teza A** (`[Source: X]`), **Teza B** (`[Source: Y]`), **Status** (`unresolved`/`resolved → Z`), **Implikacje dla projektu**
- `type: open_question` → dodaj sekcje **Pytanie** (1 zdanie), **Dlaczego ważne**, **Czego brakuje by odpowiedzieć**, **Powiązane strony**

**UPDATE — istniejąca strona:**

1. Przeczytaj istniejącą stronę.
2. **Refine, nie dodaj na końcu.** Nowe fakty wpinają się tam gdzie są tematycznie powiązane (sekcja Szczegóły, sekcja Kluczowe fakty) — NIE jako osobny blok "z 2026-XX". Strona ma być spójna, nie chronologiczna.
3. Zaktualizuj frontmatter: `last_updated`, `source_count += 1`, **`times_refined += 1`**.
4. Zaktualizuj: tabelę źródeł, summary (jeśli się zmieniło rozumienie), backlinki (jeśli nowe powiązania).
5. Jeśli nowe źródło **PRZECZY** istniejącym faktom — DWIE opcje:
   - Drobna sprzeczność (fakt vs fakt) → wpis w stronie:
     ```markdown
     > CONTRADICTION: {{stary fakt}} [Source: X] vs {{nowy fakt}} [Source: Y]
     > Status: unresolved — user decyduje
     ```
   - Strukturalna sprzeczność (paradigm vs paradigm) → osobna strona `type: contradiction` zlinkowana z obu summary.
6. **Zagęszczanie (gdy strona urosła > ~1200 słów):** najstarsze szczegóły skondensuj 1-2 zdaniami do `## Summary` (żywa synteza), usuń rozwlekłe oryginały, zostaw 5-7 najświeższych faktów w pełnej formie. Zachowaj WSZYSTKIE `[Source:]`. Cel: graf gęstnieje (lepsza synteza), nie rozrasta się (więcej plików). NIE split — patrz Zasada żelazna 5. (D23)

### Krok 4: Update index + log

**index.md** — dodaj/zaktualizuj wiersz w tabeli Strony + Statystyki + zsynchronizuj sekcję `## Otwarte pytania` (dopisz nowe `open_question`, usuń te które źródło zamknęło — `RESOLVE` z Kroku 1 pkt 7).

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
| 6 | **OVERSIZE** | Strony > ~1200 słów (→ ZAGĘŚĆ w sobie, nie dziel na pliki) / index > 100 wpisów |

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
5. **Max ~1200 słów/stronę → ZAGĘŚĆ, nie tnij** — gdy strona rośnie: najstarsze/najgrubsze szczegóły skondensuj do żywej syntezy w `## Summary` (zachowaj `[Source:]`), zostaw 5-7 najświeższych faktów w pełnej formie. NIE rozbijaj na nowe pliki — więcej plików = droższy scan i propagacja przy skali, słabszy graf. Split TYLKO gdy temat realnie rozszczepił się na 2 odrębne byty. (D23)
6. **Max ~100 stron** — przy 100 zasugeruj bazę wektorową / RAG (wiki niesie do ~100, potem warstwa wektorowa indeksuje skondensowane strony)
7. **NIE w rehydrate** — za duże. Agent czyta index.md on-demand
8. **NIE usuwaj stron bez potwierdzenia** — archiwizuj
9. **Context_Forge NIE optymalizuje KNOWLEDGE/** — osobna warstwa
10. **PROPAGATION > APPEND-ONLY** — nowy dokument integruje się w istniejące strony (refine + times_refined++), nie tylko tworzy nowe. Tworzenie nowej strony obok istniejącej tylko gdy temat realnie inny.
11. **KAŻDA STRONA MA `type:`** — `summary` / `entity` / `contradiction` / `open_question`. Bez typu = ingest nie kończy się.
12. **`times_refined` ROŚNIE PRZY KAŻDYM UPDATE** — to metryka dojrzałości strony. CREATE = 0, każdy UPDATE = +1.

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
