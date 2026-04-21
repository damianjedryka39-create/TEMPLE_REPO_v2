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
| D10 | ~~2026-04-18~~ **2026-04-19** | ~~Codex manual only~~ → **Codex AUTO-DELEGACJA**. Claude = architekt/reviewer, Codex = koder (>~20 linii / >1 plik). Gate przed commit. Max 2 rundy. | auto vs manual vs hybrid | Fi chce zero ręcznej delegacji. Próg ~20 linii/1 plik = sweet spot (mniejsze = overhead). Inline prompt (nie contract file). Multi-pass (2 rundy) + Claude fallback | 0.92 |
| D11 | 2026-04-18 | MIND.md + AVATAR.md → Muaddib.md (🅓_SYSTEM/AVATAR/) | osobne vs merge | AVATAR dekoracyjny (kompetencje, motto = zero wpływu na agenta). MIND miał tożsamość, AVATAR duplikował. Merge = 1 plik CORE, rehydrate 6→5, -1 root plik. Specjalizacja per-projekt zachowana jako sekcja | 0.92 |
| D12 | 2026-04-19 | Knowledge Pocket — warstwa wiedzy domenowej w KNOWLEDGE/ | Knowledge Pocket vs Enhanced Compounding vs Full Karpathy | Minimalna zmiana (1 folder + 2 skille), zero impact na rehydrate, 3 ortogonalne warstwy pamięci (DECISIONS/LESSONS/KNOWLEDGE). Inspiracja: Karpathy LLM KB. Przygotowanie pod bazę wektorową w przyszłości | 0.90 |
| D13 | 2026-04-19 | Auto_Codex — redesign Task_Codex z manual na auto-pilot | zmiana D10 | Codex delegacja automatyczna: Claude buduje inline prompt (nie contract file), Codex koduje w --full-auto, Claude review, max 2 rundy, Fi gate przed commit. Próg: >~20 linii lub >1 plik. Poniżej progu Claude sam. | 0.92 |
| D14 | 2026-04-21 | Router krok 0.5 — auto-lookup w `KNOWLEDGE/index.md` przy pytaniach merytorycznych (domknięcie D12) | A) cały `index.md` w rehydrate (rośnie liniowo) B) snapshot w STATE (łamie SSOT, drift) C) pointer + krok 0.5 w CO_PILOT §4 (wybrane) D) nic — on-demand manual | Problem: KNOWLEDGE celowo poza rehydrate (D6+D12), agent na start nie wie co wie. C = zero duplikacji autorytetu (index.md pozostaje jedynym SSOT listy stron), stały koszt rehydrate, lookup on-demand tylko gdy trigger. B odrzucone po Grill_Me (łamało AGENTS.md §ROOT FILES: „inne pliki referują, NIE duplikują"). Po code-review dopracowane: krok 0.5 **ustępuje krokowi 10** (INGEST > LOOKUP przy wklejonym źródle), guard 0-stron czyta `index.md §Statystyki` (nie STATE — może być nieaktualny po mid-session ingest), 3 reguły wykluczające ochroną warstw: źródło→10, pamięć projektu→DECISIONS/LESSONS, meta-praca→router dalej. Pętla zamknięta: brak matcha w lookup → sugestia krok 10. | 0.92 |

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
