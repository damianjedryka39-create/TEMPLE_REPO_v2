---
title: Andrej Karpathy
type: entity
created: 2026-05-28
last_updated: 2026-05-28
times_refined: 0
source_count: 2
status: active
tags: [person, ai-researcher, llm, knowledge-systems, agent-engineering]
---

# Andrej Karpathy

## Summary

Były dyrektor AI w Tesli, były członek OpenAI. Jeden z najbardziej cytowanych głosów w architekturze LLM-ów. Inspiracja dla architektonicznych decyzji w TEMPLE_REPO_v2 — koncept "LLM Wiki / LLM KB" stoi za [[D12]] (Knowledge Pocket) i [[D18]] (page typology + propagation ingest).

## Rola

- **Edukator AI** — wykłady i materiały o LLM-ach, transformerach, tokenizacji (kanał YouTube + Stanford CS231n)
- **Praktyk** — wcześniej Tesla Autopilot, OpenAI (założyciel core team)
- **Architekt konceptów** — autor terminów które przeszły do mainstreamu: "vibe coding", "software 2.0", LLM KB / LLM Wiki, agent-oriented engineering
- **Bridge między teorią a praktyką** — jego wpisy nie są ani czystą teorią, ani product-pitchem, lecz inżynierskimi obserwacjami

## Powiązane koncepty (cross-link do summary)

- [[rag_vs_llm_wiki]] — koncept persistent wiki layer ponad RAG, główny pomysł stojący za [[D12]] i [[D18]] w TEMPLE
- [[agent_oriented_engineering]] — teza że najlepsi AI engineers budują **systemy wokół agentów**, nie promptują. Dosłowne źródło CLAUDE.md-as-OS w TEMPLE i podobnych projektach.

## Znaczące teksty/wystąpienia (te które znamy)

| Co | Forma | Data | Znaczenie dla TEMPLE |
|---|-------|------|----------------------|
| "LLM KB" (LLM Wiki) — koncept persistent knowledge wiki | brak primary source w naszej bazie (znamy via re-interpretację @NainsiDwiv50980) | przed 2026-05-15 | Inspiracja [[D12]] (2026-04-19) i [[D18]] (2026-05-28) |
| "Don't tell the model what to do. Give it success criteria and let it loop." | re-interpretacja @NainsiDwiv50980 | przed 2026-05-27 | Wzmocnienie filozofii Auto_Codex + Preflight (już istniejące w TEMPLE) |

**Uwaga źródłowa:** oba teksty znamy via cytowanie przez @NainsiDwiv50980 (Nainsi Dwivedi — copywriterka technologiczna). Te zdania **nie są dosłownymi cytatami** Karpathy'ego — są re-interpretacją. Aby mieć autorytatywne źródło, trzeba znaleźć primary text Karpathy'ego (tweet, post, video). To otwarty task — można dodać `karpathy_andrej_primary_sources.md` jako follow-up.

## Wpływ na TEMPLE_REPO_v2

- **[[D12]] (Knowledge Pocket)** — folder `🅓_SYSTEM/KNOWLEDGE/` istnieje bezpośrednio dzięki konceptowi LLM KB Karpathy'ego. Cytat z DECISIONS.md D12: *"Inspiracja: Karpathy LLM KB."*
- **[[D18]] (Page typology + propagation)** — 4 typy stron i flow integracji nowego dokumentu zamiast append-only. Adopcja przez Fi 2026-05-28 po analizie tweetów @NainsiDwiv50980.
- **Brak wpływu na**: Muaddib.md core, CO_PILOT.md routing, rehydrate strategia — to są niezależne od Karpathy'ego.

## Backlinki

- [[rag_vs_llm_wiki]] — koncept którego autorem jest Karpathy
- [[agent_oriented_engineering]] — koncept którego autorem jest Karpathy
