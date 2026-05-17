# Wnioski i Rekomendacje — Sesja 2026-05-16

> Podsumowanie kluczowych wniosków i decyzji do podjęcia

---

## Kluczowe wnioski sesji

### 1. Hermes vs TEMPLE — wynik analizy

TEMPLE jest architektonicznie lepszy od Hermesa w większości wymiarów. Jedyna prawdziwa przewaga Hermesa dla Fi to:

- **Self-evolving skills** (agent tworzy SKILL.md sam po złożonym tasku)
- **SQLite conversation history** (pełna historia, przeszukiwalna)
- **Cron / proactive agents** (24/7 bez inicjacji Fi)

Wszystko inne w Hermesie jest albo gorzej (brak DECISIONS.md, CONSTITUTION.md, SSOT, git-native) albo analogicznie (SOUL.md ≈ Muaddib.md).

**Wniosek:** Nie migrować do Hermesa. Adoptować wybrane wzorce INTO TEMPLE.

---

### 2. RAG nie umiera — przesuwa się niżej

```
[Agent / User]
      ↓
[LLM Wiki — synthesized understanding]     ← nowość
      ↓
[RAG + Vector DB — retrieval z surowych źródeł]  ← nadal potrzebny
      ↓
[Surowe dokumenty]
```

Karpathy nie zastąpił RAG. Uzupełnił architekturę o środkową warstwę której brakowało.

**Największy insight sesji:** Bottleneck wiedzy nigdy nie był inteligencja — był maintenance. LLM robi maintenance prawie za darmo. To zmienia co jest architektonicznie możliwe.

---

### 3. Obecny "most pro" stack dla vibe codingu

**TEMPLE-style structured context** nad codebasem — bez warstwy wektorowej, bez autonomicznego LLM Wiki (jeszcze).

LLM Wiki jako autonomiczna warstwa = za wcześnie. Błędna synteza kompounduje się. Brak produkcyjnie proven toolingu. 12-18 miesięcy do "most pro."

---

### 4. Nio — właściwa koncepcja

Nio nie jest chatbotem z pamięcią. Jest **systemem operacyjnym ekosystemu Gofans Neoverse** z czterema warstwami:

- USER WIKI (per-user syntetyczna pamięć)
- ECOSYSTEM WIKI (LLM-maintained wiedza o GOFANS)
- Vector DB + RAG (gdy wiki za duże)
- Game Agent Layer (orkiestracja agentów użytkowników)

Trzy background procesy czynią Nio "żywym":
1. Memory Consolidator (co 24h)
2. Knowledge Updater (on-event)
3. Proactive Notifier (wg reguł)

---

## Rekomendacje do działania

### Dla TEMPLE (krótkoterminowe)

| Priorytet | Akcja | Effort |
|---|---|---|
| 🔴 HIGH | Stworzyć `🅓_SYSTEM/AVATAR/USER.md` — profil Fi | S |
| 🔴 HIGH | Stworzyć konwencję `🅖_ARCHIVE/SESSIONS/` dla historii sesji | S-M |
| 🟡 MEDIUM | Dodać trigger semi-auto skill creation do CO_PILOT §4 | M |
| 🟡 MEDIUM | Progressive disclosure w AGENTS.md tabeli skilli | S |

### Dla Nio / Gofans Neoverse (długoterminowe)

| Faza | Co | Kiedy |
|---|---|---|
| MVP | Nio Core + PROFILE.md + ECOSYSTEM WIKI ręczny + PostgreSQL | Tygodnie 1-6 |
| Autonomia | Auto-ingest + Memory Consolidator + Vector DB | Tygodnie 7-14 |
| Gra | Agent Registry + Message Bus + Nio Supervisor | Tygodnie 15-24 |
| Pełna żywość | Proactive Notifier + User feedback loop | Tygodnie 25+ |

### Otwarte decyzje (wymagają Check_Me / System_Architect)

1. **Koszt konsolidacji pamięci:** 10k active users × $0.05/synthesis/dzień = $500/dzień. Kiedy triggerować? Jak throttlować?
2. **Skalowalność USER WIKI:** Pliki per user vs JSON blobs w bazie danych?
3. **Agent ekonomia:** Mechanizm ochrony MEMORY.md agenta podczas wynajmu?
4. **GDPR compliance:** USER WIKI z danymi PII dla userów EU?
5. **Jakość syntezy:** User feedback loop → jak user koryguje błędny profil Nio?

---

## Decyzje do DECISIONS.md (jeśli Fi potwierdzi)

```
D18 (propozycja): Nio architecture = Living Memory Stack (Wariant D)
D19 (propozycja): Nio fazy wdrożenia wg harmonogramu z 03_NIO_ARCHITEKTURA.md
D20 (propozycja): Nie migrować TEMPLE do Hermesa — adoptować wzorce selektywnie
```

---

## Stan wiedzy po sesji

| Temat | Poziom rozumienia |
|---|---|
| Hermes Agent architektura | 🟢 Pełny |
| RAG mechanika | 🟢 Pełny |
| LLM Wiki pattern | 🟢 Pełny |
| Bazy wektorowe | 🟢 Fundament |
| Nio koncepcja | 🟡 Brainstorm gotowy → potrzeba System_Architect ADR |
| Nio implementacja | 🔴 Do zaprojektowania |

`CONF: 0.88 | Sesja: 2026-05-16 | Agent: Muaddib (Claude Sonnet 4.6)`

---

## Analiza zewnętrzna — Google Agent Stack (Eva Nardini, Google Cloud I/O 2026)

> Źródło: transkrypt prezentacji "Building AI Agents using Claude on Vertex AI"
> Data analizy: 2026-05-17

### Co ogłosiła Google

Cztery komponenty "AgenteStack":
1. **ADK** (Agent Development Kit) — open-source framework do budowania agentów
2. **MCP integration** — ADK kompatybilny z MCP od day-zero
3. **Agent Engine** (Vertex AI) — managed platform do deployment agentów w produkcji
4. **A2A Protocol** — open protocol do komunikacji między agentami z różnych frameworków

### Brainstorming — 6 perspektyw

**Optymista:** ADK + Agent Engine = skip miesięcy budowania orchestracji. Claude 4 już w Vertex AI.

**Google graveyard:** Google Reader, Stadia, Hangouts, Cloud IoT Core. ADK ma kilka miesięcy. Zero produkcyjnych case studies w skali.

**Realista solo-founder:** Każda zależność = nowa powierzchnia awarii. GCP = +1 billing, +1 IAM, +1 dashboard do pilnowania. Już mamy Claude API + Supabase + Qdrant + Redis.

**Strateg:** Z czterech komponentów tylko dwa mają network effects: **MCP i A2A**. ADK i Agent Engine = commoditized middleware, wymienialne. Protokoły > frameworki.

**Architekt:** ADK jest stateless-session-based. Nio jest synthesis-based persistent memory. Dwa różne paradygmaty. Wciśnięcie Nio w ADK = utrata moatu (USER WIKI, ECOSYSTEM WIKI).

**Business/Inwestor:** Moat to Game Agent Layer + agent economy. Czas na naukę GCP = czas NIE-spędzony na unikalnej IP.

**Co przeoczono w pierwszej analizie:**
- MCP nigdzie nie jest jawnie nazwany w `03_NIO_ARCHITEKTURA.md` — to luka
- Eva wprost mówi: "live webinar z Anthropic" → Anthropic + Google współpracują, A2A będzie miał pierwszorzędne wsparcie Claude
- Langfuse już daje ~70% observability Agent Engine — realna nadwyżka = managed scaling (niepotrzebny na MVP)

---

## Decyzja D-NIO-001 — Stosunek do Google Agent Stack

**Status:** Propozycja → wymaga potwierdzenia Fi

**Decyzja: Nie adoptujemy Google Agent Stack jako fundamentu Nio. Adoptujemy selektywnie tylko protokoły otwarte (MCP, potencjalnie A2A). Frameworków Google'a (ADK, Agent Engine) nie używamy.**

### Uzasadnienie

1. Nasza architektura (synthesis-based persistent memory) jest głębsza niż session-based ADK — wymuszenie ADK = utrata moatu.
2. Frameworki Google'a są commoditized i wymienialne — protokoły otwarte (MCP, A2A) mają network effects i są warte uwagi.
3. Solo-founder energy budget nie pozwala na podwójny paradygmat — adopcja GCP = +1 dashboard, +1 billing, +1 IAM, zero unique IP.

### Konkretne akcje

| # | Akcja | Kiedy | Effort |
|---|---|---|---|
| 1 | Dodać jawną sekcję "MCP jako standard dla Nio tools" do `03_NIO_ARCHITEKTURA.md` | Teraz | S |
| 2 | Stworzyć watcher w `🅒_NOW/`: "A2A Protocol — review co kwartał" | Teraz | S |
| 3 | Zapisać D-NIO-001 w `DECISIONS.md` po confirm Fi | Po confirm | S |
| 4 | Re-evaluacja A2A przy projektowaniu Fazy 3 (Game Agent Layer, tydzień 15+) | Tydzień 15+ | M |
| 5 | Re-evaluacja Agent Engine vs własna infra przy 1k+ active users | Tydzień 25+ | M |

### Czego NIE robimy

- Nie portujemy Nio Core na ADK
- Nie zakładamy konta GCP
- Nie zamieniamy FastAPI + Docker + Langfuse na Agent Engine
- Nie próbujemy hybridu (ADK + własna synthesis layer) — double maintenance

### Warunki triggerujące re-decyzję

1. A2A adoptują 3+ major vendors (Anthropic, OpenAI, Mistral) → adoptujemy A2A w Fazie 3
2. Anthropic releases natywny SDK do Agent Engine → re-evaluacja deployment layer
3. Nio > 10k active users i infra trzeszczy → benchmark Agent Engine vs własna
4. Google deprecates ADK/Agent Engine → decyzja potwierdzona z marszu

### Jedno zdanie do zapamiętania

> *"Protokoły otwarte adoptujemy, frameworki vendorów ignorujemy. Moat to Game Agent Layer + USER WIKI, nie infrastruktura."*

`CONF: 0.84 | Analiza: 2026-05-17 | Agent: Muaddib (Claude Opus 4.7)`
