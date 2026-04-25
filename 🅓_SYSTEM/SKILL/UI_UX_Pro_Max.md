---
name: UI_UX_Pro_Max
trigger: "design system|paleta kolorów|color palette|landing layout|typography pairing|fontpairing|UI style|wybierz styl|projekt landing|design dla|estetyka strony|design intelligence"
purpose: Generuje kompletny design system (style/colors/typography/layout/anti-patterns) dla projektu w sekundach. Multi-domain search + BM25 ranking + 161 reguł reasoning. Output = decyzje projektowe gotowe do implementacji
output: Design System Card — pattern + style + colors (5) + typography pair + key effects + anti-patterns + pre-delivery checklist
agents: [Claude]
cross_link: [DESIGN_ARSENAL.md, Prompt_Master.md]
ecosystem: {{NAZWA_PROJEKTU}}
---

# UI UX PRO MAX — Design intelligence on-demand

> Wrapper na `REPOSITORIES/ui-ux-pro-max-skill/` (Next Level Builder, MIT). Skill oparty na **Python CLI + CSV databases** (BM25 search). Treść właściwa: 161 reasoning rules, 67 UI styles, 161 color palettes, 57 font pairings, 99 UX guidelines, 25 chart types, 15+ tech stacks.

---

## 🚀 KIEDY UŻYWAĆ

- **GOFANS landing** — nowy splash/hero/sekcja, refresh kolorów, dobór typography
- **Nowy projekt** który potrzebuje design system od zera ("zaprojektuj UI dla X")
- Fi pyta: *"jaki kolor/font/styl dla tego projektu"* / *"design pod sportową gildię"*
- Pre-delivery review estetyki przed deployem (a11y/contrast/responsive checklist)

## 🚫 KIEDY NIE używać

- Drobne tweak'i CSS (zostaw `DESIGN_ARSENAL` lub Claude sam)
- Backend/scrapery/API (MALING, MCP_KNOWLEDGE_ENGINE)
- Pojedynczy snippet (np. button hover) → Claude sam

---

## 🎯 7 DOMEN DO WYSZUKIWANIA

| Domena | Co zwraca |
|--------|-----------|
| `product` | Pattern landing dla typu produktu (SaaS / e-com / portfolio / spa / sportowa marka...) |
| `style` | UI style (glassmorphism, brutalism, soft UI, neo-skeumorphism...) + AI prompts + CSS keywords |
| `color` | Color palette (5 kolorów: primary/secondary/CTA/bg/text) + branding notes |
| `typography` | Font pairing + Google Fonts import string + mood/best-for |
| `landing` | Page structure (sekcje w kolejności) + CTA strategy |
| `chart` | Chart types + library recommendations (gdy projekt ma dashboards) |
| `ux` | Best practices + anti-patterns dla domeny |

## 📦 15 STACKÓW TECH

`html-tailwind` (default), `react`, `nextjs`, `astro`, `vue`, `nuxtjs`, `nuxt-ui`, `svelte`, `swiftui`, `react-native`, `flutter`, `shadcn`, `jetpack-compose`.

## 📋 KOMENDA (CLI Python)

```bash
cd REPOSITORIES/ui-ux-pro-max-skill/

# Domain search:
python3 src/ui-ux-pro-max/scripts/search.py "<query>" --domain <product|style|color|typography|landing|chart|ux>

# Stack search:
python3 src/ui-ux-pro-max/scripts/search.py "<query>" --stack <html-tailwind|react|nextjs|...>

# Auto-detection (omit --domain):
python3 src/ui-ux-pro-max/scripts/search.py "modern sport landing"
```

Brak external Python dependencies — tylko Python 3.x.

## 🎯 WORKFLOW (4 kroki)

1. **Zrozum kontekst** — typ projektu (sport gildia / SaaS / spa), branding (vibe), constraints (mobile-first?)
2. **Multi-domain search** — odpal CLI dla relevant domain (np. `--domain landing` + `--domain color`)
3. **Reasoning + filter anti-patterns** — agent łączy wyniki, odrzuca konflikty (np. dark mode dla wellness brand = anti-pattern)
4. **Output: Design System Card** w formacie:

```
TARGET: <nazwa projektu>
PATTERN: <hero-centric / dashboard-first / story-driven>
STYLE: <Soft UI / Brutalism / Glassmorphism>
COLORS:
  Primary:    #XXXXXX
  Secondary:  #XXXXXX
  CTA:        #XXXXXX
  Background: #XXXXXX
  Text:       #XXXXXX
TYPOGRAPHY: <Heading Font> / <Body Font>
KEY EFFECTS: <shadows + transitions + hover states>
AVOID: <anti-patterns dla domeny>
PRE-DELIVERY: [checklist a11y/contrast/responsive]
```

## ✅ PRE-DELIVERY CHECKLIST (PRO BOOST)

Każdy output zawiera:
- [ ] Brak emoji jako ikon (używaj SVG: Heroicons/Lucide)
- [ ] `cursor: pointer` na każdym klikalnym elemencie
- [ ] Hover states z `transition` 150-300ms
- [ ] Light mode: text contrast ≥4.5:1 (WCAG AA)
- [ ] Focus states widoczne dla keyboard nav
- [ ] `prefers-reduced-motion` respektowany
- [ ] Responsive: 375px / 768px / 1024px / 1440px

## 🔗 CROSS-LINK

- `DESIGN_ARSENAL.md` — komplementarne. **Pro Max = decyzje** (jaki styl/kolor/font), **DESIGN_ARSENAL = implementacja** (snippety, biblioteki, animacje). Najpierw Pro Max → dostajesz design system → potem DESIGN_ARSENAL realizuje konkretne sekcje.
- `Prompt_Master.md` — gdy Pro Max zwróci AI prompts dla stylu (np. dla Midjourney na hero) → prompt-master finalizuje wezuwiusz prompt.

## ⚠️ HARD RULES

1. **NIGDY nie pomijaj pre-delivery checklist** — to gwarancja minimum a11y
2. **NIGDY nie kombinuj 2+ stylów** w jednym design systemie (np. brutalism + soft UI = chaos)
3. **ZAWSZE filtruj anti-patterns** dla domeny (np. neon dla wellness brand = NIE)
4. **Przy konflikcie z DESIGN_ARSENAL** — Pro Max wygrywa dla decyzji, DESIGN_ARSENAL dla wykonania
