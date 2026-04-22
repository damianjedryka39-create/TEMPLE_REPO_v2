---
version: 1.3
conf: 0.95
last_updated: 2026-04-22
phase: TEMPLE_REVIEW_FIX (PHASE A+B DONE → C blokowane DEC-3)
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
| — | (brak — PHASE A+B DONE sesja 13, awaiting sync_state commit) | — | — |

---

## NEXT (priorytet od góry)

### 🔴 BLOKADY — decyzje Fi wymagane

| # | Zadanie | Proof wymagany | Zależy od |
|---|---------|----------------|-----------|
| B6 | **R4:** STATE vs CHECKLIST SSOT — **DEC-1 wymagana**. Jeśli living-template: przenieś zadania z STATE.NEXT do CHECKLIST, STATE ma pointer. Jeśli pure-template: zanuluj oba. | STATE.NEXT = pointer ALBO CHECKLIST wypełniony konkretami zgodnymi z STATE | DEC-1 (B1) |
| B7 | **I3 VOICE.md** — **DEC-2 wymagana**. Jeśli CZĘŚĆ 2 wspólna: jawny komentarz w INIT.md "VOICE.md CZĘŚĆ 2 zostaje as-is". Jeśli per-projekt: wypełnij placeholderami + dodaj do sed | VOICE.md CZĘŚĆ 2 zgodna z decyzją | DEC-2 (B2) |

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
| 000 | **Sesja 13 — PHASE B COMPLETE (B4+B5+B8+B9+B10+B11)**: Silnik.md→pointer + PROOF historyczny. Frontmatter 13 skilli ujednolicony (`ecosystem: {{NAZWA_PROJEKTU}}` + `agents: [Claude]` wszędzie, Auto_Codex zostaje `[Claude, Codex]`). Muaddib §SUBAGENCI pointer do CO_PILOT §8. AGENTS.md SSOT merge 2→1 wiersza o Muaddib. CO_PILOT §1 TRYBY → przeniesione do VOICE.md §TRYBY ODPOWIEDZI; CO_PILOT zostawia 1-linijkowy pointer. Grep consistency: 3/3 pass. | 2026-04-22 | `🅓_SYSTEM/SKILL/*.md` (13 plików), `AGENTS.md`, `🅓_SYSTEM/AVATAR/Muaddib.md`, `🅓_SYSTEM/SOUL/VOICE.md`, `🅓_SYSTEM/AGENT/CO_PILOT.md` |
| 00 | **Sesja 13 — B4 DONE** (Silnik.md → 8-linijkowy pointer do AGENTS+CO_PILOT; sekcja PROBLEM wyniesiona do `🅔_STRATEGIA/PROOFS/AGENT_QUALITY_20260418.md` wraz z mapą D9-D14). Grep pass: 0 orphan refs. | 2026-04-22 | `🅐_OPIS/Silnik.md` (8 linii), `🅔_STRATEGIA/PROOFS/AGENT_QUALITY_20260418.md` |
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
> **Specjalne dla sesji 14+:** PHASE A+B DONE (sesje 11-13). Zostały tylko B6/B7 (BLOCKED na DEC-1/DEC-2) + PHASE C (BLOCKED na DEC-3) + propagacja do żywych projektów (C4). **L11:** handoff po DONE → od razu do CHECKLIST, nie do chatu. **L12:** język prosty (nie technożargon, nie wall-of-IDs) — Fi korygował 2× (2026-04-21 + 2026-04-22).
