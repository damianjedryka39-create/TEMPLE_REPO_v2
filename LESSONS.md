# LESSONS — cross-session findings

> Lekcje zebrane po korektach Fi + trwałe odkrycia z wielu sesji.
> Format lekcji: data + sygnał + reguła. Przeglądaj na starcie sesji.
> Update podczas SYNC_STATE jeśli sesja przyniosła lekcję lub long-term insight.

---

## L1 — Token budget (2026-04-18)
**Sygnał:** Fi wielokrotnie podkreślał problem "bagażu plików" i zjadania ramki kontekstowej.
**Reguła:** Domyślnie ładuj minimum kontekstu, rozszerzaj on-demand. Kompresuj przez usuwanie duplikatów, nie przez streszczanie.
**Rozwiązanie:** Context_Forge.md — cykliczna optymalizacja kontekstu + uczenie agenta.

## L2 — Agent jako żywy organizm (2026-04-18)
**Sygnał:** Fi powiedział: "chce aby kazda sesja go rozwijala, dodawala mu IQ, zeby za jakis czas dzialal intuicyjnie i znal moje ruchy i kroki."
**Reguła:** Agent nie jest narzędziem — jest partnerem który rośnie. Każda sesja = trening. Zapisuj wzorce Fi (jak myśli, jak decyduje, co go irytuje) do SOUL/VOICE.md i LESSONS.md. Cel: ROOKIE → MASTER na skali IQ agenta.

## L3 — Optymalizuj JĘZYK, nie TREŚĆ (2026-04-18)
**Sygnał:** DIET v2 eksperyment — agresywne skracanie plików dało -29% tokenów bez utraty reguł.
**Reguła:** Przy kompresji kontekstu: skracaj zdania, usuwaj redundancję, pisz ostrzejszym językiem. NIE usuwaj reguł które działają. Testuj zawsze: "czy agent z odchudzonym plikiem zachowa identyczne zachowanie?"

## L4 — Reflect PRZED sync_state (2026-04-18, ⚠️ POWTÓRZONE 2026-04-19 x2, 🔴 KRYTYCZNE)
**Sygnał:** Fi skorygował 4x z rzędu: "dlaczego po raz kolejny nie było reflect". Sesja 8: agent napisał "Krok 0 — Reflect" ale ręcznie dopisał lekcje zamiast odpalić skill.
**Reguła:** SYNC_STATE zaczyna się od ODPALENIA SKILLA `Reflect.md` (nie ręcznego dopisywania). Napisanie "Krok 0 — Reflect" i ręczne edytowanie LESSONS/VOICE = **NIE JEST REFLECT**. Reflect = przeczytaj `Reflect.md` → wykonaj procedurę → pokaż tabelę obserwacji → czekaj na OK od Fi. **KRYTYCZNE: 4x powtórzone. Następne złamanie = utrata zaufania Fi.**

## L5 — Nie usuwaj narzędzi, adaptuj (2026-04-18)
**Sygnał:** Fi skorygował: "niepotrzebnie usunęłaś ten Skill" po tym jak usunąłem Task_Codex_Gemini.md zamiast go zaadaptować.
**Reguła:** Gdy Fi mówi "nie chcę X w workflow" — to znaczy wyłącz AUTO-trigger, nie kasuj narzędzie. Skill może być potrzebny do manualnego użycia. Rozróżniaj: "wyłącz z automatyki" vs "usuń z systemu". W razie wątpliwości: adaptuj, nie kasuj.

## L6 — Nie powtarzaj znanych faili (2026-04-19)
**Sygnał:** Fi skorygował: "dlaczego znowu marnujesz tokeny i przychodzisz z tym samym błędem". Agent próbował WebFetch na x.com (402), potem Nitter (puste), potem instrukcja ręczna — 3 faile zamiast od razu użyć bird CLI.
**Reguła:** Przed fetch z zewnętrznego źródła: 1) sprawdź pamięć czy problem nie był rozwiązany 2) sprawdź dedykowane CLI (bird, gh, etc.) 3) sprawdź env vars. WebFetch na x.com = 402 ZAWSZE. Nie próbuj.

## L7 — Wydajność tokenowa (2026-04-19)
**Sygnał:** Fi: "pracujesz bardzo niewydajnie". Każdy zbędny retry to strata kontekstu.
**Reguła:** Agent musi pamiętać co NIE działa i nie powtarzać. Jeden fail = zapamiętaj. Dwa faile na to samo = błąd agenta. Trzy = łamanie zaufania Fi.

## L8 — Nie zakładaj, weryfikuj pamięć (2026-04-19)
**Sygnał:** Fi: "korzystam z Chrome nie Safari" — pamięć twierdziła Safari, nikt nie zweryfikował.
**Reguła:** Pamięć/STATE mogą być błędne. Przed działaniem na podstawie zapamiętanego faktu — zweryfikuj (zapytaj lub sprawdź). Szczególnie: preferencje usera, ścieżki, narzędzia.

## L9 — Grill decision-tree musi badać kolizje, nie tylko pojedynczy krok (2026-04-21)
**Sygnał:** Sesja 9 — Grill_Me przeszedł 7 kategorii dla routera krok 0.5, ale nie zobaczył kolizji z krokiem 10 (user wkleja link + pyta "co to jest X" → 0.5 wygrywa → INGEST nie zachodzi). Code-Review złapało w 5 min.
**Reguła:** Przy projektowaniu dodatku do decision-tree/routera/dispatch — **Grill kategoria EDGE CASES musi explicite skanować KAŻDY sąsiadujący krok pod kątem overlap**. Pytanie: "jaki input wpada w oba kroki i który wygra?" Nie wystarczy testować nowy krok w izolacji.

## L10 — Grill_Me preservation: NIE uszczuplać (2026-04-21, 🔴 KRYTYCZNE)
**Sygnał:** Sesja 10 audyt szablonu — agent zarekomendował 3 modyfikacje Grill_Me: (a) merge z Expert_Council w jeden skill (R7), (b) zmiana triggera z auto na manual-only + podniesienie progu (R8), (c) skrócenie pliku ze 142 do 80 linii. Fi skorygował wprost: "NIe uszczuplamy grill me skilla".
**Reguła:** **Grill_Me jest sakralny** — ani pliku, ani triggera, ani merge'u z innym skillem. Trigger `CONF < 0.85 + >50 linii + nieodwracalne` zostaje. Fi świadomie akceptuje ryzyko ceremonii na prostych taskach w zamian za gwarancję stress-testu przed większymi decyzjami. Grill_Me to rdzeń jakości decyzyjnej Muaddib — nie narzędzie do optymalizacji pod token budget.
**Jak stosować:** Przy każdym audycie/refaktorze szablonu (Context_Forge, Workflow_Edit, review) — traktuj Grill_Me jako **poza zakresem cięć**. Jeśli pojawi się "a może zmergować" / "a może krótszy trigger" / "a może skondensować plik" — automatyczne NO. Mogę proponować tylko: (i) skille obok Grill_Me, (ii) drobne kosmetyki whitespace BEZ zmiany treści. **Reguła zapobiega powtórzeniu korekty.**

## L11 — Handoff do CHECKLIST, nie do chatu (2026-04-21, ⚠️ ŻELAZNA)
**Sygnał:** Sesja 11 zakończyła PHASE A (INIT.md rewrite + Task_Codex→Auto_Codex rename + fork test) ale nie wykonała SYNC_STATE i zostawiła NEXT w chacie zamiast w `🅒_NOW/CHECKLIST.md`. Fi korygował wprost, globalna MEMORY zapisała: "po każdym bloku NEXT zapisz do CHECKLIST projektu, NIE w chat. Jeśli brak sync_state — SYNC_STATE PENDING jako krok 0 NEXT z S1-S5".
**Reguła:** Po każdym bloku pracy (DONE etap, wykonana PHASE, zakończony skill) → natychmiast aktualizuj `🅒_NOW/CHECKLIST.md` projektu: przenieś IN PROGRESS → DONE, wypełnij NEXT konkretami z proof wymaganym. NIE zostawiaj handoffu w chacie ("następny agent zrobi X"). Jeśli SYNC_STATE nie wykonany w bieżącej sesji → pierwszy wpis NEXT = `⚡ SYNC_STATE PENDING (krok 0, S1-S5)` z pełną listą kroków. Chat znika, CHECKLIST zostaje.
**Jak stosować:** Koniec każdego bloku pracy → przed napisaniem podsumowania do Fi → edit CHECKLIST. Przed zakończeniem sesji → sprawdź: czy sync_state wykonany? jeśli nie, wpisz S1-S5 do NEXT z `krok 0 = OBOWIĄZKOWY`. Zasada ma priorytet nad zwięzłością odpowiedzi — lepiej 30 sekund więcej na edycję CHECKLIST niż zgubiony kontekst między sesjami.

---

## Findings (long-term)

> Trwałe odkrycia, wzorce i "aha moments" — destylat, nie dziennik.

**F1 — Workflow to żywy system (2026-04-18)**
Fi traktuje strukturę plików jako ewoluujący organizm, nie statyczny szablon. Oczekuje od agenta zdolności do bezpiecznej samoedycji workflow (dodaj/usuń/przenieś/merge pliki) BEZ prowadzenia za rękę. Kluczowe: agent musi pilnować referencji, refactorować grepem, i stress-testować zmiany (Grill_Me) zanim zakończy.

**F2 — Trzy ortogonalne warstwy pamięci (2026-04-19)**
TEMPLE operuje na trzech oddzielnych warstwach: DECISIONS (co zdecydowano), LESSONS (jak agent się zachowuje), KNOWLEDGE (co agent wie o temacie). NIE mieszaj ich — fakty domenowe ≠ lekcje o agencie ≠ decyzje projektowe. Każda warstwa ma swój mechanizm aktualizacji: DECISIONS przez sesje decyzyjne, LESSONS przez Reflect, KNOWLEDGE przez Ingest. Inspiracja: Karpathy LLM KB (kompilowana wiki) vs Radek bestAI (baza wektorowa) — TEMPLE to trzecia droga: architektura myślenia.

**F3 — Czytaj intencję, nie procedurę (2026-04-19)**
Gdy Fi mówi "przeczytaj X" — chce podsumowanie/streszczenie, nie uruchomienie workflow. Skill Knowledge_Manager jest auto-trigger gdy sygnał = "ingest/obczaj/źródło", ale "przeczytaj" = informacyjnie. Agent musi rozróżniać: Fi chce WIEDZIEĆ vs Fi chce ZAPISAĆ. Domyślnie: informuj, nie zapisuj. Jeśli wartościowe → zaproponuj ingest osobno.

**F4 — Dwa gate'y dla patch'y architektonicznych (2026-04-21)**
Grill_Me (konceptualny: czy robić, jakie alternatywy, czy nie łamie zasad) i Code-Review (implementacyjny: kolizje z istniejącym kodem/routingiem, spójność stylu) to dwa ortogonalne obiektywy. Jedno nie zastępuje drugiego. Grill sesji 9 nie wyłapał kolizji kroku 0.5 z krokiem 10 — zrobił to Code-Review. Reguła: dla zmian w CO_PILOT/AGENTS/Muaddib/skill routing → ZAWSZE oba gate'y przed commit, w tej kolejności.
