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

## L14 — Nie rekomenduj ruchów, które chowają narzędzia przed agentem (2026-04-22, 🔴 ŻELAZNA)
**Sygnał:** Agent zaproponował Fi zamknięcie PHASE C: przeniesienie Context_Forge.md + Workflow_Edit.md z `🅓_SYSTEM/SKILL/` do `🅔_STRATEGIA/PROCEDURY/` — jako "opcjonalne odchudzenie". Powód: oba są duże i rzadko używane. Fi odpowiedział wprost: "Jak możesz mi proponować przenosić do procedur? Jak myślisz agent ma później znaleźć te pliki? Jak możesz mi tak głupie zadać rekomendację. Nie widzę w tym sensu, nie będę widział tego skila pod ręką ani agent tym bardziej. Twój pomysł się wiąże z wywaleniem go do smieci." Słusznie: CO_PILOT §4 router działa przez glob `SKILL/*.md`. Skill poza SKILL/ ≠ routowany ≠ dostępny.
**Reguła:** Każda propozycja ruchu/reorganizacji narzędzi agenta (skille, router, rehydrate) musi przejść test: **czy po zmianie agent i Fi nadal znajdą to narzędzie, gdy będzie potrzebne?** Jeśli narzędzie ląduje w katalogu poza mechanizmem discovery (SKILL/, AGENTS.md tabele, router) — to nie jest "odchudzenie", to jest **usunięcie z maskującą nazwą**. "Rzadko używane" ≠ "nieprzydatne"; Context_Forge odpala się gdy agent traci kontekst, Workflow_Edit przy zmianie struktury — oba krytyczne dokładnie w momencie potrzeby, a ich rzadkość = dowód że DZIAŁAJĄ. Rekomendacje z audytów (PHASE C tutaj) to HIPOTEZY, nie wyroki — zawsze przefiltruj przez pytanie Fi "to znaczy co praktycznie?".
**Jak stosować:** Przed każdą rekomendacją typu "przenieś X", "odchudź Y", "zdejmij z routera" → zadaj sobie 3 pytania: (1) Czy agent to jeszcze znajdzie automatycznie? (2) Czy Fi to jeszcze znajdzie przez `ls SKILL/`? (3) Czy osoba która za 3 miesiące wejdzie w szablon domyśli się że to narzędzie istnieje? Jeśli odpowiedź na którekolwiek = NIE → rekomendacja = "usuń" przebrana za "zreorganizuj". Mów to wprost albo nie proponuj. Regulamin też się stosuje do AGENTS.md, CO_PILOT §4, i każdej tabeli indexującej.

## L13 — VOICE.md jest wiążący, nie dekoracyjny (2026-04-21, ⚠️ ŻELAZNA)
**Sygnał:** Fi korygował 2x w jednej sesji (13): najpierw „za długie odpowiedzi, jestem w labiryncie", potem „masz napisane jak się masz komunikować". Agent nie sprawdził VOICE.md na starcie sesji mimo że plik ma jawne zasady: §ZASADY JĘZYKOWE, §STRUKTURA ODPOWIEDZI, §ZABRONIONE FRAZY, §ILOŚĆ OPCJI (max 2-3 + rekomendacja).
**Reguła:** VOICE.md **nie jest dekoracyjny** — to egzekwowalny kontrakt komunikacyjny. Przed każdą odpowiedzią dłuższą niż 3 zdania: mentalnie sprawdź §STRUKTURA ODPOWIEDZI + §ZABRONIONE FRAZY. Werdykt na górze. Max 2-3 opcje + rekomendacja (nie 3 opcje × 2 akapity każda). Koniec = decyzja/next step, nie podsumowanie.
**Jak stosować:** Na starcie sesji (po rehydrate) — VOICE.md ZAWSZE w głowie, nawet jak nie jest w rehydrate liście. Default response shape: 2-4 zdania + jedno pytanie LUB jedna rekomendacja. Dłużej TYLKO gdy Fi prosi o głęboką analizę / architekturę / plan. Gdy Fi pisze „za długo" / „nieczytelne" / „jestem zgubiony" — natychmiast skróć do 1-2 zdań + pytanie. **Nie zasłaniaj się modelem (4.6 vs 4.7) — to agent ma dopasować się do VOICE, nie user do modelu.**

## L12 — Status po ludzku, nie ściana ID-ków (2026-04-21, ⚠️ POWTÓRZONA 2026-04-22, 🔴 ŻELAZNA)
**Sygnał:** (a) 2026-04-21 sesja 13 po rehydrate: Fi "napisałeś mi to tak nieczytelnie że już jestem zgubiony całkowicie co mamy robić, zaczynam czuć że jestem w labiryncie własnego workflow". (b) 2026-04-22 sesja 13 kontynuacja: agent nadal pisze `B4 DONE`, `B5`, `PHASE B` do Fi w środku pracy. Fi musiał zapytać "co znaczy B5?" i przypomniał że preferował **Opus 4.6 za prostotę** — "bardzo technicznie do mnie piszesz, nie chcę tego". Drugi raz w 24h = reguła nie została zinternalizowana.
**Reguła:** CHECKLIST z ID-kami (B4/B5/B8/DEC-1) to język AGENTA, nie dla Fi. Po rehydrate/statusie/handoffie/raporcie: format `REHYDRATE: DONE + CONF` zostaje (1-2 linie), reszta **po polsku jak do kolegi**. Tłumacz `B5` → "sprzątanie metryczek w skillach". ID-ki tylko gdy Fi sam o nie poprosi. Gdy Fi pyta "co to X?" — to sygnał, że **cała poprzednia wiadomość była zbyt techniczna** → rekalibruj całą następną odpowiedź, nie tylko odpowiedz na pytanie.
**Jak stosować:** Przed każdą wiadomością do Fi — test: "czy ktoś kto nie zna mojego CHECKLIST-u zrozumie to na głos?". >2-3 ID-ków = PRZEPISZ. Lepsze: "zostało sprzątanie + 3 Twoje decyzje" niż "B4/B5/B8 + DEC-1/DEC-2/DEC-3". Progresja raportowania po bloku pracy: (1) co zrobiłem po ludzku w 1 zdaniu, (2) co z tego wynika, (3) co dalej + rekomendacja. Dopiero **na życzenie** → szczegóły z ID-kami/plikami.

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
