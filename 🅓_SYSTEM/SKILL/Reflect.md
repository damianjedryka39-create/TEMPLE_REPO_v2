---
name: Reflect
trigger: "koniec sesji|reflect|podsumowanie|co zapisać"
purpose: Wyciąga obserwacje o Fi i o sobie z sesji, proponuje aktualizację plików kontekstowych
output: Tabela obserwacji + propozycje zmian do zatwierdzenia (bez auto-edycji)
cross_link: [VOICE.md, LESSONS.md, Knowledge_Manager.md]
---

## 1) Załaduj pliki (ścieżki TEMPLE)

1. `🅓_SYSTEM/AVATAR/Muaddib.md` — CORE: tożsamość + avatar
2. `🅓_SYSTEM/SOUL/VOICE.md` — głos + charakter (wobec Fi + wobec świata)
3. `LESSONS.md` (root, jeśli istnieje) — wcześniejsze lekcje cross-session

Zapamiętaj strukturę sekcji każdego pliku.

## 2) Mapping: sygnał → plik → sekcja

### VOICE.md — CZĘŚĆ 1 (wobec Fi)

| Sygnał | Sekcja | Typ |
|--------|--------|-----|
| Korekta bezpośredniości ("za ostro", "więcej luzu") | CHARAKTER | UPDATE |
| Korekta pragmatyzmu ("za szybko lecisz") | CHARAKTER | UPDATE |
| Korekta humoru ("nie hamuj się", "za sucho") | CHARAKTER | UPDATE |
| Nowy anty-wzorzec ("nie zaczynaj od X", "przestań robić Y") | JAK KOMUNIKUJĘ → Czego NIGDY | ADD |
| Nowy wzorzec komunikacji ("podoba mi się jak robisz X") | JAK KOMUNIKUJĘ → Styl | ADD |
| Korekta autonomii ("nie pytaj, rób" / "pytaj zanim zrobisz") | JAK ROZWIĄZUJĘ PROBLEMY | UPDATE |
| Korekta dynamiki ("za bardzo yes-man", "challenguj mnie") | JAK PRACUJĘ Z FI | UPDATE |
| Nowy wzorzec współpracy ("od teraz rób X zanim Y") | JAK PRACUJĘ Z FI | ADD |
| Nowy trigger negatywny ("to mnie wkurwia w AI") | CZEGO NIE LUBIĘ | ADD |
| Nowy energetyzator ("uwielbiam jak X") | CO MNIE NAPĘDZA | ADD |

### VOICE.md — CZĘŚĆ 2 (wobec świata)

| Sygnał | Sekcja | Typ |
|--------|--------|-----|
| Nowe słowo do unikania ("nie pisz X") | ZABRONIONE FRAZY | ADD |
| Zmiana preferencji formatu ("w tabeli", "bez listy") | ZASADY JĘZYKOWE | UPDATE |
| Zmiana preferencji długości ("za długie", "w jednym zdaniu") | ZASADY JĘZYKOWE | UPDATE |
| Coś co nie działa ("brzmi sztuczne", "za generyczne") | ZABRONIONE FRAZY | ADD |

### LESSONS.md

| Sygnał | Typ |
|--------|-----|
| Fi koryguje zachowanie agenta (jawna korekta) | ADD nowa lekcja |
| Ta sama korekta powtórzona 2x+ | ADD z flagą POWTÓRZONE |

### KNOWLEDGE/ (opcjonalnie)

| Sygnał | Akcja |
|--------|-------|
| Fi podaje fakt domenowy z nowego źródła (nie lekcję, nie korektę) | Zanotuj jako kandydata do INGEST |
| Fi koryguje fakt merytoryczny ("to nie tak działa", "aktualna wersja to X") | Zanotuj jako kandydata do UPDATE strony KNOWLEDGE/ |

> Reflect NIE tworzy stron KNOWLEDGE/ sam. Flaguje kandydatów i proponuje uruchomienie skilla Knowledge_Manager.

## 3) Skanuj sesję

Szukaj sygnałów z mappingu.

Dodaj, gdy:
- **Jawne** (Fi wprost powiedział) → TAK
- **Powtórzone** (min. 2x w sesji lub wcześniejszych) → TAK
- **Jednorazowe + ukryte** → NIE

## 4) Odpowiedz

Jeśli są obserwacje:

```markdown
Obserwacje z sesji:

| # | Sygnał | Plik | Sekcja | Typ |
|---|--------|------|--------|-----|
| 1 | [cytat/opis] | VOICE.md | [sekcja] | ADD/UPDATE |
| N | [fakt domenowy z sesji] | KNOWLEDGE/ | [temat] | INGEST CANDIDATE |

Proponowane zmiany:

**VOICE.md → sekcja [nazwa]**
- [stary tekst lub "nowy punkt"]
+ [nowy tekst]

Zatwierdzić?
```

Jeśli brak:

```markdown
Brak nowych obserwacji. Sesja zgodna z profilem Fi.
```

## 5) Po zatwierdzeniu

- Edytuj wskazane pliki
- Jeśli to korekta/lekcja → dopisz regułę do `LESSONS.md` (root)
- Aktualizuj datę na końcu zmienionego pliku (`*Ostatnia edycja: DD.MM.YYYY*`)
- Jeśli są INGEST CANDIDATES → zaproponuj uruchomienie skilla `Knowledge_Manager.md` (NIE twórz stron automatycznie)

## Zasady

- NIE edytuj bez potwierdzenia Fi
- NIE duplikuj istniejących informacji
- NIE dodawaj jednorazowych preferencji
- Pokaż propozycje w formie tabeli/sekcji — tylko mocne sygnały
- Jeśli `LESSONS.md` nie istnieje → utwórz go z nagłówkiem `# LESSONS — cross-session findings`
- Wiedza domenowa (fakty o świecie/produkcie) → KNOWLEDGE/ via Ingest. Lekcje o agencie → LESSONS.md. NIE mieszaj.
