# PLAN REALIZACJI PB-1 → PB-4 (dla agenta sesji 19+)

> Zatwierdzony przez Fi 2026-07-07 („w nast sesji zaczne ten plan realizowac").
> Znaleziska + pełne dowody per C#: `PROOF_BOOST_20260707.md` + `PROOF_BOOST_20260707_findings.json`.

---

## ZASADY WYKONANIA (z grilla — obowiązkowe)

1. Kolejność: **PB-1 → PB-2 → PB-3 → PB-4**. Każdy pakiet = osobny commit z proofem.
2. **Jedna zmiana → weryfikacja → następna** (ŻELAZNA Fi). Nigdy „gotowe" bez dowodu.
3. **Move, nigdy delete** — kondensacja = przenoszenie do ARCHIVE/PROOFS.
4. Nietykalne: `Grill_Me.md` (L10), widoczność skilli w SKILL/ (D17/L14), LESSONS §⚡ ŻELAZNE.
5. Start: rehydrate temple_v2. Przy PB-1/PB-2 przeczytaj `Workflow_Edit.md` (zmiany struktury/referencji).

---

## PB-1 — FORK-SAFETY (INIT.md) — [C24 🔴, C25, C26, C30]

1. `INIT.md` Krok 1 (~l.53-58): po `rm -rf REPOSITORIES/` dopisz **`rm -rf "${SCIEZKA_NOWEGO_REPO}/.git"`** — to naprawia C24 (fork dziedziczy .git i remote szablonu).
2. Decyzja z Fi na starcie sesji (1 pytanie + werdykt). REKOMENDACJA: przy forku **LESSONS → zostaje tylko §⚡ ŻELAZNE** (uniwersalne reguły Fi) + pusty szkielet; **DECISIONS → pusta tabela** (zasady zostają); **PROOFS → tylko EXAMPLE_PROOF**. Dopisz jako Krok 5.5 INIT. Alternatywa: D15-dopisek że fork dziedziczy pamięć → wtedy popraw INIT.md:229-230 na zgodne z faktem.
3. `INIT.md:134`: weryfikację „grep -rn '{{' . = zero" zamień na **grep listy 17 placeholderów z §2** (meta-pliki przestają fałszywie failować — C26).
4. `AGENTS.md:33`: `{{ALIAS}}` → `{{ALIAS_PROJEKTU}}` (jedyny niepokryty placeholder).
5. `INIT.md` nagłówek: „12 parametrami" → „13 parametrami" (C30).

**PROOF:** pełny fork symulacyjny do /tmp — (a) po `git init`+commit: `git log --oneline | wc -l` == 1; (b) `git remote -v` puste; (c) grep 17 placeholderów = 0; (d) pamięć zgodna z decyzją pkt 2. Wynik → `PROOFS/FORK_TEST_<data>.md`. Commit.

---

## PB-2 — CONTEXT_FORGE / ODCHUDZANIE — [C6 🔴, C1, C11, C2, C3, C4, C5]

0. Przeczytaj i prowadź wg `Context_Forge.md`; konkrety poniżej. **Per-plik: wc -w przed/po każdym.**
1. CHECKLIST §DONE: zostaw 15 najnowszych; sesje 4-13 → `🅖_ARCHIVE/CHECKLIST_DONE_2026q2.md`. Od teraz wiersz DONE = 1 linia + pointer do PROOF (C2).
2. DECISIONS D10-D23: rationale >2 zdań → `🅖_ARCHIVE/DECISIONS_RATIONALE_2026q2.md` (nagłówek per D#); w tabeli 1 zdanie + pointer (M5 rozszerzone — C3).
3. STATE: LAST SESSION DELTA ≤5 linii pointerów; usuń narracje potrójnie zapisane (grep `session_active|ZAGĘSZCZAJ|uprząż` — pełna wersja tylko w PROOFS) (C4).
4. Duplikat ŻELAZNYCH (C5): REKOMENDACJA — źródłem na start zostaje hook session-inject (egzekwowalny); w `AGENTS.md` §REHYDRATE poz. 7 dopisek „(wstrzykiwane hookiem — Read tylko gdy hook nieaktywny)".
5. Po wszystkim: **zmierz** pełny rehydrate (`wc -w` × 1.35) i wpisz zmierzone liczby + datę pomiaru do `AGENTS.md:33-36`, `CO_PILOT.md §9`, STATE FACT (F6: pomiar > deklaracja). Target ≤ ~7k tk.
6. **Code-review subagent** na całym diffie (governance >5 plików — F4/pattern D48). Fix → commit.

**PROOF:** FORGE REPORT w PROOFS (tabela plik przed/po + nowy budżet z datą pomiaru).

---

## PB-3 — HOOKI v2 (.claude/hooks/) — [C7, C19, C20, C21, C22, C9, C23, C12/C16]

1. `block-destructive.sh`: kotwica `(^|[;&|]\s*)` dla wszystkich wzorców + rm łapane warunkiem złożonym: wywołanie `rm` ORAZ flaga recursive (`-[a-z]*r|--recursive`) ORAZ force (`-[a-z]*f|--force`), dowolna kolejność/rozdzielenie (C19, C7).
2. `block-deploy.sh`: kotwice + certbot tylko mutujące (`renew|certonly|run|install|revoke|delete`) (C7).
3. `block-git-add-all.sh`: blokuj też `cd <dir> && … git add -A/./--all` i `git -C <dir> add …`; docelowo porównanie `git rev-parse --show-toplevel` vs `$CLAUDE_PROJECT_DIR` (szablon #4 Hooks_Audit) (C20 — scenariusz incydentu L15).
4. `session-inject.sh`: (a) ścieżki przez `$CLAUDE_PROJECT_DIR` (C23); (b) licznik cadence: sesje SYNC_STATE od ostatniego FORGE REPORT ≥5 → echo „⚠️ FORGE+LINT zaległy o N sesji" (C12/C16); (c) marker D22 z PID+timestamp, alarm tylko gdy proces nie żyje (C21); (d) czyść z wstrzykiwania blockery CLOSED (C10).
5. `reflect-gate.sh` + `Reflect.md`: Reflect na końcu robi `touch .claude/.reflect_done`; gate wymaga śladu mtime<2h obok staged LESSONS/VOICE i kasuje po przejściu (C22). Udokumentuj escape SKIP_REFLECT w CO_PILOT §2 (C8).
6. Gaszenie markera D22 **hookiem** (PostToolUse Bash: udany `git commit` z SYNC_STATE → `rm -f "$CLAUDE_PROJECT_DIR/.claude/.session_active"`); krok 8 CO_PILOT §2 zostaje jako fallback z adnotacją (C21).

**PROOF:** `PROOFS/HOOKS_V2_<data>.md` — tabela testów: stare 16 + nowe: `rm -r -f`✋, `rm --recursive --force`✋, `cd /root/GOFANS-NEOVERSE && git add -A`✋, `git -C .. add -A`✋, `git commit -m "docs: rm -rf w przykładzie"`✅przechodzi, `grep -rn "git reset --hard" LESSONS.md`✅przechodzi. Commit.

---

## PB-4 — ROZWÓJ FI + ROUTER — [C15, C27, C28, C16-metryka]

1. `Reflect.md`: nowy krok **„Wnioski dla Fi"** — 1-3 punkty na koniec sesji (co sesja pokazała o zależnościach/AI/systemie; jakość osądu, nie informacje). Output w chacie + 1 linia w STATE DELTA (C15 — najtańszy mechanizm na istniejącym reflect-gate).
2. `CO_PILOT.md §4` tabela on-demand: +8 wierszy (Hooks_Audit, Prompt_Master, Code_Reviewer, Defuddle, Obsidian_Markdown, JSON_Canvas, UI_UX_Pro_Max, Proof_Boost), 1 linia per skill; w kroku 4 routera dopisek „review → Code_Reviewer (drugie oko)" (C27).
3. `AGENTS.md` Quick Reference: „skill Ingest" → „skill Knowledge_Manager" (C28).
4. LESSONS przy L4/L12: pole „domknięta od: <data/mechanizm>" — metryka czy powtórki ustały po D19/D21 (C16).

**PROOF:** grep 8 nazw w CO_PILOT ≥1 każda; demo „Wnioski dla Fi" w pierwszym sync po wdrożeniu. Commit.

---

## KOSZYK IMPROVE + INSIGHT (T1-T7) — propozycje ulepszeń, po PB, decyzja Fi per pozycja

> To NIE naprawy (te są w PB). To zmiany, żeby workflow był LEPSZY, + tajniki o działaniu modeli zastosowane do tego systemu. Dopisane po korekcie Fi (L18).

| # | Propozycja | Fakt/tajnik za tym | Zysk |
|---|-----------|--------------------|------|
| T1 | **Kontekst przy akcji, nie na starcie**: rehydrate minimum (Muaddib TL;DR + STATE NEXT + CHECKLIST NEXT ≈ 2-3k tk), reguły wstrzykiwane hookami przy właściwej akcji (commit→polityka commit, edycja STATE→format, deploy→preflight) | TAJNIK: instrukcja działa najmocniej BLISKO decyzji. Dowód w repo: ŻELAZNE #1 zaczęło działać dopiero gdy session-inject je wstrzyknął (sesja 17), nie gdy leżało w pliku | start ~13k→~3k tk + reguły mocniej przestrzegane |
| T2 | **Wyciąć placebo z WORKFLOW/CO_PILOT**: zostają tylko reguły ZMIENIAJĄCE domyślne zachowanie (PL, footer CONF, anti-bloat, korekty Fi, routing); „rozbij problem", „oddziel fakty od hipotez" itd. Opus robi natywnie. **Lista cięć najpierw do Fi** | Własny F5 to odkrył 2026-05-29; audyt zmierzył, że nikt nie wyciął. TAJNIK: każda zbędna reguła rozmywa pozostałe | ~1-1.5k tk/sesja + ostrzejsza egzekucja reszty |
| T3 | **Router 12 kroków → 3 bramki + tabela sygnałów**: (1) wiem co robić? NIE→Check_Me/Brainstorm (2) nieodwracalne/duże? TAK→Grill/Preflight (3) koniec sesji? TAK→Reflect+Sync | TAJNIK: model nie iteruje literalnie po 12 krokach — czyta całość i decyduje; krótka tabela sygnałów routuje równie dobrze | mniej teatru przy prostych taskach, te same bezpieczniki |
| T4 | **Wersjonowanie TEMPLE-core**: frontmatter `temple_core: 2.x` we wspólnych plikach (WORKFLOW, hooki, ŻELAZNE); session-inject forka porównuje z TEMPLE i raportuje drift na starcie | Fakt: 2026-07-07 powstały DWA bliźniacze skille (GOFANS PROOP_BOOST ↔ TEMPLE Proof_Boost) jednego dnia; C4 wisi tygodniami jako ręczna sesja | propagacja = widoczny licznik zamiast pamięci |
| T5 | **Metryka uczenia**: sync liczy powtórki korekt per sesja (0 = zdrowo) + trend 1 linią w STATE (rozszerza PB-4 „domknięta od") | Fakt: pętla domyka się po 3-4 korektach (L4 4×, L12 3×) i nikt nie mierzy, czy po D19/D21 ustały | pierwszy twardy wskaźnik „system się uczy" |
| T6 | **Subagenci do czytania, główne okno do decyzji**: pełne DECISIONS/LESSONS/PROOFS czyta subagent → zwraca digest 5 linii, gdy potrzebny | Fakt z sesji 18: panel zrobił ~1.9M tk pracy, okno Fi dostało tylko wynik. TAJNIK: świeży kontekst subagenta = tania pamięć robocza | budżet głównego okna chroniony |
| T7 | **Proof-driven wszystko**: każda procedura (sync, INIT, skill) kończy się komendą weryfikującą (grep/wc/test), nie zdaniem „zrobione" | Cały audyt = dowód: co nie ma komendy weryfikującej, drift-uje (budżet, liczby, router) | drift wykrywany w sesji, nie po 5 tygodniach |

**Rekomendowana kolejność po PB:** T1+T3 (największa dźwignia) → T4 (przy C4) → T2 (z listą cięć do zatwierdzenia) → T5/T6/T7 wplatane na bieżąco.

---

## PO CAŁOŚCI

- sync_state (Reflect → STATE/DECISIONS → commit → push).
- Bilans dla Fi: rehydrate przed/po, tabela testów hooków, pierwsze „Wnioski dla Fi".
- **NIE ruszaj w tych sesjach:** C4 propagacja do GOFANS/MALING/MCP = osobna sesja; przy niej pogodzić GOFANS `PROOP_BOOST` ↔ TEMPLE `Proof_Boost` (jeden kanon nazwy/zakresu). K2 (test propagation KNOWLEDGE) bez zmian.
