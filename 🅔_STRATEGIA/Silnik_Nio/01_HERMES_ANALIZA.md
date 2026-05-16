# Hermes Agent — Analiza vs TEMPLE_REPO_v2

> Źródło: artykuł Akshay Pachaar (@akshay_pachaar) — guide do Hermes Agent (Nous Research)
> Data analizy: 2026-05-16

---

## Co to jest Hermes Agent

Open-source **Python daemon** instalowany lokalnie na komputerze (Mac/Linux/Windows). Nie jest agentem chmurowym — żyje na Twoim sprzęcie.

**Nie ma własnej inteligencji** — jest infrastrukturą wokół zewnętrznych modeli: Claude, GPT, Gemini, lub lokalnego Ollama przez API.

Trzy rzeczy które go definiują:
1. **Nie zapomina między sesjami** — SQLite z historią każdej rozmowy
2. **Uczy się Twoich procedur** — agent sam pisze SKILL.md po złożonych taskach
3. **Działa bez Ciebie** — cron scheduler, 24/7, Telegram bots

---

## Architektura Hermesa — rozbicie na pierwsze zasady

### Jak startuje i żyje

```
Proces: hermes (Python daemon)
  └── gateway daemon    ← nasłuchuje (Telegram / CLI)
  └── scheduler         ← co 60s sprawdza cron jobs
  └── agent loop        ← gdy zadanie = odpala sesję
```

### System Prompt — serce każdej sesji

Każde wywołanie = zbudowanie jednego długiego stringa:

```
[SLOT 1] SOUL.md          — tożsamość agenta
[SLOT 2] USER.md          — profil użytkownika
[SLOT 3] MEMORY.md        — fakty o projekcie (2200 zn max)
[SLOT 4] Lista skilli     — tylko nazwy + opisy (nie pełna treść)
[SLOT 5] Dostępne tools   — read_file, run_command, skill_manage...
[SLOT 6] Historia sesji
```

### 3-Tier Memory

**Tier 1 — MEMORY.md + USER.md (zawsze w kontekście)**
- MEMORY.md: 2200 znaków max. Auto-kompresja gdy 80% pełny.
- USER.md: 1375 znaków. Profil usera: preferencje, poziom, czego unikać.
- Oba: zwykłe pliki markdown na dysku, wstrzykiwane do system promptu.

**Tier 2 — SQLite (state.db)**
- Każda rozmowa zapisywana po sesji.
- Full-text search (FTS5) — keyword search, NIE semantyczny.
- "Co gadaliśmy 3 tygodnie temu?" → `SELECT WHERE content MATCH 'deploy'`

**Tier 3 — 8 external memory plugins**
- Opcjonalne. Jeden aktywny naraz.
- Prefetch relevant memories przed każdą turą, sync po odpowiedzi.

### Self-Evolving Skills

**Progressive disclosure:**
- Level 0: agent widzi tylko `nazwa + opis` (~3k tokenów na cały katalog)
- Level 1: ładuje pełny SKILL.md gdy potrzebny
- Level 2: drąży do reference files wewnątrz skilla

**Pętla samodoskonalenia:**
```
Agent → rozwiązuje złożony problem (5+ tool calls)
      → wywołuje skill_manage(action="create")
      → zapisuje SKILL.md na dysk
      → następna sesja: skill jest w katalogu
      → agent nie odkrywa koła od nowa
```

Trigger tworzenia skilla: 5+ tool calls, błędy + znalezione wyjście, korekta od usera, non-trivial workflow.

### The Curator (garbage collection)

Odpala gdy: agent idle 2h+ AND 7 dni od ostatniego uruchomienia.

```
Faza 1 (deterministyczna, bez LLM):
  skill nieużywany > 30 dni → status: stale
  skill nieużywany > 90 dni → status: archive_candidate

Faza 2 (LLM review, do 8 iteracji):
  forked agent przeegzaminuje każdy agent-created skill
  decyzja: keep / patch / consolidate / archive
```

**Nigdy nie usuwa.** Najgorsze = `~/.hermes/skills/.archive/`. Zawsze recoverable.
Snapshot tar.gz przed każdym przejściem. Rollback jedną komendą.

### GEPA (Genetic-Pareto Prompt Evolution)

Osobne narzędzie, uruchamiane ręcznie gdy skill jest słaby.

```
1. Czyta skill
2. Generuje evaluation dataset (syntetyczne + realne z SQLite)
3. Evolutionary loop: traces → failure points → warianty → LLM-as-judge
4. Constraint gates: testy 100%, skill < 15KB, cel nie driftuje
5. Wynik → PR (nigdy direct commit)
```

Koszt: $2-10 per run. ICLR 2026 Oral paper — legitymowany naukowo.
Alternatywa dla fine-tuningu bez GPU.

### Multi-Agent Profiles

Każdy profil = pełna izolacja:
- Własny config, SOUL.md, MEMORY.md, skills/, SQLite
- Uruchamiany: `hermes -p designer`
- Może mieć własnego Telegram bota

### Cron / Scheduled Tasks

```
User pisze: "codziennie o 8:00 wyślij digest AI news"
Agent: cronjob_manage(schedule="0 8 * * 1-5", prompt="...", delivery="telegram")
Scheduler: co 60s sprawdza jobs.json → odpala isolated sesję → Telegram
```

---

## Porównanie TEMPLE vs Hermes

### Identity Layer

| | TEMPLE | Hermes |
|---|---|---|
| Plik | `Muaddib.md` | `SOUL.md` |
| Głębokość | 12 zasad poznawczych, jakość, elegancja, autonomia | 3-5 linii osobowości |
| Per-projekt | TAK (fork) | Jeden globalny, ew. per-profil |

**Wynik: REMIS — różne filozofie. TEMPLE głębszy kognitywnie, Hermes prostszy i przenośniejszy.**

### Memory Architecture

| Temat | TEMPLE | Hermes |
|---|---|---|
| Decyzje architektoniczne | ✅ DECISIONS.md (nigdy nie debatuj od nowa) | ❌ brak |
| Cross-session lekcje | ✅ LESSONS.md (żelazne reguły L1-L16) | ⚠️ MEMORY.md (2200 zn, kompresja) |
| Wiedza domenowa | ✅ KNOWLEDGE/ (on-demand) | ❌ brak dedykowanej warstwy |
| Historia konwersacji | ❌ tylko co weszło do SYNC_STATE | ✅ SQLite FTS, pełna historia |
| Profil usera | ❌ brak | ✅ USER.md |
| Bieżący stan | ✅ STATE_OF_SYSTEM.md | ❌ brak |

**Krytyczna luka TEMPLE: brak historii konwersacji. Hermes zapisuje WSZYSTKO.**

### Skills System

| | TEMPLE | Hermes |
|---|---|---|
| Liczba skilli | 20 (ręcznie kurowane) | 87+ bundled + auto-tworzone |
| Tworzenie | Fi + agent ręcznie | Agent sam (po złożonym tasku) |
| Progressive disclosure | NIE (pełny skill przy routingu) | TAK (nazwa → pełny → references) |
| Garbage collection | NIE | TAK (Curator) |
| Optymalizacja | NIE | TAK (GEPA) |
| Routing | ✅ CO_PILOT §4 (deterministyczny) | ❌ heurystyczny |

**Największa różnica: TEMPLE skills są statyczne. Hermes kompounduje.**

### Co TEMPLE ma czego Hermes NIE MA

| TEMPLE | Hermes |
|---|---|
| DECISIONS.md (architektura niezmieniana) | ❌ |
| CONSTITUTION.md (zasady projektu) | ❌ |
| 🅐-🅖 folder structure (klarowność) | ❌ |
| Git-native (wszystko wersjonowane) | ❌ (SQLite + tar.gz) |
| SSOT discipline | ❌ |
| Deterministyczny skill router | ❌ |
| PROOFS system | ❌ |
| CHECKLIST jako SSOT zadań | ❌ |

---

## Grill_Me Wyniki (stress-test analizy)

**Coverage: 7/7 kategorii przeanalizowanych**

1. **ZAŁOŻENIA** — Conversation history jest potrzebna: CONF 0.75. TEMPLE's manual curation może być higher quality signal niż raw SQLite (tylko szum + sygnał zamiast tylko sygnału).

2. **EDGE CASES** — Auto-skill creation ryzykowne: agent ma bias ku self-congratulation. GEPA jako korekta istnieje, ale dodaje koszt. Dla TEMPLE: semi-auto (agent drafts → Fi approves) bezpieczniejszy.

3. **ZALEŻNOŚCI** — Compounding w praktyce: mechanism sound (ICLR Oral), ale real-world effectiveness dla specjalistycznego workflow jak TEMPLE nieudowodniona. Traktować jako hypothesis.

4. **ALTERNATYWY** — Migracja do Hermesa: NIE. Tracisz DECISIONS.md, CONSTITUTION.md, SSOT, git-native. Adoptuj wzorce FROM Hermes INTO TEMPLE.

5. **RYZYKA** — Hermes bug: "The Hermes.md Bug That Charged Claude Max Users $200 Extra" — runaway API cost przy 24/7 agencie. Anthropic zablokował Claude Max subscription dla third-party tools (tylko pay-as-you-go API).

6. **KOSZTY** — USER.md: effort S. Session archive: S-M. Cron: L (osobna sesja). Semi-auto skills: M.

7. **REVERSIBILITY** — Wszystkie rekomendacje HIGH reversibility.

**VERDICT: 🟢 ZIELONY | CONF 0.88**

---

## Co adoptować z Hermesa (ranking)

### 🔴 HIGH

| # | Co | Jak w TEMPLE |
|---|---|---|
| 1 | Conversation history | `🅖_ARCHIVE/SESSIONS/YYYY-MM.md` append-only, curated key moments |
| 2 | USER.md | `🅓_SYSTEM/AVATAR/USER.md` — profil Fi, ładowany jako 6. element rehydrate |
| 3 | Proactive tasks | Claude Code hooks lub external cron |

### 🟡 MEDIUM

| # | Co | Jak |
|---|---|---|
| 4 | Semi-auto skill creation | Trigger w CO_PILOT §4 po complex task |
| 5 | Progressive disclosure | AGENTS.md tabela: tylko name + trigger + 1 zdanie |
| 6 | Curator pattern | W Reflect.md: co 30 dni flaguj unused skills |

### ❌ NIE ADOPTOWAĆ

- Full Hermes runtime (tracisz git-native, SSOT, klarowność)
- 687 community skills (Fi's 20 > 505 LobeHub generic)
- Platform agnosticism (jesteś Claude-native)

---

## Kontekst kulturowy: Mac Mini "Shrimp Farming"

Zjawisko z początku 2026: masowy zakup Mac Mini M4 do uruchamiania **OpenClaw** (inny agent AI) 24/7 — trend nazwany "shrimp farming" (hodowla krewetek — karmisz maszynę żeby zarabiała).

OpenClaw okazał się skomplikowany, niestabilny, drogi. Hermes pojawił się jako prostszy, API-based alternatywa.

Prześmiewczy komentarz "płacz dla tych co kupili Mac Mini" = jeśli Hermes działa przez API (bez lokalnego compute), po co kupowałeś drogi Mac Mini?

Ironia: Hermes obsługuje też lokalny Ollama — więc Mac Mini jednak może mieć sens dla prywatności + zero API cost. Ale przy typowym workflow (nieintensywnym) break-even to ~$50-100/mies API spend.

**Dodatkowy skandal:** Hermes bug który generował podwójne wywołania API → +$200 na rachunkach Claude Max userów.
