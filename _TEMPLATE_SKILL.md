---
name: {{NAZWA_SKILLA}}
trigger: >
  Uruchom gdy:
  - {{Scenariusz 1 — np. "Agent planuje nowy moduł"}}
  - {{Scenariusz 2 — np. "Potrzebna analiza architektoniczna"}}
  - {{Scenariusz 3}}
purpose: >
  {{Krótki opis celu skilla — co robi i dlaczego jest potrzebny}}
output: >
  {{Co skill generuje — np. "ADR (Architecture Decision Record)", "Spec techniczny", "Plan działania"}}
agents: [{{Agent1 — np. Claude}}]
cross_link: [{{powiązany_skill_1.md}}, {{powiązany_skill_2.md}}]
ecosystem: {{NAZWA_PROJEKTU}}
---

# SKILL: {{PEŁNA NAZWA SKILLA}}

---

## PRE-CHECK

Przed uruchomieniem sprawdź:
1. {{Warunek 1 — np. "Czy CHECKLIST ma zadanie powiązane z tym skillem?"}}
2. {{Warunek 2 — np. "Czy STATE_OF_SYSTEM jest aktualny?"}}
3. {{Warunek 3 — np. "Czy nie ma blockera w DECISIONS.md?"}}

---

## KROK 1: {{NAZWA KROKU}}

{{Instrukcje — co agent ma zrobić w tym kroku}}

---

## KROK 2: {{NAZWA KROKU}}

{{Instrukcje}}

---

## KROK 3: {{NAZWA KROKU}}

{{Instrukcje}}

---

## OUTPUT

Po wykonaniu skilla dostarczyć:
- {{Output 1 — np. "Plik z analizą w 🅔_STRATEGIA/"}}
- {{Output 2 — np. "Aktualizacja DECISIONS.md"}}
- {{Output 3 — np. "Aktualizacja CHECKLIST.md (DONE)"}}

---

## UWAGI

- {{Uwaga 1 — np. "Skill wymaga CONF >= 0.75 aby dać GO"}}
- {{Uwaga 2 — np. "Jeśli output > 300 linii → podziel na mniejsze kroki"}}
