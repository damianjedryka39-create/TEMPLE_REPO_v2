# TASK CONTRACT — Template delegacji do Codex

Użyj tego szablonu gdy Fi manualnie deleguje zadanie do Codex CLI.
Wypełnij KAŻDE pole. Puste pole = słaba delegacja = słaby output.

---

## 0. KIEDY DELEGOWAĆ

**Zasada:** Claude jest gatekeeperem. Codex to wykonawca — nie podejmuje decyzji, nie zmienia scope, nie commituje bez review. Delegacja = manualna decyzja Fi.

**TAK — deleguj do Codex:**
- Implementacja konkretnego ticketu z jasnym AC
- Generowanie kodu z gotowej specyfikacji / blueprint
- Refaktor mechaniczny (rename, extract, reorganize)
- Naprawianie bugów z jasnym reproduce scenario
- Pisanie testów do istniejącego kodu
- Generowanie boilerplate / scaffolding

**NIE — nie deleguj do Codex:**
- Decyzje architektoniczne (to Claude)
- Zadania wymagające kontekstu wielu plików naraz (Codex ma wąski kontekst)
- Cokolwiek co wymaga pytania usera (Codex nie pyta — robi)
- Praca z plikami > 500 linii bez jasnego wskazania gdzie zmienić

### FLOW: CLAUDE → CODEX → CLAUDE

```
1. CLAUDE: Specyfikacja + TASK CONTRACT
   ↓
2. Fi: Zatwierdza i odpala Codex manualnie
   ↓
3. CODEX: Implementacja (full-auto)
   ↓
4. CLAUDE: Review output → PREFLIGHT → DEPLOY/DONE
```

### ZASADY DELEGACJI

1. **Jeden task = jeden contract** — nie łącz wielu zadań w jedną delegację
2. **AC musi być sprawdzalne** — każdy punkt TAK/NIE, zero „powinno wyglądać dobrze"
3. **ZAKAZ jest obowiązkowy** — bez niego agent rozszerzy scope
4. **Review ZAWSZE** — Claude sprawdza output przed DONE/commit
5. **Fallback** — jeśli output słaby po 2 próbach → Claude robi sam

---

## 1. WORKFLOW — Pełny cykl delegacji

```
CLAUDE (architekt)                    CODEX (wykonawca)
─────────────────                     ─────────────────
1. Analizuje zadanie
2. Pisze CONTRACT → plik .md
3. Zapisuje: 🅒_NOW/TASK_<nazwa>.md
4. Fi zatwierdza i odpala manualnie
5. ────────────────────────────────►  6. Czyta contract
                                      7. Implementuje
                                      8. Zwraca output
9. ◄────────────────────────────────
10. Weryfikuje DoD (testy, lint)
11. Jeśli FAIL → poprawia lub nowy contract
12. Jeśli PASS → zamyka task, usuwa TASK_*.md
```

**ZASADA:** Claude NIGDY nie pisze inline prompt do Codex.
Zawsze: plik contract → `$(cat)` → Codex.

---

## 2. EXECUTION — Dokładne komendy

```bash
cd /root/GOFANS-NEOVERSE/<PROJEKT>/
/usr/local/bin/codex exec --full-auto "$(cat '🅒_NOW/TASK_<nazwa>.md')"
```

### Równoległe taski (różne pliki)
```bash
# TYLKO gdy taski dotyczą RÓŻNYCH plików (zero kolizji)
codex exec --full-auto "$(cat '🅒_NOW/TASK_boost_rss.md')" &
codex exec --full-auto "$(cat '🅒_NOW/TASK_boost_hn.md')" &
wait
```

---

## 3. CONTRACT FILE CONVENTION

| Element | Reguła |
|---------|--------|
| **Lokalizacja** | `🅒_NOW/TASK_<nazwa>.md` |
| **Nazewnictwo** | `TASK_` + snake_case opis, np. `TASK_sources_boost.md` |
| **Lifecycle** | Utwórz → Fi odpala → Execute → DoD PASS → Usuń |
| **Max 1 cel** | Jeden contract = jedno zadanie. Nie pakuj wielu celów. |
| **Ścieżki** | ZAWSZE pełne ścieżki od root projektu |
| **Idempotentność** | Contract musi być re-executable (Codex może odpalić 2x) |

---

## 4. CONTRACT TEMPLATE

```markdown
## TASK CONTRACT: [nazwa zadania]

### CEL
[1 zdanie — co ma powstać. Konkretnie, mierzalnie.]

### KONTEKST
[2-3 zdania — dlaczego to robimy, jaki jest stan systemu, co było wcześniej.]

### INPUT
[Pliki/dane które agent dostaje. Pełne ścieżki.]
- Plik 1: `🅕_PRODUKT/src/...`
- Plik 2: ...

### OUTPUT
[Dokładnie co ma zwrócić — format, pliki, nazwy, gdzie zapisać.]
- Plik wynikowy: `🅕_PRODUKT/...`
- Format: [HTML/MD/JSON/YAML/Python]

### ZMIANY DO WYKONANIA
[Konkretne, kopiowalne zmiany. Codex NIE zgaduje — dostaje gotowe dane.]
- Zmiana 1: ...
- Zmiana 2: ...

### AC (Acceptance Criteria)
[3-5 sprawdzalnych punktów. Każdy musi być TAK/NIE.]
1. [ ] ...
2. [ ] ...
3. [ ] ...

### ZAKAZ (Scope Guard)
[Czego NIE robić. Co jest poza zakresem.]
- NIE: ...
- NIE: ...

### DoD (Definition of Done)
[Dokładna komenda którą Claude odpali po wykonaniu.]
- Test: `komenda testu`
- Proof: `komenda weryfikacji`
```

---

## 5. CLAUDE PRE-CHECK (przed napisaniem contractu)

| # | Pytanie | Jeśli NIE |
|---|---------|-----------|
| 1 | Czy przeczytałem pliki INPUT? | → Przeczytaj najpierw |
| 2 | Czy wiem jakie DOKŁADNE zmiany mają być? | → Doprecyzuj z userem |
| 3 | Czy contract jest re-executable? | → Dodaj idempotentność |
| 4 | Czy ZAKAZ chroni przed scope creep? | → Dodaj guardy |
| 5 | Czy DoD ma KOMENDĘ (nie opis)? | → Zamień na executable |

---

## 6. CLAUDE POST-CHECK (po wykonaniu Codex)

```
1. Odpal DoD komendy
2. Jeśli testy PASS → oznacz task DONE, usuń TASK_*.md
3. Jeśli testy FAIL → przeczytaj diff, zdiagnozuj, popraw SAM lub nowy contract
4. NIGDY nie mów "gotowe" bez DOWODU (output testów)
```

---

## 7. PRZYKŁAD WYPEŁNIONEGO CONTRACTU

```markdown
## TASK CONTRACT: sources_yaml_boost

### CEL
Rozszerz `sources.yaml` dodając 12 RSS feedów, 9 Bluesky kont, 3 ArXiv kategorie i 3 języki GitHub Trending.

### KONTEKST
System ma 10 RSS, 5 Bluesky, 4 ArXiv, 3 trending languages. Cel: szerszy lejek danych dla intelligence engine.

### INPUT
- Plik: `🅕_PRODUKT/src/config/sources.yaml`

### OUTPUT
- Ten sam plik: `🅕_PRODUKT/src/config/sources.yaml`
- Format: YAML (2-space indent, zachowany styl)

### ZMIANY DO WYKONANIA
**rss_feeds** — dopisz na końcu listy:
  - name: Hugging Face Blog
    url: https://huggingface.co/blog/feed.xml
  [... konkretne wpisy ...]

**arxiv.categories** — zmień na: [cs.AI, cs.CL, cs.LG, cs.CV, cs.SE, cs.CR, stat.ML]

### AC
1. [ ] YAML parsuje się bez błędów (`python3 -c "import yaml; yaml.safe_load(open(...))"`)
2. [ ] Żaden istniejący wpis nie został usunięty
3. [ ] RSS count >= 22
4. [ ] Bluesky count >= 14
5. [ ] ArXiv categories = 7

### ZAKAZ
- NIE usuwaj istniejących wpisów
- NIE zmieniaj category_weights
- NIE zmieniaj struktury pliku

### DoD
- Test: `python3 -c "import yaml; c=yaml.safe_load(open('🅕_PRODUKT/src/config/sources.yaml')); print(len(c['rss_feeds']), 'RSS,', len(c['bluesky_accounts']), 'BSky')"`
- Proof: RSS >= 22, BSky >= 14, YAML valid
```
