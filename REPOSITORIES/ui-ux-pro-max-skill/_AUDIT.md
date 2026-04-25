# 🔍 AUDIT — ui-ux-pro-max-skill

- **Source:** https://github.com/nextlevelbuilder/ui-ux-pro-max-skill
- **Author:** Next Level Builder (uupm.cc)
- **License:** MIT
- **Data importu:** 2026-04-25
- **Werdykt:** 🟢 **USED** (skill wrapper `🅓_SYSTEM/SKILL/UI_UX_Pro_Max.md`)

---

## 📌 Co to jest po ludzku

**Inteligentny generator design systemów.** Mówisz *"landing dla spa wellness"* / *"sportowa gildia"* / *"SaaS dashboard"* → Python CLI + BM25 search po **csv-bazach** (161 reguł, 67 stylów, 161 palet kolorów, 57 par fontów, 99 wytycznych UX) → wypluwa kompletną kartę design system: pattern + style + 5 kolorów + para fontów + animacje + anti-patterns + a11y checklist.

To jest **decyzyjny etap projektowania** — nie implementacja, tylko *"co i dlaczego"*.

---

## 🎯 Dla TWOJEGO workflow

### 🟢 GOFANS landing — najmocniejszy use case

Masz tam masę splash/hero/character. Każda nowa sekcja może odpalić:
```bash
python3 src/ui-ux-pro-max/scripts/search.py "sport gildia hero section" --domain landing
python3 src/ui-ux-pro-max/scripts/search.py "GOFANS" --domain color
```
→ dostajesz konkretną paletę + pattern + checklist a11y. Mniej zgadywania.

### 🟢 Komplementarny dla DESIGN_ARSENAL

W TEMPLE masz już `DESIGN_ARSENAL.md` (snippety, biblioteki, animacje). UI_UX_Pro_Max **NIE konkuruje**:
- **Pro Max = decyzje** (jaki styl/kolor/font dla tego projektu)
- **DESIGN_ARSENAL = wykonanie** (gotowe snippety/biblioteki)
Najpierw Pro Max → dostajesz design system → potem DESIGN_ARSENAL realizuje sekcje.

### 🔴 Pomijaj dla

- MALING / MCP_KNOWLEDGE_ENGINE (backend, no UI design)
- TEMPLE meta (workflow szablon, no estetyka)
- Drobne CSS tweaks (overkill)

---

## 🚀 PRO BOOSTY

1. **Pre-delivery checklist** — automatyczny WCAG AA + responsive breakpoints + reduced-motion. Mała rzecz, ale dyscyplinuje.
2. **Anti-patterns per domena** — filtruje błędy które są typowe dla danego brandu (np. dark mode = anti-pattern dla wellness/spa).
3. **15 stacków tech support** — odpowiedzi adaptowane do `html-tailwind` (Twój GOFANS) lub innych jeśli kiedyś.
4. **Brak Python dependencies** — czysty Python 3.x, działa od razu.

---

## ⚠️ Co warto wiedzieć

- Repo to nie czysty markdown skill — to **Python CLI + CSV bazy**. Wrapper w `🅓_SYSTEM/SKILL/UI_UX_Pro_Max.md` mówi agentowi jak go odpalić.
- 12MB repo — głównie CSV bazy + screenshoty preview. NIE kopiuj zawartości do `🅓_SYSTEM/SKILL/`. Niech leży w `REPOSITORIES/`.
- Możesz też zainstalować przez npm: `npx uipro-cli init` (ale lokalnie w klonie też działa).

---

## 📝 Zasada dla kolejnego agenta

Gdy Fi pyta o decyzje projektowe (kolor/font/styl/layout/landing pattern):
1. Sprawdź czy temat to design system (nie czysty kod)
2. Odpal CLI z relevant domeną
3. Zwróć **Design System Card** w formacie z wrappera
4. Filtruj anti-patterns
5. Dodaj pre-delivery checklist na końcu

Gdy realizuje wykonanie (snippety/biblioteki) → przekaż do `DESIGN_ARSENAL.md`.
