---
name: JSON_Canvas
trigger: "canvas|.canvas|mind map|flowchart|wizualna mapa|graf węzłów|visual notes|json canvas"
purpose: Tworzenie/edycja plików .canvas (JSON Canvas Spec 1.0) — visual notes z węzłami i połączeniami, otwierane w Obsidian Canvas i innych narzędziach
output: Poprawny plik .canvas (JSON) z unikalnymi ID, niekolidującymi pozycjami, walidnymi referencjami fromNode/toNode
agents: [Claude]
cross_link: [Obsidian_Markdown.md]
ecosystem: {{NAZWA_PROJEKTU}}
---

# JSON CANVAS — Visual notes/mapy

> Wrapper na `REPOSITORIES/obsidian-skills/skills/json-canvas/SKILL.md` (Steph Ango/kepano, MIT). Pełna referencja (244 linii) — czytaj gdy potrzebujesz wszystkich typów node'ów (group, link node) lub edge styling (sides, labels).

## 🚀 KIEDY UŻYWAĆ

- Fi mówi: **canvas**, **mind map**, **flowchart**, **diagram**, **wizualna mapa**
- Edycja istniejącego `.canvas` (vault Obsidian, websites jak jsoncanvas.org)
- Tworzenie graficznej reprezentacji workflow / architektury

## 📋 SZKIELET PLIKU

```json
{
  "nodes": [],
  "edges": []
}
```

### Node (minimum)
```json
{
  "id": "6f0ad84f44ce9c17",
  "type": "text",
  "x": 0,
  "y": 0,
  "width": 250,
  "height": 100,
  "text": "Treść"
}
```
Typy: `text` (markdown), `file` (link do .md/.png), `link` (URL), `group` (kontener).

### Edge
```json
{
  "id": "edge-001",
  "fromNode": "6f0ad84f44ce9c17",
  "toNode": "8a1bd95e55df0d28",
  "label": "opcjonalny opis"
}
```
Optionally: `fromSide`/`toSide` (`top`/`right`/`bottom`/`left`).

## ⚠️ HARD RULES

1. **ID unikalne** — generuj 16-znakowy hex (np. przez `crypto.randomUUID().replace(/-/g, '').slice(0, 16)`)
2. **Pozycje bez kolizji** — zostaw 50-100px spacing między nodami
3. **Edges ZAWSZE walidowane** — `fromNode`/`toNode` muszą wskazywać na istniejące ID
4. **Po edycji ZAWSZE waliduj JSON** — uszkodzony plik = canvas się nie otworzy w Obsidian

## 🎯 TYPOWY WORKFLOW

1. Read + parse istniejący `.canvas` (lub stwórz `{"nodes":[],"edges":[]}`)
2. Generuj nowe ID (sprawdź czy nie kolidują z istniejącymi)
3. Dodaj node'y z polami: `id`, `type`, `x`, `y`, `width`, `height`
4. Dodaj edges z walidnym `fromNode`+`toNode`
5. Walidacja: `python3 -c "import json; json.load(open('plik.canvas'))"` lub Node odpowiednik
6. Otwórz w Obsidian → sanity check

## 🔗 CROSS-LINK

- `Obsidian_Markdown.md` — gdy zamiast canvas Fi chce notatkę tekstową
- Spec referencja: https://jsoncanvas.org/spec/1.0/
