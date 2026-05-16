# RAG vs LLM Wiki vs Bazy Wektorowe — Pełna Mapa

> Data: 2026-05-16 | Źródła: Akshay Pachaar (tweets), Andrej Karpathy (LLM Wiki gist)

---

## Podstawy — Baza Wektorowa od zera

### Czym jest wektor

Komputer nie rozumie słów — rozumie liczby. Model embedding zamienia tekst w wektor (listę liczb):

```
"Deploy na produkcję"  →  [0.82, -0.14, 0.53, 0.91, ...]  (1536 liczb)
"Wdrożenie systemu"    →  [0.79, -0.11, 0.51, 0.88, ...]  ← podobne!
"Wakacje w Grecji"     →  [0.12,  0.74, -0.33, 0.02, ...]  ← inne
```

Podobieństwo = cosine similarity (kąt między wektorami w 1536-wymiarowej przestrzeni).

### Czym jest baza wektorowa

Baza danych zoptymalizowana do jednego zadania: **znajdź N wektorów najbliższych wektorowi zapytania**.

Popularne: Chroma (lokalnie/free), Qdrant (self-hosted/cloud), Pinecone (cloud), Weaviate.

---

## RAG — jak faktycznie działa

**RAG = Retrieval-Augmented Generation**

### Pipeline

```
KROK 1 — INDEKSOWANIE (raz, offline):
Dokumenty → chunk na kawałki (~500 tokenów)
          → embedding model → wektor dla każdego chunka
          → zapisz (chunk_tekst, wektor) do bazy wektorowej

KROK 2 — RETRIEVAL (przy każdym pytaniu):
Pytanie → wektor pytania
        → szukaj w bazie: top-5 najbliższych wektorów
        → pobierz ich oryginalny tekst

KROK 3 — GENERATION:
[System prompt] + [5 chunków] + [Pytanie] → model → odpowiedź
```

### Cykl który się powtarza bez końca

```
retrieve chunks → generate answer → discard synthesis → repeat forever
```

Model rebuilds understanding from scratch na każde zapytanie. Nie ma persistent synthesis.

### Gdzie RAG wygrywa

- Miliony dokumentów (legal, ogromne codebases)
- Wiedza zewnętrzna, statyczna, której nie zmieniasz
- Kiedy ważna jest dokładność cytatu ze źródła
- Audytowalność: wiesz dokładnie który chunk dał odpowiedź

### Słabości RAG

- Keyword ≠ meaning: "wdrożenie" nie znajdzie dokumentów o "deployu" (w FTS5)
- Zero learning: wiedza nie kompounduje
- Każda sesja od zera — model nie "rozumie" lepiej po 100 pytaniach
- Corpus statyczny: nie adaptuje się do nowej wiedzy automatycznie

---

## LLM Wiki Pattern (Karpathy)

### Kluczowa idea

Zamiast żeby AI *pobierało* kawałki z bazy przy każdym pytaniu — niech AI *utrzymuje* żywą, syntetyczną bazę wiedzy.

```
RAG:       retrieve → answer → forget
LLM Wiki:  ingest → synthesize → evolve
```

### Architektura

```
SUROWE ŹRÓDŁA (dokumenty, PDFy, artykuły)
        ↓ (Knowledge_Manager / ingest agent)
WIKI LAYER (syntetyczne strony markdown)
  ├── entities/      → ludzie, organizacje, produkty
  ├── concepts/      → idee, wzorce, terminologia
  ├── sources/       → przeanalizowane materiały
  ├── index.md       → master katalog
  └── hot.md         → recent context (ostatnia sesja)
        ↓ (on-demand)
MODEL → odpowiada z syntetycznego rozumienia
```

### Co się dzieje przy ingestion nowego dokumentu

Jeden nowy dokument może:
- Zrefinować istniejące podsumowania
- Zmodyfikować strony entity
- Stworzyć nowe linki konceptualne
- Wyświetlić niespójności (contradiction detection)
- Wzmocnić lub osłabić wcześniejsze wnioski
- Zaktualizować długoterminową syntezę

**Baza wiedzy sama w sobie kompounduje.**

### Kluczowy insight sesji

> *"The bottleneck in knowledge systems was never intelligence. It was maintenance."*

Każda firma, każda osoba próbowała budować knowledge bases. Wszystkie rozpadały się:
```
Rok 1: aktualne
Rok 2: połowa linków martwa
Rok 3: nikt nie pamięta dlaczego coś zdecydowano
Rok 4: łatwiej zbudować od nowa
```

**LLM zmienia to równanie po raz pierwszy w historii.** Continuous organizational maintenance prawie za darmo. To odblokowuje architektury które były niemożliwe.

### Czego artykuł nie mówi (uczciwa ocena)

1. **Halucynacje kompoundują się** — błędna synteza wchodzi do bazy i rośnie
2. **"Prawie za darmo" ≠ za darmo** — ciągłe API calls przy dużej bazie
3. **Mniej audytowalne** — nie możesz wskazać dokładnego chunka źródłowego
4. **"Fatal flaw" framing jest marketing** — RAG nie jest "broken", to inny tool do innego problemu

### Czy RAG jest przestarzały?

**Nie. Przesuwa się niżej w stacku.**

RAG dla: zewnętrzne, duże, statyczne korpusy, dokładność cytatów.
LLM Wiki dla: pamięć agenta, evolving understanding, domain knowledge.

Nie konkurencja — **komplementarne warstwy**.

---

## Ekosystem który wyłonił się z Karpathy's gist (5000+ gwiazdek)

Developerzy budują w DAYS:
- Persistent AI memory systems
- Self-maintaining knowledge bases
- Multi-agent research environments
- Contradiction detection engines (sheaf cohomology — akademickie, niszowe)
- "Sleep consolidation" dla AI (inspirowane ludzkimi procesami REM) ← **genuinely brilliant**
- AI-native company operating systems
- Local-first memory z audit trails + provenance + graph exports + MCP

**Ocena**: kierunek prawdziwy, wiele to prototypy. 6-12 miesięcy zanim wyłonią się production-grade systemy.

---

## Pełny Stack Architektury (gdzie to wszystko siedzi)

```
WARSTWA 3 — Agent / User
      ↓ ↑
WARSTWA 2 — LLM Wiki
            (syntetyczne rozumienie, ewoluuje, model jako redaktor)
      ↓ ↑ (gdy baza wiki za duża)
WARSTWA 1 — Baza wektorowa + RAG
            (retrieval z surowych źródeł, skalowalna)
      ↓ ↑
WARSTWA 0 — Surowe dokumenty / dane
```

### Czy to najbardziej pro schemat dla vibe codingu DZIŚ?

**Nie.** To architektura aspiracyjna na 12-18 miesięcy.

**Najbardziej pro DZIŚ dla solo vibe codera:**

```
AGENT (Claude Code)
      ↓ ↑
STRUCTURED CONTEXT
  DECISIONS + LESSONS + STATE + SKILLS (TEMPLE-style)
      ↓ ↑
CODEBASE (git jako ground truth)
```

RAG dodajesz TYLKO gdy codebase > 100k linii.

Warstwa 2 (LLM Wiki autonomiczna) = za wcześnie. Autonomiczna synteza bez ludzkiego gate'u jest nadal niestabilna — błędy kompoundują się.

---

## TEMPLE jako LLM Wiki (już istniejące)

| LLM Wiki concept | TEMPLE equivalent |
|---|---|
| Persistent synthesis | DECISIONS.md |
| Evolving structure | LESSONS.md (L1-L16) |
| Contradiction detection | Grill_Me skill |
| Integration przy nowym dokumencie | Knowledge_Manager skill |
| Sleep consolidation | SYNC_STATE + Reflect |
| Entity maps | KNOWLEDGE/ pages |
| Hot cache | STATE_OF_SYSTEM.md |

**Różnica:** TEMPLE wymaga Fi + Muaddiba jako redaktorów. LLM Wiki w pełnej wizji = autonomiczne.
Dziś TEMPLE jest właściwym podejściem — human-in-the-loop synthesis = lepsza jakość niż auto.

---

## FTS5 vs Wektor — tabela decyzyjna

| Pytanie | FTS5 (Hermes) | Wektor (RAG) |
|---|---|---|
| Skala | setki dokumentów | miliony |
| "wdrożenie" = "deploy"? | NIE | TAK |
| Setup | zero | embedding model + baza |
| Latencja | ~ms | ~100-500ms |
| Koszt | zero | embedding API + hosting |
| Audytowalność | wysoka | wysoka |
| Dla agenta (workflow memory) | OK | overkill |
| Dla dużej bazy wiedzy | za słabe | idealne |
