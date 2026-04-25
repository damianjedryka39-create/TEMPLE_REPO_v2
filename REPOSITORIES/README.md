# 📂 REPOSITORIES/

> **Cel:** Katalog na zewnętrzne repozytoria klonowane z GitHuba do analizy i ewentualnego użycia w projekcie. Każdy podkatalog = jedno repo.

---

## 🎯 Po co to?

Damian (Fi) przesyła linki do repo które warto przeanalizować. Agent klonuje je tutaj, robi audyt, ocenia użyteczność dla aktualnego workflow. Pozwala:

- 🔍 Czytać pełny kod / dokumentację bez bouncowania po WebFetch
- 🤖 Pisać skille-wrappery (np. `🅓_SYSTEM/SKILL/Prompt_Master.md`) wskazujące na te repo
- 📊 Trzymać trwały log "co rozważaliśmy" — nawet gdy oryginał z GitHuba zniknie
- ⚖️ Decydować GO / NO-GO świadomie, na podstawie kodu, nie streszczeń

---

## 📋 Konwencja

### Klonowanie
```bash
cd REPOSITORIES/
git clone --depth 1 <url>
rm -rf <repo>/.git    # NIE zostawiaj .git — żeby nie embedować jako submodule
```

### 📖 Co czytać przy audycie
Czytaj **TYLKO pliki opisowe** repo: `README.md`, `SKILL.md`, `OVERVIEW.md`, `CONTRIBUTING.md`, ewentualnie `package.json` / `pyproject.toml` dla zorientowania się w stacku.
**NIE czytaj** całego kodu, scriptsów, testów, examples — to żre tokeny i nie pomaga zrozumieć po co projekt jest. Audyt = "co to robi i czy mi się przyda", nie "code review".

### Struktura podkatalogu
```
REPOSITORIES/<nazwa-repo>/
├── (pliki oryginału — bez .git)
└── _AUDIT.md         (opcjonalnie — nasza analiza, werdykt, użyte fragmenty)
```

### Werdykt audytu (`_AUDIT.md`)
```markdown
# AUDIT — <nazwa-repo>
- **Source:** <URL>
- **License:** <MIT/Apache/etc>
- **Data importu:** YYYY-MM-DD
- **Werdykt:** 🟢 USED / 🟡 INSPIRATION / 🔴 REJECTED

## Co to jest
1-3 zdania.

## Co daje TOBIE
- Konkretny use case 1
- Konkretny use case 2

## Co pominęliśmy i dlaczego
- ...

## Powiązania
- Skill który tego używa: `🅓_SYSTEM/SKILL/<nazwa>.md`
- Inne pliki: ...
```

---

## 🚫 Co NIE leży w REPOSITORIES/

- ❌ **Nasze skille / workflow** → `🅓_SYSTEM/SKILL/`
- ❌ **Nasze proofy / audyty wewnętrzne** → `🅔_STRATEGIA/PROOFS/`
- ❌ **Kod produkcyjny projektu** → `🅕_PRODUKT/`
- ❌ **Aktywne dependencies projektu** (npm/pip) → standardowe lokalizacje (node_modules, venv)

REPOSITORIES = **archiwum referencyjne**, nie część kodu.

---

## 🔄 Fork TEMPLE → nowy projekt

Przy forku przez `INIT.md` katalog `REPOSITORIES/` **NIE jest propagowany** do nowego projektu. Każdy projekt buduje swój własny zbiór importowanych repo (zależnie od potrzeb). INIT.md czyści ten folder po kopiowaniu szablonu.

---

## 📚 Aktualnie zaimportowane

| Repo | Źródło | Licencja | Skill-wrapper | Werdykt |
|------|--------|----------|---------------|---------|
| `prompt-master/` | https://github.com/nidhinjs/prompt-master | MIT | `🅓_SYSTEM/SKILL/Prompt_Master.md` | 🟢 USED (on-demand) |
