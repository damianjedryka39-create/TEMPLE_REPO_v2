# 🔍 AUDIT — n8n-mcp

- **Source:** https://github.com/czlonkowski/n8n-mcp
- **Author:** Romuald Członkowski (aiadvisors.pl, Polish 🇵🇱)
- **License:** MIT
- **Data importu:** 2026-04-25
- **Werdykt:** 🟡 **INSPIRATION** (przydatne tylko jeśli zaczniesz używać n8n)

---

## 📌 Co to jest po ludzku

**Most między n8n a Claude Code.** Serwer MCP (Model Context Protocol) który daje agentowi pełną wiedzę o **1505 nodów n8n** + 2709 workflow templates + 87% oficjalnej dokumentacji. Bez tego Claude w temacie n8n leci na ślepo (halucynacje konfiguracji). Z tym — wie co dokładnie wpisać w każdy node.

**n8n = wizualne workflow automation** (alternatywa Zapier/Make/Make.com). Łączysz API/usługi w drag&drop flow. Open source, self-hosted lub cloud.

---

## 🎯 Dla Twojego workflow TERAZ

🔴 **Brak natychmiastowego use case** — nie używasz n8n. Twoje projekty są na Python/Static HTML/Cron/Twilio.

🟡 **Potencjał dla MALING:** Twój scraper + WhatsApp alerty (Python + Twilio + Cron) **technicznie mógłby żyć w n8n** zamiast custom Pythonie. Plusy: GUI dla flow, wbudowane integracje (Twilio, Slack, e-mail). Minusy: zmiana stacku, learning curve, mniej kontroli nad scrapingu detals.

🟡 **Potencjał dla GOFANS:** Gdybyś chciał podpiąć formularze z landingu (newsletter, contact) do CRM/Slack/Maila — n8n robi to bez kodu.

---

## 🚀 PRO BOOSTY (architektoniczne)

1. **MCP server = wiedza domenowa agenta on-demand.** Twój `MCP_KNOWLEDGE_ENGINE` jest serwerem MCP innej kategorii (intelligence radar). n8n-mcp pokazuje wzorzec: serwer MCP z **strukturalną wiedzą produktu** (nodes/properties/operations). Inspiracja gdyby kiedyś robił agentowy plugin dla GOFANS/MALING.

2. **Cloud free tier 100 calls/day** — jeśli zechcesz testować n8n bez self-hostowania: dashboard.n8n-mcp.com (gotowy serwer hostowany przez Romka).

3. **Claude Code setup guide** już gotowy — `docs/CLAUDE_CODE_SETUP.md` w klonie. Gdyby kiedyś migrować — 5 min konfiguracja.

---

## ❓ Kiedy wrócić do tego repo

- Decydujesz się przepisać MALING z Python → n8n
- Chcesz dla GOFANS landing automation (formularze → CRM/Slack)
- Budujesz nowy projekt który ma 5+ integracji API i chcesz GUI flow
- Studiujesz architekturę MCP servers z bogatą wiedzą domenową

---

## 📝 Zasada dla kolejnego agenta

Trzymaj jako **referencję**. NIE adoptuj ŻADNEGO skilla / wrappera teraz — n8n to inny świat niż Twój obecny stack. Czytaj README + `docs/CLAUDE_CODE_SETUP.md` dopiero gdy padnie konkretne *"chcę zacząć z n8n"*.
