---
type: knowledge-index
auto_maintained: true
last_updated: 2026-05-28
page_count: 4
---

# KNOWLEDGE INDEX

> Spis treści wiedzy domenowej. Agent utrzymuje automatycznie przy każdym Ingest.
> NIE wchodzi do rehydrate. Agent czyta on-demand gdy potrzebuje wiedzy domenowej.

---

## Strony

| # | Temat | Typ | Status | Źródła | Updates | Ostatnia aktualizacja | Backlinki |
|---|-------|-----|--------|--------|---------|-----------------------|-----------|
| 1 | [rag_vs_llm_wiki](rag_vs_llm_wiki.md) | summary | active | 1 | 0 | 2026-05-28 | karpathy_andrej, czy_llm_wiki_skaluje_powyzej_100_stron, agent_oriented_engineering |
| 2 | [karpathy_andrej](karpathy_andrej.md) | entity | active | 2 | 0 | 2026-05-28 | rag_vs_llm_wiki, agent_oriented_engineering |
| 3 | [agent_oriented_engineering](agent_oriented_engineering.md) | summary | active | 1 | 0 | 2026-05-28 | karpathy_andrej, rag_vs_llm_wiki |
| 4 | [czy_llm_wiki_skaluje_powyzej_100_stron](czy_llm_wiki_skaluje_powyzej_100_stron.md) | open_question | active | 0 | 0 | 2026-05-28 | rag_vs_llm_wiki, karpathy_andrej |

> **Kolumny:**
> - **Typ** = `summary` / `entity` / `contradiction` / `open_question` (wzorzec LLM Wiki, patrz `Knowledge_Manager.md §Typy stron`)
> - **Updates** = `times_refined` z frontmattera strony — ile razy aktualizowana po CREATE. Metryka dojrzałości. 0 = świeża/zapomniana, 10+ = sprawdzona przez wiele źródeł.

---

## Kategorie

> Agent grupuje strony tematycznie. Kategorie rosną organicznie.

- **Knowledge architecture / LLM Wiki** — `rag_vs_llm_wiki`, `czy_llm_wiki_skaluje_powyzej_100_stron`
- **AI engineering** — `agent_oriented_engineering`
- **Osoby** — `karpathy_andrej`

---

## Statystyki

- Stron: 4
- Źródeł: 2 (oba: tweety @NainsiDwiv50980 z 15 i 27 maja 2026)
- Ostatni Ingest: 2026-05-28T20:30Z (K1)
- Ostatni Lint: —
- Sprzeczności: 0

### Per typ

| Typ | Liczba stron | Średnio updates |
|-----|--------------|------------------|
| summary | 2 | 0 |
| entity | 1 | 0 |
| contradiction | 0 | — |
| open_question | 1 | 0 |
