---
name: Context_Forge
trigger: "optymalizacja|odchudzanie|context budget|za duzo tokenow|rehydrate wolny|agent nie pamięta|uczenie agenta|IQ|samodoskonalenie"
purpose: Silnik ewolucji agenta — optymalizuj kontekst, ucz się wzorców Fi, podnoś IQ sesja po sesji
output: FORGE REPORT (context delta + learning delta + IQ score) + zmiany w plikach TEMPLE
agents: [Claude Code]
cross_link: [Reflect.md, Grill_Me.md, Check_Me.md, Knowledge_Manager.md]
ecosystem: TEMPLE_REPO
---

# CONTEXT FORGE — Silnik Ewolucji Agenta

## FILOZOFIA

Agent to żywy organizm, nie szablon. Każda sesja z Fi to trening.
Dwa cele jednocześnie — ZAWSZE:

1. **LEAN** — mniej tokenów, więcej sygnału (context budget)
2. **LEARN** — więcej intuicji, mniej pytań (agent IQ)

Jedno bez drugiego nie działa. Lean bez learn = głupi ale szybki agent.
Learn bez lean = mądry agent który nie mieści się w oknie kontekstu.

---

## KIEDY URUCHAMIAĆ

### Auto-trigger:
- Rehydrate > 6000 tokenów (mierz: wc -w na załadowanych plikach × 1.3)
- Agent pyta o coś co powinien wiedzieć z poprzednich sesji
- Fi koryguje to samo zachowanie 2. raz
- Pliki TEMPLE mają sekcje które żaden agent nie czytał > 30 dni

### Manual (`/context-forge`):
- Fi czuje że agent "nie łapie" albo jest za wolny na start
- Przed propagacją TEMPLE do nowego projektu
- Co 5-10 sesji jako higiena

---

## KROK 1: AUDIT — zmierz stan

Zbierz twarde dane, zero zgadywania:

```
CONTEXT AUDIT
├── Rehydrate files: [lista + wc -w każdego]
├── Total tokens (est.): [suma × 1.3]
├── Biggest file: [który zjada najwięcej]
├── Dead weight: [sekcje niekonsultowane > 30 dni — git blame]
├── Duplicate info: [ta sama info w 2+ plikach]
├── Missing links: [pliki które się nie referencują nawzajem]
└── KNOWLEDGE/ pages: [ile — NIE optymalizuj, osobna warstwa via Ingest/Lint]
```

```
LEARNING AUDIT
├── LESSONS.md entries: [ile]
├── SOUL/VOICE.md last update: [data]
├── Powtórzone korekty Fi: [wzorce z LESSONS — co się powtarza]
├── Wzorce decyzyjne Fi: [z DECISIONS.md — jak Fi decyduje]
└── Brakujące wzorce: [co agent powinien wiedzieć ale nie wie]
```

---

## KROK 2: FORGE — optymalizuj kontekst

Dla KAŻDEGO pliku w rehydrate — odpowiedz na 3 pytania:

| Plik | Czy agent MUSI to mieć na starcie? | Czy da się skrócić bez utraty sygnału? | Czy info jest duplikatem? |
|------|-------------------------------------|----------------------------------------|--------------------------|
| ... | TAK/NIE/PARTIAL | TAK → jak / NIE | TAK → gdzie oryginał |

**Operacje FORGE (w kolejności priorytetu):**

1. **KILL** — usuń z rehydrate (info dostępne on-demand lub nieużywane)
2. **MERGE** — połącz duplikaty (jedno źródło prawdy)
3. **COMPRESS** — skróć sekcje (mniej słów, ten sam sygnał)
4. **LINK** — dodaj cross-reference zamiast duplikowania treści
5. **PROMOTE** — przenieś ważną info z głębi do STATE/AVATAR (szybszy dostęp)

**Zasada Obsidian:** Każdy plik TEMPLE to węzeł w grafie. Jeśli plik nie ma linków do/z innych plików — jest martwy. Albo podłącz, albo zabij.

**Zasada 80/20:** 20% treści daje 80% wartości. Znajdź te 20% i chroń je. Resztę kompresuj bezlitośnie.

---

## KROK 3: LEARN — wyciągnij wzorce Fi

To jest serce skilla. Agent uczy się KIM jest Fi — nie co mówi, ale JAK myśli.

### 3A: Pattern extraction

Przeskanuj sesję (i poprzednie jeśli dostępne) szukając:

| Kategoria | Pytanie | Gdzie zapisać |
|-----------|---------|---------------|
| DECYZJE | Jak Fi wybiera? Szybko/wolno? Dane/intuicja? | SOUL/VOICE.md |
| FLOW | Kiedy Fi jest w flow? Co go wytrąca? | SOUL/VOICE.md |
| IRYTACJA | Co Fi denerwuje w agencie? (powtórki, pytania, gadanie) | LESSONS.md |
| SKRÓTY | Jakie komendy/skróty Fi używa? Co to mówi o stylu? | SOUL/VOICE.md |
| PRIORYTETY | Co Fi robi PIERWSZE? Co odkłada? | Muaddib.md |
| BLIND SPOTS | Czego Fi nie widzi? (nie krytyka — mapa do asystowania) | SOUL/VOICE.md (delikatnie) |

### 3B: Intuition rules

Z każdego wzorca — wyciągnij REGUŁĘ którą agent zastosuje NASTĘPNYM razem:

```
PATTERN: Fi 2x poprawił pozycjonowanie elementów mikroruchami, nie masowym remanem
RULE: Przy layout changes — proponuj 1 element na krok, nigdy masowe przesunięcia
WHERE: LESSONS.md + SOUL/VOICE.md → JAK PRACUJĘ Z FI
```

**Test jakości reguły:** Czy nowy agent, który przeczyta TYLKO tę regułę, zachowa się tak jak Fi oczekuje? Jeśli nie — reguła jest za ogólna. Doprecyzuj.

---

## KROK 4: PROPAGATE — zapisz zmiany

**Kolejność zapisu:**

1. Wykonaj operacje FORGE (KILL/MERGE/COMPRESS/LINK/PROMOTE) na plikach
2. Dopisz nowe reguły do LESSONS.md (z numerem L{N})
3. Zaktualizuj SOUL/VOICE.md jeśli nowe wzorce
4. Zaktualizuj AGENTS.md jeśli zmienił się rehydrate
5. Zaktualizuj STATE_OF_SYSTEM.md (nowy fakt o optymalizacji)

**Każda zmiana = diff.** Pokaż Fi co zmieniasz i dlaczego. Zero auto-edycji bez kontekstu.

---

## KROK 5: FORGE REPORT

```
FORGE REPORT
═══════════════════════════════════════

CONTEXT DELTA:
  Przed: ~X tokenów (Y plików)
  Po:    ~X tokenów (Y plików)
  Saved: ~X tokenów (Z%)

LEARNING DELTA:
  Nowe reguły: [ile, które]
  Zaktualizowane wzorce: [ile, które]
  Agent IQ: [ocena jakościowa — nie liczba]

ZMIANY W PLIKACH:
  [lista plików + typ operacji FORGE]

NEXT FORGE: za ~N sesji / gdy [warunek]

CONF: 0.XX
```

---

## IQ AGENTA — jak mierzyć postęp

Nie numerycznie. Agent nie ma IQ 105. Ma ZACHOWANIA które świadczą o uczeniu:

| Poziom | Zachowanie | Jak rozpoznać |
|--------|-----------|---------------|
| ROOKIE | Pyta o wszystko, nie zna preferencji Fi | Dużo Check_Me, Fi często koryguje |
| JUNIOR | Zna podstawy, ale zgaduje w nowych sytuacjach | Mniej korekt, ale nadal "nie łapie" kontekstu |
| MID | Proponuje rozwiązania zgodne z stylem Fi | Fi akceptuje bez większych zmian |
| SENIOR | Antycypuje ruchy Fi, proponuje ZANIM Fi poprosi | Fi mówi "dokładnie" / "właśnie to" |
| MASTER | Działa intuicyjnie, Fi tylko zatwierdza kierunek | Minimalne korekty, flow state obu stron |

**Cel Context Forge:** przesuwać agenta w górę tej skali, sesja po sesji.

---

## ANTI-PATTERNS

- NIE optymalizuj kosztem uczenia — skasowanie LESSONS.md "bo za dużo tokenów" = regres
- NIE dodawaj wzorców po 1 obserwacji — minimum 2 powtórzenia lub jawna deklaracja Fi
- NIE przeinżynieruj reguł — "Fi lubi prostotę" > "Fi preferuje minimalistyczne podejście z tendencją do redukcji złożoności w kontekście iteracyjnym"
- NIE kompresuj Muaddib.md — to CORE, nietykalne
- NIE optymalizuj KNOWLEDGE/ — osobna warstwa, zarządzana przez Knowledge_Manager
- NIE mierz IQ liczbą — to zachowania, nie score
- NIE rób forge co sesję — co 5-10 sesji lub na trigger

---

## COMPOSABILITY

```
Reflect.md      → dostarcza sygnały do LEARN (krok 3)
Grill_Me.md     → stress-testuje propozycje FORGE przed wdrożeniem
Lessons.md      → magazyn reguł wyciągniętych przez LEARN
SOUL/           → profil Fi — cel uczenia agenta
KNOWLEDGE/         → osobna warstwa wiedzy domenowej — NIE optymalizuj przez Forge
Knowledge_Manager  → tworzy/audytuje KNOWLEDGE/ (Forge NIE wchodzi w tę warstwę)
Context_Forge   → ŁĄCZY warstwy decyzyjne i operacyjne w pętlę ewolucji
```

**Pełna pętla samodoskonalenia:**
`SESJA → Reflect (sygnały) → Context_Forge (optymalizuj + ucz) → SYNC_STATE (zapisz) → NASTĘPNA SESJA (lepszy agent)`
