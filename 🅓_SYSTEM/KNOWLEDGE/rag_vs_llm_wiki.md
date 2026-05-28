---
title: RAG vs LLM Wiki
type: summary
created: 2026-05-28
last_updated: 2026-05-28
times_refined: 0
source_count: 1
status: active
tags: [knowledge-architecture, rag, llm-wiki, karpathy, memory-systems]
---

# RAG vs LLM Wiki

## Summary

RAG (retrieval-augmented generation) działa **stateless**: każde zapytanie powoduje pobranie kawałków dokumentów, wygenerowanie odpowiedzi, wyrzucenie syntezy. Wiedza nie kumuluje się. Karpathy "LLM Wiki" odwraca to: AI utrzymuje **persistent warstwę wiki** między userem a źródłami, którą aktualizuje przy każdym nowym dokumencie. Wiedza odkłada się, dojrzewa, propaguje między stronami.

## Kluczowe fakty

- RAG nie ma pamięci rozumienia, tylko pamięć danych. Każda odpowiedź buduje syntezę od zera. [Source: Tweet @NainsiDwiv50980 2026-05-15]
- LLM Wiki = strukturalne strony markdown + interlinked koncepty + entity maps + summaries + porównania + sprzeczności + open questions + long-term synteza. [Source: tamten tweet]
- Mechanizm integracji: nowy dokument **NIE jest "storowany"** — modyfikuje istniejące strony (refine summaries / update entitów / nowe linki / wyciąga sprzeczności / wzmacnia lub osłabia wnioski). [Source: tamten tweet]
- Bottleneck systemów wiedzy nigdy nie był intelekt — był **maintenance**. LLM pierwszy raz robi maintenance bliski darmowemu. [Source: tamten tweet]
- Konsekwencje: research systems które ewoluują, personal KB które dojrzewają latami, company memory która kumuluje zamiast resetować się co kwartał. [Source: tamten tweet]

## Szczegóły

**Czemu RAG niewystarcza** — model "brzmi" mądrze ale za każdym razem rekonstruuje rozumienie z surowego kontekstu. NotebookLM, czat z PDF, ChatGPT uploady — wszystkie fundamentally stateless. Użyteczne, ale z sufitem.

**Czym LLM Wiki różni się od RAG** — nie indeksem embeddingowym, tylko **substratem wiedzy**. Strony markdown są semantycznie spójne (nie chunki). Linki są celowe (nie odległość wektorowa). Aktualizacja jest propagacją (nie nadpisaniem). System przechowuje "rozumienie", nie tylko "dane".

**Dlaczego maintenance jest kluczowy** — human-created systemy gniją bo overhead maintenance staje się nieudźwignięty: linki gniją, taksonomia driftuje, kontekst znika. Systemy stają się trudniejsze do utrzymania niż do przepisania od nowa. LLM zmienia to równanie — kiedy maintenance koszt zbliża się do 0, **zupełnie nowe architektury wiedzy stają się realne**.

**Powiązanie z TEMPLE_REPO_v2** — folder `🅓_SYSTEM/KNOWLEDGE/` i decyzja [[D12]] (Knowledge Pocket, 2026-04-19) cytują Karpathy LLM KB jako inspirację. Decyzja [[D18]] (2026-05-28) wdraża konkretne patterny LLM Wiki w `Knowledge_Manager.md`: typologia 4 typów stron + propagation ingest + metryka `times_refined`. Ta strona jest częścią pierwszego ingestu (K1) testującego schemat D18.

## Sprzeczność z RAG?

Nie wprost — LLM Wiki **nie zastępuje RAG**, dopełnia. RAG zostaje dobry dla "retrieval na żądanie z dużej bazy". LLM Wiki dodaje warstwę "skumulowana synteza ponad RAG". Tweet 1 implikuje że RAG to ślepa uliczka — tu **adversarial wniosek**: to przesada copywriterska. Karpathy nie powiedział "RAG to śmieć", powiedział "dla persistent understanding potrzeba czegoś więcej". Patrz [[czy_llm_wiki_skaluje_powyzej_100_stron]] dla otwartego pytania o granice.

## Źródła

| # | Nazwa | Typ | Data |
|---|-------|-----|------|
| 1 | Tweet @NainsiDwiv50980 — *RAG Doesn't Learn — Karpathy's LLM Wiki Changes the Entire Knowledge Paradigm* | x.com link | 2026-05-15 |

URL: https://x.com/NainsiDwiv50980/status/2055326391454023864

**Uwaga źródłowa:** Nainsi Dwivedi to copywriterka technologiczna, nie inżynier. Cytaty Karpathy'ego w tweecie są re-interpretacją, nie dosłowne. Rdzeń konceptu pochodzi od Karpathy'ego (LLM KB), warstwa narracyjna jest Nainsi. Traktować jako op-ed, nie autorytatywny source — ale rdzeń architektoniczny pozostaje wartościowy.

## Backlinki

- [[karpathy_andrej]] — autor konceptu LLM Wiki / LLM KB
- [[czy_llm_wiki_skaluje_powyzej_100_stron]] — open question wynikające z analizy
- [[agent_oriented_engineering]] — szerszy kontekst (drugi tweet Nainsi, ten sam autor)
