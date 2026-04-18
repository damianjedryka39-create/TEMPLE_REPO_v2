---
version: 1.0
conf: 0.85
status: ACTIVE
last_updated: {{DATA_YYYY-MM-DD}}
type: EVENT-DRIVEN (nie daty — zdarzenia)
---

# ROADMAP — {{NAZWA_PROJEKTU}}

> **Zasada:** Daty kłamią. Zdarzenia nie. Każda faza startuje gdy warunek jest spełniony, nie gdy kalendarz mówi.

---

## PHASE 0 — FUNDAMENT
**Status:** {{W TOKU | DONE}}

**STARTS WHEN:** Projekt utworzony, repo zainicjowane.

**DONE WHEN:**
- [ ] Struktura repo (🅐-🅖) gotowa
- [ ] CONSTITUTION.md napisany
- [ ] Avatar agenta zdefiniowany
- [ ] CO_PILOT.md skonfigurowany
- [ ] Pierwszy OPIS_PROJEKTU.md

---

## PHASE 1 — MVP
**Status:** {{NASTĘPNA | W TOKU}}

**STARTS WHEN:** Phase 0 = DONE + wizja produktu jasna (CONF >= 0.75)

**DONE WHEN:**
- [ ] {{Deliverable 1 — np. Landing page LIVE}}
- [ ] {{Deliverable 2 — np. Core feature działa}}
- [ ] {{Deliverable 3 — np. Pierwszy user test}}
- [ ] Proof zapisany w 🅔_STRATEGIA/

---

## PHASE 2 — SCALE
**Status:** ZAPLANOWANA

**STARTS WHEN:** Phase 1 = DONE + {{warunek — np. 100 userów, revenue > 0}}

**DONE WHEN:**
- [ ] {{Deliverable 1}}
- [ ] {{Deliverable 2}}
- [ ] {{Deliverable 3}}

---

## PHASE 3 — HORYZONT
**Status:** HORYZONT

**STARTS WHEN:** Phase 2 = DONE + {{warunek długoterminowy}}

**DONE WHEN:**
- [ ] {{Wizja długoterminowa 1}}
- [ ] {{Wizja długoterminowa 2}}

---

## Zasady Roadmapy

1. **Event-driven** — fazy startują od zdarzeń, nie dat
2. **Max 3 aktywne taski** — w danym momencie (reszta = BACKLOG)
3. **DONE = proof** — ukończenie wymaga dowodu (plik, screenshot, test)
4. **Blocker = eskalacja** — jeśli faza zablokowana > 48h → ROOT_CAUSE_TABLE
5. **Scope lock** — NIE dodawaj scope'u do aktywnej fazy (nowy scope → BACKLOG lub nowa faza)
