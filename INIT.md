# INIT — Bootstrap nowego projektu z TEMPLE

> Ten plik jest kompletny. Agent czyta tylko to i wykonuje bez pytań dodatkowych poza 13 parametrami z §2.

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

> ⚠️ **Hook `block-destructive.sh` zablokuje `rm -rf` w tym kroku** — i słusznie, to jego robota. Tu destrukcja jest zamierzona i dotyczy **świeżej kopii**, nie oryginału, więc autoryzujemy ją jawnie markerem (ważny 2 minuty). Nie omijaj hooka przez przepisywanie komendy na wariant, którego regex nie łapie — to sabotaż własnego strażnika.

```bash
: "${SCIEZKA_NOWEGO_REPO:?STOP: zmienna SCIEZKA_NOWEGO_REPO nie jest ustawiona}"   # zabezpieczenie przed rm -rf "/.git"
cp -r /root/GOFANS-NEOVERSE/TEMPLE_REPO_v2/ "${SCIEZKA_NOWEGO_REPO}"
cd "${SCIEZKA_NOWEGO_REPO}"
touch /tmp/ALLOW_DESTRUCTIVE                 # autoryzacja dla block-destructive.sh (2 min) — czyścimy KOPIĘ, nie szablon
rm -rf "${SCIEZKA_NOWEGO_REPO}/.git"         # 🔴 KRYTYCZNE — bez tego fork commituje na historię TEMPLE i push nadpisuje remote szablonu (C24)
rm -f INIT.md                                # INIT zbędny po użyciu
rm -rf REPOSITORIES/                         # zewnętrzne repo nie propagują się — każdy projekt buduje własny zbiór
rm -f .claude/.session_active .claude/.reflect_done   # markery sesji szablonu — inaczej fork startuje z fałszywym alarmem urwanej sesji (D22)
```

**Weryfikacja Kroku 1 (przed dalszymi krokami):**

```bash
[ ! -d .git ] && echo "OK: brak .git — fork odcięty od historii szablonu" || echo "STOP: .git nadal istnieje"
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
  -e "s|{{ALIAS}}|${ALIAS_PROJEKTU}|g" \
  {} +
```

**Weryfikacja (BLOCKING):** sprawdzaj **tylko placeholdery z §2** — te, które sed podmienia. Reszta `{{...}}` w repo to celowe szablony składni (`{{N}}`, `{{DATA}}`, `{{ZASADA_1}}`, `{{Wzorzec 1 — ...}}` itd.) wypełniane później przez agenta — one NIE są błędem (C26).

```bash
PLACEHOLDERY=(
  '{{NAZWA_PROJEKTU}}' '{{ALIAS_PROJEKTU}}' '{{ALIAS_UPPER}}' '{{ALIAS}}'
  '{{NAZWA_AVATARA}}' '{{ROLA_AVATARA}}' '{{ROLA}}' '{{POZIOM}}'
  '{{URL_PRODUKCJI}}' '{{KATALOG_ROOT}}' '{{PROCEDURA_DEPLOY}}'
  '{{SERWER — np. Nginx, Vercel, Cloudflare}}' '{{STATUS_SSL}}'
  '{{FAZA — np. MVP, SEED, SCALE}}' '{{OWNER}}'
  '{{DATA_YYYY-MM-DD}}' '{{YYYY-MM-DDTHH:MM:SSZ}}'
  '{{Specjalizacja 1 — np. "Fokus na architekturę AI systemów"}}'
  '{{Specjalizacja 2 — np. "Domain expert w fintech"}}'
  '{{Specjalizacja 3 — np. "Bridge między produkt <-> inżynieria"}}'
)
BRAKI=0
for p in "${PLACEHOLDERY[@]}"; do
  n=$(grep -rlF "$p" . --include="*.md" 2>/dev/null | wc -l)
  [ "$n" -gt 0 ] && { echo "❌ $p — pozostał w $n plikach:"; grep -rlF "$p" . --include="*.md"; BRAKI=1; }
done
[ "$BRAKI" -eq 0 ] && echo "✅ Wszystkie placeholdery §2 podmienione" || echo "🛑 STOP — uzupełnij zanim przejdziesz dalej"
```

Jeśli któryś został — dopisz go do sed albo wypełnij ręcznie i powtórz sprawdzenie.

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

### Krok 5.5 — Reset pamięci szablonu (decyzja Fi 2026-07-30)

**Zasada:** nowy projekt startuje z czystą pamięcią, ale **zachowuje uniwersalne reguły Fi**. Lekcje, decyzje i dowody TEMPLE to historia szablonu — nie historia tego projektu.

| Plik | Co zostaje | Co znika |
|------|-----------|----------|
| `LESSONS.md` | Nagłówek + cała sekcja `⚡ ŻELAZNE` | Wszystkie `L<N>` + `Findings` |
| `🅒_NOW/DECISIONS.md` | Frontmatter, nagłówki tabeli, instrukcja „Jak dodać" | Wszystkie wiersze `D<N>` |
| `🅔_STRATEGIA/PROOFS/` | `EXAMPLE_PROOF_YYYYMMDD.md` + `.gitkeep` | Wszystkie proofy szablonu |
| `🅖_ARCHIVE/` | Pusty katalog + `.gitkeep` | Archiwum sesji szablonu |

```bash
# 1) LESSONS — utnij na pierwszej lekcji, zostaw ŻELAZNE + pusty szkielet
awk '/^## L[0-9]/{exit} {print}' LESSONS.md > /tmp/lessons_new.md
cat >> /tmp/lessons_new.md <<'EOF'
## Lekcje

> Format: `## L<N> — <tytuł> (<data>)` + **Sygnał:** + **Reguła:**.
> Dodawane WYŁĄCZNIE przez skill `Reflect.md` — nigdy ręcznie (ŻELAZNA #3).

(pusto — pierwsza lekcja po pierwszej korekcie Fi)

---

## Findings (long-term)

(pusto — odkrycia z wielu sesji, nie pojedyncze korekty)
EOF
mv /tmp/lessons_new.md LESSONS.md

# 1b) ŻELAZNE — utnij odsyłacze do lekcji, których w forku już nie ma (→ L12 + L13 itd.)
sed -i -e 's/ → L[0-9]\+\( + L[0-9]\+\)*$//' \
       -e 's/Łamanie = utrata zaufania\. Pełny kontekst → odpowiednie L# niżej\./Łamanie = utrata zaufania. Przeniesione z TEMPLE — obowiązują od pierwszej sesji./' \
       LESSONS.md

# 1c) Referencje do decyzji/lekcji SZABLONU w plikach systemowych — oznacz jako TEMPLE-*
# Powód: AGENTS/CO_PILOT/skille cytują (D19), (D20), L4, L18 itd. Po resecie pamięci fork nie ma tych
# numerów, a po 19 własnych decyzjach nada D19 CAŁKIEM INNE znaczenie → referencja rozwiąże się cicho błędnie.
PLIKI_SYS=$(find . -name "*.md" -not -path "./🅒_NOW/*" -not -name "LESSONS.md" -not -path "./🅔_STRATEGIA/*" -not -path "./🅖_ARCHIVE/*")
for i in 1 2; do   # 2 przebiegi — dopasowania sąsiadujące (np. "(D9, D11, D14)")
  echo "$PLIKI_SYS" | xargs sed -i -e 's/\([(, ]\)D\([0-9]\+\)\([),]\)/\1TEMPLE-D\2\3/g'
done
echo "$PLIKI_SYS" | xargs sed -i -e 's/(L\([0-9]\+\))/(TEMPLE-L\1)/g' -e 's/\(^\| \)L\([0-9]\+\):/\1TEMPLE-L\2:/g'

# 2) DECISIONS — usuń wiersze D<N> + pointer do archiwum szablonu (którego fork nie ma), wstaw notkę o konwencji
grep -v '^| D[0-9]' "🅒_NOW/DECISIONS.md" \
  | grep -v 'DECISIONS_RATIONALE_2026q2' \
  | sed 's|^> Tutaj: decyzja + jednozdaniowy powód.*|> ⚠️ Odwołania `TEMPLE-D<N>` i `TEMPLE-L<N>` w plikach systemowych (AGENTS, CO_PILOT, skille) dotyczą decyzji i lekcji **szablonu**, nie tego projektu. Numeracja tego projektu startuje od D1 niezależnie.|' \
  > /tmp/decisions_new.md
mv /tmp/decisions_new.md "🅒_NOW/DECISIONS.md"

# 3) PROOFS — zostaw tylko przykład
find "🅔_STRATEGIA/PROOFS/" -type f ! -name 'EXAMPLE_PROOF_YYYYMMDD.md' ! -name '.gitkeep' -delete

# 4) ARCHIVE — wyczyść historię szablonu
find "🅖_ARCHIVE/" -type f ! -name '.gitkeep' -delete
touch "🅖_ARCHIVE/.gitkeep"
```

**Weryfikacja (BLOCKING):**

```bash
echo "LESSONS L<N>:      $(grep -c '^## L[0-9]' LESSONS.md)   (oczekiwane 0)"
echo "LESSONS ŻELAZNE:   $(grep -c '⚡ ŻELAZNE' LESSONS.md)   (oczekiwane 1)"
echo "DECISIONS D<N>:    $(grep -c '^| D[0-9]' '🅒_NOW/DECISIONS.md')   (oczekiwane 0)"
echo "PROOFS plików:     $(find '🅔_STRATEGIA/PROOFS/' -type f ! -name '.gitkeep' | wc -l)   (oczekiwane 1)"
echo "Wiszące ref D/L:   $(grep -rnoE '\([D][0-9]+|(^| )L[0-9]+:' --include='*.md' . | grep -v TEMPLE- | grep -vE '🅒_NOW|LESSONS.md' | wc -l)   (oczekiwane 0)"
echo "Wiszące pointery:  $(grep -rl '🅖_ARCHIVE/[A-Z]' --include='*.md' . | wc -l)   (oczekiwane 0)"
```

Każda wartość niezgodna → **STOP**, popraw ręcznie zanim zrobisz commit.

### Krok 6 — Git init + pierwszy commit

```bash
cd <ŚCIEŻKA_NOWEGO_REPO>
[ ! -d .git ] || { echo "🛑 STOP: .git istnieje — wróć do Kroku 1"; exit 1; }   # bramka C24
git init -q
git add -A
git commit -q -m "INIT <ALIAS_UPPER> from TEMPLE

- Skopiowano strukturę TEMPLE_REPO (bez .git szablonu)
- Wypełniono placeholdery z §2 (alias, avatar, deploy)
- Zresetowano pamięć: LESSONS do ŻELAZNE, DECISIONS pusta, PROOFS przykład
- Zainicjowano CHECKLIST + STATE
- Avatar: <NAZWA_AVATARA> (<ROLA_AVATARA>)
"
```

**Weryfikacja (BLOCKING):**

```bash
echo "commity: $(git log --oneline | wc -l)   (oczekiwane 1)"
echo "remote:  $(git remote -v | wc -l)       (oczekiwane 0)"
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
3. **NIE wypełniaj `LESSONS.md`** — Krok 5.5 zostawia w nim tylko sekcję `⚡ ŻELAZNE` (uniwersalne reguły Fi). Lekcje `L<N>` rosną z czasem przez skill `Reflect.md`.
4. **NIE wypełniaj `🅔_STRATEGIA/PROOFS/`** — Krok 5.5 zostawia tylko `EXAMPLE_PROOF`. Proofy rosną w czasie z realnej pracy.
5. **NIE usuwaj `🅓_SYSTEM/AVATAR/Muaddib.md`** — to CORE, wypełnia się automatycznie (placeholder specjalizacji).
6. **Placeholdery TBD** są OK jeśli brak danych — nie zmyślaj URL/deploy procedur.
7. **Jeśli coś blokuje** (brak parametru, konflikt ścieżek, plik istnieje) → STOP, zgłoś Fi, nie improwizuj.
8. **VOICE.md CZĘŚĆ 2 (tone of voice wobec świata) = WSPÓLNA, zostaje as-is** (D16, 2026-04-22). Sed NIE ingeruje w CZĘŚĆ 2. Fi = jeden człowiek, jeden styl zewnętrzny. Wypełniana jest tylko nagłówek `{{NAZWA_AVATARA}}` w tytule pliku.
9. **`🅓_SYSTEM/WORKFLOW/WORKFLOW.md` = WSPÓLNY, zostaje as-is** (D20, 2026-05-29). Model myślenia jest jeden dla wszystkich projektów — sed NIE ingeruje, brak placeholderów. Specjalizacja per-projekt idzie do `Muaddib.md §SPECJALIZACJA`, nie tutaj.
10. **`.claude/` (hooki) = KOPIUJE SIĘ przy forku, działa od razu** (D21, 2026-05-29). 6 strażników (sekrety/destrukcja/git-add/deploy/reflect-gate/session-inject) używa `$CLAUDE_PROJECT_DIR` → ścieżki auto-dostosują się w nowym projekcie. Sed NIE ingeruje. Hooki są uniwersalne (nie project-specific) — zostają as-is. Audyt: `🅔_STRATEGIA/PROOFS/HOOKS_AUDIT_*.md`.
11. **🔴 Fork MUSI być odcięty od szablonu** — `rm -rf .git` w Kroku 1 jest nieopcjonalne. Bez tego nowy projekt commituje na historię TEMPLE, a pierwszy `sync_state` (`git push`) nadpisuje remote szablonu-master. Weryfikacje `[ ! -d .git ]` w Kroku 1 i Kroku 6 to bramki, nie formalność (C24, 2026-07-30).

---

## 5. PO INIT

Od tego momentu projekt żyje samodzielnie:
- `rehydrate <ALIAS_PROJEKTU>` → wczyta Muaddib + WORKFLOW + CO_PILOT + State + Checklist + Decisions + LESSONS §ŻELAZNE + workspace MEMORY (8 pozycji)
- `sync_state` → update State + Decisions + commit
- Nowe zadania → Router w CO_PILOT.md §4
- Koniec sesji → skill `Reflect.md`

**INIT.md w nowym projekcie zostaje usunięty w Kroku 1** — nie jest potrzebny po bootstrapie.
