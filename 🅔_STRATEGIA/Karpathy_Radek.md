# LLM Knowledge Bases — Synteza materiałów

> Data: 2026-04-19
> Źródła: Andrej Karpathy (gist + tweet), artykuł God of Prompt, notatki Radka Baka (bestAI v7.5)
> Kontekst: Fi analizuje podejścia do środowiska pracy agenta

---

## 1. Karpathy — LLM Knowledge Base (kompilowana wiki)

### Koncept
LLM czyta surowe źródła (artykuły, papery, notatki) i **kompiluje** z nich ustrukturyzowaną wiki w markdown. Agent jest bibliotekarzem — czyta, pisze encyklopedię, łączy tematy, flaguje sprzeczności.

### Architektura
```
raw/           → surowe źródła (artykuły, PDF, screenshoty). Niemodyfikowalne.
wiki/          → skompilowana wiki (agent pisze, user czyta). Indeks + backlinki.
outputs/       → raporty, analizy, odpowiedzi na pytania.
CLAUDE.md      → schema file — konstytucja definiująca workflow agenta.
```

### Workflow
| Operacja | Co robi |
|----------|---------|
| **Ingest** | Czyta źródło → tworzy stronę wiki → aktualizuje indeks → dodaje backlinki → flaguje sprzeczności |
| **Query** | Czyta indeks → znajduje strony → syntezuje odpowiedź z cytatami → opcjonalnie zapisuje z powrotem do wiki |
| **Lint** | Szuka sprzeczności, osieroconych stron, brakujących cytatów, niewyjaśnionych konceptów |

### Compounding Loop
Odpowiedzi na pytania wracają do wiki jako nowe strony. Każde użycie = bogatsza baza. Wiedza kumuluje się zamiast resetować.

### Skala i ograniczenia
- **Max ~100 artykułów / ~400K słów** — context window ceiling
- **Error compounding** — błąd w wiki → złe odpowiedzi → błąd wraca do wiki → 2 strony wzmacniają ten sam błąd
- **Hallucination** — wiki wygląda autorytatywnie, ale agent może tworzyć połączenia których nie ma w źródłach
- **Koszt** — $2-5 za ingest jednego źródła (frontier models), $100-250 za 50 źródeł
- **Single-model blind spots** — cała wiki to interpretacja jednego modelu
- **NIE skaluje się do enterprise** — przy 10K+ artykułów indeks jest za duży

### Cytat Karpathy'ego
> "The human's job is to curate sources, direct the analysis, ask good questions, and think about what it all means. The LLM's job is everything else."
> "A hacky collection of scripts. There is room here for an incredible new product."

---

## 2. Radek Bak — bestAI v7.5 + OpenClaw (baza wektorowa)

### Koncept
System oparty na **bazie wektorowej** (Pinecone). Tekst zamieniany na wektory (listy liczb) — wyszukiwanie przez podobieństwo matematyczne, nie przez czytanie. Pipeline do masowego przetwarzania danych.

### Co już ma (stan na 2026-04-10)
- **Multi-source ingest:** WhatsApp, Teams, Outlook, IMAP, Nextcloud — automatyczny
- **Pinecone RAG:** 68K wektorów (więcej niż 400K słów Karpathy'ego)
- **Obsidian daily notes** jako wiki (auto-generowane)
- **Semantic dedup** (>0.92) — usuwa duplikaty na poziomie znaczenia
- **Consolidation + decay scoring** — stare dane tracą wagę
- **Real-time ingest** (co 30-60s)
- Repo publiczne na GitHub, `npx bestai init .`

### Różnica vs Karpathy
Radek trafił na ścianę przy 1TB danych — wiki się rozsypała. Wektory rozwiązują problem skali, ale kosztem głębi rozumienia. Wektory WYSZUKUJĄ podobne fragmenty, nie ROZUMIEJĄ kontekstu.

---

## 3. TEMPLE_v2 (Fi) — system operacyjny agenta

### Czym się różni
TEMPLE to nie baza wiedzy (Karpathy) ani pipeline danych (Radek). To **architektura myślenia agenta**.

| Warstwa | Karpathy | Radek | TEMPLE |
|---------|----------|-------|--------|
| **Cel** | Kompilacja wiedzy | Przetwarzanie danych | Jakość myślenia i decyzji |
| **Agent jest** | Bibliotekarzem | Procesorem pipeline | Partnerem poznawczym |
| **Przechowuje** | Fakty, artykuły | Wiadomości, dokumenty | Decyzje, tożsamość, lekcje |
| **Skala** | ~100 artykułów | ~68K wektorów | ~5-20 plików CORE |
| **Siła** | Synteza wiedzy | Szybkość wyszukiwania | Ciągłość rozumowania |

### Co TEMPLE już ma z Karpathy'ego
| Karpathy | TEMPLE odpowiednik |
|----------|-------------------|
| `raw/` (źródła) | `🅐_OPIS/` + `🅔_STRATEGIA/` |
| `wiki/` (skompilowana wiedza) | `🅒_NOW/STATE` + `DECISIONS` + `LESSONS` |
| Schema file | `CO_PILOT.md` + `Muaddib.md` |
| Index | `AGENTS.md` (entry point + SSOT) |
| Ingest workflow | Skill routing (CO_PILOT §4) |
| Lint/health check | `Context_Forge` + `Reflect` |
| Compounding | `LESSONS.md` + `PROOFS/` |

**TEMPLE ma ~80% konceptów Karpathy'ego, ale w formie zoptymalizowanej pod pracę agenta, nie pod bazę wiedzy.**

---

## 4. Porównanie — analogie dla nieinżyniera

| | Wiki (Karpathy) | Wektory (Radek) | TEMPLE (Fi) |
|---|---|---|---|
| **Analogia** | Ekspert pisze raport z 50 książek | Google przeszukuje miliony stron | Doradca strategiczny z pamięcią |
| **Jak szuka** | Czyta → rozumie → pisze syntezę | Porównuje liczby → znajduje podobne | Zna kontekst → podejmuje decyzje |
| **Limit** | ~100-400 artykułów | Miliony dokumentów | ~5-20 plików, ale głębokie |
| **Koszt** | Drogi (LLM czyta wszystko) | Tańszy w skali | Najtańszy (małe pliki) |
| **Kiedy najlepszy** | Głęboki research jednego tematu | Masowe dane, szybkie wyszukiwanie | Ciągła praca nad projektami |

---

## 5. Wnioski — co dalej

### Co warto wziąć z Karpathy'ego do TEMPLE
1. **Compounding loop** — wzmocnić pętlę wiedzy (LESSONS + PROOFS już to robią, można ulepszyć)
2. **Lint workflow** — regularny audyt spójności (Context_Forge robi to częściowo)
3. **Knowledge layer** — warstwa wiedzy domenowej OBOK warstwy decyzyjnej

### Czego NIE kopiować
- Pełna wiki z indeksem (TEMPLE ma STATE/DECISIONS — to wystarczy)
- Ręczny ingest (TEMPLE ma automatyczny skill routing)
- Schema file jako osobny CLAUDE.md (TEMPLE ma CO_PILOT.md — lepsza wersja tego samego)

---

## AGENT NOTE — Kierunek rozwoju Fi

> **Baza wektorowa** — Fi wyraził zainteresowanie budową systemu podobnego do bestAI Radka (Pinecone RAG, multi-source ingest, semantic search). Plan: po zakupie Mac Mini. Cel: użycie dla GOFANS i innych projektów.
>
> **Priorytet teraz:** Nie budować bazę wektorową — najpierw dokończyć ewolucję TEMPLE_v2 i wzmocnić istniejące mechanizmy compounding/lint. Baza wektorowa to osobny projekt na przyszłość (wymaga infra: Mac Mini, Pinecone, pipeline).
>
> **Kiedy baza wektorowa ma sens dla Fi:**
> - Gdy ilość danych przekroczy ~100 dokumentów per projekt
> - Gdy potrzebne real-time przeszukiwanie wielu źródeł (maile, czaty, dokumenty)
> - Gdy będzie dedykowany sprzęt (Mac Mini) do hostowania pipeline
>
> **Sekwencja:** TEMPLE_v2 (teraz) → propagacja do projektów → baza wektorowa (przyszłość, osobne repo)
