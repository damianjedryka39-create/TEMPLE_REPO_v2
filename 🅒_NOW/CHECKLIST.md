---
version: 1.6
conf: 0.98
last_updated: 2026-04-25
phase: TEMPLE_SZABLON_DOMKNIĘTY + REPOSITORIES system + 20 skilli (5 nowych z 5 audytów, sesja 13 cz.4). Zostaje C4 propagacja + K1 ingest
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

### 🟢 OTWARTE (osobne sesje, nic nie blokuje)

| # | Zadanie | Proof wymagany | Zależy od |
|---|---------|----------------|-----------|
| C4 | **Propagacja PHASE A+B do żywych projektów** (GOFANS, MALING, MCP) — osobna sesja per-projekt. Zakres: frontmatter skilli, Muaddib §SUBAGENCI pointer, AGENTS.md SSOT merge, CO_PILOT §1 → VOICE, Silnik.md pointer. | 3 commity SYNC_STATE w 3 projektach | — |
| K1 | Pierwszy ingest do `🅓_SYSTEM/KNOWLEDGE/` (test routera krok 0.5 end-to-end) | strona w KNOWLEDGE + udany lookup | — |

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

| # | Zadanie | Data | Proof |
|---|---------|------|-------|
| 000000 | **Sesja 13 cz.4 — REPOSITORIES system + 5 audytów + 5 adopcji + L16 ŻELAZNA**: top-level `REPOSITORIES/` z konwencją (`_AUDIT.md`, czytaj README/SKILL, fork-exclude w INIT). 7 audytów: prompt-master🟢→Prompt_Master, awesome-claude-code🔴 usunięty (Fi: nie korzystamy), everything-claude-code🟡 INSPIRATION, lightrag🟡, obsidian-skills🟢→3 wrappery, n8n-mcp🟡, ui-ux-pro-max🟢→UI_UX_Pro_Max. 5 nowych skilli: Code_Reviewer/Defuddle/Obsidian_Markdown/JSON_Canvas/UI_UX_Pro_Max (15→20). L16 (🔴 ŻELAZNA): "Audyt ≠ adopcja. Werdykt 🟢 USED to REKOMENDACJA, NIE zgoda" — incydent ui-ux-pro-max (agent zaadoptował automatycznie, Fi wybuchł). Pamięć: feedback_audyty_lekkie + feedback_audyt_nie_adopcja. | 2026-04-25 | commits `1af29c5..bb6941d` (TEMPLE pushed) + `4015b31..ab4f2f1` (GOFANS lokalnie); LESSONS L16; `REPOSITORIES/*/_AUDIT.md` |
| 00000 | **Sesja 13 cz.3 — 2 nowe skille on-demand + L15**: Hooks_Audit (audyt hooków, 7 szablonów JSON), Prompt_Master (wrapper na external/prompt-master MIT v1.5.0, 30+ AI tooli). AGENTS.md 13→15 skilli. Propagacja do GOFANS (commit lokalny). L15 ŻELAZNA: "git add -A zawsze sprawdź git rev-parse --show-toplevel" — incydent commitu do outer GOFANS zamiast TEMPLE, naprawiony przez revert+checkout+reset. | 2026-04-22 | commits `8e5e378`, `cb1c260` (TEMPLE) + `0be061e`, `12346c2` (GOFANS lokalnie); LESSONS.md L15 |
| 0000 | **Sesja 13 — 3 DECYZJE FI + ZAMKNIĘCIE SZABLONU**: D15 (TEMPLE = living-template), D16 (VOICE.md CZĘŚĆ 2 wspólna) + dopisek w INIT.md §4 pkt 8, D17 (PHASE C REJECTED — Context_Forge + Workflow_Edit zostają w SKILL/). L14 w LESSONS: nie rekomenduj ruchów które chowają narzędzia przed agentem. | 2026-04-22 | `DECISIONS.md` D15+D16+D17, `LESSONS.md` L14, `INIT.md` §4 pkt 8 |
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
> **Specjalne dla sesji 14+:** Szablon DOMKNIĘTY (PHASE A+B DONE, PHASE C REJECTED przez D17). Zostaje tylko C4 propagacja do żywych projektów (osobne sesje per-projekt) + K1 pierwszy ingest do KNOWLEDGE. **L11:** handoff po DONE → CHECKLIST, nie chat. **L12:** język prosty (2×). **L14:** nie chowaj narzędzi przed agentem — skill poza `SKILL/` = skill którego router nie znajdzie.
