---
name: Check_Me
trigger: "check me|diagnoza|wywiad|CONF < 0.70|nowy temat|niejasny cel"
purpose: Ekstrakcja wiedzy z usera przez iteracyjny wywiad — daj agentowi MAX kontekstu
output: Raport wiedzy zapisany do pliku .md
cross_link: Brain_Storming.md
---

# CHECK ME — Wywiad z Userem

## PRE-CHECK

1. Czy naprawdę NIE WIEM czego user chce? → jeśli wiem → **SKIP, idź do Brain_Storming lub System_Architect**
2. Czy odpowiedź jest już w kontekście rozmowy? → jeśli TAK → **SKIP, nie pytaj o to co wiesz**
3. Czy to prosty task z jasnym AC? → jeśli TAK → **SKIP, wykonaj bez wywiadu**

**Ten skill odpala się TYLKO gdy agent ma za mało danych żeby działać.**

---

## CEL

Przeprowadz szczegolowy wywiad z userem uzywajac AskUserQuestion. Pytaj o wszystko co wazne dla problemu i potencjalnie wazne dla calego systemu. Pytaj o cele, wartosci, ograniczenia, preferencje, zasoby, ryzyka. Pytaj o rozne aspekty problemu lub celu. Uwzgledniaj obawy, kompromisy, zastrzezenia.

Upewnij sie ze pytania NIE sa oczywiste.

## TRYB PRACY

Badz bardzo wnikliwy i kontynuuj zadawanie pytan w sposob ciagly az wszystko zostanie kompletnie omowione. Dzialaj w trybie ciaglym az do momentu gdy uznasz ze wszystko zostalo omowione.

Na koniec: utworz i zapisz caly raport do pliku .md. Podaj userowi nazwe pliku.

## ZASADY MYSLENIA

- Zweryfikuj. Ocen pewnosc. Zglos niepewnosc.
- Podziel zlozone problemy na mniejsze czesci
- Sprawdz odpowiedzi z roznych perspektyw
- Zdobadz pewnosc przy kazdym twierdzeniu
- Zastanow sie i popraw slabe rozumowanie
- Podejmuj zobowiazania tylko wtedy gdy masz duze poczucie pewnosci

## METODY ANALIZY

Wykorzystuj rozne metody: analiza wielokryterialna, macierz decyzyjna, scoring. Zapytaj usera o preferencje dotyczace tych metod i jakie kryteria sa dla niego najwazniejsze.

## POSTAWA

Celem wywiadu jest danie Ci maksymalnej ilosci wiedzy, abys mogl najoptymalniej i najefektywniej stworzyc wraz z agentami absolutne arcydzielo przyszlosci w postaci strategii i jej egzekucji.

Badz cierpliwy, empatyczny i otwarty na odpowiedzi usera — nawet jesli sa nieoczywiste lub trudne do zrozumienia.

---

## GUARDRAILS

### Coverage Tracker
Sledz pokrycie tych kategorii — nie koncz dopoki min. 6/8 nie jest pokryte:

- [ ] CEL        (co chcesz osiagnac)
- [ ] WARTOSCI   (co jest wazne, czego nie poswiecisz)
- [ ] OGRANICZENIA (czas, budzet, tech, ludzie)
- [ ] ZASOBY     (co masz do dyspozycji)
- [ ] RYZYKA     (co moze pojsc nie tak)
- [ ] KOMPROMISY (na co jestes gotow pojsc na kompromis)
- [ ] KONTEKST   (dlaczego teraz, co bylo wczesniej)
- [ ] SUKCES     (po czym poznasz ze sie udalo)

### CONF Gate
Po pokryciu kategorii — ocen pewnosc i dzialaj:

- CONF >= 0.85 → ZIELONY — przejdz do raportu
- CONF 0.70-0.84 → ZOLTY — 1-2 pytania wiecej
- CONF < 0.70 → CZERWONY — kontynuuj, zmien kat pytan

### Anti-Patterns
- NIE zadawaj 5 pytan naraz — 1 na raz, zawsze
- NIE pytaj o to co juz wiesz z kontekstu
- NIE zakladaj odpowiedzi — pytaj nawet jesli "wydaje sie oczywiste"
- NIE koncz po 3 pytaniach — minimum 5, optymalnie 7-10
- NIE pisz raportu bez walidacji z userem
