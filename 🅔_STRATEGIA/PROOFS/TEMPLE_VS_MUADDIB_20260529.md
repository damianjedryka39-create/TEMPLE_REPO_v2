# PROOF — Analiza porównawcza TEMPLE_REPO_v2 vs MUADDIB (2026-05-29)

> Źródło decyzji D22 + D23. Surowy output workflow (17 agentów, ~907k tk):
> `/tmp/claude-0/.../tasks/wsxxnfimv.output` (sesyjny, nietrwały).
> Wejście MUADDIB: `MU_WORKFLOW.md` dostarczony przez Fi (system zewnętrzny, Obsidian Vault).

## Metoda

Workflow wielo-agentowy (skill Expert_Council rozszerzony): 7 podsystemów × (porównanie → adversarialna weryfikacja wprost w plikach TEMPLE) + rada 3 ekspertów (Futurist / Systems-thinker / Pragmatist). Osie: optymalizacja / wydajność / efektywność (1-5).

## Wynik — scoring (suma 3 osi, max 15)

| Podsystem | TEMPLE | MUADDIB |
|---|---|---|
| Pamięć / rehydrate | **13** | 10 |
| Routing skilli | **13** | 10 |
| Token economy | **12** | 10 |
| Hooki | 11 | 11 |
| Warstwa wiedzy (LLM Wiki) | 10 | **12** |
| Samodoskonalenie | 9 | **11** |
| Architektura core | 9 | **12** |
| **SUMA** | **77** | **76** |

Remis. TEMPLE wygrywa w logistyce/egzekucji (hooki, SSOT, router, glob-discovery). MUADDIB wygrywa w domkniętych pętlach feedback (detekcja crashu) i strukturze grafu wiedzy.

## Werdykt rady ekspertów (zbieżny 3/3)

- **Futurist:** wygra warstwa EGZEKUCJI (hooki — niezależne od modelu, rosną przy rojach agentów) + STRUKTURA GRAFU WIEDZY. Optymalizacje scarcity-tokenów = martwy kapitał za 2 lata. Split stron (>500 linii) anti-future-proof.
- **Systems-thinker:** TEMPLE ma czystszy SSOT, ale 2 OTWARTE pętle które MUADDIB domyka: crash (session_status) + telemetria. Prawdziwy bottleneck wiedzy = propagation-cost liniowy z LICZBĄ stron, nie rozmiar.
- **Pragmatist:** kompresja wiedzy = over-engineering przy 5 stronach (F5). Jedyny twardy, tani konkret z MUADDIB: czujka urwanej sesji (~10 linii).

## Decyzje (przyjęte)

- **D22 — Czujka urwanej sesji** (ADOPT, 3/3 #1 ROI). Marker `.claude/.session_active`: jedyna twarda luka TEMPLE (`grep session_status`=0).
- **D23 — Warstwa wiedzy ewoluuje** (po korekcie Fi: auto-rozwój = równie ważny co hooki). Zagęszczanie zamiast splitu + pętla open-questions. KSZTAŁT teraz, ciężka maszyneria później.

## Odrzucone (weryfikacja: REJECT/DROP)

- Auto-rehydrate 5 plików (anty-optymalizacja — TEMPLE ma dwuwarstwowość lepszą).
- Model tiering Haiku/Sonnet/Opus (placebo przy pracy na Opus).
- Cofnięcie D20 (Fi zdecydował świeżo, DECISIONS „nie debatuj ponownie").
- „Prawdziwa graduacja lekcji" + „§ŻELAZNE do rehydrate" (TEMPLE JUŻ to ma — D19, Reflect 2×).

## Meta-wniosek (kierunek)

Nie optymalizować niedoboru tokenów (10× tańsze za 2 lata). Inwestować w 2 warstwy rosnące na wartości: **hooki (egzekucja niezależna od modelu)** + **jakość grafu wiedzy**. Powiązane: L17, F5, D21.
