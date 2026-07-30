---
version: 1.12
conf: 0.92
last_updated: 2026-07-30
phase: PB-1 + PB-2 DONE (sesja 19). NEXT: PB-3 (hooki v2) → PB-4 → PB-5 → C4 + K2
---

# CHECKLIST — TEMPLE_REPO_v2

> Jedyne źródło prawdy o aktualnej pracy. Agent ZAWSZE pracuje według tej checklisty.
> Pełen kontekst: `🅔_STRATEGIA/PROOFS/TEMPLE_REVIEW_20260421.md`.

---

## BLOCKED

| ID | Blocker | Typ | Zależy od | Od kiedy |
|----|---------|-----|-----------|----------|
| — | (brak — wszystkie trzy DEC rozstrzygnięte 2026-04-22: D15 living, D16 VOICE wspólna, D17 PHASE C REJECTED) | — | — | — |

---

## IN PROGRESS

| ID | Zadanie | Przypisany | Start |
|----|---------|-----------|-------|
| — | (brak — PHASE A+B DONE sesja 13, awaiting sync_state commit) | — | — |

---

## NEXT (priorytet od góry)

### 🔴 PB — pakiety napraw z audytu PROOF_BOOST (**ZATWIERDZONE przez Fi 2026-07-07, realizacja od sesji 19**)

> Instrukcja wykonawcza krok-po-kroku: **`🅔_STRATEGIA/PROOFS/PROOF_BOOST_PLAN_20260707.md`** (zasady z grilla + konkrety per pakiet). Dowody: `PROOF_BOOST_20260707.md` + `_findings.json`.

| # | Zadanie | Proof wymagany | Zależy od |
|---|---------|----------------|-----------|
| PB-3 | **Hooki v2** — kotwice wzorców (w tym: koniec `§ŻELAZNE` łapać na `^---`, nie na `## L1` — ustalenie z PB-2), warianty rm, toplevel-check git add, marker D22 hookiem, ślad Reflect, licznik cadence Forge (C7, C19-C23, C12) | HOOKS_V2: stare 16 + warianty PASS | PB-2 ✅ |
| PB-4 | **Rozwój Fi + router** — Reflect § „Wnioski dla Fi" + 8 skilli do CO_PILOT §4 + fix „skill Ingest" + metryka „domknięta od" przy L4/L12 (C15, C27, C28, C16) | grep 8 nazw w CO_PILOT ≥1 + demo Wniosków | PB-3 |
| PB-5 | **T1-T7 IMPROVE+INSIGHT** (zatwierdzone Fi 2026-07-07) — kontekst-przy-akcji, router 3 bramki, wersjonowanie core, cięcie placebo (T2: lista cięć do Fi PRZED), metryka uczenia, subagenci-czytacze, proof-driven → instrukcja: `PROOFS/PROOF_BOOST_PLAN_20260707.md §KOSZYK` | proof per T (wg planu), rehydrate ≤~3k po T1 | PB-4 |

### 🟢 OTWARTE (osobne sesje, nic nie blokuje)

| # | Zadanie | Proof wymagany | Zależy od |
|---|---------|----------------|-----------|
| C4 | **Propagacja PHASE A+B + D18 + D19 do żywych projektów** (GOFANS, MALING, MCP) — osobna sesja per-projekt. Zakres: frontmatter skilli, Muaddib §SUBAGENCI pointer, AGENTS.md SSOT merge, CO_PILOT §1 → VOICE, Silnik.md pointer, **+ Knowledge_Manager.md D18 typologia + propagation + zasady 10/11/12 + KNOWLEDGE/index.md refresh, + D19: sekcja LESSONS §⚡ ŻELAZNE + rehydrate 5→7 (LESSONS §ŻELAZNE + workspace MEMORY)**. | 3 commity SYNC_STATE w 3 projektach | — |
| K2 | Drugi ingest do KNOWLEDGE — TEST PROPAGATION flow (nowe źródło dotykające tematów `rag_vs_llm_wiki` / `karpathy_andrej` / `agent_oriented_engineering`, sprawdzić czy UPDATE istniejących + `times_refined++` działa) | log entry UPDATE w KNOWLEDGE/log.md + bumped `times_refined: 1` na min. 1 stronie | K1 DONE ✓ |

### ❌ REJECTED

**Decyzja Fi 2026-04-21 (L10 — Grill_Me preservation):**
- ~~R7: Merge Expert_Council w Grill_Me~~ → Grill_Me zostaje osobno
- ~~R8: Zmiana triggera Grill_Me (auto → manual-only, podniesienie progu)~~ → Trigger zostaje as-is
- ~~M6 skrócenie Grill_Me.md (142 → 80 linii)~~ → Plik zostaje as-is

**Decyzja Fi 2026-04-22 (D17 + L14 — nie chowaj narzędzi):**
- ~~C1 R6: Przeniesienie Context_Forge + Workflow_Edit do `🅔_STRATEGIA/PROCEDURY/`~~ → oba zostają w `🅓_SYSTEM/SKILL/`. Skill poza SKILL/ = skill którego router i Fi nie znajdą. Fi: "wywalenie do smieci".
- ~~C2 R9: CO_PILOT §4 dopisek Brain/Architect~~ → MINOR, do Context_Forge w przyszłości jak będzie realny sygnał
- ~~C3 R10: CO_PILOT §4 krok 0.5 guard `Statystyki=0 → skip cicho`~~ → MINOR, dodamy gdy KNOWLEDGE zacznie puchnąć

---

## BACKLOG

### IMPROVE+INSIGHT po PB (decyzja Fi per pozycja)
- [ ] T1-T7: propozycje ulepszeń workflow (kontekst-przy-akcji, cięcie placebo, router 3 bramki, wersjonowanie core, metryka uczenia, subagenci-czytacze, proof-driven) → `🅔_STRATEGIA/PROOFS/PROOF_BOOST_PLAN_20260707.md §KOSZYK IMPROVE`

### Minor (do Context_Forge w przyszłości)
- [ ] M2: `ask_user_input` vs `AskUserQuestion` — ujednolicić w Brain_Storming.md + Check_Me.md
- [ ] M5: D14 w DECISIONS.md — wynieś rationale do PROOF, w D14 zostaw 1 zdanie + pointer
- [ ] M7: Ujednolic frontmatter root files (AGENTS/CONSTITUTION/INIT/LESSONS — bez YAML; CHECKLIST/DECISIONS — z YAML)
- [ ] M8: Usuń pole `conf:` z frontmatterów szablonów (ROADMAP, OPIS_PROJEKTU) — bez sensu dla niewypełnionego pliku
- [ ] M9: Karpathy_Radek.md — dopisz wiersz tabeli o warstwie KNOWLEDGE/ (drift po D12)

### KNOWLEDGE layer — po PHASE A+B
- [ ] Pierwszy ingest do `🅓_SYSTEM/KNOWLEDGE/` (np. tweet Kacpra, kanonowy artykuł)
- [ ] Test routera krok 0.5 end-to-end (pytanie o fakt z ingested strony)

### Decyzje rozstrzygnięte 2026-04-22 (DEC)
- [x] ~~DEC-1: TEMPLE_REPO_v2 living-template vs pure~~ → **D15 LIVING** (2026-04-22)
- [x] ~~DEC-2: VOICE.md CZĘŚĆ 2 wspólna vs per-projekt~~ → **D16 WSPÓLNA** (2026-04-22)
- [x] ~~DEC-3: Czy wdrażać PHASE C debloat~~ → **D17 REJECTED** (2026-04-22, L14)

---

## DONE (ostatnie 15)

> Pełna treść wpisów (opisy sesji, rationale) → `🅖_ARCHIVE/CHECKLIST_DONE_2026q2.md`. Tu 1 linia + proof.

| # | Zadanie | Data | Proof |
|---|---------|------|-------|
| S19b | PB-2 odchudzanie — rehydrate **9.8k → 6.3k tk** (−36%); DONE i rationale do `🅖_ARCHIVE/`, zmierzone liczby wpisane do AGENTS/CO_PILOT/STATE. Move, nie delete | 2026-07-30 | `PROOFS/FORGE_REPORT_20260730.md` |
| S19 | PB-1 fork-safety — INIT odcina `.git`, Krok 5.5 resetuje pamięć forka, bramki `[ ! -d .git ]`. Blocker „zakaz forkowania" zamknięty | 2026-07-30 | `PROOFS/FORK_TEST_20260730.md` |
| S18 | PROOF_BOOST — nowy skill + pierwszy audyt (30 potwierdzonych / 3 obalone, werdykt ŻÓŁTY, grill 7/7 GO) | 2026-07-07 | `PROOFS/PROOF_BOOST_20260707.md` |
| S17 | Forma odpowiedzi (ŻELAZNE #1 wzorzec wizualny) + brainstorm „workflow vs natywny Claude" → werdykt „uprząż nie kaftan" | 2026-05-29 | `PROOFS/WORKFLOW_VS_CLAUDE_20260529.md` |
| S16 | D22 czujka urwanej sesji (marker `.session_active`) + D23 warstwa wiedzy: ZAGĘSZCZAJ nie tnij | 2026-05-29 | `DECISIONS.md` D22+D23 |
| S15c | D21 hooki egzekwujące — pakiet 6 strażników w `.claude/`, 16/16 testów | 2026-05-29 | `PROOFS/HOOKS_AUDIT_20260529.md` |
| S15b | D20 split: Muaddib = tożsamość, WORKFLOW.md = model myślenia. Rehydrate 7→8 | 2026-05-29 | `DECISIONS.md` D20 |
| S15a | D19 LESSONS §⚡ŻELAZNE + workspace MEMORY do rehydrate (5→7) | 2026-05-29 | `DECISIONS.md` D19 |
| S14b | K1 pierwszy ingest do KNOWLEDGE (4 strony) — blocker zamknięty | 2026-05-28 | `🅓_SYSTEM/KNOWLEDGE/` |
| S14a | D18 Knowledge_Manager — typologia 4 typów stron + propagation + `times_refined` | 2026-05-28 | `DECISIONS.md` D18 |
| S13d | REPOSITORIES/ + 7 audytów zewnętrznych repo + 5 nowych skilli (15→20) + L16 „audyt ≠ adopcja" | 2026-04-25 | `REPOSITORIES/*/_AUDIT.md`, `LESSONS.md` L16 |
| S13c | Skille Hooks_Audit + Prompt_Master (13→15) + L15 (`git add -A` po toplevel check) | 2026-04-22 | `LESSONS.md` L15 |
| S13b | 3 decyzje Fi: D15 living-template, D16 VOICE wspólna, D17 PHASE C REJECTED + L14 | 2026-04-22 | `DECISIONS.md` D15-D17 |
| S13a | PHASE B COMPLETE (B4+B5+B8+B9+B10+B11) — frontmatter 13 skilli, SSOT merge, CO_PILOT §1 → VOICE | 2026-04-22 | `AGENTS.md`, `CO_PILOT.md` |
| S12 | SYNC_STATE + L11 (handoff do CHECKLIST, nie do chatu) | 2026-04-21 | `LESSONS.md` L11 |
| S11 | PHASE A COMPLETE (A1-A7) — Auto_Codex rename + INIT.md pełny rewrite | 2026-04-21 | `INIT.md` |
| — | **Sesje 10 i starsze** (audyt TEMPLE, router 0.5, Auto_Codex redesign, Knowledge Pocket, konsolidacja root files, Muaddib merge) | 2026-04-18/21 | `🅖_ARCHIVE/CHECKLIST_DONE_2026q2.md` |

## Zasady dla agentów

> Pełne zasady → `CO_PILOT.md` §3. Kluczowe: CHECKLIST IS KING, max 1 IN PROGRESS, PROOF = DONE.
> **Specjalne dla sesji 14+:** Szablon DOMKNIĘTY (PHASE A+B DONE, PHASE C REJECTED przez D17). Zostaje tylko C4 propagacja do żywych projektów (osobne sesje per-projekt) + K1 pierwszy ingest do KNOWLEDGE. **L11:** handoff po DONE → CHECKLIST, nie chat. **L12:** język prosty (2×). **L14:** nie chowaj narzędzi przed agentem — skill poza `SKILL/` = skill którego router nie znajdzie.
