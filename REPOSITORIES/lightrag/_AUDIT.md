# 🔍 AUDIT — LightRAG

- **Source:** https://github.com/HKUDS/LightRAG
- **Author:** HKU Data Science (papier arXiv 2410.05779)
- **License:** MIT
- **Data importu:** 2026-04-25
- **Werdykt:** 🟡 **INSPIRATION** (nie ma teraz zastosowania w Twoich projektach)

---

## 📌 Co to jest po ludzku

Profesjonalny framework RAG (Retrieval-Augmented Generation) z uczelni Hong Kong. Bierzesz kupę dokumentów (PDF, Word, obrazki, tabele) → buduje knowledge graph + bazę wektorową → potem zadajesz pytania w naturalnym języku, odpowiada cytując źródła.

Działa lokalnie (PostgreSQL/Neo4j/MongoDB/OpenSearch/SQLite) lub w cloudzie. Web UI + API + integracja z Ollama. Aktywnie rozwijane (ostatni update marzec 2026).

---

## 🎯 Co daje TOBIE

### 🔴 Realnie: nic teraz

Twoje projekty NIE są use case'em dla RAG:
- **GOFANS** = static landing, no documents
- **MALING** = job scraper + alerty (mało dokumentów, wiele zapytań strukturalnych)
- **MCP_KNOWLEDGE_ENGINE** = już ma swój pipeline (Gemini compression + SQLite WAL + 22 RSS feedy + collectors). LightRAG byłby równoległy system, nie ulepszenie
- **TEMPLE** = meta-szablon, no documents

### 🟡 Inspiracja konceptualna (na potem)

Gdy kiedyś zbudujesz **lokalną bazę wiedzy** na Mac Mini (rozważałeś w `Karpathy_Radek.md`), LightRAG to mocniejszy kandydat niż Pinecone bo:
- Open source MIT (zero kosztu)
- Działa lokalnie (Twój Mac Mini)
- Knowledge Graph + Vector retrieval w jednym (lepsze niż czysty wektor)
- Może być adapterem do GOFANS/MALING dokumentów (gdyby się zbierały)

---

## 🚀 PRO BOOSTY (koncepty warte zapamiętania)

1. **Dual-level retrieval** — knowledge graph (relacje) + vector (semantyka) razem. Lepsze niż sam wektor (mniej hallucynacji, więcej kontekstu).
2. **Reranker w default mode** — po retrieval drugie sortowanie z lepszym modelem. Większa precyzja kosztem latency.
3. **Auto KG regeneration przy delete** — gdy wywalasz dokument, graf się sam odbudowuje.
4. **RAGAS + Langfuse eval** — metryki precyzji kontekstu (gdy będziesz oceniał jakość RAG'a).

---

## 📝 Zasada dla kolejnego agenta

NIE adoptuj LightRAG do żadnego z 4 obecnych projektów. Trzymaj jako **referencję na przyszłość** (gdy Fi rozpocznie projekt z prawdziwą bazą dokumentów). Wtedy: `cd REPOSITORIES/lightrag/` → `docs/QuickStart.md` → setup wizard → Docker compose.
