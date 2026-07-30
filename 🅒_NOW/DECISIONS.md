---
version: 1.0
status: ACTIVE
rule: "Nie debatuj ponownie — jeśli temat był tu zdecydowany, agent czyta decyzję zamiast otwierać dyskusję od nowa."
---

# DECISIONS — {{NAZWA_PROJEKTU}}

> Log decyzji architektonicznych. Każda strategiczna decyzja ląduje tu — nie w głowie, nie w chacie.

---

## Decyzje

> **Pełne rationale + opcje rozważane** (D1-D24) → `🅖_ARCHIVE/DECISIONS_RATIONALE_2026q2.md`.
> Tutaj: decyzja + jednozdaniowy powód. Chcesz wiedzieć DLACZEGO tak, a nie inaczej — czytaj archiwum.

| # | Data | Decyzja + powód | CONF |
|---|------|-----------------|------|
| D1 | 2026-04-18 | `CHECKLIST.md` = SSOT zadań — jeden system śledzenia, żyje w CO_PILOT §3 | 0.95 |
| D2 | 2026-04-18 | Agent decyduje sam o skillach — nie pyta Fi, router w CO_PILOT §4 | 0.90 |
| D3 | 2026-04-18 | Reflect automatyczny w routerze (krok 0 przy korekcie + krok 8 na koniec sesji) | 0.92 |
| D4 | 2026-04-18 | Partial rehydrate (`core`/`state`/`decisions`) — pełny start to za dużo tokenów na mid-session refresh | 0.88 |
| D5 | 2026-04-18 | ~~BOOT.md~~ → Context_Forge; kompresja przez usuwanie duplikatów, nie przez streszczanie | 0.90 |
| D6 | 2026-04-18 | PROOFS/ poza rehydrate — agent zapisuje dowody w trakcie pracy, STATE trzyma pointery | 0.92 |
| D7 | 2026-04-18 | Merge DIET v2 → v1 — ostrzejszy język v2 (-29% tokenów) + Context_Forge z v1 | 0.92 |
| D8 | 2026-04-18 | character + ToV → `VOICE.md`, Mapping → `Reflect.md` — jedno źródło prawdy o głosie agenta | 0.93 |
| D9 | 2026-04-18 | INDEX→AGENTS, MEMORY→LESSONS (7→5 plików root) — zero split-brain | 0.95 |
| D10 | 2026-04-19 | Codex = **auto-delegacja** kodowania (>~20 linii / >1 plik), Claude = architekt i reviewer, Fi = gate przed commit | 0.92 |
| D11 | 2026-04-18 | MIND + AVATAR → `Muaddib.md` — AVATAR był dekoracyjny, merge dał 1 plik CORE | 0.92 |
| D12 | 2026-04-19 | Knowledge Pocket — `KNOWLEDGE/` jako trzecia, ortogonalna warstwa pamięci obok DECISIONS i LESSONS | 0.90 |
| D13 | 2026-04-19 | Auto_Codex: inline prompt (nie plik kontraktu), max 2 rundy, fallback do Claude | 0.92 |
| D14 | 2026-04-21 | Router krok 0.5 — auto-lookup w `KNOWLEDGE/index.md` przy pytaniach merytorycznych; ustępuje krokowi 10 (ingest > lookup) | 0.92 |
| D15 | 2026-04-22 | TEMPLE_REPO_v2 = **living template** — szablon rośnie między forkami, STATE/CHECKLIST prowadzone jak w żywym projekcie | 0.95 |
| D16 | 2026-04-22 | `VOICE.md` CZĘŚĆ 2 **wspólna** dla wszystkich projektów — Fi to jeden człowiek, jeden styl wobec świata | 0.98 |
| D17 | 2026-04-22 | PHASE C debloat **REJECTED** — skille zostają w `SKILL/`; skill poza tym katalogiem to skill, którego router nie znajdzie | 0.97 |
| D18 | 2026-05-28 | Knowledge_Manager: typologia 4 typów stron + ingest z propagacją + `times_refined` (wzorzec LLM Wiki) | 0.92 |
| D19 | 2026-05-29 | `LESSONS §⚡ŻELAZNE` + workspace MEMORY do rehydrate — destylat reguł (~700 tk), nie cały plik (~9k) | 0.93 |
| D20 | 2026-05-29 | Split: `Muaddib.md` = tożsamość, `WORKFLOW.md` = model myślenia (wspólny między forkami). Rehydrate 7→8 | 0.90 |
| D21 | 2026-05-29 | **Hooki egzekwujące** — pakiet 6 strażników w `.claude/`; hook zmienia wynik niezależnie od pamięci agenta | 0.90 |
| D22 | 2026-05-29 | Czujka urwanej sesji — marker `.claude/.session_active`, zapala się na starcie, gasi przy sync_state | 0.90 |
| D23 | 2026-05-29 | Warstwa wiedzy: **ZAGĘSZCZAJ, nie tnij** (strona >~1200 słów → synteza w sobie, nie split) + pętla open-questions | 0.88 |
| D24 | 2026-07-07 | `Proof_Boost` = 21. skill (audyt: 6 sektorów + sceptyk per znalezisko + grill) + plan napraw PB-1→4 | 0.90 |
| D25 | 2026-07-30 | **Fork startuje z czystą pamięcią, ale zachowuje `⚡ŻELAZNE`** — nowy projekt nie dziedziczy lekcji, decyzji ani proofów szablonu; reguły komunikacji Fi działają od pierwszej minuty (INIT Krok 5.5) | 0.92 |

---

## Jak dodać nową decyzję

**1) Wiersz w tabeli wyżej** — decyzja + jednozdaniowy powód:

```markdown
| D{{N}} | {{DATA}} | {{DECYZJA — imperatywnie}} — {{POWÓD w jednym zdaniu}} | {{CONF}} |
```

**2) Pełne rationale** → `🅖_ARCHIVE/DECISIONS_RATIONALE_2026q2.md` (sekcja `## D{{N}} — {{DATA}}` z opcjami rozważanymi i twardym uzasadnieniem).

**Zasady:**
1. Numer sekwencyjny (D1, D2, D3...)
2. Data w formacie YYYY-MM-DD
3. Decyzja = co zdecydowano (krótko, imperatywnie)
4. Powód w tabeli = jedno zdanie; opcje i pełna argumentacja idą do archiwum (PB-2, 2026-07-30)
5. Uzasadnienie = twarde fakty, dane, źródła — nie „wydaje mi się"
6. CONF = confidence level (0.75-1.00; niska = decyzja może się zmienić)

**Reguła systemowa:** Jeśli agent chce zmienić zdecydowany temat → MUSI najpierw przeczytać tę tabelę i uzasadnić DLACZEGO nowa informacja zmienia kalkulację.
