# WORKFLOW vs NATYWNY CLAUDE — diagnoza + Grill_Me + werdykt

> Sesja 17, 2026-05-29. Pytanie Fi: *„Jak bardzo mój workflow / repo / architektura zarządzania przeszkadza albo zabiera Claude Code jego umiejętności źródłowe? Czy występuje coś takiego?"*
> Skille: Brain_Storming (superpowers) → Grill_Me (self-test własnej analizy).

---

## Teza (po Grillu, oczyszczona z retoryki)

Workflow **nie dotyka „algorytmu"** — model pod spodem jest identyczny w repo i w pustym folderze. Gra toczy się o **alokację uwagi** i **protokół działania** (kiedy działam sam vs pytam), nie o moc.

---

## Bilans na 3 osiach

| Oś | Co DAJE | Gdzie TNIE |
|----|---------|------------|
| Autonomia | Hooki = bramki na nieodwracalne (secrets/deploy/git add) ratują przed faulami | „Glob SKILL przed KAŻDYM ruchem" = ceremoniał przy mikro-tasku |
| Jakość myślenia | 12 zasad poznawczych podnosi sufit | Skille jako sztywny formularz wymuszają sztuczną symetrię |
| Uwaga/kontekst | STATE/DECISIONS/CHECKLIST = pamięć między sesjami | Warstwa mikro-feedbacków = stały podatek od uwagi |

---

## Grill_Me — co padło, co przeżyło

**Padło (fałszywa precyzja, wycofane):**
- Liczby „80% wzmacnia / 20% tnie" — nigdy nie zmierzone, retoryka.
- „Netto zawsze plus" — tylko dla sesji-ścian (produkcja, wielosesyjne); dla czystego brainstormu uprząż przeszkadza.
- Metoda: introspekcja agenta o własnych kajdanach jest zawodna — brak „siebie-bez-workflow" do porównania.

**Przeżyło (twarde):**
- Rdzeń „to nie algorytm, to alokacja uwagi + protokół" — broni się w pełni.
- 🔴 **Konflikt reguł** (fakt z plików): KARDYNALNA „glob przed KAŻDĄ operacją" vs CO_PILOT §4 krok 7 „prosty task = zero skilli". Twardsza (z karą) wygrywała → paraliż nad drobiazgiem. JEDYNE dowodliwe tarcie.

---

## WERDYKT: 🟡 ŻÓŁTY, CONF 0.72

Workflow **nie okrada Cię z Claude** — w przeważającej części to uprząż (pamięć + kierunek + siatka bezpieczeństwa), nie kajdany. Realne tarcie istnieje, ale jego *rozmiaru nie da się zmierzyć*; jedyne **dowodliwe** to konflikt reguł.

**GO:** chirurgiczne rozbrojenie konfliktu (granica mikro vs nietrywialne).
**NO-GO:** cięcie workflow hurtem, osłabianie KARDYNALnej (powstała z realnych korekt), działanie na zmyślonych liczbach.

---

## Zmiana wdrożona (Fi: „GO")

`feedback_skille_kardynalne.md` (workspace memory) + pointer w `MEMORY.md`:
- Glob SKILL **obowiązuje**: nowy plik/moduł, >~50 linii, deploy, placement, kreacja, refaktor, nieodwracalne.
- Glob SKILL **pomijam**: typo, fix <~20 linii/1 plik, rename, 1 linia, odczyt.
- Granica niejasna → glob (jak próg Auto_Codex).

Konflikt „KAŻDĄ" vs „prosty task" usunięty. Ochrona zostaje tam, gdzie błąd boli.
