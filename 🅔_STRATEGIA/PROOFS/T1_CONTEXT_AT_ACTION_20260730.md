# T1 — KONTEKST PRZY AKCJI (pierwszy wyzwalacz: commit)

> Data: 2026-07-30 | Zadanie **T1** z `PROOF_BOOST_PLAN_20260707.md §KOSZYK` | Decyzja Fi: 2026-07-30
> Plik: `.claude/hooks/context-at-action.sh` | Rejestracja: `.claude/settings.json` (PreToolUse → Bash)

---

## 1. Dlaczego to, a nie cięcie

PB-2 próbował zmieścić rehydrate w oknie przez skracanie plików governance. Fi to cofnął tego samego dnia — kondensacja zabrała rationale z cytatami Fi, czyli najsilniejszy sygnał uczący w systemie.

Wniosek: **problem nie polega na tym, że reguł jest za dużo, tylko że wszystkie przychodzą w chwili, gdy żadna nie jest potrzebna.** Agent dostaje politykę commitów na starcie, a commit robi godzinę później — z tysiącem tokenów innej pracy pomiędzy.

T1 nie tyka treści. Przesuwa **moment dostarczenia**.

Dowód, że mechanizm działa, mamy we własnym repo: ŻELAZNA #1 („mów po ludzku") leżała w pliku miesiącami i była łamana 3×. Zaczęła być przestrzegana dopiero, gdy `session-inject.sh` zaczął ją wstrzykiwać (sesja 17).

---

## 2. Co zbudowano

Jeden wyzwalacz — **commit** — jako pilot. Wybrany, bo commit robimy co sesję, więc dowód przychodzi natychmiast.

| Właściwość | Rozwiązanie |
|---|---|
| Źródło treści | `CO_PILOT.md §7` czytane `awk`-iem przy każdym wywołaniu — **hook nie ma własnej kopii reguły** |
| Kanał | `hookSpecificOutput.additionalContext` (PreToolUse) |
| Wpływ na akcję | żaden — `exit 0` zawsze, hook informuje, nie blokuje |
| Selektywność | regex wymaga `git commit` na początku komendy lub po `;`/`&&`/`|` |

Zasada „hook czyta z SSOT" jest tu istotna: edycja `CO_PILOT §7` natychmiast zmienia to, co agent zobaczy przy commicie. Gdyby hook miał własną kopię, powstałoby drugie źródło prawdy (łamie D9).

---

## 3. Testy

| # | Wejście | Oczekiwane | Wynik |
|---|---------|-----------|-------|
| 1 | `git commit -m "test"` | wstrzyknięcie §7 | ✅ poprawny JSON z treścią §7 |
| 2 | `ls -la` | cisza | ✅ brak outputu |
| 3 | `cd /tmp && git -C /repo commit -q -m x` | wstrzyknięcie | ✅ złapane mimo `cd` i `-C` |
| 4 | `grep -rn "git commit" LESSONS.md` | cisza | ✅ nie myli wzmianki z wywołaniem |
| 5 | `.claude/settings.json` | poprawny JSON, 5 hooków na Bash | ✅ |
| 6 | **SSOT** — dopisanie markera do CO_PILOT §7 | hook natychmiast go pokazuje | ✅ 1 trafienie |
| 7 | **SSOT** — cofnięcie markera | marker znika z outputu | ✅ 0 trafień (brak własnej kopii) |

**Ograniczenie testu:** powyższe to symulacja przez stdin. Test w działającej sesji wymaga uruchomienia Claude Code z katalogiem TEMPLE jako projektem — hooki z `.claude/` submodułu nie są aktywne w sesji prowadzonej z katalogu nadrzędnego. Do sprawdzenia przy pierwszym forku albo pierwszej sesji odpalonej wprost w TEMPLE.

---

## 4. Co dalej (kolejne wyzwalacze, każdy osobno + weryfikacja)

| Wyzwalacz | Co wstrzyknąć | Źródło |
|---|---|---|
| Edycja `STATE_OF_SYSTEM.md` | format STATE (TOP-10 faktów ze źródłem, blockery, CONF) | `CO_PILOT §5` |
| Edycja `DECISIONS.md` | jak zapisać decyzję: opcje + twarde „dlaczego" | `DECISIONS §Jak dodać` |
| `nginx`/`certbot`/deploy | Preflight | skill `Preflight.md` |
| 3× nieudana próba tego samego | anti-loop: STOP + tabela + eskalacja | `CO_PILOT §6` |

**Warunek dla każdego:** wyzwalacz musi być wąski. Reguła podana za często zamienia się w szum, którego agent przestaje czytać — to jedyne realne ryzyko tego mechanizmu.

Dopiero gdy wyzwalacze pokryją procedury, można zdjąć odpowiadające im sekcje ze startu i zmierzyć realny spadek (~14,8k → cel ~3k). **Kolejność jest nieodwracalna: najpierw wstrzykiwanie działa, potem zdejmujemy ze startu.** Odwrotnie = agent zostaje bez reguły.

---

**CONF: 0.85** — mechanizm zweryfikowany jednostkowo i na zasadzie SSOT; brak jeszcze potwierdzenia w działającej sesji.
