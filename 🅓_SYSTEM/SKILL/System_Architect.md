---
name: System_Architect
trigger: >
  Uruchom gdy: projektowanie nowego modulu systemu, optymalizacja istniejacej architektury,
  analiza techniczna, decyzja build-vs-buy, modelowanie przeplywow,
  projektowanie API/protokolow agentowych, refaktor strukturalny.
purpose: >
  Systematyczny protokol architektoniczny — od problemu do implementowalnego modelu.
  Zapobiega: scope creep, over-engineering, architekturze bez modelu, budowaniu bez pomiaru.
output: >
  ARCHITECTURE DECISION RECORD (ADR) w DECISIONS.md
  + opcjonalnie: diagram (mermaid), contract API, task breakdown
agents: [Claude Code]
cross_link: [Brain_Storming.md, Preflight.md, Check_Me.md]
ecosystem: {{NAZWA_PROJEKTU}}
---

# SKILL: System Architect Protocol

## PRE-CHECK

1. Czy problem jest zdefiniowany? → jesli NIE → uruchom `Check_Me.md` najpierw
2. Czy to wymaga kreatywnej eksploracji? → jesli TAK → uruchom `Brain_Storming.md` PRZED tym skillem
3. Czy CONSTITUTION.md jest zaladowany? → MUSI byc (non-negotiable constraints)
4. Czy jest istniejaca decyzja w `DECISIONS.md` na ten temat? → sprawdz, nie powtarzaj

---

## EXECUTION FLOW

### KROK 1: PROBLEM FRAME (5 min)

Odpowiedz na 5 pytan:

```
1. CO dokladnie budujemy / optymalizujemy? (1 zdanie)
2. DLA KOGO? (persona)
3. DLACZEGO TERAZ? (co blokuje / co odblokowuje)
4. JAKIE SA OGRANICZENIA? (czas, stack, budget, legal)
5. CO JEST POZA SCOPE? (explicit exclusion)
```

**Output:** `PROBLEM_FRAME` — 5 odpowiedzi, max 1 zdanie kazda.

---

### KROK 2: LANDSCAPE SCAN (10 min)

Zbierz kontekst:

- [ ] Sprawdz `DECISIONS.md` — czy temat byl rozstrzygany
- [ ] Sprawdz `ROADMAP.md` — gdzie to lezy na timeline
- [ ] Sprawdz `🅐_OPIS/OPIS_PROJEKTU.md` — czy MVP scope to obejmuje
- [ ] Sprawdz `CONSTITUTION.md` — czy sa hard constraints
- [ ] Sprawdz istniejacy kod w `🅕_PRODUKT/` — co juz istnieje

**Output:** `LANDSCAPE` — lista faktow, constraints, prior decisions.

---

### KROK 3: OPCJE ARCHITEKTONICZNE (15 min)

Wygeneruj **dokladnie 3 opcje** (nie wiecej, nie mniej):

```
OPCJA A: [nazwa] — [1 zdanie opis]
├── Architektura: [jak to dziala]
├── Stack: [technologie]
├── Effort: [S/M/L/XL]
├── Risk: [glowne ryzyko]
└── Alignment: [jak wpasowuje sie w zasady projektu]

OPCJA B: ...
OPCJA C: ...
```

**Reguly:**
- Opcja A = najprostsza (MVP mindset)
- Opcja B = zbalansowana (wartosc/effort sweet spot)
- Opcja C = najbardziej ambitna (future-proof, ale wiecej pracy)
- Zawsze musi byc opcja z effort = S (kill scope creep)

---

### KROK 4: TRADE-OFF MATRIX

| Kryterium (waga) | Opcja A | Opcja B | Opcja C |
|-------------------|---------|---------|---------|
| Prostota (25%) | | | |
| Composability (25%) | | | |
| Time-to-value (20%) | | | |
| Alignment z zasadami (15%) | | | |
| Reversibility (15%) | | | |
| **SUMA** | | | |

Scoring: 1 (slabo) → 5 (doskonale)

---

### KROK 5: VERDICT

```
VERDICT:
├── Rekomendacja: [OPCJA X]
├── Rationale: [2 zdania max]
├── Trade-off: [co zyskujemy / co tracimy]
├── Reversibility: [HIGH/MED/LOW]
├── Next action: [konkretny krok]
└── CONF: [0.00-1.00]
```

---

### KROK 6: IMPLEMENTATION BLUEPRINT (jesli CONF >= 0.75)

Jesli rekomendacja zatwierdzona:

```
## BLUEPRINT: [nazwa]

### Warstwy systemu
CORE (61.8%): [co jest sercem]
EXTENSION (38.2%): [co jest rozszerzalne]

### Komponenty
1. [komponent] — [odpowiedzialnosc] — [interfejs]
2. ...

### Przeplywy danych
[mermaid diagram lub opis sekwencyjny]

### API / Protokoly
[contract w TypeScript lub pseudokod]

### Task Breakdown
- [ ] TASK 1: [nazwa] — agent: [kto] — effort: [S/M/L]
- [ ] TASK 2: ...

### Metryki sukcesu
- [ ] [mierzalny KPI 1]
- [ ] [mierzalny KPI 2]
- [ ] [mierzalny KPI 3]
```

---

### KROK 7: ZAPIS DECYZJI

Dopisz do `🅒_NOW/DECISIONS.md`:

```markdown
## [DATA] — [TYTUL DECYZJI]
- **Kontekst:** [1 zdanie]
- **Opcje:** A/B/C — [nazwy]
- **Decyzja:** [OPCJA X]
- **Uzasadnienie:** [2 zdania]
- **CONF:** [wartosc]
- **Autor:** [agent]
```

---

## EXIT CONDITIONS

### SUKCES
- VERDICT wydany z CONF >= 0.75
- BLUEPRINT gotowy do delegacji
- Decyzja zapisana w DECISIONS.md
- Zaden punkt nie lamie CONSTITUTION.md

### NOWA RUNDA
- CONF < 0.75 → wroc do KROK 3 z nowymi opcjami
- Owner kwestionuje rekomendacje → wroc do KROK 2 z nowym kontekstem
- Odkryto nowy constraint → wroc do KROK 1

### ESKALACJA
- Decyzja wymaga zmiany CONSTITUTION.md → STOP, eskaluj do ownera
- Decyzja wymaga opinii prawnej (legal) → STOP, flaguj bloker
- Brak wystarczajacych danych do modelowania → uruchom `Check_Me.md`

---

## ANTI-PATTERNS (czego NIE robic)

| Anti-pattern | Dlaczego | Zamiast tego |
|--------------|----------|--------------|
| Zaprojektujmy wszystko od razu | Scope creep, paralysis | MVP → iterate |
| Uzyjmy najnowszej technologii X | CV-driven development | Stack z OPIS_PROJEKTU.md |
| To potem zoptymalizujemy | Tech debt od dnia 1 | Modeluj TERAZ |
| Kazdy modul potrzebuje abstrakcji | Over-engineering | Abstrakcja po 3. uzyciu |
| Skopiujmy jak robi firma X | Inny kontekst | Modeluj SWOJE dane |
| Budowanie bez PROBLEM_FRAME | Rozwiazujesz zly problem | Zawsze KROK 1 first |

---

## COMPOSABILITY Z INNYMI SKILL-AMI

```
Brain_Storming.md → generuj pomysly PRZED System_Architect
System_Architect  → architektura, model, blueprint
Implementacja     → wykonaj taski z blueprint (lub Fi deleguje manualnie)
Preflight.md      → gate PRZED deploy wynikowego kodu
Check_Me.md       → gdy CONF < 0.70 lub brak danych
```

**Pelny pipeline:**
`Brain_Storming → System_Architect → [Implementacja x N] → Preflight → Deploy`
