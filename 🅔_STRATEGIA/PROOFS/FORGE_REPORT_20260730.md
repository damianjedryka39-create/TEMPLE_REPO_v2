# FORGE REPORT — PB-2 (odchudzanie kontekstu)

> Data: 2026-07-30 | Pakiet **PB-2** z `PROOF_BOOST_PLAN_20260707.md` | Znaleziska: C6 🔴, C1, C11, C2, C3, C4, C5
> Metoda pomiaru: `wc -w` na plikach rehydrate × 1.35. **Ta sama metoda przed i po** — liczby porównywalne.

---

## CONTEXT DELTA

| Plik | Przed (słowa) | Po (słowa) | Zmiana |
|------|--------------|-----------|--------|
| `Muaddib.md` | 223 | 223 | — (CORE, nietykalny) |
| `WORKFLOW.md` | 537 | 537 | — |
| `CO_PILOT.md` | 1048 | 1072 | +24 (wpisane zmierzone liczby) |
| `STATE_OF_SYSTEM.md` | 656 | 512 | **−22%** |
| `CHECKLIST.md` | 2382 | 1249 | **−48%** |
| `DECISIONS.md` | 2109 | 784 | **−63%** |
| `LESSONS §⚡ŻELAZNE` | 279 | 279 | — (nietykalne) |
| **SUMA** | **7234** | **4656** | **−36%** |

**Rehydrate: ~9 766 tk → ~6 285 tk.** Target planu (≤~7k) osiągnięty.

⚠️ **Uczciwa uwaga:** 6 285 tk to nadal *powyżej* własnego progu 6k z `CO_PILOT §4 krok 9`. Dalsze cięcie to zadanie T1 w PB-5 (kontekst przy akcji zamiast na starcie, cel ~3k). Nie udajemy, że próg jest spełniony.

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

**CONF: 0.92**
