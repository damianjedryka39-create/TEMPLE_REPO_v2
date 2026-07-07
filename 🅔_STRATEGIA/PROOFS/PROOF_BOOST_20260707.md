# PROOF_BOOST — audyt TEMPLE_REPO_v2 (2026-07-07)

> Pierwsze uruchomienie skilla `Proof_Boost.md` (sesja 18). Panel 6 specjalistów + sceptyk per znalezisko.
> Pełne dowody (evidence/impact/fix/notatki sceptyków): **`PROOF_BOOST_20260707_findings.json`** (obok).

---

## Metodologia

- **39 subagentów**: 6 audytorów sektorowych (optymalizacja, wydajność, efektywność, rozwój usera, egzekwowalność, spójność) + 33 sceptyków (1 per znalezisko), 390 operacji na repo, 0 błędów.
- Reguła twardych faktów: znalezisko bez dowodu `plik:linia`/komendy = discard. Sceptyk odtwarza dowód samodzielnie; nie odtworzy = znalezisko pada.
- Wynik weryfikacji: **30 potwierdzonych / 3 obalone** (91% przeżywalność — audytorzy nie fantazjowali).

---

## Wynik: 2 CRITICAL, 16 IMPORTANT, 12 MINOR — w 4 klastrach

### 🔴 KLASTER A — Fork wadliwy (C24 CRITICAL, C25, C26, C30)
`INIT.md` Krok 1 kopiuje repo **bez `rm -rf .git`** → nowy projekt commituje na historię TEMPLE i `git push` (sync_state krok 7) nadpisuje remote szablonu-master (zweryfikowane symulacją forka). Do tego fork dziedziczy LESSONS L1-L17 + D1-D23 + 6 PROOFS jako fałszywą pamięć nowego projektu (INIT twierdzi, że są puste), weryfikacja `grep "{{"` Kroku 2 jest niespełnialna (14 plików poza whitelistą), `{{ALIAS}}` w AGENTS.md:33 nie jest w sed-liście.

### 🔴 KLASTER B — Źródła prawdy kłamią o liczbach (C6 CRITICAL, C1, C11, C18, C29, C27, C28, C10)
Budżet rehydrate zaniżony 2-3×: **realnie ~9.7-12.7k tk** (pomiar wc, dwie niezależne metody) vs deklarowane 4.8-5.8k w AGENTS.md:33, CO_PILOT.md:122, STATE:13. Próg 6k (sygnał Context_Forge, krok 9) dawno przebity — **alarm martwy, bo agent czyta fałszywą liczbę**. Partial rehydrate zdriftowany 2.8-5.5×. STATE podaje złą liczbę lekcji (L1-L16 vs realne L1-L17). Router CO_PILOT §4 **nie zna 7 z 20 skilli (35%)** — dokładnie ryzyko z D17/L14, tym razem od środka. Martwa referencja „skill Ingest" w AGENTS.md.

### 🟡 KLASTER C — Egzekucja dziurawa (C7, C19, C20, C21, C22, C8, C9, C23, C12, C16, C13)
Hooki przepuszczają **dokładnie te incydenty, przeciw którym powstały**: `rm -r -f` i `rm --recursive --force` przechodzą (C19); `cd parent && git add -A` = scenariusz incydentu L15 1:1 przechodzi (C20); ręczny dopisek do LESSONS = anty-wzorzec L4 przechodzi reflect-gate (C22). Czujka D22: zapala hook, gasi dobra wola (asymetria) + fałszywe alarmy przy 2 sesjach równoległych (C21). Substring-matching false-blockuje legalne komendy read-only (C7). Bilans: **0/8 ŻELAZNYCH w pełni enforced**. Context_Forge — silnik samo-odchudzania — **0 uruchomień w 17 sesjach** mimo spełnionych sygnałów (C12, C16); bloat z klastra B to bezpośredni skutek.

### 🟡 KLASTER D — Rozwój Fi = martwa litera (C15, C16, C17) + bloat rehydrate (C2, C3, C4, C5, C14)
Cel dwukierunkowy („user rozumie zależności i zastosowania AI"): **3 deklaracje, 0 mechanizmów** — wszystkie pętle uczenia płyną do agenta, żadna do usera (C15). Pętla uczenia agenta domyka się po 3-4 korektach (L4 4×, L12 3×) (C16). KNOWLEDGE stoi 40 dni, times_refined=0 (C17). Bloat: CHECKLIST §DONE 24 wpisy przy limicie 15 (68% pliku!), DECISIONS 2029 słów mega-rationale, potrójny zapis narracji sesji (CHECKLIST+STATE+DECISIONS), podwójne ładowanie ŻELAZNYCH (hook + rehydrate).

### ✅ Mocne strony (też twarde fakty)
- **sync_state trzymany 17/17 sesji** (git log: 17× SYNC_STATE, zero dziur) — dyscyplina procedury wzorowa.
- Struktura SSOT/foldery/warstwy pamięci — audytorzy nie znaleźli wad architektury, tylko wady serwisu.
- Jakość audytu: sceptycy obalili tylko 3/33 — w tym 1 defekt naprawiony równolegle przez drugą sesję (MEMORY.md), 2 wnioski nadmiarowe przy prawdziwych faktach bazowych.

### ❌ Obalone (R1-R3)
R1 MEMORY.md przekroczony limit — naprawione w trakcie audytu przez równoległą sesję GOFANS. R2 „hooki chronią tylko szablon" — fakty prawdziwe, ale to znany OPEN blocker C4/decyzja Fi, nie nowe znalezisko. R3 „Agent Teams martwe" — wniosek nie wynika (triggery nie były jednoznacznie spełnione; Expert_Council ma ślad użycia).

---

## WERDYKT MUADDIBA

**ŻÓŁTY | CONF 0.90 (po grillu).** Architektura zdrowa — telemetria kłamie, egzekucja dziurawa, fork niebezpieczny. System nie wymaga przebudowy, wymaga **serwisu**. Trzy z czterech klastrów to jedna choroba: *living template (D15) urósł, a liczby/wzorce/deklaracje stoją w miejscu z maja*.

**Plan napraw (kolejność wg blast-radius) — REKOMENDACJA, adopcja per komenda Fi (ŻELAZNA #5):**

| Pakiet | Zakres | Koszt | Zysk |
|--------|--------|-------|------|
| **PB-1 Fork-safety** | INIT: `rm -rf .git` + reset LESSONS/DECISIONS/PROOFS (lub jawna decyzja o dziedziczeniu) + whitelist grep + `{{ALIAS}}` | ~30 min | eliminuje jedyne ryzyko nieodwracalne (push na remote szablonu) |
| **PB-2 Context_Forge TERAZ** | kondensacja CHECKLIST §DONE→ARCHIVE, DECISIONS rationale→PROOFS, dedup narracji; liczby budżetu z pomiaru | 1 sesja | rehydrate ~12.7k → ~7k tk, **na każdą przyszłą sesję** |
| **PB-3 Hooki v2** | kotwice wzorców, warianty rm, toplevel-check git add, marker gaszony hookiem, ślad Reflect, licznik cadence Forge w session-inject | ~1 h | hooki łapią incydenty L15/L4 zamiast ich wariantów stylistycznych |
| **PB-4 Rozwój Fi** | Reflect § „Wnioski dla Fi" (1-3 punkty/sesja, na istniejącym reflect-gate) + router sync 7 skilli | ~20 min | martwa połowa celu systemu dostaje pierwszy mechanizm |

Korekta z grilla wpisana w plan: PB-2 per-plik z pomiarem po każdym (jedna zmiana → weryfikuj), po PB-2 code-review subagent (governance >5 plików), testy hooków przed/po (stare 16 + nowe warianty).

**Koordynacja:** GOFANS dostał dziś (równoległa sesja) własny `PROOP_BOOST` meta-skill. Przy C4 pogodzić z TEMPLE `Proof_Boost` (nazwa/zakres) — nie dublować.

---

## GRILL_ME werdyktu (self, coverage 7/7)

1. **ZAŁOŻENIA** — Priorytet PB-1 zakłada bliski fork? Nie musi: koszt fixu 3 linie vs blast radius = nadpisany remote. Asymetria broni priorytetu niezależnie od terminu. Konwersja tokenów sporna (1.35/słowo vs 4B/zn) → dwa pomiary, 9.7k i 12.7k, **oba >6k** — wniosek odporny na metodę. STOI.
2. **EDGE CASES** — Kondensacja CHECKLIST vs „trwały rejestr"? Reguła własna repo mówi „max 15 DONE →ARCHIVE" = przenoszenie, nie kasowanie; archiwum istnieje. Zastrzeżenie do PB-2: NIGDY delete, zawsze move. STOI.
3. **ZALEŻNOŚCI** — PB-2 dotyka >5 plików governance → obowiązkowy code-review subagent po (pattern D48-GOFANS). PB-3 wymaga testów jak D21 (16/16) rozszerzonych o warianty C19/C20. Wpisane w plan. STOI.
4. **ALTERNATYWY** — (a) wyrzucić dziurawe hooki zamiast łatać? NIE: D21 rozstrzygnięte, dziury łatalne, strażnik przy nieodwracalnych ma realną wartość. (b) wyciąć deklarację rozwoju usera (F5 placebo) zamiast budować mechanizm? NIE: Fi w tym zadaniu jawnie zażądał „mojego rozwoju" — popyt potwierdzony, mechanizm tani. (c) podnieść próg 6k zamiast odchudzać? NIE: leczenie termometru. STOI.
5. **RYZYKA (TOP-3)** — (1) PB-2 hurtem łamie „jedna zmiana → weryfikuj" → mitygacja per-plik + wc po każdym. (2) Kotwiczenie wzorców może osłabić istniejące blokady → testy przed/po. (3) Kolizja z równoległą sesją GOFANS (wspólna workspace MEMORY, bliźniaczy skill) → TEMPLE-zmiany nie dotykają GOFANS, kolizja zgłoszona Fi jawnie. POKRYTE.
6. **KOSZTY** — PB-1+3+4 ≈ 2-3 h; PB-2 = 1 sesja. Zwrot: ~5-6k tk oszczędności na start każdej sesji → zwrot po ~2 sesjach. OPŁACALNE.
7. **REVERSIBILITY** — wszystko w git; kondensacja = move do ARCHIVE/PROOFS; hooki = pliki .sh. Jedyna nieodwracalność w grze to ta, której PB-1 zapobiega. PEŁNA.

**GRILL VERDICT: ZIELONY | CONF 0.90 | GO** (na PB-1→PB-4 w tej kolejności; PB-1 przed jakimkolwiek forkiem — bezwzględnie).

---

## Meta (dogfood skilla)

- `Proof_Boost.md` (nowy skill, sesja 18) zadziałał end-to-end za pierwszym razem; koszt: 39 agentów / ~1.9M tk subagentów / ~54 min.
- Wnioski do ewentualnego szlifu skilla: sektory 1-2-3 częściowo się nakładały na budżecie rehydrate (3 duplikaty tego samego faktu) — plus: potrójna niezależna konfirmacja; minus: koszt. Opcja: wspólna sekcja „pomiary bazowe" przed panelem.
