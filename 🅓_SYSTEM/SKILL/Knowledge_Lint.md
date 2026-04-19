---
name: Knowledge_Lint
trigger: "sprawdź wiedzę|lint wiedzy|knowledge lint|audyt wiedzy|co 5-10 sesji"
purpose: Audyt spójności wiedzy domenowej — sprzeczności, osierocone strony, luki, stałe dane
output: LINT REPORT + propozycje napraw do zatwierdzenia
agents: [Claude]
cross_link: [Ingest.md, Context_Forge.md]
ecosystem: TEMPLE_REPO
---

# SKILL: KNOWLEDGE LINT — Audyt spójności wiedzy

---

## PRE-CHECK

Przed uruchomieniem sprawdź:
1. Czy `🅓_SYSTEM/KNOWLEDGE/` istnieje i ma > 0 stron? Jeśli NIE → SKIP (nic do audytu).
2. Czy minęło >= 5 sesji od ostatniego Lint? (sprawdź log.md → ostatni wpis LINT)
3. Czy index.md jest dostępny?

---

## KROK 1: ZAŁADUJ STAN WIEDZY

1. Przeczytaj `🅓_SYSTEM/KNOWLEDGE/index.md` — pełna mapa stron.
2. Przeczytaj `🅓_SYSTEM/KNOWLEDGE/log.md` — historia operacji.
3. Zrób `ls 🅓_SYSTEM/KNOWLEDGE/*.md` — fizyczna lista plików.
4. Porównaj: czy index.md matchuje fizyczne pliki? (brakujące w indeksie = orphans).

---

## KROK 2: AUDYT SPÓJNOŚCI

Sprawdź KAŻDĄ stronę wiedzy pod kątem 6 kryteriów:

### 2A: Sprzeczności (CONTRADICTIONS)

- Czy są nierozwiązane sprzeczności (`> CONTRADICTION:` ze status `unresolved`)?
- Czy dwie różne strony twierdzą coś przeciwnego o tym samym temacie?
- Porównaj kluczowe fakty między stronami z overlappującymi tagami.

### 2B: Osierocone strony (ORPHANS)

- Strony BEZ backlinków do/z innych stron.
- Strony w folderze ale NIE w index.md.
- Strony w index.md ale NIEISTNIEJĄCE fizycznie.

### 2C: Brakujące cytaty (MISSING SOURCES)

- Fakty BEZ `[Source: ...]`.
- Strony z `source_count: 0` w frontmatter.
- Źródła wymienione w treści ale nieobecne w tabeli Źródła.

### 2D: Stałe dane (STALENESS)

- Strony z `last_updated` starszym niż 30 dni (może wymagać review).
- Strony ze status `draft` starszym niż 14 dni.

### 2E: Luki (GAPS)

- Tematy często referencjonowane w backlinkach ale NIEISTNIEJĄCE jako strony.
- Placeholder backlinki: `[[temat]]` który nie ma pliku.

### 2F: Oversize

- Strony > 500 linii (kandydaci do podziału).
- index.md > 100 wpisów (sugestia migracji do bazy wektorowej).

---

## KROK 3: LINT REPORT

```
KNOWLEDGE LINT REPORT
======================================
Data: {{YYYY-MM-DD HH:MM UTC}}
Stron: {{total}} | Źródeł: {{total}}

SPRZECZNOŚCI (unresolved): {{N}}
{{lista: strona → fakt vs fakt}}

ORPHANS: {{N}}
{{lista: strona → powód}}

BRAKUJĄCE CYTATY: {{N}}
{{lista: strona → fakt bez źródła}}

STALE (>30 dni): {{N}}
{{lista: strona → last_updated}}

LUKI: {{N}}
{{lista: [[temat]] → referencjonowany przez X stron, brak pliku}}

OVERSIZE: {{N}}
{{lista: strona → linii}}

HEALTH SCORE: {{X}}/6 kryteriów CLEAN
CONF: 0.XX
```

---

## KROK 4: PROPOZYCJE NAPRAW

Dla każdego problemu zaproponuj konkretną naprawę:

| # | Problem | Typ | Proponowana naprawa |
|---|---------|-----|---------------------|
| 1 | ... | CONTRADICTION / ORPHAN / MISSING_SOURCE / STALE / GAP / OVERSIZE | ... |

**NIE naprawiaj automatycznie.** Przedstaw do zatwierdzenia.

Po zatwierdzeniu:
- Wykonaj naprawy
- Zaktualizuj index.md
- Dopisz wpis LINT do log.md

---

## KROK 5: LOG

Dopisz do `🅓_SYSTEM/KNOWLEDGE/log.md`:

```markdown
### {{YYYY-MM-DD HH:MM UTC}} | LINT
- **Strona:** (all)
- **Akcja:** LINT
- **Źródło:** —
- **Delta:** {{N}} problemów znalezionych, {{M}} naprawionych
- **Agent:** {{model}}
```

---

## OUTPUT

```
KNOWLEDGE_LINT: DONE
Stron: {{N}} | Health: {{X}}/6
Problemów: {{N}} | Naprawionych: {{M}} | Do decyzji: {{K}}
Następny Lint: za ~{{5-10}} sesji
CONF: 0.XX
```

---

## ANTI-PATTERNS

- NIE naprawiaj sprzeczności bez potwierdzenia — user decyduje co jest prawdą
- NIE usuwaj stron (nawet osieroconych) bez potwierdzenia — może archiwizuj
- NIE uruchamiaj co sesję — co 5-10 sesji lub na trigger
- NIE ignoruj wyników — jeśli health < 4/6, uruchom Ingest na problematycznych stronach

---

## COMPOSABILITY

```
Knowledge_Lint  → audytuje to co Ingest stworzył
Ingest.md       → naprawia luki znalezione przez Lint
Context_Forge   → optymalizuje CAŁY system, Lint optymalizuje KNOWLEDGE/
Reflect.md      → może dostarczyć wiedzę z sesji do Ingest
```
