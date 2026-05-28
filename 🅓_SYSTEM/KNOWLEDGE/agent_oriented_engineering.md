---
title: Agent-Oriented Engineering
type: summary
created: 2026-05-28
last_updated: 2026-05-28
times_refined: 0
source_count: 1
status: active
tags: [ai-engineering, claude-code, workflow, agents, karpathy]
---

# Agent-Oriented Engineering

## Summary

Teza Karpathy'ego (via Nainsi Dwivedi): **najlepsi AI engineers już nie "promptują", budują systemy wokół agentów**. Plik typu `CLAUDE.md` to nie prompt — to system operacyjny dla agenta. Krytyczna zasada: zamiast mówić modelowi co zrobić, daj mu kryteria sukcesu + system weryfikacji + pętlę iteracji.

## Kluczowe fakty

- LLM-y są dramatycznie lepsze gdy **zmuszone do dyscyplinowanych workflow** (a nie zostawione z luźnym promptem). [Source: Tweet @NainsiDwiv50980 2026-05-27]
- Pliki `CLAUDE.md` rozprzestrzeniły się bo zachowują się **jak OS dla agenta**, nie jak prompt. Kodują reguły bezpośrednio w workflow. [Source: tamten tweet]
- Karpathy wskazał konkretne anti-patterns AI coding: modele **zakładają zamiast pytać** / **overengineerują** proste rzeczy / **ukrywają niepewność** / **przepisują niepowiązany kod** / **optymalizują pod completion, nie correctness**. [Source: tamten tweet]
- Rules które weszły do workflow: Think before coding / Simplicity first / Surgical edits / Goal-driven execution. [Source: tamten tweet]
- Multi-agent orchestration: ludzie odpalają wielu agentów paralelnie jak zespoły inżynierskie (research / debug / tests / optimize / validate). [Source: tamten tweet]
- Kluczowy cytat (re-interpretacja): *"Don't tell the model what to do. Give it success criteria and let it loop."* — od "napisz funkcję" do "tu cel, ograniczenia, testy, system weryfikacji — iteruj aż będzie ok". [Source: tamten tweet]
- Wniosek: highest leverage engineer = nie najlepszy koder, ale ten kto **buduje najlepsze systemy wokół AI agentów**. [Source: tamten tweet]

## Szczegóły

**Czemu prompty są przeszłością** — pojedynczy prompt zostawia model bez kontekstu o tym jak ma się zachowywać między zadaniami, jak ma raportować postęp, kiedy ma pytać, kiedy ma działać. Bez tego dostajesz nieprzewidywalność. `CLAUDE.md` koduje to raz, używasz tysiącami razy.

**Jak ma wyglądać "system wokół agenta"** — operacyjny kontrakt: kiedy odpalać który skill, jak raportować, co jest gate'em przed commit, jak agent ma się komunikować, gdzie zapisuje wiedzę. To dokładnie pokrywa się z architekturą TEMPLE_REPO_v2.

**Success criteria + loop zamiast write-this** — model dostaje **cel** ("przejdź te testy") + **ograniczenia** ("nie zmieniaj plików spoza X/") + **weryfikację** ("uruchom test po każdej zmianie") i sam iteruje. Auto_Codex w TEMPLE robi dokładnie to (max 2 rundy, gate Claude, gate Fi przed commit).

**Multi-agent orchestration vs solo-user reality** — tweet promuje paralelizm jako norm. Dla solo-pracownika (Fi) to overkill bez triggera. TEMPLE rozwiązuje to przez Agent Teams (CO_PILOT §8) z triggerem CONF<0.70 + złożoność, plus Expert_Council jako lżejszy overlay 3 perspektyw. Paralelizm jest dostępny, nie default.

**Powiązanie z TEMPLE_REPO_v2** — TEMPLE wdraża wszystkie 5 anti-patterns które Karpathy wytknął:
- "Zakładają zamiast pytać" → skill **Check_Me**
- "Overengineerują" → Muaddib §ELEGANCJA + §ZASADY BAZOWE Prostota
- "Ukrywają niepewność" → CONF footer (Muaddib §TL;DR) + STUCK flag
- "Przepisują niepowiązany kod" → §ZASADY BAZOWE Minimalny zakres
- "Optymalizują pod completion" → §WERYFIKACJA PRZED DONE

Czyli tweet 2 = **walidacja istniejącej architektury TEMPLE**, nie nowa decyzja. Brak ingest-action wymaganej, ale warto mieć stronę dla cross-link z [[karpathy_andrej]].

## Sprzeczność z czymś?

Nie wewnętrzna. Adversarial wątpliwość: "80% manual coding → 80% agent-driven w miesiące" w tweecie to **anegdota**, nie statystyka. Dla Fi to może być prawda (intensywne użycie Claude Code), dla branży to indywidualne ścieżki adopcji. Nie traktować jako fakt rynkowy.

## Źródła

| # | Nazwa | Typ | Data |
|---|-------|-----|------|
| 1 | Tweet @NainsiDwiv50980 — *Karpathy on future of software engineering* | x.com link | 2026-05-27 |

URL: https://x.com/NainsiDwiv50980/status/2059555402036150285

**Uwaga źródłowa:** ten sam autor co [[rag_vs_llm_wiki]]. Wszystkie cytaty Karpathy'ego to re-interpretacja Nainsi Dwivedi, nie dosłowne. Patrz [[karpathy_andrej]] §"Znaczące teksty" dla statusu primary sources.

## Backlinki

- [[karpathy_andrej]] — autor konceptu
- [[rag_vs_llm_wiki]] — siostrzany koncept, ten sam autor + ta sama źródłówka @NainsiDwiv50980
