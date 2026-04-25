# 🔍 AUDIT — obsidian-skills

- **Source:** https://github.com/kepano/obsidian-skills
- **Author:** Steph Ango (@kepano, CEO Obsidian)
- **License:** MIT
- **Data importu:** 2026-04-25
- **Werdykt:** 🟡 **DEPENDS** — wartość zależy od tego czy używasz Obsidian. 1 perła niezależna od Obsidian: `defuddle`.

---

## 📌 Co to jest po ludzku

Pakiet 5 skilli zgodnych ze standardem Agent Skills (działa w Claude Code, Codex, OpenCode), napisany przez **CEO Obsidian'a**. Wszystkie skupione na pracy w ekosystemie Obsidian (markdown vault, bases, canvas, CLI). Plus jeden skill ogólny.

---

## 🎯 5 skilli + werdykt per skill

| # | Skill | Co robi | Wart dla Ciebie? |
|---|-------|---------|------------------|
| 1 | **obsidian-markdown** | Pisze .md z wikilinks, embeds, callouts, properties (Obsidian Flavored Markdown) | 🟢 jeśli używasz Obsidian / 🔴 jeśli nie |
| 2 | **obsidian-bases** | Tworzy .base (Obsidian database) z views/filters/formulas | 🔴 niche Obsidian feature |
| 3 | **json-canvas** | Edycja .canvas (visual notes — graf węzłów/połączeń) | 🟡 standalone format, działa w Obsidian + innych narzędziach |
| 4 | **obsidian-cli** | Steruje Obsidian z CLI (plugin/theme dev) | 🔴 bardzo niche |
| 5 | **defuddle** ⭐ | Ekstrakcja czystego markdown ze stron www (usuwa reklamy/nav/sidebar). **Token saving.** | 🟢 **WARTOŚCIOWY niezależnie od Obsidian** |

---

## 🥇 PRO BOOST: `defuddle`

**Najmocniejszy** dla Twojego workflow. Gdy podrzucasz mi link → agent przez `defuddle` zassie tylko treść artykułu (bez śmieci), oszczędność tokenów + lepsza analiza.

Może wzmocnić Twój istniejący `Knowledge_Manager.md` skill — zamiast surowego WebFetch, użyć defuddle dla czystej ekstrakcji.

**Instalacja niezależna od Obsidian:**
```bash
npm install -g @kepano/defuddle-cli
defuddle <url>  # zwraca clean markdown
```

---

## ❓ KLUCZOWE PYTANIE

**Czy używasz Obsidian** do swojego workflow / notatek / GOFANS docs?

- **TAK** → 🟢 USED. Wziąć: defuddle + obsidian-markdown + json-canvas. Pominąć: bases, cli.
- **NIE** → 🟡 tylko `defuddle` warto. Reszta to noise.

---

## 📝 Zasada dla kolejnego agenta

Jeśli Fi nie używa Obsidian — usuń folder, zostaw tylko skill `defuddle/SKILL.md` jako jednoplikowy import. NIE adoptuj `obsidian-markdown/bases/canvas/cli` — to byłoby chowanie 4 plików których nie używamy.
