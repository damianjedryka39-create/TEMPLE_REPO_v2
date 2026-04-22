# PROOF — Agent Quality / TEMPLE token bloat

Data: 2026-04-18
Obszar: Agent Quality / Context Engineering
Plik główny: `🅐_OPIS/Silnik.md` (źródło pierwotne — PROBLEM section wyniesiona tu w sesji 13 / task B4)

## CEL

Zachować diagnozę Fi z 2026-04-18 o przeroście TEMPLE (~14k tk overhead przed zadaniem), która uruchomiła serię decyzji odchudzających: D9 (root files 7→5), D10/D13 (Auto_Codex), D11 (MIND+AVATAR→Muaddib), D12 (KNOWLEDGE Pocket), D14 (router krok 0.5). Oryginał żył w `Silnik.md §PROBLEM` — plik został przepisany na 1-zdaniowy pointer (zgodnie z CHECKLIST B4 / TEMPLE_REVIEW_20260421).

## ZAKRES SESJI (2026-04-18)

- Diagnoza: 14k tokenów instrukcji przed zadaniem (system prompt + CLAUDE.md + LESSONS + REHYDRATE TEMPLE)
- Hipoteza: degradacja jakości przez 3 mechanizmy (attention dilution, procedura zjada myślenie, paradoks kontroli)
- Wniosek otwarty: TEMPLE musi schudnąć o ~70% przez wyrzucenie, nie kompresję

## STAN KOŃCOWY (po sesji 12, 2026-04-21)

- REHYDRATE TEMPLE ~3.5-4.5k tk (audit potwierdzony w TEMPLE_REVIEW_20260421)
- Root files 7→5 (D9), rehydrate 6→5 (D11), 14→13 skilli (Knowledge_Manager merge)
- Router skilli: 8 kroków + 0.5 (lookup) + 0/8 (Reflect) — CO_PILOT.md §4
- Auto_Codex przejął kodowanie >~20 linii (D10→D13), Claude = architekt/gate
- PHASE A/B/C fixów w toku — patrz `TEMPLE_REVIEW_20260421.md`

## KLUCZOWE DECYZJE (śladowane z tej diagnozy)

- D9 (2026-04-18) — INDEX→AGENTS, MEMORY→LESSONS (-2 pliki root)
- D10 (2026-04-18→19) — Codex manual→auto-delegacja
- D11 (2026-04-18) — MIND+AVATAR→Muaddib.md (rehydrate 6→5)
- D12 (2026-04-19) — KNOWLEDGE Pocket (warstwa wiedzy domenowej, poza rehydrate)
- D13 (2026-04-19) — Auto_Codex redesign (inline prompt, 2 rundy, gate)
- D14 (2026-04-21) — Router krok 0.5 (auto-lookup w KNOWLEDGE/index.md)

## POWIĄZANE PLIKI

- `🅐_OPIS/Silnik.md` (po B4: 1-zdaniowy pointer)
- `🅓_SYSTEM/AGENT/CO_PILOT.md` (router SSOT)
- `AGENTS.md` (rehydrate SSOT + mapa skilli)
- `🅒_NOW/DECISIONS.md` (D9-D14)
- `🅔_STRATEGIA/PROOFS/TEMPLE_REVIEW_20260421.md` (pełny audyt sesji 10)

## PROOF / DOWÓD

Treść diagnozy Fi (2026-04-18):

> **Problem jest głębszy niż "za dużo tokenów"**
> Policzmy pełny kontekst jaki agent dostaje zanim w ogóle zacznie myśleć o Twoim zadaniu:
>
> | Warstwa | ~Tokenów |
> |---------|----------|
> | System prompt Claude Code | ~3 000 |
> | CLAUDE.md (global) | ~800 |
> | LESSONS.md + pliki pamięci | ~2 500 |
> | REHYDRATE TEMPLE | ~7 700 |
> | Σ overhead przed zadaniem | ~14 000 |
>
> To 14 tysięcy tokenów instrukcji zanim agent przeczyta pierwsze słowo Twojego zadania.
>
> **Dlaczego to degraduje jakość — trzy mechanizmy:**
>
> 1. **Rozproszenie uwagi (attention dilution)** — Im więcej instrukcji, tym mniej "wagi" model kładzie na każdą z nich. Muaddib.md mówi "bądź prosty", CO_PILOT mówi "przejdź router 8-krokowy", CHECKLIST mówi "pracuj wg listy". Agent próbuje spełnić wszystko naraz i nie robi dobrze niczego.
>
> 2. **Procedura zjada myślenie** — Agent spędza cykle mentalne na: "czy powinienem odpalić skill? który skill? czy CONF < 0.85? czy to krok 0 czy krok 4?" — zamiast myśleć o problemie.
>
> 3. **Paradoks kontroli** — Im bardziej precyzyjne instrukcje, tym bardziej agent zachowuje się jak biurokrata — odfajkowuje procedurę zamiast używać osądu. Tracisz to, co w LLM najcenniejsze: elastyczne rozumowanie.
>
> **Hipoteza:** TEMPLE w obecnej formie to system zaprojektowany dla idealnego agenta, który nie istnieje. Prawdziwy LLM działa lepiej z:
> - 5 twardych zasad niż 50
> - Przykładami zamiast procedur
> - Wolnością osądu zamiast drzew decyzyjnych
>
> CO_PILOT §4 (Skill Router) sam ma ~2 500 tokenów — to cały mini-dokument poświęcony temu, żeby agent "sam decydował". Ale LLM i tak sam decyduje — router jest redundantny z naturalnym rozumowaniem modelu.
>
> **Pytanie:** Kiedy praca z agentem szła najlepiej — z pełnym TEMPLE, czy gdy dałeś proste polecenie bez tego wszystkiego? Jeśli to drugie, TEMPLE musi schudnąć o 70%, nie przez kompresję, a przez wyrzucenie tego, co przeszkadza.
>
> CONF: 0.75 | STUCK: nie | ASSUMPTIONS: degradacja jakości jest realna, nie tylko wrażenie

## ZASADA DLA KOLEJNEGO AGENTA

- Diagnoza Fi o przeroście TEMPLE jest **źródłem prawdy** dla kierunku odchudzania (D9-D14, PHASE A/B/C w TEMPLE_REVIEW_20260421).
- NIE traktuj tego jako rozwiązany problem — PHASE B/C jeszcze otwarte, DEC-1/DEC-2/DEC-3 wiszą.
- Przy kolejnej propozycji nowego pliku/sekcji/skilla: zapytaj "czy to wyrzucanie, czy dokładanie?". Dokładanie wymaga uzasadnienia vs tę diagnozę.
- Silnik.md jest teraz 1-zdaniowym pointerem do AGENTS.md + CO_PILOT.md — nie odtwarzaj tam ani procedur, ani diagnozy. Diagnoza żyje tu.
