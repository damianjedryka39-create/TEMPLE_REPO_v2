# INIT — Bootstrap nowego projektu z TEMPLE

> Ten plik jest kompletny. Agent czyta tylko to i wykonuje bez pytań dodatkowych poza 12 parametrami z §2.

---

## 0. ŹRÓDŁO

Szablon leży w: `/root/GOFANS-NEOVERSE/TEMPLE_REPO_v2/`
Ten plik (`INIT.md`) jest w root szablonu — wszystkie ścieżki poniżej są względne do niego.

---

## 1. CEL

Skopiować strukturę TEMPLE pod nowy projekt, wypełnić placeholdery, zainicjować pierwszy CHECKLIST, commit. Od razu gotowy do `rehydrate <alias>`.

---

## 2. PARAMETRY (zapytaj Fi JEDNORAZOWO na starcie — wszystkie na raz)

```
1.  ALIAS_PROJEKTU      — kebab-case, np. "fi-trading"
2.  ALIAS_UPPER         — UPPER_SNAKE, np. "FI_TRADING"       (auto: z ALIAS)
3.  NAZWA_PROJEKTU      — pełna, np. "Fi Trading Intelligence"
4.  OPIS_PROJEKTU       — 2-3 zdania (co to jest, po co, dla kogo)
5.  NAZWA_AVATARA       — imię agenta w tym projekcie, np. "Muaddib"
6.  ROLA_AVATARA        — np. "Chief Architect"
7.  POZIOM_AVATARA      — np. "Principal"
8.  ŚCIEŻKA_NOWEGO_REPO — gdzie utworzyć, np. "/root/GOFANS-NEOVERSE/FI_TRADING"
9.  URL_PRODUKCJI       — jeśli brak: "TBD"
10. KATALOG_ROOT        — folder kodu w 🅕_PRODUKT/, jeśli brak: "TBD"
11. PROCEDURA_DEPLOY    — jeśli brak: "TBD"
12. SERWER / STATUS_SSL — jeśli brak: "TBD" / "TBD"
13. SPECJALIZACJA_AVATARA — 3 bullety, czym avatar różni się w tym projekcie:
     - SPECJALIZACJA_1 — np. "Fokus na architekturę AI systemów"
     - SPECJALIZACJA_2 — np. "Domain expert w fintech"
     - SPECJALIZACJA_3 — np. "Bridge między produkt <-> inżynieria"
```

**Opcjonalne (defaults w Kroku 2 jeśli Fi nie poda):**
- `FAZA` — np. "MVP", "SEED", "SCALE" (default: `MVP`)
- `OWNER` — osoba odpowiedzialna za CONSTITUTION (default: `Fi`)

Zadaj je jedną listą. Czekaj na odpowiedź. Bez parametrów nie startuj.

---

## 3. PROCEDURA (wykonaj sekwencyjnie)

### Krok 1 — Kopia struktury

```bash
cp -r /root/GOFANS-NEOVERSE/TEMPLE_REPO_v2/ "${SCIEZKA_NOWEGO_REPO}"
cd "${SCIEZKA_NOWEGO_REPO}"
rm -f INIT.md                                # INIT zbędny po użyciu
rm -rf REPOSITORIES/                         # zewnętrzne repo nie propagują się — każdy projekt buduje własny zbiór
```

### Krok 2 — Podmiana placeholderów

We WSZYSTKICH plikach `.md` zamień wystąpienia (regex/sed po pełnym drzewie).

**Placeholdery wypełniane z §2:**

| Placeholder | Bash var |
|---|---|
| `{{NAZWA_PROJEKTU}}` | `${NAZWA_PROJEKTU}` |
| `{{ALIAS_PROJEKTU}}` | `${ALIAS_PROJEKTU}` |
| `{{ALIAS_UPPER}}` | `${ALIAS_UPPER}` |
| `{{NAZWA_AVATARA}}` | `${NAZWA_AVATARA}` |
| `{{ROLA}}` / `{{ROLA_AVATARA}}` | `${ROLA_AVATARA}` |
| `{{POZIOM}}` | `${POZIOM_AVATARA}` |
| `{{URL_PRODUKCJI}}` | `${URL_PRODUKCJI}` |
| `{{KATALOG_ROOT}}` | `${KATALOG_ROOT}` |
| `{{PROCEDURA_DEPLOY}}` | `${PROCEDURA_DEPLOY}` |
| `{{SERWER — np. Nginx, Vercel, Cloudflare}}` | `${SERWER}` |
| `{{STATUS_SSL}}` | `${STATUS_SSL}` |
| `{{Specjalizacja 1 — np. "..."}}` | `${SPECJALIZACJA_1}` |
| `{{Specjalizacja 2 — np. "..."}}` | `${SPECJALIZACJA_2}` |
| `{{Specjalizacja 3 — np. "..."}}` | `${SPECJALIZACJA_3}` |
| `{{DATA_YYYY-MM-DD}}` | `${DATE_ISO}` (auto) |
| `{{YYYY-MM-DDTHH:MM:SSZ}}` | `${TIMESTAMP}` (auto) |
| `{{FAZA — np. MVP, SEED, SCALE}}` | `${FAZA}` (default `MVP`) |
| `{{OWNER}}` | `${OWNER}` (default `Fi`) |

**Komenda (jedna, pełna — zadeklaruj zmienne na górze):**

```bash
# 1) Deklaracja zmiennych (Fi podaje z §2; FAZA/OWNER mają defaulty)
ALIAS_PROJEKTU="<wartość z §2>"
ALIAS_UPPER="<wartość z §2>"
NAZWA_PROJEKTU="<wartość z §2>"
NAZWA_AVATARA="<wartość z §2>"
ROLA_AVATARA="<wartość z §2>"
POZIOM_AVATARA="<wartość z §2>"
URL_PRODUKCJI="<wartość z §2>"
KATALOG_ROOT="<wartość z §2>"
PROCEDURA_DEPLOY="<wartość z §2>"
SERWER="<wartość z §2>"
STATUS_SSL="<wartość z §2>"
SPECJALIZACJA_1="<wartość z §2>"
SPECJALIZACJA_2="<wartość z §2>"
SPECJALIZACJA_3="<wartość z §2>"
FAZA="${FAZA:-MVP}"
OWNER="${OWNER:-Fi}"
DATE_ISO=$(date -u +"%Y-%m-%d")
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# 2) Podmiana we wszystkich .md
find . -type f -name "*.md" -exec sed -i \
  -e "s|{{YYYY-MM-DDTHH:MM:SSZ}}|${TIMESTAMP}|g" \
  -e "s|{{DATA_YYYY-MM-DD}}|${DATE_ISO}|g" \
  -e "s|{{NAZWA_PROJEKTU}}|${NAZWA_PROJEKTU}|g" \
  -e "s|{{ALIAS_PROJEKTU}}|${ALIAS_PROJEKTU}|g" \
  -e "s|{{ALIAS_UPPER}}|${ALIAS_UPPER}|g" \
  -e "s|{{NAZWA_AVATARA}}|${NAZWA_AVATARA}|g" \
  -e "s|{{ROLA_AVATARA}}|${ROLA_AVATARA}|g" \
  -e "s|{{ROLA}}|${ROLA_AVATARA}|g" \
  -e "s|{{POZIOM}}|${POZIOM_AVATARA}|g" \
  -e "s|{{URL_PRODUKCJI}}|${URL_PRODUKCJI}|g" \
  -e "s|{{KATALOG_ROOT}}|${KATALOG_ROOT}|g" \
  -e "s|{{PROCEDURA_DEPLOY}}|${PROCEDURA_DEPLOY}|g" \
  -e "s|{{SERWER — np\\. Nginx, Vercel, Cloudflare}}|${SERWER}|g" \
  -e "s|{{STATUS_SSL}}|${STATUS_SSL}|g" \
  -e "s|{{FAZA — np\\. MVP, SEED, SCALE}}|${FAZA}|g" \
  -e "s|{{OWNER}}|${OWNER}|g" \
  -e "s|{{Specjalizacja 1 — np\\. \"Fokus na architekturę AI systemów\"}}|${SPECJALIZACJA_1}|g" \
  -e "s|{{Specjalizacja 2 — np\\. \"Domain expert w fintech\"}}|${SPECJALIZACJA_2}|g" \
  -e "s|{{Specjalizacja 3 — np\\. \"Bridge między produkt <-> inżynieria\"}}|${SPECJALIZACJA_3}|g" \
  {} +
```

**Weryfikacja:** `grep -rn "{{" .` musi zwrócić zero wyników (poza meta-placeholderami `{{N}}`, `{{DATA}}`, `{{DECYZJA}}`, `{{OPCJE}}`, `{{DLACZEGO}}`, `{{CONF}}`, `{{CO ZMIENIONO — krótko}}`, `{{DLACZEGO — twarde fakty}}` w `DECISIONS.md` i `Workflow_Edit.md` — te są szablonami składni dla agenta, NIE do wypełnienia). Jeśli coś innego zostało — dopisz do sed lub wypełnij ręcznie.

### Krok 3 — Wypełnij OPIS_PROJEKTU

Plik: `🅐_OPIS/OPIS_PROJEKTU.md` (jeśli istnieje, inaczej stwórz).
Zawartość: OPIS_PROJEKTU z §2 (2-3 zdania) + 3 bullets „co będzie gotowe na MVP".

### Krok 4 — Zainicjuj CHECKLIST

Plik: `🅒_NOW/CHECKLIST.md` — zastąp szablon wpisem:

```markdown
# CHECKLIST — <NAZWA_PROJEKTU>

## NEXT
- [ ] Ustal zakres MVP z Fi (CHECK_ME session)

## IN PROGRESS
(pusto)

## DONE
- [x] INIT projekt z TEMPLE (<data UTC>)
```

### Krok 4.5 — GATE: Waliduj CONSTITUTION

**BLOCKING:** Sprawdź `CONSTITUTION.md`:

```bash
grep -c "{{" CONSTITUTION.md
```

Jeśli wynik > 0 → **STOP**. Konstytucja musi być wypełniona przed dalszym bootstrapem. Agent bez granic = agent bez kontroli. Wróć do Fi i wypełnij wartości, misję i Dekalog.

### Krok 5 — Zainicjuj STATE

Plik: `🅒_NOW/STATE_OF_SYSTEM.md` — zastąp wpisem:

```markdown
# STATE — <NAZWA_PROJEKTU>
<timestamp UTC>

## TOP-10 FACTS
1. Projekt zainicjowany z TEMPLE_REPO

## TOP-5 PROOFS
(pusto — pierwsze proofy po pierwszym milestone)

## TOP-3 BLOCKERS
1. DATA: brak zdefiniowanego MVP scope

## NEXT GOAL
CHECK_ME z Fi — ustal zakres MVP

## LAST SESSION DELTA
INIT z TEMPLE zakończony. Struktura + placeholdery wypełnione. Gotowy do pierwszego rehydrate.

CONF: 0.85 | STUCK: nie | ASSUMPTIONS: parametry podane przez Fi są finalne
```

### Krok 6 — Git init + pierwszy commit

```bash
cd <ŚCIEŻKA_NOWEGO_REPO>
git init -q
git add -A
git commit -q -m "INIT <ALIAS_UPPER> from TEMPLE

- Skopiowano strukturę TEMPLE_REPO
- Wypełniono placeholdery ({{ALIAS}}, {{AVATAR}}, etc.)
- Zainicjowano CHECKLIST + STATE
- Avatar: <NAZWA_AVATARA> (<ROLA_AVATARA>)
"
```

### Krok 7 — Raport do Fi

```
✅ INIT <ALIAS_UPPER> DONE

Ścieżka: <ŚCIEŻKA_NOWEGO_REPO>
Avatar:  <NAZWA_AVATARA> (<ROLA_AVATARA>)
Commit:  <hash>

NEXT: `rehydrate <ALIAS_PROJEKTU>` — wejdę w projekt i zrobimy CHECK_ME scope MVP.

CONF: 0.90 | STUCK: nie | ASSUMPTIONS: brak
```

---

## 4. ZASADY (NIE ŁAMAĆ)

1. **NIE modyfikuj plików w `/root/GOFANS-NEOVERSE/TEMPLE_REPO_v2/`** — to jest szablon-master. Pracujesz TYLKO w nowym repo.
2. **NIE zmieniaj skilli** w `🅓_SYSTEM/SKILL/` — kopiuj 1:1. Skille są uniwersalne.
3. **NIE wypełniaj `lessons.md`** — zostaje pusty, rośnie z czasem przez REFLECT.
4. **NIE wypełniaj `🅔_STRATEGIA/PROOFS/`** — zostaje pusty (tylko EXAMPLE_PROOF), rośnie w czasie.
5. **NIE usuwaj `🅓_SYSTEM/AVATAR/Muaddib.md`** — to CORE, wypełnia się automatycznie (placeholder specjalizacji).
6. **Placeholdery TBD** są OK jeśli brak danych — nie zmyślaj URL/deploy procedur.
7. **Jeśli coś blokuje** (brak parametru, konflikt ścieżek, plik istnieje) → STOP, zgłoś Fi, nie improwizuj.
8. **VOICE.md CZĘŚĆ 2 (tone of voice wobec świata) = WSPÓLNA, zostaje as-is** (D16, 2026-04-22). Sed NIE ingeruje w CZĘŚĆ 2. Fi = jeden człowiek, jeden styl zewnętrzny. Wypełniana jest tylko nagłówek `{{NAZWA_AVATARA}}` w tytule pliku.

---

## 5. PO INIT

Od tego momentu projekt żyje samodzielnie:
- `rehydrate <ALIAS_PROJEKTU>` → wczyta Muaddib + CO_PILOT + State + Checklist + Decisions
- `sync_state` → update State + Decisions + commit
- Nowe zadania → Router w CO_PILOT.md §4
- Koniec sesji → skill `Reflect.md`

**INIT.md w nowym projekcie zostaje usunięty w Kroku 1** — nie jest potrzebny po bootstrapie.
