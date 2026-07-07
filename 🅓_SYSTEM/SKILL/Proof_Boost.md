---
name: Proof_Boost
trigger: "proof boost|głęboki audyt|audyt repo|audyt workflow|boost systemu|deep audit"
purpose: Głęboki multi-agentowy audyt repo — optymalizacja, wydajność, efektywność, rozwój usera, egzekwowalność, spójność. Twarde fakty z dowodami, zero przypuszczeń.
output: PROOF w 🅔_STRATEGIA/PROOFS/PROOF_BOOST_<YYYYMMDD>.md + werdykt + Grill_Me werdyktu + handoff CHECKLIST
agents: [Claude + subagenci]
cross_link: [Grill_Me.md, Expert_Council.md, Context_Forge.md, Reflect.md]
ecosystem: {{NAZWA_PROJEKTU}}
---

# SKILL: PROOF_BOOST — audyt na twardych faktach

---

## ŻELAZNA ZASADA

**Znalezisko bez dowodu = śmieć.** Każde znalezisko MUSI mieć:
- `plik:linia` + cytat, ALBO
- komendę + jej realny wynik (grep / wc / git log).

Przypuszczenia, „co by było gdyby", opinie bez pokrycia → DISCARD na wejściu.

---

## PRE-CHECK

1. Rehydrate zrobiony? (STATE + CHECKLIST + DECISIONS w kontekście) → jeśli nie, rehydrate najpierw
2. `git status` czysty? — audytujemy stan zapisany, nie WIP
3. DECISIONS.md w głowie — znalezisko dotykające rozstrzygniętej decyzji (D#) musi ją jawnie zaadresować i uzasadnić co zmienia kalkulację, nie „odkrywać" tematu na nowo

---

## KROK 1 — PANEL 6 SPECJALISTÓW (subagenci, równolegle)

| # | Sektor | Co bada (przykładowe twarde checki) |
|---|--------|-------------------------------------|
| 1 | **Optymalizacja** | koszt tokenów: `wc -w` plików rehydrate, duplikaty treści między plikami, bloat governance vs limity |
| 2 | **Wydajność** | tarcie operacyjne: ile odczytów/kroków od startu sesji do pierwszej realnej roboty; overhead routera i procedur |
| 3 | **Efektywność** | czy workflow DOWOZI: `git log` vs deklaracje (sync_state realnie robiony?), CHECKLIST vs rzeczywistość, martwe procedury |
| 4 | **Rozwój usera** | pętla uczenia: powtórki tych samych korekt w LESSONS (powtórka = pętla NIE działa), użycie Reflect, wzrost KNOWLEDGE, dwukierunkowość (system uczy USERA, nie tylko agenta) |
| 5 | **Egzekwowalność** | reguła po regule: wymuszana hookiem (`.claude/hooks/`, settings.json) czy wisi na dobrej woli agenta? Dobra wola = udokumentowana awaryjność |
| 6 | **Spójność / Drift** | martwe referencje (ścieżki, które nie istnieją), złamania SSOT (ta sama prawda w 2+ plikach), rozjazdy wersji między plikami |

**Kontrakt specjalisty:** max 7 znalezisk, każde = `{tytuł, severity CRITICAL/IMPORTANT/MINOR, dowód, impact, fix}`. Specjalista SAM wykonuje komendy — nie teoretyzuje.

---

## KROK 2 — SCEPTYCY (adversarial verify)

Każde znalezisko → niezależny subagent-sceptyk z jednym zadaniem: **OBALIĆ je na repo**.
Sceptyk sam sprawdza dowód (odpala komendy, czyta pliki). Nie może potwierdzić = znalezisko PADA.
Przeżywają tylko potwierdzone. Obalone → lista `REFUTED` z powodem (też wartość — pokazuje gdzie audyt przesadził).

---

## KROK 3 — SYNTEZA + WERDYKT (trzy koszyki — L18)

Agent (główne okno): potwierdzone znaleziska → tabela wg severity → **werdykt ZIELONY/ŻÓŁTY/CZERWONY + CONF**. Output MUSI mieć trzy koszyki:
1. **FIX** — co zepsute: plan napraw z dowodami, kolejność wg blast-radius.
2. **IMPROVE** — co działa, ale mogłoby lepiej: propozycje zmian architektury/procesu, których user nie widzi.
3. **INSIGHT** — tajniki: co agent wie o działaniu modeli/agentów spoza repo, zastosowane do tego systemu.

Sam FIX = połowa roboty (L18). Jedna rekomendacja główna per koszyk, nie lista życzeń.

---

## KROK 4 — GRILL_ME WERDYKTU

Odpal `Grill_Me.md` na WŁASNYM werdykcie — coverage min 5/7 (założenia, edge cases, zależności, alternatywy, ryzyka, koszty, reversibility). Werdykt, który nie przeżył grilla → przerób i grilluj ponownie.

---

## KROK 5 — OUTPUT + HANDOFF

1. PROOF: `🅔_STRATEGIA/PROOFS/PROOF_BOOST_<YYYYMMDD>.md` (znaleziska + refuted + werdykt + grill)
2. CHECKLIST handoff (ŻELAZNA #4) — fixy jako pozycje NEXT/BACKLOG
3. **Werdykt = REKOMENDACJA, nie zgoda.** Adopcja fixów wymaga explicit komendy usera (ŻELAZNA #5, L16)

---

## UWAGI / ANTI-PATTERNS

- NIE otwieraj na nowo tematów rozstrzygniętych w DECISIONS bez nowych faktów
- NIE raportuj znalezisk bez dowodu „bo wydaje się słuszne"
- Max 7 znalezisk per sektor — sygnał, nie szum
- Skala: pełny panel 6 = duża sesja (audyt kwartalny / przed propagacją); szybki puls = 3 sektory (1+3+5)
- Sunset check jak każdy skill: >60 dni nieużyty → review
