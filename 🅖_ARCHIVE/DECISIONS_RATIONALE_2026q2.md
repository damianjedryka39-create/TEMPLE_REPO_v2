# ARCHIWUM — DECISIONS: pełne rationale (D10-D24, Q2 2026)

> Wyniesione z `🅒_NOW/DECISIONS.md` przy PB-2 (Context_Forge, 2026-07-30).
> Powód: kolumny „Opcje + „Dlaczego zjadały 2109 słów rehydrate. W tabeli zostaje 1 zdanie + pointer tutaj.
> Zasada: **move, nigdy delete**. Decyzja pozostaje wiążąca — to jest jej pełne uzasadnienie.

---

## D1 — 2026-04-18

**Decyzja:** CHECKLIST.md = SSOT zadań

**Opcje rozważane:** —

**Dlaczego:** Żyje w Muaddib.md + CO_PILOT §3

**CONF:** 0.95

---

## D2 — 2026-04-18

**Decyzja:** Agent decyduje sam o skillach

**Opcje rozważane:** —

**Dlaczego:** Żyje w CO_PILOT §4

**CONF:** 0.90

---

## D3 — 2026-04-18

**Decyzja:** Reflect auto w routerze (krok 0+8)

**Opcje rozważane:** —

**Dlaczego:** Żyje w CO_PILOT §4

**CONF:** 0.92

---

## D4 — 2026-04-18

**Decyzja:** Partial rehydrate: core/state/decisions

**Opcje rozważane:** full-only vs partial

**Dlaczego:** 8k tokenów na start to za dużo. Partial pozwala na 1.5k refresh mid-session

**CONF:** 0.88

---

## D5 — 2026-04-18

**Decyzja:** ~~BOOT.md~~ → zastąpiony przez Context_Forge

**Opcje rozważane:** BOOT vs odchudzanie

**Dlaczego:** Kompresja przez usuwanie duplikatów > kompresja przez streszczenie

**CONF:** 0.90

---

## D6 — 2026-04-18

**Decyzja:** PROOFS/ wyłączony z rehydrate

**Opcje rozważane:** w rehydrate vs on-demand

**Dlaczego:** Agent zapisuje PROOFS w trakcie pracy, nie ładuje na start. STATE ma pointery

**CONF:** 0.92

---

## D7 — 2026-04-18

**Decyzja:** Merge DIET v2 → v1 (best of both)

**Opcje rozważane:** v1-only vs v2-only vs merge

**Dlaczego:** v2 daje -29% tokenów przez ostrzejszy język; v1 ma Context_Forge. Merge = oszczędność + ewolucja. MIND: 5 elementów przywróconych (elegancja, bezlitośnie, nauka Fi, CI, rozwój)

**CONF:** 0.92

---

## D8 — 2026-04-18

**Decyzja:** Konsolidacja: character+ToV→VOICE.md, Mapping→Reflect

**Opcje rozważane:** 6 plików vs 4 pliki

**Dlaczego:** Jedno źródło prawdy o głosie agenta, Reflect samowystarczalny. 2 pliki mniej, zero duplikacji "jak mówię"

**CONF:** 0.93

---

## D9 — 2026-04-18

**Decyzja:** INDEX→AGENTS, MEMORY→LESSONS (7→5 root plików)

**Opcje rozważane:** osobne vs merge

**Dlaczego:** INDEX duplikował CLI/deploy/rehydrate z AGENTS. MEMORY pusty, LESSONS robi tę samą robotę. Merge = zero split-brain, -2 pliki

**CONF:** 0.95

---

## D10 — ~~2026-04-18~~ **2026-04-19**

**Decyzja:** ~~Codex manual only~~ → **Codex AUTO-DELEGACJA**. Claude = architekt/reviewer, Codex = koder (>~20 linii / >1 plik). Gate przed commit. Max 2 rundy.

**Opcje rozważane:** auto vs manual vs hybrid

**Dlaczego:** Fi chce zero ręcznej delegacji. Próg ~20 linii/1 plik = sweet spot (mniejsze = overhead). Inline prompt (nie contract file). Multi-pass (2 rundy) + Claude fallback

**CONF:** 0.92

---

## D11 — 2026-04-18

**Decyzja:** MIND.md + AVATAR.md → Muaddib.md (🅓_SYSTEM/AVATAR/)

**Opcje rozważane:** osobne vs merge

**Dlaczego:** AVATAR dekoracyjny (kompetencje, motto = zero wpływu na agenta). MIND miał tożsamość, AVATAR duplikował. Merge = 1 plik CORE, rehydrate 6→5, -1 root plik. Specjalizacja per-projekt zachowana jako sekcja

**CONF:** 0.92

---

## D12 — 2026-04-19

**Decyzja:** Knowledge Pocket — warstwa wiedzy domenowej w KNOWLEDGE/

**Opcje rozważane:** Knowledge Pocket vs Enhanced Compounding vs Full Karpathy

**Dlaczego:** Minimalna zmiana (1 folder + 2 skille), zero impact na rehydrate, 3 ortogonalne warstwy pamięci (DECISIONS/LESSONS/KNOWLEDGE). Inspiracja: Karpathy LLM KB. Przygotowanie pod bazę wektorową w przyszłości

**CONF:** 0.90

---

## D13 — 2026-04-19

**Decyzja:** Auto_Codex — redesign Task_Codex z manual na auto-pilot

**Opcje rozważane:** zmiana D10

**Dlaczego:** Codex delegacja automatyczna: Claude buduje inline prompt (nie contract file), Codex koduje w --full-auto, Claude review, max 2 rundy, Fi gate przed commit. Próg: >~20 linii lub >1 plik. Poniżej progu Claude sam.

**CONF:** 0.92

---

## D14 — 2026-04-21

**Decyzja:** Router krok 0.5 — auto-lookup w `KNOWLEDGE/index.md` przy pytaniach merytorycznych (domknięcie D12)

**Opcje rozważane:** A) cały `index.md` w rehydrate (rośnie liniowo) B) snapshot w STATE (łamie SSOT, drift) C) pointer + krok 0.5 w CO_PILOT §4 (wybrane) D) nic — on-demand manual

**Dlaczego:** Problem: KNOWLEDGE celowo poza rehydrate (D6+D12), agent na start nie wie co wie. C = zero duplikacji autorytetu (index.md pozostaje jedynym SSOT listy stron), stały koszt rehydrate, lookup on-demand tylko gdy trigger. B odrzucone po Grill_Me (łamało AGENTS.md §ROOT FILES: „inne pliki referują, NIE duplikują"). Po code-review dopracowane: krok 0.5 **ustępuje krokowi 10** (INGEST > LOOKUP przy wklejonym źródle), guard 0-stron czyta `index.md §Statystyki` (nie STATE — może być nieaktualny po mid-session ingest), 3 reguły wykluczające ochroną warstw: źródło→10, pamięć projektu→DECISIONS/LESSONS, meta-praca→router dalej. Pętla zamknięta: brak matcha w lookup → sugestia krok 10.

**CONF:** 0.92

---

## D15 — 2026-04-22

**Decyzja:** TEMPLE_REPO_v2 = **LIVING TEMPLATE** — szablon żyje, rośnie z pomysłami Fi między forkami. Nie jest „zamrożonym wzorcem" do raz-użycia.

**Opcje rozważane:** A) pure template (zamrożony, praca nad nim w osobnym meta-repo) B) living template (wbudowany CHECKLIST + STATE rosną z czasem)

**Dlaczego:** Fi: "Ten szablon będę udoskonalał jak tylko wpadnie mi jakiś pomysł. Nie wiem w którym momencie wpadnie mi pomysł do głowy i zrobię INIT dla projektu." = praktyka użycia wymaga ciągłej ewolucji szablonu w tym samym repo. B wygrywa przez realizm workflow Fi. Konsekwencja: STATE/CHECKLIST w szablonie prowadzone jak w żywym projekcie (historia sesji szablonu, nie placeholdery). Przy forku INIT.md wypełnia placeholdery + zeruje CHECKLIST+STATE (już obsłużone).

**CONF:** 0.95

---

## D16 — 2026-04-22

**Decyzja:** VOICE.md CZĘŚĆ 2 (tone of voice wobec świata) = **WSPÓLNA dla wszystkich projektów**, NIE per-projekt.

**Opcje rozważane:** A) wspólna (1 styl dla wszystkich) B) per-projekt (placeholdery + sed w INIT)

**Dlaczego:** Fi: "VOICE jest jedna dla wszystkich." Fi = jeden człowiek, jeden styl komunikacji z światem niezależnie od projektu. Per-projekt tworzyłby rozjazd tożsamości. Konsekwencja: CZĘŚĆ 2 zostaje as-is w szablonie, INIT.md jawnie to sygnalizuje (komentarz "VOICE.md CZĘŚĆ 2 zostaje as-is — wspólna"). B7 odblokowane i proste: dopisek.

**CONF:** 0.98

---

## D17 — 2026-04-22

**Decyzja:** PHASE C debloat (Context_Forge + Workflow_Edit → PROCEDURY/) = **REJECTED**. Skille zostają w `🅓_SYSTEM/SKILL/`.

**Opcje rozważane:** A) przenieść 2 skille do `🅔_STRATEGIA/PROCEDURY/` (zamknięcie PHASE C z audytu sesji 10) B) zostawić w SKILL/

**Dlaczego:** Fi (wprost, 2026-04-22): "Jak możesz mi proponować przenosić do procedur? Jak myślisz agent ma później znaleźć te pliki? Jak możesz mi tak głupie zadać rekomendację. Nie widzę w tym sensu, nie będę widział tego skila pod ręką ani agent tym bardziej. Twój pomysł się wiąże z wywaleniem go do smieci." Słuszne: skill routing w CO_PILOT §4 wymaga żeby skill był widoczny w `SKILL/*.md` glob. Przeniesienie do PROCEDURY = wyłączenie z routera = de facto usunięcie. Nawet on-demand trudno znaleźć. A audyt sesji 10 oznaczył oba jako "rzadko używane" — ale to odwrotna implikacja: rzadko ≠ nieprzydatne. Context_Forge odpala się gdy agent traci kontekst, Workflow_Edit przy edycji struktury — oba krytyczne gdy są potrzebne. Zamknięcie PHASE C przez REJECT, nie przez migrację. L14 w LESSONS.

**CONF:** 0.97

---

## D21 — 2026-05-29

**Decyzja:** **Hooki egzekwujące — pakiet 6 w `TEMPLE/.claude/`** — 6 strażników: block-secrets (Read), block-destructive/git-add-all/deploy/reflect-gate (Bash PreToolUse), session-inject (SessionStart wstrzyka ŻELAZNE). Ścieżki przez `$CLAUDE_PROJECT_DIR` → propagacja przy forku. 16/16 testów.

**Opcje rozważane:** A) tylko dokumentować w skillu B) wdrożyć pakiet 6 (wybrane) C) wdrożyć wszystkie ~10 z katalogu D) global scope

**Dlaczego:** Code-review (3 recenzentów) ujawnił że TEMPLE ma dopracowany skill Hooks_Audit (7 wzorów) ale ZERO wdrożonych hooków — cały system egzekucji reguł stał na "dobrej woli" agenta, która zawodzi 3-4× na tę samą regułę (L12 3×, L4 4×). Hook = jedyny mechanizm zmieniający WYNIK gdy agent zrobi zły ruch, niezależnie od pamięci. Pakiet 6 pokrywa nieodwracalne (sekrety/destrukcja/git-add/deploy) + workflow (Reflect-gate) + realizuje cel D19 mechanicznie (session-inject). NIE wszystkie 10 — minimalizm (każdy hook to ryzyko false-block). Pominięto self-check języka (niehookowalny — treść nie akcja). Scope TEMPLE (nie global) — szablon + propagacja; global do osobnej decyzji Fi.

**CONF:** 0.90

---

## D20 — 2026-05-29

**Decyzja:** **Split: Muaddib.md = tożsamość, WORKFLOW.md = model myślenia** — wydzielenie sekcji poznawczych (12 zasad, tryb planu, subagenci, jakość, elegancja, autonomia, rozwój, reflect, zasady bazowe) z Muaddib.md do nowego `🅓_SYSTEM/WORKFLOW/WORKFLOW.md`. Muaddib zostaje samą tożsamością (imię, rola, specjalizacja per-fork). Rehydrate 7→8 (WORKFLOW jako #2). WORKFLOW wspólny i niezmienny między forkami (jak VOICE §CZĘŚĆ 2, D16) — INIT sed nie ingeruje.

**Opcje rozważane:** A) wydziel WORKFLOW.md + przenieś perły z GOFANS §0 CORE B) tylko wydziel WORKFLOW.md (wybrane) C) zostaw scalone, popraw efektywność D) tylko analiza

**Dlaczego:** Fi 2026-05-29 (po analizie porównawczej GOFANS WORKFLOW.md vs TEMPLE Muaddib.md): "Muaddib = kim jest agent, WORKFLOW = jak agent myśli, VOICE i CO_PILOT bez zmian — to mi odpowiada". **NIE cofa D11** (D11 scaliło dekoracyjny AVATAR z MIND; tu rozdzielamy myślenie od tożsamości — inny podział, single-responsibility). Motyw: model myślenia jest wspólny dla wszystkich projektów — osobny plik = 1 źródło prawdy współdzielone między forkami zamiast kopii w każdym Muaddib (analogia D16 VOICE wspólna). Treść 1:1 przeniesiona, zachowanie agenta bez zmian. Zakres minimalny: bez dokładania zasad z GOFANS (opcja B nie A). Koszt rehydrate +~600 tk brutto / Muaddib odchudzony → próg 6k niezagrożony.

**CONF:** 0.90

---

## D19 — 2026-05-29

**Decyzja:** **LESSONS §ŻELAZNE + workspace MEMORY do rehydrate** — rehydrate 5 → 7 pozycji. Poz. 6 = sekcja `LESSONS §⚡ ŻELAZNE` (8 jednolinijkowców, ~700 tk), NIE cały plik. Poz. 7 = workspace MEMORY (auto-injected, jawny sygnał przejrzeć Feedback).

**Opcje rozważane:** A) cały LESSONS.md w rehydrate (5→7, ~9k tk) B) tylko sekcja ŻELAZNE TL;DR (wybrane) C) nic — zostaw on-demand

**Dlaczego:** Sesja 14: 4× ta sama korekta (język L12 3× + brak rekomendacji) w jednej sesji = root cause „LESSONS + MEMORY poza rehydrate, agent nie odświeża reguł na starcie". A naprawia to, ale ~9k tk przebija własny próg „rehydrate >6k = sygnał Context_Forge" (CO_PILOT §4 krok 9) → naprawia jeden dług tworząc drugi. B = destylat żelaznych reguł na starcie + pełne L# on-demand: koszt ~700 tk, próg 6k niezagrożony, anti-bloat zachowany. MEMORY i tak auto-injected przez harness → poz. 7 to sygnał przetwarzania, zero kosztu Read. Fi wybrał B 2026-05-29.

**CONF:** 0.93

---

## D18 — 2026-05-28

**Decyzja:** **Knowledge_Manager LLM Wiki patterns** — KNOWLEDGE/ dostaje typologię stron (4 typy: `summary` / `entity` / `contradiction` / `open_question`) + propagation ingest (update istniejących stron zamiast append-only) + metryka `times_refined`. Domknięcie D12 (Knowledge Pocket) pod kątem wzorca Karpathy LLM Wiki.

**Opcje rozważane:** A) zaadoptować 3 patterny do Knowledge_Manager.md przed K1 ingest (wybrane) B) odrzucić, KNOWLEDGE zostaje amorficzny C) tylko typologia, propagation i metryki później

**Dlaczego:** Fi 2026-05-28: "tak wez to" — explicit komenda adopcji po analizie 2 tweetów (@NainsiDwiv50980 15+27 maja 2026 o Karpathy LLM Wiki). Tweety nie wprowadzają nowego paradygmatu, ale dostarczają **konkretną typologię stron** której brakowało w D12. KNOWLEDGE/ wciąż 0 stron (BLOCKER #2) — łatwiej zacząć z dobrym schematem niż migrować 20 stron później. Zero impact na rehydrate, router, decyzje (czysto additive w 1 skillu + 1 indexie). Atrybucja: Karpathy via Nainsi Dwivedi. **Reguła L16 zachowana** — adopcja po explicit komendzie, nie automatyczna.

**CONF:** 0.92

---

## D22 — 2026-05-29

**Decyzja:** **Czujka urwanej sesji** — marker `.claude/.session_active` (gitignored): `session-inject.sh` zapala go na starcie i OSTRZEGA gdy zastał go z poprzedniej sesji (urwanie bez sync_state → wymuś Reflect); `sync_state` gasi (`rm -f`) jako ostatni krok.

**Opcje rozważane:** A) pole `session_status` w STATE (jak MUADDIB) B) marker file gitignored (wybrane) C) osobny Stop hook

**Dlaczego:** Analiza porównawcza z MUADDIB (workflow 17 agentów, 2026-05-29): jedyna twarda luka TEMPLE (`grep session_status`=0), 3/3 eksperci #1 ROI. Crash = lekcja przepadała bezpowrotnie. Marker zamiast pola w STATE = zero git-churn governance + pełna automatyka detekcji, mniej infrastruktury niż Stop hook.

**CONF:** 0.90

---

## D24 — 2026-07-07

**Decyzja:** **Proof_Boost = 21. skill** (audyt na twardych faktach: panel 6 sektorów + sceptyk per znalezisko + grill werdyktu) **+ plan napraw PB-1→4 zatwierdzony** (fork-safety → odchudzanie → hooki v2 → rozwój Fi), realizacja od sesji 19

**Opcje rozważane:** skill+panel vs audyt ad-hoc vs nic

**Dlaczego:** Pierwszy przebieg: 30 potwierdzonych / 3 obalone (2 CRITICAL: C24 fork dziedziczy .git, C6 budżet rehydrate fałszywy 2-3×), werdykt ŻÓŁTY. Pełne rationale + dowody → `🅔_STRATEGIA/PROOFS/PROOF_BOOST_20260707.md` + `_PLAN`

**CONF:** 0.90

---

## D23 — 2026-05-29

**Decyzja:** **Warstwa wiedzy ewoluuje: ZAGĘSZCZAJ, nie tnij + pętla open-questions** — Knowledge_Manager reguła 5: strona >~1200 słów → kondensacja najstarszych szczegółów do żywej syntezy (zachowaj `[Source:]`), NIE split na pliki; Lint #6 słowa zamiast linii; Ingest Krok 1 pkt 7 + Krok 4 + `index.md §Otwarte pytania` = pętla zamykania pytań.

**Opcje rozważane:** A) odłożyć całość jako over-eng B) zbudować ściskarkę/wektory teraz C) zmienić KSZTAŁT teraz, ciężką automatykę później (wybrane)

**Dlaczego:** Korekta Fi 2026-05-29: auto-rozwój wiedzy = równie ważny co hooki. Futurist+Systems (workflow): split mnoży pliki = droższy scan/propagacja przy skali (anti-future-proof), prawdziwy bottleneck to LICZBA stron nie rozmiar. Inwestujemy w jakość grafu (kondensacja + domykanie pytań) bez maszynerii — RAG/wektory dopiero gdy baza realnie urośnie (~100 stron).

**CONF:** 0.88

---

