# AGENTS — {{NAZWA_PROJEKTU}}

> Mapa operacyjna + entry point. CORE → `🅓_SYSTEM/AVATAR/Muaddib.md`. Procedury → `CO_PILOT.md`.

**Alias:** `{{ALIAS_PROJEKTU}}`

## REHYDRATE — 5 pozycji (w tej kolejności)

1. **`🅓_SYSTEM/AVATAR/Muaddib.md`** — **CORE: tożsamość + tryb poznawczy + avatar (MUSI być #1)**
2. `🅓_SYSTEM/AGENT/CO_PILOT.md` — konstytucja operacyjna
3. `🅒_NOW/STATE_OF_SYSTEM.md` — stan systemu
4. `🅒_NOW/CHECKLIST.md` — co robimy (SSOT)
5. `🅒_NOW/DECISIONS.md` — trwałe decyzje

> **PROOFS/** — NIE w rehydrate. Agent zapisuje dowody w trakcie pracy, STATE ma pointery (TOP-5 PROOFS).

**Po załadowaniu:**
```
REHYDRATE: DONE | CORE: Muaddib ACTIVE
LOADED: Avatar + Constitution + State + Checklist + Decisions
CURRENT GOAL: <z CHECKLIST → NEXT>
CONF: 0.XX | STUCK: nie | ASSUMPTIONS: <lista lub brak>
```

### PARTIAL REHYDRATE

| Komenda | Ładuje | ~Tokenów | Kiedy |
|---------|--------|----------|-------|
| `rehydrate {{ALIAS}}` | Wszystkie 5 | ~3 500-4 500 | Start sesji |
| `rehydrate core` | Muaddib + CO_PILOT | ~2 500 | Utrata kontekstu |
| `rehydrate state` | STATE + CHECKLIST | ~1 500 | "Gdzie jestem?" |
| `rehydrate decisions` | DECISIONS | ~500 | Przed decyzją |

## SYNC_STATE

Procedura → `CO_PILOT.md` §2 (SSOT).

## SKILLe (DYNAMIC MATCHING)

**Katalog:** `🅓_SYSTEM/SKILL/` | 1 skill per operacja | NIE ładuj przy rehydrate
Agent SPRAWDZA katalog przy każdym zadaniu (glob `*.md`, nie hardcode).

| Skill | Trigger |
|-------|---------|
| Brain_Storming | Nowy moduł, pivot, CONF<0.70, wiele opcji, kreatywna sesja |
| Check_Me | Niejasny cel, brak danych, wywiad z userem |
| System_Architect | Architektura, build-vs-buy, refaktor, API |
| Grill_Me | >50 linii, nieodwracalne, CONF<0.85, sprzeczność |
| Auto_Codex | Auto-delegacja kodowania do Codex CLI (>~20 linii / >1 plik) |
| Preflight | Przed deploy/review/DONE |
| Expert_Council | Druga opinia, stress-test decyzji |
| Reflect | Koniec sesji → lekcje + update SOUL/LESSONS/ToV |
| Context_Forge | Optymalizacja kontekstu + uczenie agenta — co 5-10 sesji |
| Create_Skill | Instalacja nowego skilla |
| DESIGN_ARSENAL | UI/design, frontend aesthetic |
| Workflow_Edit | Zmiana struktury plików workflow, referencji, rehydrate, merge/split plików |
| Knowledge_Manager | Zarządzanie wiedzą domenową — ingest źródeł + audyt (łączy Ingest + Lint) |

**Sunset:** >60 dni nieużyty → review → żywy / archive / usuń.
**Routing:** Agent decyduje SAM → `CO_PILOT.md` §4.

## ROOT FILES — SSOT (Single Source of Truth)

| Plik | Owner | Temat (SSOT) | Kiedy czytać |
|------|-------|--------------|-------------|
| **`🅓_SYSTEM/AVATAR/Muaddib.md`** | Agent (CORE) | Tożsamość + tryb myślenia + avatar | Pierwszy przy rehydrate (#1) |
| **`AGENTS.md`** (ten plik) | Agent + CLI | Mapa operacyjna + REHYDRATE + SSOT | Rehydrate, bootstrap |
| **`CONSTITUTION.md`** | Projekt ({{OWNER}}) | Wartości niezmienne + Dekalog | Wątpliwość etyczna, nowa decyzja |
| **`INIT.md`** | TEMPLE bootstrap | Procedura forku TEMPLE → nowy projekt | Tylko raz — potem `rm -f INIT.md` |
| **`LESSONS.md`** | Agent (pamięć) | Cross-session lessons + long-term findings | Na starcie sesji + po Reflect + sync_state |

**Reguła:** temat X → TYLKO plik z tabeli jest autorytatywny. Inne pliki referują (`patrz X.md §Y`), NIE duplikują.

| Temat | Źródło prawdy |
|-------|---------------|
| Tożsamość + tryb myślenia + zasady poznawcze + avatar (imię, rola, specjalizacja) | `🅓_SYSTEM/AVATAR/Muaddib.md` |
| Rehydrate list, aliasy, mapa skilli, mapa repo | `AGENTS.md` |
| Procedura SYNC_STATE, skill routing, polityka commit, token budget | `🅓_SYSTEM/AGENT/CO_PILOT.md` |
| Wartości projektu, Dekalog, Non-negotiables, misja | `CONSTITUTION.md` |
| Głos + charakter agenta (ton, styl, tryby odpowiedzi A/B/C) | `🅓_SYSTEM/SOUL/VOICE.md` |
| Bieżące zadania (NEXT, IN PROGRESS, DONE) | `🅒_NOW/CHECKLIST.md` |
| Stan systemu (TOP-10 facts, blockers) | `🅒_NOW/STATE_OF_SYSTEM.md` |
| Trwałe decyzje projektu | `🅒_NOW/DECISIONS.md` |
| Proofy sesyjne | `🅔_STRATEGIA/PROOFS/<AREA>_<YYYYMMDD>.md` |
| Lekcje cross-session + long-term findings | `LESSONS.md` |
| Wiedza domenowa (kompilat ze źródeł) | `🅓_SYSTEM/KNOWLEDGE/` (index.md = entry point) |

## MAPA FOLDERÓW 🅐-🅖

| Folder | Zawartość | Kiedy czytać |
|--------|-----------|-------------|
| `🅐_OPIS/` | Opis projektu, kontekst, tło | Nowy agent, sesja kreatywna |
| `🅑_ROADMAP/` | Event-driven plan, fazy | Co budować dalej |
| `🅒_NOW/` | Aktualny sprint — CHECKLIST, STATE, DECISIONS | Codziennie |
| `🅓_SYSTEM/` | Agent OS — Avatar, Soul, Skills, CO_PILOT | Praca agenta |
| `🅔_STRATEGIA/` | Archiwum analiz, Agent Teams, PROOFS | Research, deep context |
| `🅕_PRODUKT/` | Kod produkcyjny | Zadania deweloperskie |
| `🅖_ARCHIVE/` | Stare pliki, historia | Rzadko |

### Podkatalogi `🅓_SYSTEM/`

- `AGENT/CO_PILOT.md` — konstytucja operacyjna (procedury, router, sync, token budget)
- `AVATAR/Muaddib.md` — CORE: tożsamość + tryb poznawczy + avatar (imię, rola, specjalizacja)
- `SOUL/VOICE.md` — głos + charakter agenta (rośnie przez Reflect)
- `SKILL/*.md` — skille dynamiczne — ładowane on-demand przez router w `CO_PILOT.md §4`
- `KNOWLEDGE/` — wiedza domenowa — kompilowana wiki ze źródeł. NIE w rehydrate. Agent czyta `index.md` on-demand.

## CLI Tools

| Tool | Komenda | Rola |
|------|---------|------|
| Claude | `claude` | Architektura, decyzje, review, gate |
| Codex | `codex exec --full-auto` | Kodowanie (auto-delegacja przez Claude, >~20 linii) |

Delegacja Claude → Codex **automatyczna** (skill Auto_Codex). Fi = gate przed commit.

## Deploy

| Parametr | Wartość |
|----------|---------|
| Produkcja | {{URL_PRODUKCJI}} |
| Root | `🅕_PRODUKT/{{KATALOG_ROOT}}/index.html` |
| Procedura | {{PROCEDURA_DEPLOY}} |

## Quick Reference — gdzie co zmieniam

| Chcę zmienić... | Idę do... |
|-----------------|-----------|
| Sposób myślenia agenta / avatar | `🅓_SYSTEM/AVATAR/Muaddib.md` |
| Procedurę pracy (sync, commit, routing) | `🅓_SYSTEM/AGENT/CO_PILOT.md` |
| Listę plików do rehydrate | `AGENTS.md §REHYDRATE` |
| Wartość / zasadę projektu | `CONSTITUTION.md` |
| Imię/rolę/specjalizację avatara | `🅓_SYSTEM/AVATAR/Muaddib.md` |
| Bieżące zadanie | `🅒_NOW/CHECKLIST.md` |
| Trwałą decyzję | `🅒_NOW/DECISIONS.md` |
| Skill (istniejący) | `🅓_SYSTEM/SKILL/<nazwa>.md` |
| Nowy skill | `_TEMPLATE_SKILL.md` → kopia do `🅓_SYSTEM/SKILL/` |
| Wiedzę domenową | `🅓_SYSTEM/KNOWLEDGE/index.md` → skill Ingest |

## Rehydrate Protocol

**Komenda:** `rehydrate {{ALIAS_PROJEKTU}}`
**Po rehydrate:** STOP na statusie. `NEXT ACTION` ustala dopiero agent wykonujący `sync_state`.
