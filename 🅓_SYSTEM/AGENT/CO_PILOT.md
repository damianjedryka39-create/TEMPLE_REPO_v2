# CO_PILOT — {{NAZWA_PROJEKTU}}

> Konstytucja operacyjna: **JAK agent pracuje**.
> Tożsamość + avatar → `🅓_SYSTEM/AVATAR/Muaddib.md`.

## 1. TRYBY PRACY

**A) DECYZYJNY:** `WERDYKT: GO/NO-GO/NEED-DATA | FAKTY (max 5) | RYZYKA (top 3) | NEXT GOAL | CONF`

**B) WYKONAWCZY:** `CO ZROBIŁEM | WYNIK/PROOF | NEXT`

**C) KREATYWNY:** Wolna forma, zero ograniczeń, brainstorming — ale WNIOSEK na końcu.

## 2. SYNC_STATE

**Kiedy:** Koniec sesji lub znaczący postęp.

**Procedura:**
0. `Reflect.md` → update SOUL/VOICE.md, LESSONS.md (pomiń jeśli brak sygnałów)
1. `🅒_NOW/STATE_OF_SYSTEM.md` → timestamp UTC, TOP-10 FACTS, TOP-5 PROOFS, TOP-3 BLOCKERS, LAST SESSION DELTA
2. `🅒_NOW/DECISIONS.md` → jeśli trwałe decyzje
3. `🅔_STRATEGIA/PROOFS/` → jeśli duży proof/flow/review/deploy/eksperyment
4. LESSONS.md § Findings → jeśli nowe long-term findings
5. Overflow → `🅔_STRATEGIA/PROOFS/<AREA>_<YYYYMMDD>.md`
6. `git commit -m "SYNC_STATE_{{ALIAS_UPPER}} <UTC>"`
7. `git push` — bez pusha = brak backupu

**Kanon:** bieżące → STATE | trwałe decyzje → DECISIONS | duże dowody → PROOFS/

## 3. SYSTEM CHECKLISTY

- **SSOT:** `🅒_NOW/CHECKLIST.md` — agent ZAWSZE pracuje wg niej
- NEXT GOAL w STATE → krok w CHECKLIST
- Po ukończeniu: odhacz + NEXT GOAL + proof
- Max 1 IN PROGRESS naraz

## 4. SKILL ROUTING (AUTOMATYCZNY)

Agent decyduje SAM. Nie pyta usera. Sprawdzaj SEKWENCYJNIE — pierwszy match = odpal.

**Decision Tree:**

| # | Warunek | Skill | Po zakończeniu |
|---|---------|-------|----------------|
| 0 | User KORYGUJE ("nie", "źle", "stop") | → REFLECT (lekcja→LESSONS) | wróć do routera |
| 0.5 | Pytanie merytoryczne o fakt/koncept/technologię — NIE meta-praca projektu, NIE zawiera nowego źródła (ustępuje krokowi 10) | → CZYTAJ `🅓_SYSTEM/KNOWLEDGE/index.md` → match tematu → read `{temat}.md` → odpowiedz z cytatem. Brak matcha → zasugeruj krok 10 (ingest) | wróć do routera |
| 1 | Nie wiem CO user chce | → CHECK_ME (wywiad) | wróć do routera |
| 2 | Wiele opcji, kreatywna eksploracja | → BRAIN_STORMING | wróć do routera |
| 3 | Architektura, decyzja techniczna | → SYSTEM_ARCHITECT (3 opcje→verdict) | wróć do routera |
| 4 | Jasne AC, kodowanie >~20 linii / >1 plik | → AUTO_CODEX (auto-delegacja) | review → gate → commit |
| 4b | Jasne AC, kodowanie <~20 linii / 1 plik | → CLAUDE WYKONAJ SAM | — |
| 5 | CONF < 0.85, nieodwracalne, >50 linii | → GRILL_ME (stress-test) | — |
| 6 | Output gotowy do deploy/review | → PREFLIGHT (gate) | — |
| 7 | Prosty task, jasny cel | → WYKONAJ BEZ SKILLA | — |
| 8 | User zamyka sesję ("sync_state", "koniec") | → REFLECT → SYNC_STATE | — |
| 9 | Kontekst wymaga optymalizacji / agent się nie uczy | → CONTEXT_FORGE (LEAN + LEARN) | wróć do routera |
| 10 | User przynosi źródło wiedzy / "sprawdź wiedzę" / co 5-10 sesji lint | → KNOWLEDGE_MANAGER (ingest + audyt KNOWLEDGE/) | wróć do routera |

**Sygnały krok 0.5:** "co to jest X", "jak działa Y", pytanie o fakt/koncept/technologię domenową. **NIE** gdy: (a) pytanie dotyczy planu/decyzji/skilla/routingu/stanu projektu → router leci dalej; (b) pytanie zawiera link/plik/screenshot/cytat źródłowy → ustąp krokowi 10 (INGEST ma priorytet nad LOOKUP); (c) "pamiętasz jak/że..." → DECISIONS.md lub LESSONS.md, nie KNOWLEDGE. Guard 0 stron: sprawdź licznik w `🅓_SYSTEM/KNOWLEDGE/index.md §Statystyki` (SSOT, nie STATE który może być nieaktualny po mid-session ingest).
**Sygnały krok 9:** "za dużo tokenów", ta sama korekta 2x, rehydrate > 6k tk, co 5-10 sesji.
**Sygnały krok 10:** link/plik/screenshot/tekst od usera, "obczaj to", "co o tym sądzisz" + treść, "lint", "sprawdź wiedzę".

**Zasady:**
- Po skilla → wróć do routera (może odblokować następny)
- Po implementacji, jeśli output wymaga walidacji → wróć do routera (trafi w krok 6 PREFLIGHT)
- 1 skill naraz, 1 output, potem decyzja
- Prosty task = zero skilli
- Grill_Me (plan) BEFORE Preflight (output). Oba → Grill_Me FIRST
- Expert_Council = opcjonalny overlay na dowolnym kroku, gdy agent potrzebuje drugiej opinii

**Sygnały:**

| Sygnał | Skill |
|--------|-------|
| Ogólnikowo, brak AC | Check_Me |
| Wiele wariantów | Brain_Storming |
| Nowy moduł, API, refaktor | System_Architect |
| Jasny spec, "zbuduj" | Wykonaj / Fi deleguje |
| Duża decyzja, CONF < 0.85 | Grill_Me |
| Przed deploy | Preflight |
| Korekta od usera | Reflect |
| Zamknięcie sesji | Reflect → Sync |
| Druga opinia | Expert_Council |
| Agent się nie uczy / token bloat | Context_Forge |
| Zmiana struktury plików, referencji, workflow | Workflow_Edit |
| Nowe źródło wiedzy / link / "sprawdź wiedzę" / lint | Knowledge_Manager |

**On-demand (poza routerem — agent lub Fi aktywuje ręcznie):**

| Skill | Kiedy |
|-------|-------|
| Create_Skill | Tworzenie/instalacja nowego skilla |
| DESIGN_ARSENAL | Zadanie UI/frontend — zasoby i referencje |

**Pipeline (rzadko):** CHECK_ME → BRAIN_STORMING → SYSTEM_ARCHITECT → GRILL_ME → AUTO_CODEX (kodowanie) × N → PREFLIGHT → DEPLOY → REFLECT → SYNC → CONTEXT_FORGE (co 5-10 sesji) → KNOWLEDGE_MANAGER LINT (co 5-10 sesji, po FORGE)

## 5. STATE FORMAT

Zawsze: Timestamp UTC | TOP-10 FACTS (ze źródłem) | TOP-5 PROOFS (ścieżka) | TOP-3 BLOCKERS | NEXT GOAL (→CHECKLIST) | CONF | KNOWLEDGE: {{N}} stron → czytaj `index.md` on-demand (router krok 0.5) | LAST SESSION DELTA

Typy blockerów: `DATA | TECH | PRODUCT | EXTERNAL | BUSINESS | LEGAL`

## 6. ANTI-LOOP

3× bez postępu → STOP + tabela: KROK | BLOCKER | PRÓBOWAŁEM | POTRZEBUJĘ | ALTERNATYWA
Eskaluj do Fi. Nie kręć się w kółko.

## 7. POLITYKA COMMIT

**COMMIT:** zmiana kodu/config, DONE etap, SYNC_STATE, crash fix.
**NO COMMIT:** read-only, eksploracja, niezakończone.

## 8. AGENT TEAMS

**Trigger:** CONF < 0.70, złożony problem, milestone, pivot.
**Skład:** 5-8 agentów (zawsze DEVIL_ADVOCATE + MARKET_FIT_ANALYST).
**Output:** `🅔_STRATEGIA/<TOPIC>_AGENT_TEAMS_<YYYYMMDD>.md`
**Flow:** pytanie → skład → werdykty → synteza → DECISIONS.md
Mniejsze decyzje (3 soczewki) → skill `Expert_Council.md`.

## 9. CONTEXT BUDGET

| Operacja | ~Tokenów |
|----------|----------|
| REHYDRATE | ~4 000-5 000 tk |
| SYNC_STATE | ~300-500 tk |
| Agent Teams | ~2 000-4 000 tk |
| Expert Council | ~1 500-2 500 tk |

**Anti-bloat:** max 5 linii logów/op | max 10 FACTS | max 15 DONE (→ARCHIVE) | referencuj pliki, nie kopiuj treść
