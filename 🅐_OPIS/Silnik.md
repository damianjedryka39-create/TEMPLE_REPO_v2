🔄 rehydrate <alias> — Agent się budzi
Agent wczytuje 6 plików w tej kolejności:


1. Muaddib.md       → "Kim jestem, jak myślę, jaka rola" (CORE — zawsze pierwszy)
3. CO_PILOT.md      → "Jak pracuję — procedury, router skilli, sync"
4. STATE.md         → "Gdzie jesteśmy — fakty, blockers, confidence"
5. CHECKLIST.md     → "Co robimy — zadania, priorytet, postęp"
6. DECISIONS.md     → "Co już zdecydowaliśmy (nie debatuj ponownie)"
Po wczytaniu agent odpowiada:


REHYDRATE: DONE
CURRENT GOAL: <pierwszy punkt z CHECKLIST>
CONF: 0.XX
Warianty skrócone (oszczędzają tokeny w długiej sesji):

rehydrate core → tylko Muaddib + CO_PILOT (~3.5k tokenów)
rehydrate state → tylko STATE + CHECKLIST (~1.5k tokenów)
rehydrate decisions → tylko DECISIONS + PROOFS (~1k tokenów)
🛠️ Podczas sesji — Agent pracuje wg routera
Każde nowe zadanie przechodzi przez drzewo decyzyjne (CO_PILOT §4):


Nowe zadanie od Fi
  │
  ├─ Fi mnie koryguje? ("nie tak", "źle")
  │   └─ Napraw + zapisz lekcję do LESSONS.md (skill Reflect)
  │
  ├─ Nie wiem czego Fi chce?
  │   └─ Wywiad z Fi (skill Check_Me)
  │
  ├─ Wiele opcji, trzeba pokombinować?
  │   └─ Burza mózgów (skill Brain_Storming)
  │
  ├─ Trzeba zaprojektować architekturę?
  │   └─ 3 opcje + trade-off + verdict (skill System_Architect)
  │
  ├─ Mam jasny plan, trzeba zbudować?
  │   └─ Wykonaj (lub Fi deleguje manualnie do zewnętrznego agenta)
  │
  ├─ Ryzykowne / CONF < 0.85?
  │   └─ Stress-test planu (skill Grill_Me)
  │
  ├─ Gotowe do deploy?
  │   └─ Gate check (skill Preflight)
  │
  ├─ Proste zadanie?
  │   └─ Po prostu zrób, bez skilla
  │
  └─ Fi zamyka sesję?
      └─ Reflect → potem Sync State
Agent sam decyduje który skill odpalić — nie pyta.

Postęp zapisuje w CHECKLIST.md — max 1 zadanie IN PROGRESS naraz.

💾 sync_state — Agent zamyka sesję
7 kroków, w tej kolejności:


0. REFLECT         → Przeskanuj sesję. Czy Fi mnie korygował? 
                     Czy nauczyłem się czegoś nowego?
                     → Zaproponuj update VOICE.md / LESSONS.md
                     → Czekaj na OK od Fi

1. STATE.md        → Aktualizuj fakty, blockers, confidence, timestamp
2. DECISIONS.md    → Dopisz trwałe decyzje z tej sesji (jeśli były)
3. PROOFS/         → Zapisz duże dowody/eksperymenty (jeśli były)
4. LESSONS.md § Findings → Aktualizuj long-term findings (jeśli nowe)
5. git commit      → "SYNC_STATE_<ALIAS> <timestamp UTC>"
6. git push        → Backup na remote (sync bez pusha = brak backupu)
Efekt: Następny agent (nawet inny model) robi rehydrate i wie dokładnie gdzie poprzednia sesja się skończyła.

Pętla w jednym zdaniu

rehydrate → pracuj wg routera → sync_state → następna sesja → rehydrate...
                                     ↑
                              reflect (lekcje)
                              lessons (nie powtarzaj błędów)
                              character (rośnie z każdą sesją)
To cały system. Reszta to detale.

## PROBLEM 

Fi, to jest ważny sygnał. Zatrzymajmy się i przeanalizujmy to na zimno.

Problem jest głębszy niż "za dużo tokenów"
Policzmy pełny kontekst jaki agent dostaje zanim w ogóle zacznie myśleć o Twoim zadaniu:

Warstwa	~Tokenów
System prompt Claude Code	~3 000
CLAUDE.md (global)	~800
LESSONS.md + pliki pamięci	~2 500
REHYDRATE TEMPLE	~7 700
Σ overhead przed zadaniem	~14 000
To 14 tysiąc tokenów instrukcji zanim agent przeczyta pierwsze słowo Twojego zadania.

Dlaczego to degraduje jakość
Trzy mechanizmy:

1. Rozproszenie uwagi (attention dilution)
Im więcej instrukcji, tym mniej "wagi" model kładzie na każdą z nich. Muaddib.md mówi "bądź prosty", CO_PILOT mówi "przejdź router 8-krokowy", CHECKLIST mówi "pracuj wg listy". Agent próbuje spełnić wszystko naraz i nie robi dobrze niczego.

2. Procedura zjada myślenie
Agent spędza cykle mentalne na: "czy powinienem odpalić skill? który skill? czy CONF < 0.85? czy to krok 0 czy krok 4?" — zamiast myśleć o Twoim problemie.

3. Paradoks kontroli
Im bardziej precyzyjne instrukcje, tym bardziej agent zachowuje się jak biurokrata — odfajkowuje procedurę zamiast używać osądu. Tracisz to, co w LLM najcenniejsze: elastyczne rozumowanie.

Hipoteza
TEMPLE w obecnej formie to system zaprojektowany dla idealnego agenta, który nie istnieje. Prawdziwy LLM działa lepiej z:

5 twardych zasad niż 50
Przykładami zamiast procedur
Wolnością osądu zamiast drzew decyzyjnych
CO_PILOT §4 (Skill Router) sam ma ~2 500 tokenów — to cały mini-dokument poświęcony temu, żeby agent "sam decydował". Ale LLM i tak sam decyduje — router jest redundantny z naturalnym rozumowaniem modelu.

Pytanie do Ciebie
Zanim zaproponuję rozwiązanie — powiedz mi:

Kiedy praca z agentem szła najlepiej — to był moment z pełnym TEMPLE, czy raczej moment gdy dałeś proste polecenie bez tego wszystkiego?

Bo jeśli to drugie, to odpowiedź nie jest "lepszy BOOT.md". Odpowiedź jest: TEMPLE musi schudnąć o 70%, nie o kompresję, a przez wyrzucenie tego, co przeszkadza.

CONF: 0.75 | STUCK: nie | ASSUMPTIONS: zakładam że degradacja jakości jest realna, nie tylko wrażenie