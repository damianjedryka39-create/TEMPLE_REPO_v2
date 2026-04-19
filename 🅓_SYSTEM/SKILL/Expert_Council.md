---
name: Expert_Council
trigger: "druga opinia|rada ekspertów|council|stress-test propozycji|czy to najlepsze podejście"
purpose: Powołanie 3 subagentów-ekspertów z RÓŻNYMI soczewkami do krytyki propozycji lub designu
output: 3 niezależne opinie + synteza (co wspólne, co sporne, rekomendacja finalna)
cross_link: [Brain_Storming.md, Grill_Me.md]
---

## KIEDY URUCHAMIAĆ

- Przed dużą decyzją architektoniczną (koszt odwrócenia > 2h pracy)
- Gdy user pyta „czy to najlepsze?" lub „daj drugą opinię"
- Gdy PROP ma CONF 0.70-0.85 (niepewność warta weryfikacji)
- Gdy agent sam ma wątpliwości co do własnej rekomendacji

## NIE URUCHAMIAĆ

- Prosty task / oczywista odpowiedź
- CONF > 0.90 (nie marnuj czasu)
- Kiedy user już zdecydował i chce tylko implementację

## PROTOKÓŁ

1. **Wybierz 3 soczewki** — każda inna, komplementarna, nie redundantna.
   Przykładowe (wybieraj pod problem):
   - **Minimalist** (Carmack/Hickey) — „tnij aż boli"
   - **Systems thinker** (Meadows) — feedback loops, emergent behavior
   - **Ergonomics** (Norman) — UX dla człowieka/agenta
   - **Adversary** — czerwony zespół, szukaj dziur
   - **Futurist** — jak to będzie działać za 2 lata / z następnym modelem
   - **Pragmatist** — koszt/benefit, realne zagrożenia

2. **Dispatch równolegle** — 3 agenty w jednym wywołaniu (parallel). Każdy dostaje:
   - Pełen kontekst propozycji (nie zakładaj że wie)
   - SWOJĄ soczewkę jasno określoną
   - Polecenie: „Krytykuj, proponuj lepsze, odpowiedz CZY obecna propozycja jest optymalna"
   - Limit długości odpowiedzi (300-500 słów max)

3. **Synteza** — po zwrocie 3 opinii:
   - Co WSPÓLNE (3/3 zgadzają się = silny sygnał)
   - Co SPORNE (różnice = decyzja dla usera)
   - Co NOWE (czego ja nie zauważyłem)
   - **Finalna rekomendacja** agenta: trzymać PROP, modyfikować, czy porzucić

## ANTI-PATTERNS

- NIE dawaj 3 soczewek które powiedzą to samo (echo chamber)
- NIE kopiuj pełnego AGENTS.md do promptu (zbędny context burn) — wrzuć tylko kluczowe fragmenty
- NIE pytaj agenta „co o tym sądzisz" bez jasnej soczewki (dostaniesz generyki)
- NIE rób tego dla każdej drobnostki — to narzędzie dla decyzji o dużej blast radius

## OUTPUT FORMAT

```
## Rada Ekspertów — <nazwa decyzji>

### Ekspert 1: <soczewka>
<streszczenie opinii + werdykt TRZYMAĆ/MODYFIKOWAĆ/PORZUCIĆ>

### Ekspert 2: <soczewka>
<jw.>

### Ekspert 3: <soczewka>
<jw.>

### Synteza
- **Zgodnie (3/3):** ...
- **Spornie:** ...
- **Nowe insighty:** ...
- **Rekomendacja:** ...
```
