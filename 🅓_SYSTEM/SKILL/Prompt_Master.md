---
name: Prompt_Master
trigger: "prompt master|prompt do (midjourney|sora|stable diffusion|comfyui|dalle|runway|kling|elevenlabs|cursor|copilot|windsurf|bolt|v0|lovable|zapier|make|perplexity|gemini|chatgpt|gpt|qwen|ollama|deepseek)|napisz prompt|stwórz prompt|wygeneruj prompt|prompt na obrazek|prompt na video|prompt na audio"
purpose: Generuje zoptymalizowany prompt do dowolnego AI tool (30+ profili) — image/video/voice/3D/coding/automation. Max 3 pytania, wybór frameworku z 12, audyt token efficiency, output gotowy do wklejenia
output: Pojedynczy blok promptu + 🎯 target tool + 💡 1 zdanie strategii (co zoptymalizowano i dlaczego)
agents: [Claude]
cross_link: [Auto_Codex.md, DESIGN_ARSENAL.md]
ecosystem: {{NAZWA_PROJEKTU}}
---

# PROMPT MASTER — Generator promptów dla 30+ AI tooli

> Zewnętrzny skill (autor: nidhinjs/prompt-master, MIT) zaadaptowany jako on-demand narzędzie. Pełna treść: `🅔_STRATEGIA/external/prompt-master/SKILL.md` + `references/templates.md` + `references/patterns.md`. Ten plik = nasz wrapper z triggerem + entry point.

---

## KIEDY URUCHOMIĆ

- Fi prosi o prompt do konkretnego AI tool: Midjourney, DALL-E, Stable Diffusion, ComfyUI, Sora, Runway, Kling, ElevenLabs, Cursor, Copilot, Windsurf, Bolt, v0, Lovable, Zapier, Make, n8n, etc.
- Fi mówi "napisz/stwórz/wygeneruj prompt na X" — szczególnie do generacji obrazów/wideo/audio
- Fi przynosi zły prompt i prosi o poprawienie
- Fi chce zaadaptować prompt z jednego narzędzia do innego (np. Midjourney → Stable Diffusion)

**NIE odpalaj** gdy Fi prowadzi naturalną rozmowę z Tobą lub Codexem — Auto_Codex i normalny dialog wystarczają. Prompt_Master = generacja **gotowych do skopiowania promptów**, nie konwersacja.

---

## FLOW (krótko)

1. **PRZECZYTAJ** `🅔_STRATEGIA/external/prompt-master/SKILL.md` (PRIMACY ZONE — hard rules + output lock + 9 wymiarów intencji)
2. **WYBIERZ KATEGORIĘ TOOLA** (Image AI / Video AI / Voice AI / Reasoning LLM / Agentic AI / Code Editor AI / Workflow Automation / 3D AI)
3. **PRZECZYTAJ TYLKO ODPOWIEDNI ROZDZIAŁ** z `references/templates.md` (nie cały plik — token saving)
4. **ZADAJ MAX 3 PYTANIA** jeśli brakuje krytycznych wymiarów (target tool / output format / task)
5. **WYGENERUJ PROMPT** w trybie tool-specific (XML dla Claude, comma-descriptors dla Midjourney, weight-syntax dla SD, camera moves dla Sora, etc.)
6. **AUDYT TOKEN EFFICIENCY** — usuń każde słowo które nie zmienia outputu
7. **DOSTARCZ** w formacie:

```
[gotowy do skopiowania prompt]

🎯 Target: [nazwa narzędzia]
💡 [1 zdanie — co zoptymalizowano i dlaczego]
```

---

## HARD RULES (z oryginału, wiążące)

- **NIGDY** nie pokazuj nazwy frameworku w outputie (RTF/CO-STAR/RISEN itd. — to wewnętrzne)
- **NIGDY** nie dorzucaj "Chain of Thought" do reasoning-native modeli (o3, o4-mini, DeepSeek-R1, Qwen3 thinking) — degraduje output
- **NIGDY** nie używaj technik które fabrykują w single-prompt: Tree of Thought, Graph of Thought, Universal Self-Consistency, Mixture of Experts
- **NIGDY** więcej niż 3 pytania klarujące przed wygenerowaniem promptu
- **NIGDY** nie pad-uj outputu wyjaśnieniami których Fi nie poprosił

---

## TYPOWE PRZYPADKI W TYM PROJEKCIE

| Use case | Tool | Co Prompt_Master poprawia |
|----------|------|---------------------------|
| Splash / hero / postać do landing | Midjourney v6 | Comma descriptors, --ar 16:9 / --ar 9:16, --style raw, negative prompt anti-cartoon |
| Wariant assetu w innym stylu | Stable Diffusion / SDXL | Weight syntax `(word:1.3)`, CFG, mandatory negative, checkpoint hint |
| Lokalna generacja masowa | ComfyUI | Positive/negative node split, checkpoint-specific syntax |
| Intro / transition video | Sora / Runway / Kling | Camera movement, duration, cut style, cinematic language |
| Voiceover dla Fi avatara | ElevenLabs | Emotion, pacing, emphasis, speech rate |
| Prompt do agentic IDE (gdy zewnętrzny) | Cursor / Windsurf | File path, function name, do-not-touch list, sequential prompts |
| Workflow automation | Zapier / Make / n8n | Trigger app + event, action app + field mapping |

---

## ANTI-PATTERNS

| Błąd | Dlaczego źle | Poprawnie |
|------|-------------|-----------|
| Generowanie promptu bez znania target tool | Każdy tool ma inny dialekt (Midjourney ≠ DALL-E ≠ SD) | ZAWSZE potwierdź target przed promptem |
| Wklejanie pełnej treści `references/templates.md` w sesję | 395 linii × każda kategoria = token waste | Czytaj TYLKO sekcję dla danej kategorii |
| Pokazywanie nazwy frameworku w outputie | "Tu RTF, tu CO-STAR" = noise dla Fi | Output = czysty prompt + 1 zdanie strategii |
| Dorzucanie CoT do o3 / DeepSeek-R1 / Qwen3 thinking | Modele myślą wewnętrznie, CoT degraduje | Krótkie clean instrukcje, zero scaffolding |
| 5 pytań klarujących | Fi zniechęcony, chciał szybko prompt | Max 3, lepiej 0-1 jeśli się da wywnioskować |

---

## CROSS-LINK

- `Auto_Codex.md` — gdy Fi chce delegować kodowanie do Codex CLI (NIE używaj Prompt_Master, Auto_Codex ma swój template)
- `DESIGN_ARSENAL.md` — gdy Fi pracuje nad UI/landing i potrzebuje stacku/snippetów (Prompt_Master generuje prompty do AI, DESIGN_ARSENAL daje recepty stylowe)

---

## ŹRÓDŁO + LICENCJA

- **Repo:** https://github.com/nidhinjs/prompt-master
- **Autor:** nidhinjs
- **Licencja:** MIT (patrz `🅔_STRATEGIA/external/prompt-master/LICENSE`)
- **Wersja:** 1.5.0
- **Data importu:** 2026-04-22
