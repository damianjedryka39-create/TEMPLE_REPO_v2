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

## L4 — Reflect PRZED sync_state (2026-04-18)
**Sygnał:** Fi skorygował: "zrobiłeś sync state ale nie zrobiłeś reflectu"
**Reguła:** SYNC_STATE zaczyna się od Reflect (CO_PILOT §2 krok 0). Nie pomijaj nawet gdy sesja wydaje się "czysto techniczna". Reflect = obowiązkowy gate.

## L5 — Nie usuwaj narzędzi, adaptuj (2026-04-18)
**Sygnał:** Fi skorygował: "niepotrzebnie usunęłaś ten Skill" po tym jak usunąłem Task_Codex_Gemini.md zamiast go zaadaptować.
**Reguła:** Gdy Fi mówi "nie chcę X w workflow" — to znaczy wyłącz AUTO-trigger, nie kasuj narzędzie. Skill może być potrzebny do manualnego użycia. Rozróżniaj: "wyłącz z automatyki" vs "usuń z systemu". W razie wątpliwości: adaptuj, nie kasuj.

---

## Findings (long-term)

> Trwałe odkrycia, wzorce i "aha moments" — destylat, nie dziennik.

**F1 — Workflow to żywy system (2026-04-18)**
Fi traktuje strukturę plików jako ewoluujący organizm, nie statyczny szablon. Oczekuje od agenta zdolności do bezpiecznej samoedycji workflow (dodaj/usuń/przenieś/merge pliki) BEZ prowadzenia za rękę. Kluczowe: agent musi pilnować referencji, refactorować grepem, i stress-testować zmiany (Grill_Me) zanim zakończy.
