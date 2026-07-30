# FORGE REPORT — PB-2 (odchudzanie kontekstu)

> Data: 2026-07-30 | Pakiet **PB-2** z `PROOF_BOOST_PLAN_20260707.md` | Znaleziska: C6 🔴, C1, C11, C2, C3, C4, C5
> Metoda pomiaru: `wc -w` na plikach rehydrate × 1.35. **Ta sama metoda przed i po** — liczby porównywalne.

---

## CONTEXT DELTA

| Plik | Przed (słowa) | Po (słowa) | Zmiana |
|------|--------------|-----------|--------|
| `Muaddib.md` | 223 | 223 | — (CORE, nietykalny) |
| `WORKFLOW.md` | 537 | 537 | — |
| `CO_PILOT.md` | 1048 | 1101 | +53 (wpisane zmierzone liczby, obie metody) |
| `STATE_OF_SYSTEM.md` | 656 | 547 | **−17%** |
| `CHECKLIST.md` | 2382 | 1259 | **−47%** |
| `DECISIONS.md` | 2109 | 784 | **−63%** |
| `LESSONS §⚡ŻELAZNE` | 279 | 279 | — (nietykalne) |
| **SUMA (pliki z listy)** | **7234** | **4732** | **−35%** |

**Pliki z listy rehydrate: ~9 766 tk → ~6 388 tk.** Target planu (≤~7k) osiągnięty.

### ⚠️ Korekta po code-review — to NIE jest pełny koszt startu

Powyższa liczba mierzy tylko 7 plików czytanych z listy REHYDRATE. Realny start sesji ładuje dodatkowo:

| Pozycja | Koszt | Dlaczego się liczy |
|---|---|---|
| `AGENTS.md` | ~1 850 tk | Agent musi go przeczytać, żeby wiedzieć CO czytać — nie da się go pominąć |
| workspace `MEMORY.md` | ~2 900 tk | Pozycja 8 listy; wstrzykiwana automatycznie przez harness |

**PEŁNY START: ~14 480 tk → ~11 146 tk (−23%).**

Próg 6k z `CO_PILOT §4 krok 9` dotyczy właśnie tej liczby — i **jest przekroczony blisko dwukrotnie**. Cięcie tekstu nie wystarczy; potrzebna zmiana architektury ładowania (T1 z PB-5: kontekst przy akcji zamiast na starcie). Nie udajemy, że próg jest spełniony.

---

## OPERACJE (move, nigdy delete)

| # | Operacja | Co | Dokąd |
|---|----------|-----|-------|
| 1 | **MOVE + COMPRESS** | CHECKLIST §DONE — pełne opisy 26 wpisów | `🅖_ARCHIVE/CHECKLIST_DONE_2026q2.md` (1553 słowa zachowane); w CHECKLIST 1 linia + proof per wpis, sesje ≤10 jednym pointerem |
| 2 | **MOVE + COMPRESS** | DECISIONS — kolumny „Opcje rozważane" + pełne „Dlaczego" dla D1-D24 | `🅖_ARCHIVE/DECISIONS_RATIONALE_2026q2.md` (2026 słów, sekcja per D#); w tabeli decyzja + jednozdaniowy powód |
| 3 | **COMPRESS** | STATE — FACTS bez potrójnie zapisanych narracji, LAST SESSION DELTA do 5 linii pointerów | w miejscu |
| 4 | **LINK** | AGENTS §REHYDRATE poz. 7 — ŻELAZNE są wstrzykiwane hookiem `session-inject.sh`, Read tylko gdy hook nieaktywny (C5, duplikat zweryfikowany w kodzie hooka) | w miejscu |
| 5 | **FIX** | Zmierzone liczby budżetu wpisane do `AGENTS.md` (partial rehydrate) + `CO_PILOT §9` + STATE FACT #3 (C6, C11) | w miejscu |

Nic nie zostało skasowane. Każdy wycięty fragment ma adres w `🅖_ARCHIVE/`.

---

## WERYFIKACJA

| Sprawdzenie | Wynik |
|-------------|-------|
| Decyzje w tabeli (D1-D25) | 25 ✅ |
| Sekcje rationale w archiwum | 24 (D1-D24) + D25 w tabeli ✅ |
| Pliki archiwum istnieją i nie są puste | 2/2 ✅ |
| Pointery z CHECKLIST/DECISIONS do archiwum | rozwiązują się ✅ |
| `Muaddib.md` nietknięty (anti-pattern Context_Forge) | ✅ |
| `LESSONS §⚡ŻELAZNE` nietknięte | ✅ |
| `Grill_Me.md` nietknięty (L10) | ✅ |
| Skille w `SKILL/` — 21, żaden nie wyjęty (D17/L14) | ✅ |

---

## USTALENIA UBOCZNE (do PB-3)

Hook `session-inject.sh` wycina sekcję ŻELAZNE wzorcem `awk '/## ⚡ ŻELAZNE/{f=1} f&&/^## L1 /{f=0} f'`. **W forku po PB-1 nie ma już nagłówka `## L1`**, więc kotwica końcowa nie zadziała — ratuje to dopiero `grep '^[0-9]+\. '` w kolejnym potoku. Działa, ale przypadkiem.

→ Do naprawy przy PB-3 (kotwice wzorców): koniec sekcji łapać na `^---` albo `^## `, nie na konkretnym `## L1`.

---

## LEARNING DELTA

- Potwierdzone F6 („pomiar > deklaracja") na własnym budżecie: deklaracja w dwóch plikach governance była zaniżona **2×** i nikt tego nie zauważył przez 5 tygodni, mimo że próg alarmowy istniał.
- Nowa reguła operacyjna wpisana do `DECISIONS §Jak dodać`: powód w tabeli = jedno zdanie, argumentacja do archiwum. Bez tego tabela znów spuchnie.

---

## NEXT FORGE

Za ~5 sesji **albo** natychmiast po T1 (PB-5), które ma zejść z ~6.3k do ~3k. Wtedy ponowny pomiar tą samą metodą.

---

## NAPRAWY PO CODE-REVIEW (ten sam dzień)

Niezależny przegląd dał **FAIL: 2 🔴 / 5 🟡 / 6 🟢**. Pełny raport: `CODE_REVIEW_20260730.md`. Oba krytyczne potwierdzone własnym testem i naprawione:

| # | Znalezisko | Naprawa | Weryfikacja |
|---|-----------|---------|-------------|
| 🔴 1 | **Wiszące referencje w forku** — 16 odwołań `(D19)`, `(D20)`, `L4:` itd. w 6 plikach systemowych. Po resecie pamięci fork ich nie ma, a po 19 własnych decyzjach nada `D19` inne znaczenie → cichy błąd | Krok 5.5 pkt 1c: prefiks `TEMPLE-D<N>` / `TEMPLE-L<N>` w plikach systemowych + notka o konwencji w DECISIONS forka | `grep` wiszących: **0**; 15 referencji `TEMPLE-*` poprawnie oznaczonych |
| 🔴 2 | **Własny hook blokuje własną procedurę** — `block-destructive.sh` łapie `rm -rf` z Kroku 1 (i `rm -rf REPOSITORIES/`, które stało tam od dawna). INIT nie podawał obejścia | Krok 1: jawna autoryzacja markerem `/tmp/ALLOW_DESTRUCTIVE` + zakaz obchodzenia hooka przepisywaniem komendy + guard `${SCIEZKA_NOWEGO_REPO:?}` przed `rm -rf "/.git"` | regex hooka przeanalizowany; obejście udokumentowane w miejscu użycia |
| 🟡 | **Liczby budżetu mierzyły tylko część** — pominięte `AGENTS.md` i workspace MEMORY | Obie liczby rozdzielone i opisane w AGENTS, CO_PILOT §9, STATE i tym raporcie | pomiar powtórzony, patrz §CONTEXT DELTA |
| 🟡 | Wiszący pointer w DECISIONS forka do archiwum, które Krok 5.5 kasuje | `grep -v DECISIONS_RATIONALE` w Kroku 5.5 | `grep` pointerów w forku: **0** |
| 🟡 | Drobne rozjazdy liczb w raportach (efekt edycji po pomiarze) | przeliczone, wartości aktualne | — |

**CONF po naprawach: 0.92**
