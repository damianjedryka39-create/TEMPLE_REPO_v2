---
name: Obsidian_Markdown
trigger: "obsidian|wikilink|callout|frontmatter|.md w obsidian|notatka obsidian|asystent biurowy|vault"
purpose: Pisanie/edycja Obsidian Flavored Markdown — wikilinks `[[Note]]`, embeds `![[file]]`, callouts `> [!note]`, properties (YAML frontmatter), tagi `#tag`, comments `%%`
output: Plik .md z poprawną składnią Obsidian, działającą po wklejeniu do vault'a
agents: [Claude]
cross_link: [JSON_Canvas.md, Knowledge_Manager.md]
ecosystem: {{NAZWA_PROJEKTU}}
---

# OBSIDIAN MARKDOWN — Pisanie pod vault

> Wrapper na `REPOSITORIES/obsidian-skills/skills/obsidian-markdown/SKILL.md` (Steph Ango/kepano, MIT). Pełna referencja (196 linii + helpery `references/PROPERTIES.md`, `EMBEDS.md`, `CALLOUTS.md`) — czytaj oryginał gdy potrzebujesz konkretnego typu callouta lub property.

## 🚀 KIEDY UŻYWAĆ

- Fi mówi o **Obsidian** / **vault** / **asystent biurowy** (jego asystent biurowy żyje w Obsidian)
- Plik `.md` ma być wklejony do vault'a
- Trzeba wikilink, callout, embed, property, tag, comment

## 🎯 KLUCZOWE ROZSZERZENIA OBSIDIAN

### Wikilinks (vault-internal)
```markdown
[[Note Name]]                  link
[[Note Name|Display Text]]     custom display
[[Note Name#Heading]]          do nagłówka
[[Note Name#^block-id]]        do bloku (^block-id na końcu paragrafu)
```

### Embeds
```markdown
![[Note Name]]                 cała notatka
![[Note Name#Heading]]         sekcja
![[image.png]]                 obrazek
![[document.pdf#page=2]]       strona PDF
```

### Callouts
```markdown
> [!note] Title
> Content

> [!warning]+ Foldable open
> [!tip]- Foldable closed
```
Typy: `note`, `info`, `tip`, `success`, `question`, `warning`, `failure`, `danger`, `bug`, `example`, `quote`.

### Properties (YAML frontmatter)
```yaml
---
tags: [project, gofans]
aliases: [Alt Name]
date: 2026-04-25
status: active
---
```

### Inne
- Tagi inline: `#tag` lub `#parent/child`
- Komentarze (niewidoczne w preview): `%% comment %%`

## ⚠️ HARD RULES

1. **Wikilink dla notatek vault'a, markdown link dla URLów zewnętrznych** — `[[Note]]` dla wewnętrznych, `[text](url)` dla web. Mieszanie = rename breakage.
2. **Properties zawsze na górze pliku** w blokach `---` (YAML frontmatter)
3. **Block ID** (`^my-id`) na końcu paragrafu lub w osobnej linii pod listą/quote
4. Jeśli potrzebujesz **typu callouta którego nie pamiętasz** lub **konkretnej property** → otwórz oryginał: `REPOSITORIES/obsidian-skills/skills/obsidian-markdown/`

## 🔗 CROSS-LINK

- `JSON_Canvas.md` — gdy zamiast notatki tekstowej Fi chce visual canvas (.canvas)
- `Knowledge_Manager.md` — gdy ingestujemy zewnętrzną wiedzę do vault'a Fi
