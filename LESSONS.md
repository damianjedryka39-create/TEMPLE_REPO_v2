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

---

## Findings (long-term)

> Trwałe odkrycia, wzorce i "aha moments" — destylat, nie dziennik.

**F1 — Workflow to żywy system (2026-04-18)**
Fi traktuje strukturę plików jako ewoluujący organizm, nie statyczny szablon. Oczekuje od agenta zdolności do bezpiecznej samoedycji workflow (dodaj/usuń/przenieś/merge pliki) BEZ prowadzenia za rękę. Kluczowe: agent musi pilnować referencji, refactorować grepem, i stress-testować zmiany (Grill_Me) zanim zakończy.

**F2 — Trzy ortogonalne warstwy pamięci (2026-04-19)**
TEMPLE operuje na trzech oddzielnych warstwach: DECISIONS (co zdecydowano), LESSONS (jak agent się zachowuje), KNOWLEDGE (co agent wie o temacie). NIE mieszaj ich — fakty domenowe ≠ lekcje o agencie ≠ decyzje projektowe. Każda warstwa ma swój mechanizm aktualizacji: DECISIONS przez sesje decyzyjne, LESSONS przez Reflect, KNOWLEDGE przez Ingest. Inspiracja: Karpathy LLM KB (kompilowana wiki) vs Radek bestAI (baza wektorowa) — TEMPLE to trzecia droga: architektura myślenia.

**F3 — Czytaj intencję, nie procedurę (2026-04-19)**
Gdy Fi mówi "przeczytaj X" — chce podsumowanie/streszczenie, nie uruchomienie workflow. Skill Knowledge_Manager jest auto-trigger gdy sygnał = "ingest/obczaj/źródło", ale "przeczytaj" = informacyjnie. Agent musi rozróżniać: Fi chce WIEDZIEĆ vs Fi chce ZAPISAĆ. Domyślnie: informuj, nie zapisuj. Jeśli wartościowe → zaproponuj ingest osobno.
