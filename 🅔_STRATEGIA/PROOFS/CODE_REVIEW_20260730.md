# CODE REVIEW — PB-1 + PB-2 (commity `39c4239`, `2d63785`)

> Data: 2026-07-30 | Recenzent: niezależny agent wg `🅓_SYSTEM/SKILL/Code_Reviewer.md`
> Zakres: `39c4239` (PB-1 fork-safety) + `2d63785` (PB-2 odchudzanie), plan: `PROOF_BOOST_PLAN_20260707.md` §PB-1/§PB-2
> Metoda: pełny diff + symulacja Kroku 1 i Kroku 5.5 na kopii repo + własny przelicznik `wc -w` / `grep -c` (nie ufano raportom)

---

## WERDYKT

**FAIL** — 2 × 🔴, 5 × 🟡, 6 × 🟢.

Powód FAIL wg rubryki `Code_Reviewer.md` (FAIL = ≥1 CRITICAL lub ≥3 HIGH): dwa znaleziska krytyczne, oba w PB-1. Blocker „zakaz forkowania" został zamknięty, choć w najbardziej prawdopodobnym środowisku uruchomienia procedura zatrzyma się na Kroku 1, a nowy Krok 5.5 wprowadza kolizję numeracji decyzji w każdym forku.

**Co jest zrobione dobrze i nie wymaga poprawek** (weryfikacja własna, nie deklaracja):
- „Move, nigdy delete" **potwierdzone mechanicznie**: 26/26 wpisów DONE i 24/24 rationale decyzji odtworzone chunk po chunku w `🅖_ARCHIVE/` — zero utraconych fragmentów.
- Nietykalne nietknięte: `Grill_Me.md`, `Muaddib.md`, `LESSONS.md` (w tym §⚡ŻELAZNE) nie występują w żadnym z dwóch commitów; `SKILL/` = 21 plików.
- Krok 5.5 wykonany 1:1 na kopii repo daje dokładnie deklarowane wyniki bramek (L=0, ŻELAZNE=1, D=0, PROOFS=1, zero wiszących `→ L<N>`).
- Liczby partial rehydrate w `AGENTS.md` przeliczone i zgodne (core 2400 / state 2400 / decisions 1100).

---

## 🔴 KRYTYCZNE

### K1 — `INIT.md:56` — własny hook blokuje krytyczny krok fork-safety

**Co:** Krok 1 nakazuje `rm -rf "${SCIEZKA_NOWEGO_REPO}/.git"` i opisuje to jako „nieopcjonalne" (§4 zasada 11). Hook `.claude/hooks/block-destructive.sh:6` łapie wzorzec `rm +-[a-z]*r[a-z]*f` i zwraca `exit 2`.

Test wzorca na dokładnej komendzie z INIT:

```
rm -rf "${SCIEZKA_NOWEGO_REPO}/.git"   → BLOCK
rm -rf REPOSITORIES/                   → BLOCK
```

**Scenariusz szkody:** Fi otwiera sesję w `/root/GOFANS-NEOVERSE/TEMPLE_REPO_v2/` (tam leży INIT.md, §0 wskazuje to jako źródło), mówi „zainicjuj projekt X". `$CLAUDE_PROJECT_DIR` = TEMPLE → `.claude/settings.json` aktywne → pierwsza komenda pierwszego kroku jest zablokowana. `INIT.md §4 zasada 7` mówi: „Jeśli coś blokuje → STOP, zgłoś Fi, nie improwizuj" — agent staje. Obejście (`touch /tmp/ALLOW_DESTRUCTIVE`, ważne 120 s) istnieje **wyłącznie w komentarzu hooka**, INIT.md nigdzie go nie wspomina.

Test w `FORK_TEST_20260730.md` tego nie pokrył — 15/15 bramek zmierzono w środowisku, w którym hook nie działał. BLOCKER #1 w STATE został przestawiony na `CLOSED` na podstawie dowodu, który nie obejmuje ścieżki uruchomienia z katalogu szablonu.

**Naprawa:** w Kroku 1 przed blokiem `rm` dopisać jawnie `touch /tmp/ALLOW_DESTRUCTIVE   # autoryzacja Fi dla block-destructive.sh (D21)` + jedno zdanie „to jedyny sankcjonowany wyjątek od zasady 7". Docelowo (PB-3) whitelistować w hooku `rm -rf <ścieżka>/.git` przy jednoczesnym istnieniu `INIT.md` w cwd.

---

### K2 — `INIT.md:236-269` (Krok 5.5) — fork gubi decyzje i lekcje, których dalej używa 7+ plików → kolizja numeracji

**Co:** Krok 5.5 kasuje wszystkie wiersze `D<N>`, wszystkie `## L<N>` **oraz cały `🅖_ARCHIVE/`**. Ale pliki kopiowane do forka 1:1 (i objęte zakazem zmian — §4 zasady 2, 9, 10) nadal cytują te identyfikatory. Sprawdzone na symulowanym forku po Kroku 5.5:

| Plik | Wiszące cytaty |
|------|----------------|
| `AGENTS.md:10,15,16,19,122` | (D20) ×2, (D21), (D19) ×3 |
| `🅓_SYSTEM/AGENT/CO_PILOT.md:23` | (D22) |
| `🅓_SYSTEM/KNOWLEDGE/index.md:42` | (D23) |
| `🅓_SYSTEM/SKILL/Knowledge_Manager.md:181,282` | (D23) ×2 |
| `🅓_SYSTEM/SKILL/Hooks_Audit.md:66-71,228` | L4, L11, L12, L14 |
| `🅓_SYSTEM/SKILL/Proof_Boost.md:56,63,77` | L18 ×2, L16 |
| `🅐_OPIS/Silnik.md:3` | (D9, …) |

**Scenariusz szkody (dwustopniowy):**
1. Miękki — agent forka czyta `AGENTS.md` poz. 7 „(D21)", idzie do `DECISIONS.md` (reguła frontmatter: „agent czyta decyzję zamiast otwierać dyskusję") i zastaje pustą tabelę. Traci uzasadnienie reguły, którą ma wykonywać.
2. Twardy — `DECISIONS.md §Jak dodać` zasada 1 każe numerować sekwencyjnie od D1. Po 19 decyzjach projekt ma **własne D19/D20/D21 o zupełnie innym znaczeniu**, a `AGENTS.md` wciąż powołuje się na „(D19)" i „(D21)". Referencja rozwiązuje się **cicho i błędnie** — agent czyta cudzą decyzję jako uzasadnienie reguły rehydrate.

To jest regresja wprowadzona tym commitem: przed PB-1 fork dziedziczył D1-D24 i wszystkie cytaty się rozwiązywały.

**Naprawa (rekomendacja — A):**
**A.** W Kroku 5.5 zachować wiersze decyzji **szablonowych** (D9, D16, D17, D19, D20, D21, D22, D23 — te, które są cytowane przez wspólne pliki), oznaczyć je w tabeli jako `TEMPLE-core`, a numerację projektu zacząć od `P1`. Wtedy cytaty się rozwiązują i nie ma kolizji.
Alternatywy: **B.** sed w Kroku 5.5 wycinający `(D<N>)` / `L<N>` ze wspólnych plików — łamie „skille kopiuj 1:1" (§4 zasada 2). **C.** prefiks per-fork (`FD1`, `FD2`) — rozwiązuje kolizję, ale nadal zostawia wiszące cytaty.

Analogicznie dla lekcji: skille cytują L4/L11/L12/L14/L16/L18 — jeśli zostają jako „ŻELAZNE bez lekcji", cytaty w skillach należy zamienić na nazwy reguł, nie numery.

---

## 🟡 ISTOTNE

### I1 — `INIT.md:54-59` — brak `set -u` / `|| exit`: pusta ścieżka niszczy szablon

Blok Kroku 1 nie ma `set -euo pipefail` ani `|| exit` po `cd`. Przy pustym/niezdefiniowanym `SCIEZKA_NOWEGO_REPO`:

```
cd ""                            # faili cicho, cwd zostaje = TEMPLE
rm -rf "/.git"                   # celuje w root filesystemu
rm -f INIT.md                    # ← kasuje INIT szablonu
rm -rf REPOSITORIES/             # ← kasuje REPOSITORIES szablonu (7 audytów)
rm -f .claude/.session_active …  # ← gasi czujkę D22 szablonu
```

Bramka `[ ! -d .git ]` z Kroku 1 tego **nie** złapie w drugą stronę: w TEMPLE `.git` istnieje, więc wypisze „STOP", ale trzy `rm` już poszły. Efekt: naruszona zasada §4.1 („NIE modyfikuj plików w TEMPLE") przez samą procedurę.

**Naprawa:** na górze Kroku 1: `set -euo pipefail` + `[ -n "${SCIEZKA_NOWEGO_REPO:-}" ] || { echo "STOP: brak ścieżki"; exit 1; }` + `cd "${SCIEZKA_NOWEGO_REPO}" || exit 1`, a dalsze `rm` zostawić względne (już po zweryfikowanym `cd`).

---

### I2 — `AGENTS.md:31-36` + `CO_PILOT.md:122` + `FORGE_REPORT:10-21` — budżet ~6 300 tk pomija pozycję 8 rehydrate

Tabela FORGE REPORT ma **7 wierszy dla „8 pozycji"**. Brakuje pozycji 8 (`workspace MEMORY.md`) i samego `AGENTS.md`, który agent musi przeczytać, żeby poznać listę.

Pomiar własny (`wc -w` × 1.35, ta sama metoda):

| Element | Słowa | ~tk |
|---|---|---|
| 7 zmierzonych pozycji | 4 625 | 6 244 |
| `AGENTS.md` (entry point, poza tabelą) | 1 370 | 1 850 |
| workspace `MEMORY.md` (poz. 8 rehydrate) | 2 155 | 2 909 |
| **realny start** | **8 150** | **≈ 11 000** |

**Scenariusz szkody:** trzy pliki governance (AGENTS, CO_PILOT §9, STATE FACT #3) niosą teraz liczbę „~6 300" jako **zmierzoną**, a jest to pomiar 7/8 pozycji. Wniosek „target planu (≤~7k) osiągnięty" nie ma pokrycia, a alarm „rehydrate > 6k" liczy na niepełnej podstawie — czyli dokładnie ten sam błąd klasy F6 („pomiar > deklaracja"), który PB-2 miał usunąć, tylko mniejszy.

**Naprawa:** dopisać do tabeli FORGE REPORT dwa wiersze (MEMORY, AGENTS) z adnotacją „auto-injected / entry point — koszt kontekstu, nie koszt Read" i podać dwie liczby: „Read: ~6 300 tk | kontekst startowy: ~11 000 tk".

---

### I3 — `CO_PILOT.md:57` — próg krok 9 spełniony na stałe, brak anotacji

Linia 57: „**Sygnały krok 9:** … rehydrate > 6k tk". Zmierzone: 6 300 tk (a realnie ~11k, patrz I2). Warunek jest spełniony **permanentnie**, od teraz, na każdej sesji.

`CO_PILOT.md:122` (tabela §9) ma uczciwą uwagę „nadal tuż nad progiem — cięcie w T1 (PB-5)", ale **linia 57 nie została ruszona**. Router czytany dosłownie każe odpalać `Context_Forge` na starcie każdej sesji; `FORGE_REPORT §NEXT FORGE` mówi „za ~5 sesji". Dwie instrukcje w tym samym systemie mówią co innego.

**Naprawa:** przy linii 57 dopisać `(zawieszony do T1/PB-5 — świadomy dług, patrz CO_PILOT §9)` albo podnieść próg do 7k z datą przeglądu.

---

### I4 — `🅓_SYSTEM/SKILL/Workflow_Edit.md:157` — skill uczy nieaktualnego formatu DECISIONS

KROK 4 skilla nakazuje wstawić do `DECISIONS.md` wiersz 6-kolumnowy:

```markdown
| D{{N}} | {{DATA}} | {{CO ZMIENIONO — krótko}} | {{OPCJE}} | {{DLACZEGO — twarde fakty}} | {{CONF}} |
```

Po PB-2 tabela ma 4 kolumny (`| # | Data | Decyzja + powód | CONF |`), a `DECISIONS.md §Jak dodać` pkt 2 wymaga, żeby rationale szło do `🅖_ARCHIVE/`. Plan §ZASADY pkt 5 wprost kazał czytać `Workflow_Edit.md` przy PB-1/PB-2 — plik został pominięty.

**Scenariusz szkody:** następna zmiana strukturalna idzie przez Workflow_Edit → agent wstawia wiersz z 6 komórkami do tabeli o 4 nagłówkach → tabela markdown się rozjeżdża, a pełne „Dlaczego" wraca do pliku, odwracając −63% oszczędności z PB-2.

**Naprawa:** zsynchronizować `Workflow_Edit.md` KROK 4 z nowym formatem + pkt „rationale → ARCHIVE".

---

### I5 — `🅒_NOW/DECISIONS.md:15,56` — pointery do archiwum przeżywają reset forka

Krok 5.5 kasuje wiersze `D<N>` i cały `🅖_ARCHIVE/`, ale zostawia:

- linia 15: „**Pełne rationale + opcje rozważane** (D1-D24) → `🅖_ARCHIVE/DECISIONS_RATIONALE_2026q2.md`" — w forku nie ma ani D1-D24, ani tego pliku;
- linia 56 (instrukcja „Jak dodać", pkt 2): „**Pełne rationale** → `🅖_ARCHIVE/DECISIONS_RATIONALE_2026q2.md`" — fork jest instruowany, żeby dopisywać uzasadnienia do nieistniejącego pliku z **zaszytym na stałe kwartałem 2026q2**. Projekt założony w 2027 będzie prowadził rationale w pliku nazwanym „2026q2".

**Naprawa:** w Krok 5.5 dodać sed czyszczący linię 15 i podmieniający nazwę pliku na `DECISIONS_RATIONALE_{{ROK}}q{{KWARTAL}}.md` (albo bezkwartalne `DECISIONS_RATIONALE.md`) + `touch` pustego pliku z nagłówkiem, żeby pointer się rozwiązywał od pierwszego dnia.

---

## 🟢 DROBNE

| # | Plik:linia | Co | Naprawa |
|---|-----------|-----|---------|
| D1 | `FORGE_REPORT_20260730.md:14-18` | Liczby nieodtwarzalne komendą: CHECKLIST po = **1259** (raport 1249), CO_PILOT po = **1070** (1072), STATE po = **514** (512). `LESSONS §ŻELAZNE 279` to `wc -w` linii 1-23 pliku (z nagłówkiem LESSONS), sama sekcja = **238**. Sumy i % w normie, ale plik o tezie „pomiar > deklaracja" ma liczby, których nie da się powtórzyć | dopisać dokładne komendy pomiaru pod tabelą |
| D2 | `FORK_TEST_20260730.md:303` | „`grep -c "{{" CONSTITUTION.md = 18`" — faktycznie **20** | poprawić lub podać komendę |
| D3 | `🅒_NOW/CHECKLIST.md:87` | Nagłówek „DONE (ostatnie 15)", w tabeli 16 wpisów + wiersz zbiorczy; plan §PB-2.1 mówił 15 | zdjąć 1 wpis albo zmienić nagłówek na „ostatnie 16" |
| D4 | `🅖_ARCHIVE/DECISIONS_RATIONALE_2026q2.md` | Brak sekcji `## D25`, choć nowa reguła `DECISIONS §Jak dodać` pkt 2 wymaga jej dla każdej decyzji — pierwsza decyzja pod nową regułą jej nie spełnia. Dodatkowo sekcje idą w kolejności D17, D21, D20, D19, D18, D22, D24, D23 | dopisać `## D25` (rationale jest w FORK_TEST) + posortować |
| D5 | commit `2d63785` | Scope creep: `AGENT_PATTERNS_20260730.md` (105 l.) + `_transkrypcja.md` (**1046 l. / 7995 słów**) doklejone do commitu o odchudzaniu; plan §ZASADY pkt 1 wymaga „każdy pakiet = osobny commit z proofem". Surowa transkrypcja to materiał źródłowy, nie proof | osobny commit; transkrypcję do `KNOWLEDGE/` lub poza repo |
| D6 | `INIT.md:286` + `INIT.md:194` | (a) `cd <ŚCIEŻKA_NOWEGO_REPO>` — literalny placeholder w nawiasach ostrych = przekierowanie wejścia w bashu; nowa bramka `[ ! -d .git ]` z Kroku 6 zależy od tego, czy `cd` się powiódł. (b) GATE 4.5 zwraca 20 → **STOP zawsze**, więc INIT nigdy nie dobiega samodzielnie do nowego Kroku 5.5/6, mimo nagłówka „wykonuje bez pytań dodatkowych poza 13 parametrami" | ujednolicić na `"${SCIEZKA_NOWEGO_REPO}"` + `|| exit 1`; w nagłówku dopisać „+ ręczne wypełnienie CONSTITUTION" |

---

## ZGODNOŚĆ Z PLANEM (PB-1 / PB-2)

| Punkt planu | Status | Uwaga |
|---|---|---|
| PB-1.1 `rm -rf .git` | ✅ wykonane | ale patrz K1 (hook blokuje) i I1 (brak guardów) |
| PB-1.2 decyzja Fi o pamięci + Krok 5.5 | ✅ wykonane | patrz K2 (skutki uboczne resetu) |
| PB-1.3 grep listy placeholderów | ✅ wykonane, **20 zamiast 17** | odchylenie udokumentowane i uzasadnione (lista wyprowadzona z sed, nie z pamięci) — poprawnie; lista pokrywa 20/20 wyrażeń sed |
| PB-1.4 `{{ALIAS}}` → `{{ALIAS_PROJEKTU}}` | ✅ | dodatkowo `{{ALIAS}}` dopisany do sed jako siatka bezpieczeństwa |
| PB-1.5 „12 → 13 parametrami" | ✅ | patrz D6b |
| PB-2.1 CHECKLIST §DONE → ARCHIVE | ✅ | 26/26 wpisów zachowanych, patrz D3 |
| PB-2.2 DECISIONS rationale → ARCHIVE | ✅ (zakres szerszy: D1-D24 zamiast D10-D23) | 24/24 zachowane, zero utraty |
| PB-2.3 STATE dedup + DELTA ≤5 linii | ✅ | `session_active`/`ZAGĘSZCZAJ` już nie występują; „uprząż" został tylko jako opis proofa |
| PB-2.4 AGENTS poz.7 dopisek o hooku | ✅ | |
| PB-2.5 zmierzone liczby do AGENTS/CO_PILOT/STATE | ⚠️ częściowo | patrz I2 — pomiar 7 z 8 pozycji |
| PB-2.6 code-review subagent | ✅ | ten dokument |
| **Poza zakresem planu** | ⚠️ | AGENT_PATTERNS + transkrypcja (D5) |

---

## REKOMENDACJA

Jedna kolejność, przed jakimkolwiek forkiem i przed PB-3:

1. **K1** — dopisać autoryzację hooka do Kroku 1 (2 linie). Bez tego BLOCKER #1 nie jest realnie zamknięty i status `CLOSED` w STATE jest przedwczesny.
2. **K2** — wariant A (decyzje TEMPLE-core zostają, numeracja projektu od `P1`). To jedyne znalezisko, które psuje forka po cichu.
3. **I1** — guardy w Kroku 1 (3 linie).
4. **I4 + I5** — synchronizacja `Workflow_Edit.md` i pointerów w `DECISIONS.md`.
5. **I2 + I3** — uzupełnić budżet o pozycję 8 i zaanotować próg 6k; dopiero potem `NEXT FORGE`.

Znaleziska 🟢 zebrać do jednego commitu porządkowego razem z PB-3.

**CONF: 0.90** — K1, K2, I1, I2, I4 zweryfikowane wykonaniem (symulacja forka, test regexu hooka, przeliczenie `wc -w`/`grep -c`). Niepewność dotyczy tylko środowiska uruchomienia INIT (K1 zakłada sesję otwartą w katalogu TEMPLE — jeśli Fi zawsze startuje z `/root/GOFANS-NEOVERSE/`, hook nie zadziała i K1 spada do 🟡).
