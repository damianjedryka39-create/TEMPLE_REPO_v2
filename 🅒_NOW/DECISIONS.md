---
version: 1.0
status: ACTIVE
rule: "Nie debatuj ponownie — jeśli temat był tu zdecydowany, agent czyta decyzję zamiast otwierać dyskusję od nowa."
---

# DECISIONS — {{NAZWA_PROJEKTU}}

> Log decyzji architektonicznych. Każda strategiczna decyzja ląduje tu — nie w głowie, nie w chacie.

---

## Decyzje

| # | Data | Decyzja | Opcje rozważane | Dlaczego | CONF |
|---|------|---------|-----------------|----------|------|
| D1 | 2026-04-18 | CHECKLIST.md = SSOT zadań | — | Żyje w Muaddib.md + CO_PILOT §3 | 0.95 |
| D2 | 2026-04-18 | Agent decyduje sam o skillach | — | Żyje w CO_PILOT §4 | 0.90 |
| D3 | 2026-04-18 | Reflect auto w routerze (krok 0+8) | — | Żyje w CO_PILOT §4 | 0.92 |
| D4 | 2026-04-18 | Partial rehydrate: core/state/decisions | full-only vs partial | 8k tokenów na start to za dużo. Partial pozwala na 1.5k refresh mid-session | 0.88 |
| D5 | 2026-04-18 | ~~BOOT.md~~ → zastąpiony przez Context_Forge | BOOT vs odchudzanie | Kompresja przez usuwanie duplikatów > kompresja przez streszczenie | 0.90 |
| D6 | 2026-04-18 | PROOFS/ wyłączony z rehydrate | w rehydrate vs on-demand | Agent zapisuje PROOFS w trakcie pracy, nie ładuje na start. STATE ma pointery | 0.92 |
| D7 | 2026-04-18 | Merge DIET v2 → v1 (best of both) | v1-only vs v2-only vs merge | v2 daje -29% tokenów przez ostrzejszy język; v1 ma Context_Forge. Merge = oszczędność + ewolucja. MIND: 5 elementów przywróconych (elegancja, bezlitośnie, nauka Fi, CI, rozwój) | 0.92 |
| D8 | 2026-04-18 | Konsolidacja: character+ToV→VOICE.md, Mapping→Reflect | 6 plików vs 4 pliki | Jedno źródło prawdy o głosie agenta, Reflect samowystarczalny. 2 pliki mniej, zero duplikacji "jak mówię" | 0.93 |
| D9 | 2026-04-18 | INDEX→AGENTS, MEMORY→LESSONS (7→5 root plików) | osobne vs merge | INDEX duplikował CLI/deploy/rehydrate z AGENTS. MEMORY pusty, LESSONS robi tę samą robotę. Merge = zero split-brain, -2 pliki | 0.95 |
| D10 | 2026-04-18 | Codex/Gemini wyłączone z auto-workflow. Tylko Claude + manualna delegacja | auto vs manual | Fi nie chce auto-delegacji. Claude = jedyny agent. Codex dostępny jako skill do ręcznego użycia przez Fi | 0.95 |
| D11 | 2026-04-18 | MIND.md + AVATAR.md → Muaddib.md (🅓_SYSTEM/AVATAR/) | osobne vs merge | AVATAR dekoracyjny (kompetencje, motto = zero wpływu na agenta). MIND miał tożsamość, AVATAR duplikował. Merge = 1 plik CORE, rehydrate 6→5, -1 root plik. Specjalizacja per-projekt zachowana jako sekcja | 0.92 |

---

## Jak dodać nową decyzję

```markdown
| D{{N}} | {{DATA}} | {{DECYZJA}} | {{OPCJE}} | {{DLACZEGO}} | {{CONF}} |
```

**Zasady:**
1. Numer sekwencyjny (D1, D2, D3...)
2. Data w formacie YYYY-MM-DD
3. Decyzja = co zdecydowano (krótko, imperatywnie)
4. Opcje rozważane = jakie alternatywy były na stole
5. Dlaczego = twarde uzasadnienie (dane, fakty, źródła — nie "wydaje mi się")
6. CONF = confidence level (0.75-1.00; niska = decyzja może się zmienić)

**Reguła systemowa:** Jeśli agent chce zmienić zdecydowany temat → MUSI najpierw przeczytać tę tabelę i uzasadnić DLACZEGO nowa informacja zmienia kalkulację.
