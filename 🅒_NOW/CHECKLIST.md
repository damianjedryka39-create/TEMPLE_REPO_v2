---
version: 1.2
conf: 0.92
last_updated: 2026-04-21
phase: TEMPLE_REVIEW_FIX (PHASE A DONE → B → C)
---

# CHECKLIST — TEMPLE_REPO_v2

> Jedyne źródło prawdy o aktualnej pracy. Agent ZAWSZE pracuje według tej checklisty.
> Pełen kontekst: `🅔_STRATEGIA/PROOFS/TEMPLE_REVIEW_20260421.md`.

---

## BLOCKED

| ID | Blocker | Typ | Zależy od | Od kiedy |
|----|---------|-----|-----------|----------|
| B1 | PHASE B R4 (STATE vs CHECKLIST SSOT) — czeka na DEC-1 (living vs pure template) | PRODUCT | Fi decyzja | 2026-04-21 |
| B2 | PHASE B I3 (VOICE.md CZĘŚĆ 2) — czeka na DEC-2 (wspólne vs per-projekt) | PRODUCT | Fi decyzja | 2026-04-21 |
| B3 | PHASE C (debloat Context_Forge + Workflow_Edit) — czeka na DEC-3 | PRODUCT | Fi decyzja | 2026-04-21 |

---

## IN PROGRESS

| ID | Zadanie | Przypisany | Start |
|----|---------|-----------|-------|
| — | (brak — PHASE A DONE w sesji 11, awaiting sync_state) | — | — |

---

## NEXT (priorytet od góry)

### 🟡 PHASE B — IMPORTANT drift (~40-60 min, start TERAZ)

| # | Zadanie | Proof wymagany | Zależy od |
|---|---------|----------------|-----------|
| B4 | **R3:** 🅐_OPIS/Silnik.md — przepisz do 1-zdaniowego pointera `→ AGENTS.md + CO_PILOT.md` lub zaktualizuj zgodnie z D11+D14+D10+D13+D12. Sekcję PROBLEM wynieś do `🅔_STRATEGIA/PROOFS/AGENT_QUALITY_20260418.md` | Silnik.md < 30 linii ALBO kompletny zgodny z aktualnym routerem | PHASE A done |
| B5 | **R5:** Ujednolic frontmatter 13 skilli — `ecosystem: {{NAZWA_PROJEKTU}}` wszędzie + usuń/ustanów `agents:` jednolicie. Dodaj `{{NAZWA_PROJEKTU}}` do sed w INIT.md | `grep -l "ecosystem: TEMPLE_REPO" SKILL/*.md` zwraca 0 | A3 |
| B6 | **R4:** STATE vs CHECKLIST SSOT — **DEC-1 wymagana**. Jeśli living-template: przenieś zadania z STATE.NEXT do CHECKLIST, STATE ma pointer. Jeśli pure-template: zanuluj oba. | STATE.NEXT = pointer ALBO CHECKLIST wypełniony konkretami zgodnymi z STATE | DEC-1 (B1) |
| B7 | **I3 VOICE.md** — **DEC-2 wymagana**. Jeśli CZĘŚĆ 2 wspólna: jawny komentarz w INIT.md "VOICE.md CZĘŚĆ 2 zostaje as-is". Jeśli per-projekt: wypełnij placeholderami + dodaj do sed | VOICE.md CZĘŚĆ 2 zgodna z decyzją | DEC-2 (B2) |
| B8 | **I4 Muaddib.md §SPECJALIZACJA** — dopisz cross-link do CO_PILOT §8 w §SUBAGENCI (M10) | Muaddib.md §SUBAGENCI ma pointer | — |
| B9 | **I5 AGENTS.md SSOT tabela** — zmerguj 2 wiersze o Muaddib (tożsamość + avatar) w jeden | AGENTS.md §SSOT ma unikalne tematy | — |
| B10 | **I6 CO_PILOT §1 TRYBY PRACY** — rozważ przeniesienie do VOICE.md §STRUKTURA ODPOWIEDZI albo zostaw z pointerem | decyzja zapisana w DECISIONS + implementacja | — |
| B11 | **WERYFIKACJA PHASE B:** grep consistency (TEMPLE_REPO zombie, STATE pointer do CHECKLIST, frontmatter jednolity) | trzy grep'y pass | B4-B10 |

### 🟢 PHASE C — Debloat (opcjonalne, ~2-3h, osobna sesja)

| # | Zadanie | Proof wymagany | Zależy od |
|---|---------|----------------|-----------|
| C1 | **R6:** `git mv 🅓_SYSTEM/SKILL/Context_Forge.md 🅔_STRATEGIA/PROCEDURY/` + analogicznie Workflow_Edit. Update CO_PILOT §4 (usuń krok 9 Context_Forge z routera lub zmień na on-demand). Update AGENTS.md §SKILLe tabela | 11 skilli w SKILL/, 2 procedury w PROCEDURY/. AGENTS.md §SKILLe = 11 wierszy | DEC-3 (B3) |
| C2 | **R9:** CO_PILOT §4 krok 2-3 — dopisek "Brain_Storming gdy JAKI/CO, System_Architect gdy JAK. Oba → Brain pierwszy" | CO_PILOT §4 zawiera dopisek | PHASE B done |
| C3 | **R10:** CO_PILOT §4 krok 0.5 — guard `jeśli Statystyki = 0 → skip krok 0.5 cicho` | CO_PILOT §4 krok 0.5 zawiera guard | PHASE B done |
| C4 | **Propagacja PHASE A+B do żywych projektów** (GOFANS, MALING, MCP) — osobna sesja per-projekt | 3 commity SYNC_STATE w 3 projektach | PHASE B done |

### ❌ REJECTED (decyzja Fi 2026-04-21 — L10)

- ~~R7: Merge Expert_Council w Grill_Me~~ → Grill_Me zostaje osobno
- ~~R8: Zmiana triggera Grill_Me (auto → manual-only, podniesienie progu)~~ → Trigger zostaje as-is
- ~~M6 skrócenie Grill_Me.md (142 → 80 linii)~~ → Plik zostaje as-is

---

## BACKLOG

### Minor (do Context_Forge w przyszłości)
- [ ] M2: `ask_user_input` vs `AskUserQuestion` — ujednolicić w Brain_Storming.md + Check_Me.md
- [ ] M5: D14 w DECISIONS.md — wynieś rationale do PROOF, w D14 zostaw 1 zdanie + pointer
- [ ] M7: Ujednolic frontmatter root files (AGENTS/CONSTITUTION/INIT/LESSONS — bez YAML; CHECKLIST/DECISIONS — z YAML)
- [ ] M8: Usuń pole `conf:` z frontmatterów szablonów (ROADMAP, OPIS_PROJEKTU) — bez sensu dla niewypełnionego pliku
- [ ] M9: Karpathy_Radek.md — dopisz wiersz tabeli o warstwie KNOWLEDGE/ (drift po D12)

### KNOWLEDGE layer — po PHASE A+B
- [ ] Pierwszy ingest do `🅓_SYSTEM/KNOWLEDGE/` (np. tweet Kacpra, kanonowy artykuł)
- [ ] Test routera krok 0.5 end-to-end (pytanie o fakt z ingested strony)

### Decyzje otwarte (DEC)
- [ ] DEC-1: TEMPLE_REPO_v2 = living-template vs pure-template (blokuje B6/R4)
- [ ] DEC-2: VOICE.md CZĘŚĆ 2 — wspólna dla wszystkich projektów czy per-projekt (blokuje B7/I3)
- [ ] DEC-3: Czy wdrażać PHASE C debloat (Context_Forge + Workflow_Edit do PROCEDURY) (blokuje C1/C2/C3)

---

## DONE (ostatnie 15)

| # | Zadanie | Data | Proof |
|---|---------|------|-------|
| 0 | **Sesja 12 — SYNC_STATE_TEMPLE_V2 (S1-S5)**: Reflect → L11 (handoff do CHECKLIST) + STATE bump (FACT #2 drift CLOSED, #7 L11, #10 sesja 11+12, BLOCKER reformułowany, CONF 0.90→0.92) + commit + push | 2026-04-21 | `git log -1`, ten sync |
| 0a | **Sesja 11 — PHASE A COMPLETE (A1-A7)**: Task_Codex→Auto_Codex rename + INIT.md pełny rewrite (TEMPLE_REPO_v2 paths, §2 13 parametrów, §3 Krok 2 bash vars + 17 placeholderów) | 2026-04-21 | `git log -1`, `grep "{{" /tmp/temple_fork_test` = 0 dla §2 (14 placeholderów), Auto_Codex.md istnieje |
| 1 | Sesja 10 — pełny audyt TEMPLE_REPO_v2 (code-review + explore + self-Grill_Me) | 2026-04-21 | `🅔_STRATEGIA/PROOFS/TEMPLE_REVIEW_20260421.md` |
| 2 | L10 w LESSONS.md — Grill_Me preservation rule | 2026-04-21 | `LESSONS.md` L10 |
| 3 | Plan fixów PHASE A/B/C + REJECTED wariantów zapisany | 2026-04-21 | PROOF TEMPLE_REVIEW + ten CHECKLIST |
| 4 | STATE_OF_SYSTEM — pointer do PROOF + nowy NEXT | 2026-04-21 | `🅒_NOW/STATE_OF_SYSTEM.md` |
| 5 | Sesja 9 — Router krok 0.5 (KNOWLEDGE lookup) + D14 | 2026-04-21 | CO_PILOT.md:46, DECISIONS D14 |
| 6 | Sesja 8 — Auto_Codex redesign + D13 | 2026-04-19 | DECISIONS D13 |
| 7 | Sesja 7 — Refaktor skilli (Ingest+Lint → Knowledge_Manager), 14→13 skilli | 2026-04-19 | AGENTS.md |
| 8 | Sesja 6 — Knowledge Pocket (KNOWLEDGE/ folder + D12) | 2026-04-19 | DECISIONS D12 |
| 9 | Sesja 5 — Root files consolidation (INDEX→AGENTS, MEMORY→LESSONS) + D9 | 2026-04-18 | DECISIONS D9 |
| 10 | Sesja 4 — MIND+AVATAR → Muaddib.md + D11 | 2026-04-18 | DECISIONS D11 |

---

## Zasady dla agentów

> Pełne zasady → `CO_PILOT.md` §3. Kluczowe: CHECKLIST IS KING, max 1 IN PROGRESS, PROOF = DONE.
> **Specjalne dla sesji 13+:** SYNC_STATE (sesje 10+11) zamknięty w sesji 12. Start od PHASE B (B4/B5/B8-B10 niezależne; B6/B7 BLOCKED na DEC-1/DEC-2). PHASE C czeka na DEC-3. **L11:** handoff po DONE → od razu do CHECKLIST, nie do chatu.
