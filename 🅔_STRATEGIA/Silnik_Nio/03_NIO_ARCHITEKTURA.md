# Nio — Architektura Agenta Gofans Neoverse

> Data: 2026-05-16 | Skill: Brain_Storming | Metoda: Strukturalny + Multi-Perspective

---

## Definicja Nio

Nio to **żywy agent ekosystemu Gofans Neoverse** — nie chatbot z pamięcią, ale system operacyjny całej przestrzeni interakcji użytkowników.

### Nio musi robić 4 fundamentalnie różne rzeczy:

```
1. PAMIĘĆ UŻYTKOWNIKA     — pamiętać każdego z osobna, długoterminowo
2. WIEDZA EKOSYSTEMU      — znać cały GOFANS i być aktualny
3. PERSONALIZACJA         — łączyć 1+2 w celowane odpowiedzi
4. ORKIESTRACJA AGENTÓW   — kontrolować grę i delegowanych agentów
```

### Personalizacja Nio opiera się na:

- Status profilowy użytkownika
- Historia wydatków i transakcji
- Poprzednie zapytania i interakcje
- Miejsce zamieszkania / geolokalizacja
- Zainteresowania i preferencje
- Zachowania nawigacyjne w ekosystemie
- Historia relacji w module gry

---

## Warianty Architektoniczne (Brain_Storming)

### Wariant A — "Monolityczny Nio" ❌ ODRZUCONY

```
User pyta → ładuj cały profil + cała wiedza GOFANS → odpowiedz
```

**Dlaczego nie:** Context window limits. Przy 10,000 userów × 50k historii każdy = niemożliwe. Kolejka (user 2 czeka na user 1). Wiedza GOFANS rośnie → overflow pewny.

---

### Wariant B — "Personalized Agents per User" ❌ ODRZUCONY

Każdy user = własna instancja Nio.

**Dlaczego nie:** 10,000 userów = 10,000 instancji. Koszt astronomiczny. Wiedza o GOFANS duplikowana tysiące razy.

---

### Wariant C — "Thin Orchestrator + Specialized Agents" ⚠️ CZĘŚCIOWO

```
User pyta
    ↓
NIO (orchestrator)
    ↓       ↓         ↓          ↓
UserAgent EcoAgent GameAgent RecommAgent
```

**Zalety:** Separacja odpowiedzialności. Skaluje niezależnie.
**Wady:** Latencja (4 calls). Synchronizacja. Nio musi być świetnym routerem.

**Verdict:** Dobry kierunek, ale potrzeba warstwy pamięci pod spodem.

---

### Wariant D — "Living Memory Stack" ✅ REKOMENDOWANY

```
┌────────────────────────────────────────────────┐
│                  NIO CORE                      │
│    Orchestrator + Response Generator           │
│    Router | Personalizer | Game Controller     │
└──────────┬──────────────────┬──────────────────┘
           │                  │
           ▼                  ▼
┌─────────────────┐  ┌──────────────────────────┐
│   USER WIKI     │  │    ECOSYSTEM WIKI         │
│  per-user .md   │  │   LLM-maintained          │
│                 │  │                           │
│ user_123/       │  │ moduły/ decyzje/           │
│  PROFILE.md     │  │ events/ updates/           │
│  HISTORIA.md    │  │ features/ content/         │
│  WZORCE.md      │  │                           │
└────────┬────────┘  └────────────┬─────────────┘
         │                        │
         └───────────┬────────────┘
                     ▼
         ┌───────────────────────┐
         │    VECTOR DB (RAG)    │
         │  semantic retrieval   │
         │  gdy wiki za duże     │
         └───────────┬───────────┘
                     ↓
         ┌───────────────────────┐
         │      RAW DATA         │
         │  PostgreSQL / Supabase│
         │  user facts, spending │
         │  location, status     │
         │  activity logs        │
         └───────────────────────┘
```

---

## Szczegóły Każdej Warstwy

### USER WIKI — Pamięć per-użytkownik

Każdy user ma folder z 3 plikami syntetycznymi. NIE surowe logi — synteza:

```
users/
  user_123/
    PROFILE.md    ← status, wydatki, lokalizacja, zainteresowania
    HISTORIA.md   ← synteza ostatnich 90 dni interakcji
    WZORCE.md     ← jak podejmuje decyzje, co go przekonuje
```

**Przykład PROFILE.md:**
```markdown
# PROFILE — user_123
Status: Premium | Wydatki: 2,340 PLN lifetime
Lokalizacja: Warszawa | Strefa: GMT+1
Zainteresowania: [moduł_gry, NFT_marketplace, networking]
Styl komunikacji: bezpośredni, nie lubi długich intro
Ostatnia aktywność: 2026-04-28
Nieaktywny przez: 18 dni
```

**Przykład WZORCE.md:**
```markdown
# WZORCE — user_123
Decyzje zakupowe: visual learner, potrzebuje social proof
Reaguje na: exclusive access, limited time
Nie reaguje na: FOMO, discount-heavy messaging
Godziny aktywności: rano 9-11, wieczór 20-22
Czas do decyzji zakupowej: ~3 dni od pierwszego kontaktu
```

**Mechanika przy powrocie usera po miesiącu:**
```
User_123 loguje się
      ↓
Nio ładuje: user_123/PROFILE.md + HISTORIA.md + WZORCE.md
      ↓
~2k tokenów zamiast tysięcy surowych logów
      ↓
Nio "pamięta" i odpowiada z pełnym kontekstem
```

Synteza plików: kosztowna raz po sesji, nie przy każdym pytaniu.

---

### ECOSYSTEM WIKI — Żywa wiedza o GOFANS

```
ecosystem/
  moduły/
    gra.md          → mechaniki, zasady, ostatnie aktualizacje
    marketplace.md  → co jest, jak działa, nowości, ceny
    networking.md   → jak używać, case studies, features
  updates/
    2026-05.md      → co nowego w tym miesiącu
  pricing/
    struktura.md    → tiers, kto płaci co
  faq/
    top-questions.md → najczęstsze pytania + odpowiedzi
```

---

### KNOWLEDGE UPDATE PIPELINE — "Żywość" Nio

Gdy nowy content pojawia się w GOFANS:

```
Nowy content dodany do ekosystemu
        ↓
Event/webhook → Knowledge_Manager agent (background)
        ↓
Ingestuje dokument
        ↓
Syntetyzuje → tworzy/aktualizuje strony ECOSYSTEM WIKI
        ↓
Flaguje: "ten update dotyczy userów z tag: [gra, premium]"
        ↓
Nio przy następnej interakcji z takim userem → wie o aktualizacji
        i może aktywnie doradzi: "widzę że interesujesz się X,
        właśnie pojawiło się Y które może Cię zainteresować"
```

Zero ręcznej pracy. Nio zawsze aktualny.

---

### GAME AGENT LAYER — Orkiestracja multi-agentowa

**Każdy agent użytkownika:**

```
agents/
  agent_xyz/
    SOUL.md     → persona (czyj, wartości, jak rozmawia, styl)
    MEMORY.md   → co agent "przeżył" (relacje, historia)
    OWNER:      user_123
    STATUS:     active / rented / paused / archived
    RENTED_BY:  user_456 (jeśli wynajęty)
```

**Mechanika interakcji między agentami:**

```
agent_A chce nawiązać relację z agent_B
        ↓
Message Bus (async queue — Redis / RabbitMQ)
        ↓
Nio jako SUPERVISOR sprawdza:
  - czy interakcja jest zgodna z zasadami
  - czy właściciele wyrazili zgodę na ten typ interakcji
        ↓
agent_B odpowiada (przez własny SOUL.md + MEMORY.md)
        ↓
Obie MEMORY.md aktualizowane po interakcji
        ↓
Właściciele powiadamiani (opcjonalnie, per preferencje)
```

**Uprawnienia Nio jako Supervisora:**
- Pauzowanie agentów łamiących zasady
- Reset relacji między agentami (np. na prośbę właściciela)
- Raportowanie właścicielom (co mój agent robi)
- Moderacja konfliktów
- Widoczność ALL agent states (elevated access)

**Model biznesowy wynajmu agentów:**
```
User_A ma agenta "Atlas" (mocny, doświadczony, wiele relacji)
User_B chce jego agenta na 7 dni → płaci User_A
Atlas działa dla User_B, ale SOUL.md pozostaje niezmieniony
Po 7 dniach wraca do User_A z zaktualizowaną MEMORY.md
```

**Moat biznesowy:** Relacje między agentami mają realną wartość w grze. Userzy nie odchodzą bo tracą historię relacji swoich agentów.

---

### MECHANIZM "ŻYWOŚCI" — 3 background procesy

**PROCESS 1 — MEMORY CONSOLIDATOR (co 24h)**
```python
for active_user in users:
    if user.had_session_today:
        synthesize(user.logs → USER_WIKI/PROFILE.md)
        update(user.HISTORIA.md)
        recalculate(user.WZORCE.md)

for active_agent in game_agents:
    if agent.had_interactions_today:
        update(agent.MEMORY.md)
```

**PROCESS 2 — KNOWLEDGE UPDATER (on-event, real-time)**
```python
on_event("new_content_added"):
    ingest(content)
    synthesize → update ECOSYSTEM_WIKI pages
    flag_relevant_users(tags)
```

**PROCESS 3 — PROACTIVE NOTIFIER (reguły)**
```python
for user in users:
    if user.days_inactive >= 7 and user.has_relevant_updates:
        send_personalized_notification(
            user=user,
            content=match_updates_to_profile(user)
        )
    if user.agent.had_important_interaction:
        notify_owner(user)
```

---

## Multi-Perspective Stress Test

**Technical Lead:**
> "Message Bus będzie bottleneck przy 10k agentów jednocześnie. Potrzebujesz async queue (Redis/RabbitMQ), nie synchronicznych callów między agentami."

**User:**
> "Chcę żeby Nio pamiętał mnie ale nie czułem się śledzony. Transparentność: 'pamiętam że interesowałeś się X' powinna być jawna, nie ukryta personalizacja."

**Sceptyk:**
> "LLM jako redaktor USER WIKI może syntetyzować źle. Jeden błędny wpis w WZORCE.md = Nio przez miesiąc źle rozumie usera. Potrzebujesz mechanizmu korekty (user feedback loop: 'ta rekomendacja była niecelna')."

**Business:**
> "Game Agent Layer to moat. Relacje między agentami z historią = lock-in. Userzy nie odchodzą bo tracą 'cyfrowy dorobek' swoich agentów."

**Security:**
> "Elevated Nio access do wszystkich agent states = potencjalny attack vector. Trzeba audyt trail dla każdego Supervisor action."

---

## Fazy Wdrożenia (nie buduj wszystkiego naraz)

### FAZA 1 — MVP (tygodnie 1-6)

```
✅ Nio Core (orchestrator + response generator)
✅ USER WIKI: tylko PROFILE.md (podstawowe fakty, ręcznie na start)
✅ ECOSYSTEM WIKI: ręcznie uzupełniany
✅ PostgreSQL dla structured user data (profil, wydatki, lokalizacja)
✅ Podstawowa personalizacja (load profile → odpowiedz)
```

**KPI:** Nio odpowiada z kontekstem użytkownika. User który wraca po tygodniu jest "pamiętany."

### FAZA 2 — Autonomia (tygodnie 7-14)

```
🔧 Knowledge Update Pipeline (auto-ingest nowego contentu)
🔧 HISTORIA.md + WZORCE.md (synteza zachowań po sesjach)
🔧 Memory Consolidator (background process)
🔧 Vector DB (gdy ECOSYSTEM WIKI > 200 stron)
```

**KPI:** Nio sam aktualizuje wiedzę. Syntheza użytkownika jest automatyczna po sesji.

### FAZA 3 — Gra i Agenci (tygodnie 15-24)

```
🚀 Agent Registry (baza agentów użytkowników)
🚀 SOUL.md + MEMORY.md per agent
🚀 Message Bus (async, Redis)
🚀 Nio Supervisor (elevated access, pauzowanie, raporty)
🚀 Mechanika wynajmu agentów
```

**KPI:** Agenci rozmawiają ze sobą. Właściciel widzi raport z aktywności agenta.

### FAZA 4 — Pełna "Żywość" (tygodnie 25+)

```
⭐ Proactive Notifier (Nio pisze pierwszy gdy coś ważnego)
⭐ Per-agent MEMORY.md evolucja przez Curator
⭐ Recommendation engine (multi-factor personalizacja)
⭐ User feedback loop (korekta błędów w USER WIKI)
```

**KPI:** Nio jest "żywy" — użytkownicy czują że system rozumie ich bez tłumaczenia od nowa.

---

## Stack Technologiczny (rekomendacja wstępna)

| Warstwa | Technologia | Dlaczego |
|---|---|---|
| LLM Core | Claude API (Sonnet) | Fi jest Claude-native, jakość |
| Database (structured) | PostgreSQL / Supabase | relacyjne dane usera, ACID |
| Vector DB | Qdrant (self-hosted) | open-source, Docker, performant |
| Message Bus | Redis Streams | lekki, sprawdzony, async |
| File Storage | S3 / lokalny FS | USER WIKI + ECOSYSTEM WIKI (markdown) |
| Background Jobs | Python asyncio + APScheduler | Memory Consolidator, Notifier |
| Agent API | FastAPI | REST endpoints dla Nio |
| Monitoring | Langfuse | observability LLM calls, koszty |

---

## Otwarte Pytania (do rozstrzygnięcia w Check_Me / System_Architect)

1. **Skalowanie USER WIKI:** Przy 100k userów — 100k folderów. Czy plik per user to właściwa abstrakcja? Alternatywa: baza danych z JSON blobs per user.

2. **Koszt API:** Memory Consolidator odpala synthesis per active user co 24h. Przy 10k active users × ~$0.05/synthesis = $500/dzień. Czy opłacalne? Kiedy trigger konsolidacji?

3. **Agent ekonomia:** Czy wynajęty agent wraca z "zepsutą" MEMORY.md jeśli renter ją zaszkodził? Kto arbitruje?

4. **Prywatność:** PROFILE.md + WZORCE.md to dane wrażliwe. GDPR compliance jeśli userzy z EU.

5. **Jakość syntezy:** Mechanizm korekty gdy Nio źle profiluje usera? User feedback loop → korekta WZORCE.md?
