# ANALIZA — wykład o wzorcach agentowych (LangGraph / Building Effective Agents)

> Data: 2026-07-30 | Źródło podane przez Fi: `x.com/EngMoElgaraihy/status/2081505972934132047`
> Materiał: wideo natywne X, **36:10**, angielski. Pełna transkrypcja: `AGENT_PATTERNS_20260730_transkrypcja.md`
> Metoda: `yt-dlp` (audio 128k) → `faster-whisper small` (int8, CPU, 881 s pracy), 1046 segmentów.

---

## 1. Czym to jest naprawdę (weryfikacja źródła)

| Twierdzenie tweeta | Fakt z nagrania |
|---|---|
| „Anthropic engineer" | Prowadzi **inżynier/edukator LangChain** — mówi o LangGraph w pierwszej osobie mnogiej („mamy API `send`", „pracujemy nad zmniejszeniem narzutu"), odsyła do LangChain Academy jako do własnego kursu (04:11) |
| „70% naszych inżynierów używa self-improving loops" | **Nie pada w nagraniu.** Ani ta liczba, ani to zdanie, ani nic o „self-improving" |
| „Koniec promptowania, za 3-6 miesięcy wszyscy budują grafy" | **Nie pada.** Nagranie kończy się na zaletach frameworka, bez żadnej prognozy czasowej |
| „Agentic Graphs to przyszłość" | Nagranie mówi wprost coś **przeciwnego** — patrz §3 |

Związek z Anthropic jest realny, ale inny: od 04:22 prowadzący jawnie deklaruje, że przechodzi przez artykuł **„Building Effective Agents"** (Anthropic) i buduje w LangGraph **każdy** opisany tam wzorzec. Anthropic = autor taksonomii, LangChain = autor tego nagrania. Dodatkowa wzmianka: SWE-bench jako przykład, gdzie architektura agentowa się sprawdziła (28:48).

**Wniosek:** nagłówek tweeta jest zmyślony. Materiał źródłowy jest natomiast solidny i darmowy.

---

## 2. Mapa nagrania (do przeskakiwania)

| Czas | Temat |
|------|-------|
| 00:00–04:21 | Agent w LangGraph od zera: narzędzia → węzły/krawędzie → `state` → `compile`; LangGraph Studio (wizualne debugowanie) |
| 04:22–09:30 | **Definicja: workflow vs agent.** Workflow = rusztowanie predefiniowanych ścieżek wokół wywołań modelu. Agent = model sam decyduje o akcjach |
| 09:32–13:33 | **Prompt chaining** — łańcuch kroków + bramka (gate) między nimi |
| 13:42–15:10 | **Parallelization** — kilka wywołań naraz + agregacja |
| 15:12–18:15 | **Routing** — model wybiera jedną ścieżkę; trik: `structured output` zamiast tool-callingu |
| 18:19–24:00 | **Orchestrator-worker** — model planuje, ile pracowników odpalić (nie wiadomo z góry), `send` API, synteza wyników |
| 24:04–27:36 | **Evaluator-optimizer** — generator + oceniający w pętli, feedback wraca do generatora |
| 27:52–33:20 | **Agent** — pętla tool-calling + „environmental feedback", aż model przestanie prosić o narzędzia |
| 33:20–34:12 | **Werdykt praktyczny** (najważniejsze 50 sekund — §3) |
| 34:13–36:07 | `create_react_agent` (gotowiec) + co daje framework: persystencja, pamięć krótko/długoterminowa, przerwanie i wznowienie (human-in-the-loop), streaming, deploy |

---

## 3. Sedno — nagranie mówi odwrotnie niż tweet

Prowadzący, po zbudowaniu wszystkich siedmiu wzorców, stwierdza wprost (33:20–34:12, parafraza + krótkie cytaty):

- agenty *„nie były jak dotąd szczególnie niezawodne"*, zwłaszcza przy dużej liczbie narzędzi i długich trajektoriach wywołań;
- *„wielu ludzi w produkcji woli workflow"*, i sam przyznaje: *„zrobiłem znacznie więcej workflow niż agentów przez ostatni rok czy dwa"*;
- reguła kciuka (29:14): **jeśli z grubsza znasz sekwencję narzędzi — lepiej zamknąć ją w workflow, bo to kwestia niezawodności**, zamiast liczyć, że agent trafi w tę sekwencję sam;
- zastrzeżenie w drugą stronę: gdy modele staną się dostatecznie dobre w tool-callingu, część rusztowania stanie się zbędna — i wtedy ruch pójdzie w stronę prostego agenta.

Drugi powtarzający się motyw: *„structured outputs to praktycznie wszystko, czego potrzeba"* (24:41) — router, ocena, plan pracowników; wszystko da się oprzeć na wymuszonym formacie odpowiedzi, bez tool-callingu.

---

## 4. Mapowanie na nasz system — co już mamy

| Wzorzec z nagrania | Nasz odpowiednik | Status |
|---|---|---|
| Routing | `CO_PILOT.md §4` (router 0→10) | mamy |
| Parallelization | subagenci, `Expert_Council` (3 soczewki) | mamy |
| Orchestrator-worker | `Agent Teams` (§8), `Proof_Boost` (39 agentów, 6 sektorów) | mamy |
| Evaluator-optimizer | `Grill_Me` → poprawka → powtórz; `Code_Reviewer` jako drugie oko | mamy, ale bez jawnego kanału feedbacku |
| Agent (pętla narzędzi) | sam Claude Code | mamy |
| Gate deterministyczny | hooki `.claude/hooks/` (D21) | mamy — i to ta sama filozofia |
| Persystencja stanu | `STATE` + `CHECKLIST` + marker sesji (D22) | mamy |
| Structured output jako sterowanie | — | brak (u nas sterowanie idzie prozą w markdownie) |

Wniosek: **taksonomia z nagrania nie wnosi do TEMPLE nowego wzorca.** Wszystkie siedem mamy w formie procesu — nagranie pokazuje ich implementację w Pythonie, my mamy je jako procedury dla agenta.

---

## 5. Co realnie warto z tego wziąć (3 rzeczy, do decyzji Fi)

### 5.1 🔴 Twardy kontrargument dla T1/T3 — najcenniejsze

Nasz plan `PB-5` zakłada (T3): *router 12 kroków → 3 bramki*, z uzasadnieniem „model nie iteruje literalnie po krokach, czyta całość i decyduje". Plus T1: *reguły wstrzykiwane przy akcji zamiast na starcie*.

To jest **dokładnie przejście workflow → agent**: zdejmujemy rusztowanie i ufamy, że model podejmie właściwą decyzję sam. Nagranie mówi, że w produkcji ruch idzie w **przeciwną** stronę i podaje kryterium: *znasz sekwencję → zostaw workflow*.

A my sekwencję znamy — router opisuje ustalone przypadki, które powtarzają się co sesję.

**Nie znaczy to, że T3 jest zły.** Znaczy, że przed wdrożeniem trzeba rozstrzygnąć: które kroki routera są przewidywalną sekwencją (zostają sztywne), a które są realnie otwarte (mogą pójść do bramek). Materiał na `Grill_Me` przy PB-5, nie na osobne zadanie.

### 5.2 🟡 Bramka to zwykły kod, nie prośba do modelu

W łańcuchu (11:32) bramka sprawdza wynik **zwykłym warunkiem w Pythonie**, nie kolejnym wywołaniem modelu. To potwierdza kierunek D21 (hooki) i PB-3: **co da się sprawdzić deterministycznie, nie powinno być prośbą w pliku .md**. Nic do zmiany — potwierdzenie kursu.

### 5.3 🟡 Pętla oceny z jawnym feedbackiem w stanie

W evaluator-optimizer (25:41) generator **sprawdza, czy w stanie jest feedback z poprzedniej rundy** i jeśli jest — dokleja go do promptu. U nas `Grill_Me` przy powtórce analizuje od nowa, bez jawnego „poprzednim razem odrzucono z powodu X".

Drobne, tanie ulepszenie: w `Grill_Me` dopisać krok „jeśli to runda 2+, wypisz zarzuty z rundy 1 i odnieś się do każdego". Kandydat do PB-5, nie pilne.

### Czego NIE bierzemy

**LangGraph jako framework.** Nie budujemy produktu agentowego w Pythonie — nasz „graf" to procedury w markdownie plus hooki. Jedyne miejsce, gdzie to mogłoby mieć sens, to **backend Nio w GOFANS**, gdyby kiedyś urósł ponad pojedyncze wywołanie modelu (np. router pytań + ocena odpowiedzi przed wysłaniem). Dziś: nie.

---

## 6. Werdykt

🟡 **Materiał wartościowy, ale nie jako „nowa architektura".** Wartość jest w jednym zdaniu, które uderza w naszą własną, jeszcze niezatwierdzoną decyzję (T3) — i w potwierdzeniu, że kierunek „hooki zamiast próśb" jest zgodny z praktyką produkcyjną.

Zero do wdrożenia natychmiast. Jedna rzecz do skonfrontowania przy PB-5.

Osobno warta odnotowania lekcja o samym źródle: tweet z 2993 polubieniami przypisał wykład niewłaściwej firmie i włożył w usta prowadzącego zdania, których nie wypowiedział — a treść nagrania mówi coś przeciwnego niż nagłówek. To ten sam mechanizm, który złapał nasz audyt (F6: **pomiar > deklaracja**), tylko na zewnętrznym materiale.
