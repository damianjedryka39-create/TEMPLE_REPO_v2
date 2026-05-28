---
title: Czy LLM Wiki skaluje powyżej 100 stron?
type: open_question
created: 2026-05-28
last_updated: 2026-05-28
times_refined: 0
source_count: 0
status: active
tags: [open-question, scaling, knowledge-architecture, llm-wiki, future]
---

# Czy LLM Wiki skaluje powyżej 100 stron?

## Pytanie

Czy schemat z [[D18]] (4 typy stron + propagation ingest + metryka `times_refined`) wytrzyma KNOWLEDGE/ z 100+ stronami, czy w którymś momencie wymagana będzie migracja do **graph database** / **vector store** / **hybrydy markdown+vector**?

## Dlaczego ważne

Zasada żelazna #6 w `Knowledge_Manager.md` mówi: *"Max ~100 stron — przy 100 zasugeruj bazę wektorową"*. To rzucone z palca jako sanity limit, nie jako twardy dowód że przy 101 wszystko się sypie.

Konkretne potencjalne problemy przy ~100 stronach:
- **Scan istniejących stron przy ingest** (krok 1 propagation w `Knowledge_Manager.md`) — agent musi przeczytać index + relevantne strony żeby zdecydować co update'ować. Przy 100 stronach to nawet w idealnym przypadku >5k tokenów na scan.
- **Backlink graph** — strona X z 30 backlinkami staje się trudna do utrzymania manualnie.
- **Detekcja sprzeczności** — przy małej liczbie stron agent łatwo zauważa "to nowe przeczy faktowi na stronie Y". Przy 100 stronach? Pewnie nie zauważy bez specjalnego mechanizmu.
- **Updates propagation cost** — jeśli nowy dokument dotyka 8 stron, agent musi przeczytać i edytować 8 plików. Token budget rośnie liniowo.

## Czego brakuje by odpowiedzieć

1. **Realny empiric** — TEMPLE ma teraz 4 strony (po K1 sesji 14). Trzeba przejść 20, 50, 80 stron żeby zobaczyć gdzie pęka.
2. **Benchmark scan cost** — ile tokenów kosztuje scan-przed-ingest przy N stron? Wzrost liniowy czy wybuchowy?
3. **Czy backlink graph utrzyma się manualnie** — czy potrzebny będzie auto-graf-rebuilder co N ingestów?
4. **Co robi LightRAG / inne hybrydy** — w `REPOSITORIES/lightrag/` jest klon (werdykt 🟡 INSPIRATION, sesja 13 cz.4) — może mieć odpowiedzi na hybryd markdown + vector.
5. **Co Karpathy mówił o skali LLM KB** — patrz [[karpathy_andrej]] §"Znaczące teksty" — nie mamy primary source jeszcze.

## Możliwe ścieżki rozwiązania (do dyskusji w przyszłości)

| Ścieżka | Opis | Kiedy rozważyć |
|---------|------|---------------|
| **Trzymać markdown, dodać index search** | Pełnotekstowy index po polu Summary każdej strony. Agent szuka po keyword zamiast czytać wszystkie. | 30-50 stron |
| **Hybryda markdown + embeddings** | Strony zostają jako .md (czytelne dla człowieka), embeddings indeksują semantycznie. LightRAG idzie tą drogą. | 60-80 stron |
| **Migracja do graph DB** | Strony → węzły, backlinks → krawędzie. Czytelność dla człowieka spada. | Raczej nie dla TEMPLE — sprzeczne z filozofią Fi |
| **Auto-archiwizacja stron `times_refined: 0`** | Strony zapomniane (nie tknięte > 90 dni i nigdy nie refined) → archive. Trzymamy KNOWLEDGE szczupły. | Realne przy 50+ stron, niezależnie od reszty |

## Status

`unresolved` — pytanie postawione 2026-05-28 sesja 14 jako część K1 ingestu. Nie ma deadline'u — czeka na **realny sygnał** ze wzrostu KNOWLEDGE/. Re-otworzyć gdy KNOWLEDGE przekroczy 30 stron (sygnał że trzeba zacząć mierzyć) lub gdy nowe źródło o LLM Wiki / RAG / knowledge architecture pojawi się.

## Powiązane strony

- [[rag_vs_llm_wiki]] — problem dotyczy schematu z tej strony
- [[karpathy_andrej]] — autor konceptu, primary source dałby odpowiedź
- Decyzja [[D18]] — to ona ustanowiła schemat, którego skalowanie pytamy

## Źródła

Brak (open question — pytanie zrodzone z analizy, nie z konkretnego źródła). Najbliższe powiązane źródło: [[rag_vs_llm_wiki]] §Źródła (tweet 2026-05-15).
