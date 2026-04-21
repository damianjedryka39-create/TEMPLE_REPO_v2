# PROOF — TEMPLE_REPO_v2 Consistency & Over-Engineering Review

Data: 2026-04-21
Obszar: Meta / Szablon / Audit
Plik główny: `/root/GOFANS-NEOVERSE/TEMPLE_REPO_v2/` (cały szablon)

---

## CEL

Pełny audyt szablonu TEMPLE_REPO_v2 przed kolejnym forkiem do nowego projektu lub propagacją zmian do żywych projektów (GOFANS/MALING/MCP). Zweryfikować: (a) spójność referencji / SSOT / dead refs, (b) over-engineering / efektywność routera + 13 skilli, (c) czy szablon jest prop pod next projects.

Trigger: Fi zapytał wprost "czy wszystko zsynchronizowane, czy nie ma przecieku, czy to TIP TOP" + "Posłuż się Grill_Me na końcu: czy to nie over-engineering".

## ZAKRES SESJI

- Code-review subagent (superpowers:code-reviewer) — audyt referencyjny wszystkich plików .md szablonu
- Explore subagent (thorough) — audyt routera + inwentaryzacja 13 skilli + budżet tokenów
- Self Grill_Me (7 kategorii COVERAGE TRACKER) — stress-test całości pod kątem "ready-to-fork"
- Synteza trzech źródeł + priorytyzacja (CRITICAL / IMPORTANT / MINOR)

## STAN KOŃCOWY

**VERDICT: 🟡 ŻÓŁTY | CONF: 0.72 | GO-AFTER-FIX**

Szablon jest w 80% solidny (router, 3-warstwa pamięci, SSOT tabela, D14 audit trail). Ale **3 CRITICAL blokują bezpieczny fork** + **~7 IMPORTANT drift** + **kandydaci do cięcia (z wyłączeniem Grill_Me)**.

**Korekta Fi (2026-04-21):** Grill_Me **nie uszczuplać** — ani plik, ani trigger w routerze, ani merge z Expert_Council. Zostaje as-is. Patrz L10 w LESSONS.md.

---

## KLUCZOWE DECYZJE (do podjęcia w następnej sesji)

- **DEC-1:** TEMPLE_REPO_v2 = living-template (ma własny STATE z zadaniami pracy nad samym TEMPLE) vs pure-template (STATE też szablon, prace żyją gdzie indziej). Rzutuje na I2.
- **DEC-2:** VOICE.md CZĘŚĆ 2 (tone wobec świata) — wspólna dla wszystkich projektów czy per-projekt. Rzutuje na I3.
- **DEC-3:** Czy wdrażać PHASE C (debloat) — cięcia Context_Forge + Workflow_Edit ze SKILL/. **Grill_Me + Expert_Council zostają osobno** (decyzja Fi).

---

## PLAN FIXÓW — dla następnego agenta

### PHASE A — CRITICAL (15-20 min, blokują fork)

#### R1 — Rename Task_Codex → Auto_Codex
**Problem:** Fizyczny plik to `🅓_SYSTEM/SKILL/Task_Codex.md` (frontmatter: `name: Auto_Codex`). AGENTS.md, CO_PILOT.md §4 krok 4, DECISIONS D13, STATE FACTS #2/#4/#5, PROOFS #4 — wszystkie wskazują `Auto_Codex.md`. Glob `SKILL/*.md` NIE znajdzie `Auto_Codex.md`.
**Fix:**
```bash
cd /root/GOFANS-NEOVERSE/TEMPLE_REPO_v2
git mv "🅓_SYSTEM/SKILL/Task_Codex.md" "🅓_SYSTEM/SKILL/Auto_Codex.md"
```
Plus: grep `Task_Codex` po całym repo, usuń pozostałe wzmianki poza LESSONS.md L5 (ma tam historyczny kontekst).

#### R2 — Fix INIT.md: dead paths + brakujące placeholdery
**Problem A (C2):** INIT.md linie 9, 46, 182 mają `/root/GOFANS-NEOVERSE/TEMPLE_REPO/` (v1, usunięty). Workflow_Edit.md linie 49, 50, 116, 117, 133 — podobnie.
**Fix A:** Zamień `TEMPLE_REPO/` → `TEMPLE_REPO_v2/` globalnie w INIT.md. W Workflow_Edit.md zmień na placeholder `<TEMPLATE_ROOT>` (bo to przykład grep'a, nie komenda fork).

**Problem B (C3):** sed w INIT.md §3 Krok 2 nie obsługuje: `{{POZIOM}}`, `{{DATA_YYYY-MM-DD}}`, `{{FAZA}}`, `{{OWNER}}`, `{{Specjalizacja 1/2/3}}` (te ostatnie w Muaddib.md §SPECJALIZACJA). Reguła weryfikacji "grep `{{` = 0" zawsze failuje.
**Fix B:** (i) dodaj te placeholdery do listy sed w INIT.md, (ii) poszerz §2 o 13. punkt `SPECJALIZACJA_AVATARA` (3 bullety), (iii) przepisz komendę sed tak by używała bash vars (`${ALIAS_UPPER}`), nie literalnych `<ALIAS_UPPER>` (M3), (iv) usuń `AGENTS1.md` z `rm -f` linii 48 (plik nie istnieje — M1).

### PHASE B — IMPORTANT drift (40-60 min, zapobiega propagacji błędów do żywych projektów)

#### R3 — Przepisz lub usuń 🅐_OPIS/Silnik.md (I1)
**Problem:** Silnik.md jest z pre-sesji 5 (mówi o 6 plikach rehydrate, brak kroków 0.5/4b/9/10 w routerze, `STATE.md` zamiast `STATE_OF_SYSTEM.md`, sekcja PROBLEM to wolny esej z sesji retrospektywnej — nie opis silnika).
**Fix:** Jedna z dwóch ścieżek:
- (a) Skrócić do 1 zdania: "Silnik opisany w `AGENTS.md` + `🅓_SYSTEM/AGENT/CO_PILOT.md`." Plus pointery do aktualnych sekcji.
- (b) Przepisać zgodnie z D11 (5 plików) + D14 (krok 0.5) + D10/D13 (Auto_Codex krok 4/4b) + D12 (KNOWLEDGE krok 10). Sekcję PROBLEM wynieść do `🅔_STRATEGIA/PROOFS/AGENT_QUALITY_20260418.md`.

#### R4 — STATE vs CHECKLIST SSOT (I2) — wymaga DEC-1
**Problem:** STATE.§NEXT ma konkretne zadanie "ingest tweeta Kacpra"; CHECKLIST jest 100% placeholderami. AGENTS.md §SSOT mówi "bieżące zadania → CHECKLIST". Naruszona hierarchia.
**Fix (po DEC-1):**
- Jeśli living-template: przenieś zadania z STATE.NEXT do CHECKLIST.NEXT, w STATE zostaw pointer `→ CHECKLIST`. Wypełnij CHECKLIST §NEXT + §IN PROGRESS zgodnie z pracami nad TEMPLE.
- Jeśli pure-template: zanuluj STATE.NEXT (placeholder), zanuluj CHECKLIST (placeholder), prace nad TEMPLE żyją w osobnym `TEMPLE_DEV/` working branchu lub issue trackerze.

#### R5 — Ujednolic frontmatter skilli (I8 + I9)
**Problem:** 7 skilli ma `ecosystem: TEMPLE_REPO` (zombie v1), 1 ma `{{NAZWA_PROJEKTU}}`, 5 nie ma w ogóle. `agents:` pole: 3 warianty + brak. STATE sesji 7 twierdzi "wszystkie ujednolicone" — false.
**Fix:**
```yaml
# Kanon frontmatter skilla (po forku sed podmieni {{NAZWA_PROJEKTU}}):
---
name: <skill_name>
trigger: <regex>
purpose: <one-liner>
output: <format>
cross_link: [<skill>.md, ...]
ecosystem: {{NAZWA_PROJEKTU}}
---
```
Usuń pole `agents:` (lub ustaw `agents: [Claude]` jednolicie). Dodaj `{{NAZWA_PROJEKTU}}` do listy placeholderów sed w INIT.md.

### PHASE C — Debloat (2-3h, osobna sesja, opcjonalne — wymaga DEC-3)

#### R6 — Przenieś Context_Forge + Workflow_Edit ze SKILL/ do 🅔_STRATEGIA/PROCEDURY/
**Rationale:** Oba to meta-procedury (optymalizacja kontekstu co 5-10 sesji, edycja struktury workflow). W świeżym szablonie = martwy kod. Agent w żywym projekcie odpala je rzadko.
**Fix:** `git mv` do `🅔_STRATEGIA/PROCEDURY/`. Update CO_PILOT §4 (usuń krok 9 Context_Forge z routera lub zmień na "on-demand, nie auto"). Update AGENTS.md §SKILLe (usuń z tabeli, zostaw w §Advanced). **Save:** ~420 linii.

#### R9 — CO_PILOT §4 — disambiguate Brain_Storming vs System_Architect
**Rationale:** Oba się odpalają na "zaprojektuj X". Agent zgaduje który pierwszy.
**Fix:** Dopisek w CO_PILOT §4 krok 2-3:
> "Brain_Storming = gdy user pyta **JAKI/CO** (kreatywne warianty, decyzja produktowa). System_Architect = gdy user pyta **JAK** (architektura, decyzja techniczna). Oba → Brain_Storming pierwszy, potem Architect."

#### R10 — Router krok 0.5 guard: skip gdy KNOWLEDGE puste
**Rationale:** Świeży fork ma 0 stron w KNOWLEDGE. Lookup zawsze failuje → propozycja ingest której user nie prosił. Ceremonia na pustym stole.
**Fix:** CO_PILOT §4 krok 0.5 dodaj:
> "Guard: jeśli `🅓_SYSTEM/KNOWLEDGE/index.md §Statystyki` pokazuje `Stron: 0` — skip krok 0.5 cicho, idź do kroku 1. Nie proponuj ingest."

### ❌ REJECTED (odrzucone przez Fi)

- ~~R7 — Merge Expert_Council w Grill_Me~~ → **Grill_Me zostaje osobno, Expert_Council zostaje osobno.**
- ~~R8 — Zmiana triggera Grill_Me na manual-only~~ → **Trigger zostaje jak jest (CONF<0.85, >50 linii).**
- ~~Skrócenie pliku Grill_Me.md z 142 do 80 linii~~ → **Plik zostaje as-is.**

Powód: L10 w LESSONS.md (Grill_Me preservation rule).

---

## MINOR (kosmetyka, do Context_Forge w przyszłości)

| # | Plik | Problem | Fix |
|---|------|---------|-----|
| M1 | INIT.md:48 | `rm -f INIT.md AGENTS1.md` — AGENTS1.md nie istnieje | Usuń `AGENTS1.md` |
| M2 | Brain_Storming.md:62 vs Check_Me.md:23 | `ask_user_input` vs `AskUserQuestion` — dwa API | Ujednolicić |
| M3 | INIT.md:75-85 | sed z literalnym `<ALIAS_UPPER>` — niejasne | Przepisz na bash vars |
| M5 | DECISIONS.md:30 | D14 jest 1200-znakową linią tabeli | Wynieś rationale do PROOFS, w D14 1 zdanie + pointer |
| M6 | Grill_Me.md | Podwójne puste linie (kopiowanie z PDF?) | Formatter (**uwaga: nie edytuj treści**) |
| M7 | Wszystkie root files | Niespójny frontmatter (część ma, część nie) | Decyzja + unifikacja |
| M8 | ROADMAP.md + OPIS_PROJEKTU.md | `conf:` w frontmatterze szablonu bez sensu | Usuń pole z szablonu |
| M9 | Karpathy_Radek.md:80-86 | Tabela nie wymienia KNOWLEDGE/ (drift po D12) | Dopisz wiersz |
| M10 | Muaddib.md:60-66 | §SUBAGENCI bez cross-linka do CO_PILOT §8 | Dopisz pointer |

---

## POWIĄZANE PLIKI (absolute paths, do otwarcia przy fix)

- `/root/GOFANS-NEOVERSE/TEMPLE_REPO_v2/🅓_SYSTEM/SKILL/Task_Codex.md` — R1 rename
- `/root/GOFANS-NEOVERSE/TEMPLE_REPO_v2/INIT.md` — R2 (C2+C3+M1+M3+I4)
- `/root/GOFANS-NEOVERSE/TEMPLE_REPO_v2/🅐_OPIS/Silnik.md` — R3
- `/root/GOFANS-NEOVERSE/TEMPLE_REPO_v2/🅒_NOW/STATE_OF_SYSTEM.md` + `🅒_NOW/CHECKLIST.md` — R4 (po DEC-1)
- `/root/GOFANS-NEOVERSE/TEMPLE_REPO_v2/🅓_SYSTEM/SOUL/VOICE.md` — I3 (po DEC-2)
- `/root/GOFANS-NEOVERSE/TEMPLE_REPO_v2/🅓_SYSTEM/AVATAR/Muaddib.md` — I4 + I6 + M10
- `/root/GOFANS-NEOVERSE/TEMPLE_REPO_v2/AGENTS.md` — I5 dedup SSOT tabeli
- `/root/GOFANS-NEOVERSE/TEMPLE_REPO_v2/🅓_SYSTEM/SKILL/*.md` (13 plików) — R5 frontmatter unification
- `/root/GOFANS-NEOVERSE/TEMPLE_REPO_v2/🅓_SYSTEM/SKILL/Workflow_Edit.md` — I1 partial + R6 (move)
- `/root/GOFANS-NEOVERSE/TEMPLE_REPO_v2/🅔_STRATEGIA/Karpathy_Radek.md` — M9

---

## PROOF / DOWÓD (co to potwierdza)

1. **Code-review raport** — 3 CRITICAL + 10 IMPORTANT + 10 MINOR, z cytatami linii. Przeczytany w pełni, verdykt: `NEEDS_FIX` przed fork.
2. **Explore raport** — 13 skilli inventory + router analysis + rehydrate budget (realny szacunek 3.5-4k tk zgodny z deklaracją AGENTS.md).
3. **Self Grill_Me** — 7 kategorii pokrytych (ZAŁOŻENIA, EDGE CASES, ZALEŻNOŚCI, ALTERNATYWY, RYZYKA, KOSZTY, REVERSIBILITY), CONF 0.72, werdykt ŻÓŁTY.
4. **Trzy niezależne źródła zgodne** co do 3 CRITICAL i pozycji 4 IMPORTANT (Silnik drift, STATE vs CHECKLIST, frontmatter niespójny, dead path w INIT).

---

## ZASADA DLA KOLEJNEGO AGENTA

- **NIE uszczuplać Grill_Me** — ani pliku `Grill_Me.md`, ani triggera w routerze, ani merge z Expert_Council. Fi korygował to wprost 2026-04-21. Patrz **L10** w LESSONS.md.
- **Kolejność wykonania:** PHASE A → verify (grep `{{` na pustym forku) → PHASE B → verify (Silnik/STATE/frontmatter spójność) → PHASE C osobna sesja po DEC-3.
- **Przed commitem każdej fazy:** Grill_Me + Preflight (2 gate'y, jak F4 w LESSONS).
- **Źródło prawdy o zakresie:** ten PROOF + CHECKLIST §NEXT. NIE otwieraj dyskusji na nowo — decyzje są tu.
- **Jeśli którykolwiek fix wymaga zmiany w AGENTS/CO_PILOT/Muaddib:** uruchom Workflow_Edit PRZED edycją (refactor grepem + lista referencji).
- **Sync_state po zakończeniu fazy:** Reflect → STATE → DECISIONS (jeśli DEC-1/2/3 rozstrzygnięte) → PROOFS append → LESSONS (jeśli nowe korekty) → commit `SYNC_STATE_TEMPLE_V2 <UTC>`.
