---
name: Defuddle
trigger: "podaj url|przeczytaj artykuł|obczaj link|extract markdown|defuddle|wczytaj stronę|wyciągnij treść z|przeczytaj <http"
purpose: Czysta ekstrakcja markdown ze stron www przez `defuddle` CLI — usuwa nawigację/reklamy/sidebary, oszczędza tokeny vs WebFetch
output: Czysty markdown treści artykułu (bez bloatu HTML)
agents: [Claude]
cross_link: [Knowledge_Manager.md, Prompt_Master.md]
ecosystem: {{NAZWA_PROJEKTU}}
---

# DEFUDDLE — Token-saver dla web extraction

> Adopcja z `REPOSITORIES/obsidian-skills/skills/defuddle/SKILL.md` (Steph Ango/kepano, MIT). Treść skondensowana — pełna referencja w pliku oryginalnym.

## 🚀 KIEDY UŻYWAĆ

- Fi przekazuje URL do artykułu/dokumentacji/blogu → **defuddle zamiast WebFetch**
- Każde online źródło wiedzy które ma sidebary, nav, reklamy, headers (czyli prawie każde)

## 🚫 KIEDY NIE używać

- URL kończy się `.md` (już markdown — WebFetch wystarczy)
- API endpoints (JSON/XML)
- x.com / twitter.com (blokuje, używaj bird CLI)

## 📋 KOMENDA

```bash
defuddle parse <url> --md           # czysty markdown (default choice)
defuddle parse <url> --md -o out.md # zapis do pliku
defuddle parse <url> -p title       # tylko metadata
```

**Setup (jednorazowy):** `npm install -g defuddle`

## 🎯 PRO BOOST: integracja z Knowledge_Manager

Gdy Fi mówi *"obczaj ten link"* / *"przeczytaj artykuł"* → router idzie w `Knowledge_Manager`. Knowledge_Manager wewnętrznie używa Defuddle jako pierwsza metoda ekstrakcji (zamiast surowego WebFetch). Zysk: 60-80% mniej tokenów, czystsza analiza.

## 🔗 CROSS-LINK

- `Knowledge_Manager.md` — wykorzystuje Defuddle jako preferowaną metodę web ingest
- `Prompt_Master.md` — niepowiązane (Prompt_Master generuje prompty, Defuddle ekstraktuje content)
