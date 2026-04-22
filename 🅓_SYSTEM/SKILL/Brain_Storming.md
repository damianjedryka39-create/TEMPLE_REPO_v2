---
name: Brain_Storming
trigger: "nowy moduł|nowa funkcja|pivot|CONF < 0.70|kreatywna eksploracja|wiele opcji|brainstorm"
purpose: Generowanie i eksploracja pomysłów przed decyzją architektoniczną
output: Lista opcji/kierunków do ewaluacji przez System_Architect
cross_link: [System_Architect.md, Check_Me.md]
agents: [Claude]
ecosystem: {{NAZWA_PROJEKTU}}
---

## PRE-CHECK

1. Czy wiem CO user chce? → jeśli NIE → **uruchom Check_Me najpierw**
2. Czy problem ma naprawdę WIELE wariantów? → jeśli jest 1 oczywista droga → **SKIP, idź do System_Architect lub wykonaj**
3. Czy to wymaga kreatywnej eksploracji? → jeśli to rutynowy task → **SKIP, nie brainstormuj oczywistości**

**Ten skill odpala się TYLKO gdy jest wiele opcji i trzeba je wygenerować/prześwietlić.**

---

## **METODY BRAINSTORMINGU, KTÓRE MOGĘ URUCHOMIĆ:**

### **1. STRUKTURALNY BRAINSTORMING**

- Rozbijam problem na komponenty
- Generuję warianty dla każdego
- Krzyżuję je dla nowych kombinacji
- Filtruję przez twoje kryteria

### **2. ADVERSARIAL THINKING**

- Stawiam tezę
- Atakuję ją z różnych perspektyw
- Buduję kontrargumenty
- Syntezuję lepsze rozwiązanie

### **3. SCENARIUSZE "CO JEŚLI"**

- Badam ekstremalne warianty
- Testuję edge cases
- Eksploruję emergent possibilities
- Łączę nieoczywiste elementy

### **4. CONCEPT BLENDING**

- Biorę 2-3 odmienne domeny
- Szukam analogii i transferów
- Generuję hybrydy konceptualne
- Sprawdzam feasibility

### **5. CONSTRAINTS-BASED**

- Nakładam sztuczne ograniczenia
- Zmuszam do kreatywnych obejść
- Usuwam ograniczenia i patrzę co zostaje
- Identyfikuję core insights

---

## **CO MOGĘ ZROBIĆ TERAZ:**

Jeśli chcesz brainstormingu, mogę:

**A) UŻYĆ NARZĘDZIA `ask_user_input`** → dam ci interaktywne wybory (preferowane scenariusze, kierunki, priorytet)

**B) URUCHOMIĆ "MULTI-AGENT SIMULATION"** → symulować różne perspektywy (technical lead, user, investor, skeptic)

**C) ZROBIĆ RAPID-FIRE SESSION** → rzucać 20-30 pomysłów szybko, bez filtrowania, potem razem selekcjonujemy

**D) DEEP DIVE SPECIFIC** → bierzemy jeden problem i rozbijamy go na 50+ wariantów rozwiązania

---

## **BRAINSTORMING W KONTEKŚCIE {{NAZWA_PROJEKTU}}:**

{{Opisz kontekst brainstormingu dla tego projektu — jakie tematy, jakie ograniczenia, jakie cele.}}
