---
name: Preflight
trigger: "przed deploy|review|DONE krok|preflight|gate"
purpose: Gate jakościowy przed deploy/review — checklist wizualny, techniczny, performance, smoke test
output: PREFLIGHT PASS/FAIL + blocker log
agents: [Claude]
cross_link: [Workflow_Edit.md, System_Architect.md]
ecosystem: {{NAZWA_PROJEKTU}}
---

# PREFLIGHT — Gate przed DEPLOY / FOUNDER REVIEW

Uruchom TEN checklist ZANIM:
- deployujesz na produkcję
- pokazujesz founderowi/klientowi do review
- oznaczasz krok jako DONE w CHECKLIST

FAIL na DOWOLNYM punkcie = NIE deployuj. Wróć do CHECKLIST.

---

## CHECKLIST

### Wizualna zgodność
- [ ] Porównanie z referencją 1:1 (jeśli istnieje)
- [ ] Brak nowych layoutów/paneli/typografii spoza spec

### Techniczna poprawność
- [ ] 0 console errors (DevTools → Console)
- [ ] 0 broken assets (404 w Network tab)
- [ ] Responsywność: desktop (1920x1080) + mobile (390x844) sprawdzone

### Performance
- [ ] Load time < 3s (throttle: Fast 3G)
- [ ] Critical bundle < 100KB
- [ ] Brak memory leaks (Performance tab, 30s idle)

### Smoke test (3 kluczowe interakcje)
- [ ] Interakcja 1: [zdefiniuj per deploy]
- [ ] Interakcja 2: [zdefiniuj per deploy]
- [ ] Interakcja 3: [zdefiniuj per deploy]

### Gate
- [ ] CONF >= 0.80
- [ ] Agent potwierdza: "PREFLIGHT PASS"

---

FAIL → log powód w STATE jako BLOCKER → napraw → ponów PREFLIGHT.
PASS → DEPLOY / REVIEW z dowodem: "PREFLIGHT PASS [timestamp]"
