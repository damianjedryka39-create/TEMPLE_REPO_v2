---
version: 1.0
conf: 0.80
last_updated: {{DATA_YYYY-MM-DD}}
phase: {{FAZA}}
---

# CHECKLIST — {{NAZWA_PROJEKTU}}

> Jedyne źródło prawdy o aktualnej pracy. Agent ZAWSZE pracuje według tej checklisty.

---

## BLOCKED

| ID | Blocker | Typ | Zależy od | Od kiedy |
|----|---------|-----|-----------|----------|
| A1 | {{Opis blockera}} | {{DATA/TECH/PRODUCT/EXTERNAL/LEGAL}} | {{Kto/co}} | {{Data}} |

---

## IN PROGRESS

| ID | Zadanie | Przypisany | Start |
|----|---------|-----------|-------|
| — | {{Nic w toku}} | — | — |

---

## NEXT (priorytet od góry)

| # | Zadanie | Proof wymagany | Zależy od |
|---|---------|----------------|-----------|
| 1 | {{Następne zadanie}} | {{Co udowodni ukończenie}} | {{Blocker/warunek}} |
| 2 | {{Zadanie 2}} | {{Proof}} | {{Zależy}} |
| 3 | {{Zadanie 3}} | {{Proof}} | {{Zależy}} |
| 4 | {{Zadanie 4}} | {{Proof}} | {{Zależy}} |

---

## BACKLOG

### {{Kategoria 1 — np. UI}}
- [ ] {{Zadanie backlog 1}}
- [ ] {{Zadanie backlog 2}}

### {{Kategoria 2 — np. Backend}}
- [ ] {{Zadanie backlog 3}}
- [ ] {{Zadanie backlog 4}}

### {{Kategoria 3 — np. Strategia}}
- [ ] {{Zadanie backlog 5}}

---

## DONE (ostatnie 15)

| # | Zadanie | Data | Proof |
|---|---------|------|-------|
| — | {{Brak ukończonych}} | — | — |

---

## Zasady dla agentów

> Pełne zasady → `CO_PILOT.md` §3. Kluczowe: CHECKLIST IS KING, max 1 IN PROGRESS, PROOF = DONE.
