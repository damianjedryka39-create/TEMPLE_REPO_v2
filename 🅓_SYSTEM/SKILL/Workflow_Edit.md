---
name: Workflow_Edit
trigger: >
  Uruchom gdy:
  - Zmiana w strukturze plików workflow (dodaj/usuń/przenieś/przemianuj plik .md)
  - Zmiana referencji między plikami systemu (AGENTS, CO_PILOT, Muaddib, VOICE, skille)
  - Merge dwóch plików w jeden lub split jednego na wiele
  - Zmiana w rehydrate list, SSOT tabelach, routing, procedurach
  - Edycja flow agenta (nowy skill, nowy krok w routerze, zmiana sync_state)
  - Komenda: "edytuj workflow", "zmień strukturę", "przenieś plik X"
purpose: >
  Bezpieczna edycja workflow TEMPLE — zero osieroconych referencji, zero konfliktów,
  pełna spójność systemu po każdej zmianie strukturalnej.
output: >
  Zmienione pliki + DECISIONS.md (nowa decyzja) + grep proof (0 orphans) + GRILL_ME verdict
agents: [Claude]
cross_link: [Grill_Me.md, Context_Forge.md, Preflight.md]
ecosystem: {{NAZWA_PROJEKTU}}
---

# SKILL: WORKFLOW EDIT — Bezpieczna edycja struktury systemu

---

## PRE-CHECK

Przed uruchomieniem sprawdź:
1. Czy rozumiesz CO agent ma zmienić (plik, referencja, procedura, flow)?
2. Czy zmiana dotyczy struktury/referencji (ten skill), czy treści merytorycznej (edytuj bezpośrednio)?
3. Czy DECISIONS.md nie zawiera decyzji blokującej tę zmianę?

> Jeśli zmiana dotyczy TYLKO treści wewnątrz pliku (np. poprawka tekstu w VOICE.md) — NIE uruchamiaj tego skilla. Ten skill jest do zmian STRUKTURALNYCH.

---

## KROK 1: MAPA IMPAKTU

Zanim cokolwiek zmienisz — zbuduj pełną mapę.

**1a) Zidentyfikuj pliki docelowe:**
- Co tworzysz / usuwasz / przenosisz / edytujesz?
- Jakie nowe ścieżki powstaną?
- Jakie stare ścieżki znikną?

**1b) Grep referencji — ZANIM ruszysz cokolwiek:**

```bash
# Dla KAŻDEGO pliku który zmienisz — znajdź WSZYSTKIE referencje:
grep -rn "STARA_NAZWA.md" TEMPLE_REPO/ --include="*.md"
grep -rn "STARA_NAZWA" TEMPLE_REPO/ --include="*.md"  # bez rozszerzenia też
```

**1c) Zapisz mapę impaktu:**

| Plik źródłowy | Akcja | Nowa ścieżka | Pliki z referencjami (count) |
|---------------|-------|-------------|------------------------------|
| ... | dodaj/usuń/przenieś/edytuj | ... | ... |

**1d) Sprawdź rehydrate list w AGENTS.md:**
- Czy zmiana wpływa na liczbę pozycji?
- Czy kolejność się zmienia?
- Czy tokeny rehydrate się zmieniają?

> STOP: Jeśli mapa impaktu jest niejasna lub dotyczy > 5 plików — przedstaw mapę Fi do zatwierdzenia ZANIM przejdziesz dalej.

---

## KROK 2: WYKONANIE ZMIAN

Kolejność operacji jest KRYTYCZNA — nie zmieniaj:

**2a) TWÓRZ nowe pliki PIERWSZE**
- Utwórz nowy plik z pełną treścią
- Zweryfikuj: plik istnieje, treść poprawna

**2b) AKTUALIZUJ referencje w WSZYSTKICH plikach z mapy (krok 1c)**

Checklist referencji — przejdź KAŻDY plik z mapy:

| Plik | Typowe referencje do sprawdzenia |
|------|----------------------------------|
| `AGENTS.md` | REHYDRATE list, SSOT tabele, ROOT FILES, Quick Reference, podkatalogi, partial rehydrate |
| `CO_PILOT.md` | Header (tożsamość →), routing, sync_state |
| `VOICE.md` | Header (relacja między plikami) |
| `Muaddib.md` | Header (cross-linki), sekcje z odniesieniami |
| `Silnik.md` | Lista plików rehydrate, opisy, wzmianki |
| `INIT.md` | Zasady (NIE usuwaj...), placeholdery, post-init komendy |
| `Context_Forge.md` | Anti-patterns, tabele mapowania |
| `Reflect.md` | Lista plików do załadowania |
| `DECISIONS.md` | Wzmianki w kolumnie "Dlaczego" |
| `STATE_OF_SYSTEM.md` | FACTS z referencjami do plików |
| `CHECKLIST.md` | Proof paths |
| `LESSONS.md` | Wzmianki w lekcjach |
| `Skille (*.md)` | cross_link w frontmatter, instrukcje wewnętrzne |

**2c) AKTUALIZUJ liczniki i metadane:**
- AGENTS.md: "REHYDRATE — X pozycji" (zmień liczbę jeśli się zmieniła)
- AGENTS.md: partial rehydrate tabela (tokeny, skład)
- Frontmatter skilli: cross_link (jeśli dotyczy)

**2d) USUŃ stare pliki NA KOŃCU**
- Dopiero po tym jak WSZYSTKIE referencje wskazują na nowe ścieżki
- `rm` stare pliki
- `ls` weryfikacja fizyczna

---

## KROK 3: REFACTOR — WERYFIKACJA SPÓJNOŚCI

Obowiązkowy grep w 3 warstwach:

**3a) Warstwa 1 — Orphan check (osierocone referencje):**

```bash
# Dla KAŻDEJ usuniętej/przeniesionej nazwy pliku:
grep -rn "STARA_NAZWA\.md" TEMPLE_REPO/ --include="*.md"
grep -rn "STARA_NAZWA" TEMPLE_REPO/ --include="*.md"
```

**Wymagany wynik: 0 dopasowań** (wyjątek: wzmianki historyczne w DECISIONS/STATE opisujące przeszłość, NIE ścieżki plików).

**3b) Warstwa 2 — Nowe ścieżki istnieją:**

```bash
# Dla KAŻDEGO nowo utworzonego pliku:
ls -la NOWA_SCIEZKA
```

**3c) Warstwa 3 — Referencje do nowych plików są poprawne:**

```bash
# Szerokie wyszukanie nowej nazwy — wszystkie trafienia powinny mieć POPRAWNĄ ścieżkę:
grep -rn "NOWA_NAZWA" TEMPLE_REPO/ --include="*.md"
```

Przejrzyj wyniki — każda wzmianka musi mieć poprawną, pełną ścieżkę.

**3d) Raport refactoru:**

```
REFACTOR REPORT:
- Orphan grep [STARA_NAZWA.md]: X wyników (oczekiwane: 0) ✅/❌
- Orphan grep [STARA_NAZWA]: X wyników (Y historycznych = OK) ✅/❌
- Nowe pliki istnieją: ✅/❌
- Nowe referencje poprawne: X plików zweryfikowanych ✅/❌
```

> FAIL na dowolnym punkcie → wróć do KROKU 2, napraw, powtórz KROK 3.

---

## KROK 4: DECYZJA

Dodaj wpis do `🅒_NOW/DECISIONS.md`:

```markdown
| D{{N}} | {{DATA}} | {{CO ZMIENIONO — krótko}} | {{OPCJE}} | {{DLACZEGO — twarde fakty}} | {{CONF}} |
```

Zasady:
- Numer sekwencyjny (ostatni D + 1)
- CONF na podstawie pewności że zmiana jest spójna i bezpieczna
- "Dlaczego" = konkretne uzasadnienie (duplikacja, dead weight, spójność, oszczędność tokenów)

---

## KROK 5: GRILL_ME — STRESS-TEST ZMIANY

> Uruchom skill `Grill_Me.md` na WŁAŚNIE DOKONANEJ ZMIANIE.

**Input do Grill_Me:**
- Co zostało zmienione (mapa impaktu z kroku 1)
- Refactor report z kroku 3
- Nowa decyzja z kroku 4

**Coverage Grill_Me musi pokryć minimum:**

- [ ] ZAŁOŻENIA — czy zmiana zakłada coś co może być fałszywe?
- [ ] EDGE CASES — czy jakiś skill/procedura/rehydrate ścieżka się nie wysypie?
- [ ] ZALEŻNOŚCI — czy inne projekty (GOFANS/MCP/MALING) korzystające z TEMPLE nie stracą spójności?
- [ ] REVERSIBILITY — czy da się wycofać jeśli zmiana okaże się błędna?
- [ ] KOSZTY — czy token budget rehydrate się pogorszył czy poprawił?

**CONF Gate z Grill_Me:**
- ZIELONY (>= 0.85) → zmiana zatwierdzona, przejdź do OUTPUT
- ŻÓŁTY (0.70-0.84) → napraw wskazane ryzyka, powtórz krok 3 (refactor)
- CZERWONY (< 0.70) → ROLLBACK: przywróć stare pliki, cofnij referencje

---

## OUTPUT

Po ukończeniu skilla dostarczyć:

1. **MAPA ZMIAN:** tabela co zmieniono (plik | akcja | stara → nowa ścieżka)
2. **PLIKI EDYTOWANE:** lista plików z poprawionymi referencjami (z liczbą zmian per plik)
3. **REFACTOR REPORT:** wynik grep — orphan check, nowe ścieżki, poprawność referencji
4. **DECYZJA:** numer D w DECISIONS.md
5. **GRILL_ME VERDICT:** ZIELONY/ŻÓŁTY/CZERWONY + CONF + top ryzyka

```
WORKFLOW_EDIT: DONE
ZMIENIONE: X plików | USUNIĘTE: Y plików | UTWORZONE: Z plików
REFERENCJE: A poprawionych w B plikach
ORPHANS: 0 ✅
DECYZJA: D{{N}} (CONF: 0.XX)
GRILL_ME: {{VERDICT}} (CONF: 0.XX)
```

---

## ANTI-PATTERNS

- NIE usuwaj pliku PRZED aktualizacją wszystkich referencji — najpierw referencje, potem delete
- NIE rób masowych zmian bez mapy impaktu — jeden plik naraz, weryfikuj po każdym
- NIE pomijaj grep refactoru — "jestem pewien że wszystko poprawiłem" = bug
- NIE pomijaj Grill_Me — każda zmiana strukturalna musi przejść stress-test
- NIE zmieniaj wpisów historycznych w DECISIONS/STATE — to historia, nie ścieżki
- NIE edytuj plików w TEMPLE_REPO jeśli zmiana dotyczy żywego projektu — edytuj w projekcie docelowym
- NIE pomijaj sprawdzenia rehydrate list — zmiana pliku bez aktualizacji REHYDRATE = agent nie załaduje nowego pliku
