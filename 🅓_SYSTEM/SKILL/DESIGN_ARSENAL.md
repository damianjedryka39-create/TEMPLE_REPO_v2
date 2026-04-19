---
name: DESIGN_ARSENAL
trigger: "UI|frontend|design|estetyka|css|animacja|landing page|dashboard"
purpose: Zasoby i referencje do budowy futurystycznych stron — frameworki, animacje, palety, snippety
output: Rekomendacja stacku UI + gotowe snippety do użycia
agents: [Claude]
cross_link: [Preflight.md]
ecosystem: TEMPLE_REPO
---

# DESIGN ARSENAL — Futurystyczny UI/UX

> Zasoby do budowy TOP stron w estetyce AI/cyber/sci-fi.
> Agent CZYTA ten plik przed KAŻDYM zadaniem UI/frontend.

---

## 1. FRAMEWORKI UI (GitHub)

| Nazwa | GitHub | Stars | Opis | Vanilla? |
|-------|--------|-------|------|----------|
| **Arwes** | `arwes/arwes` | 17k+ | Jedyny framework sci-fi/cyberpunk UI — animacje, dźwięki, efekty | Tak |
| **DaisyUI** | `saadeghi/daisyui` | 35k+ | Komponenty Tailwind CSS — zero JS, 35+ motywów (cyberpunk, night) | Tak |
| **UIverse** | `uiverse-io/galaxy` | 4k+ | 4000+ elementów UI — vanilla CSS + Tailwind | Tak |
| **shadcn/ui** | `shadcn-ui/ui` | 94k+ | Komponenty copy-paste — React ale wzorce designu do portowania | React |
| **Aceternity UI** | ui.aceternity.com | 12k+ | Glassmorphism, parallax, glow — Tailwind + Framer Motion | React |
| **Magic UI** | magicui.design | 15k+ | Mikro-interakcje, animowane gradienty, particle effects | React |

---

## 2. BIBLIOTEKI ANIMACJI (Vanilla JS — bez React)

| Nazwa | GitHub | Stars | Kiedy użyć |
|-------|--------|-------|-----------|
| **GSAP** | `greensock/GSAP` | 19k | Timeline, ScrollTrigger, morphing — KING animacji |
| **Anime.js** | `juliangarnier/anime` | 49k+ | Lekka, CSS/SVG/DOM, easing — szybki setup |
| **tsParticles** | `tsparticles/tsparticles` | 7k+ | Particle background — confetti, cząsteczki, tła |
| **AOS** | `michalsnik/aos` | 26k+ | Animate On Scroll — `data-aos="fade-up"`, zero config |
| **Vanilla-tilt.js** | `micku7zu/vanilla-tilt.js` | 4k+ | 3D hover tilt na kartach — lekki |
| **Typed.js** | `mattboldt/typed.js` | 15k+ | Efekt maszyny do pisania |
| **CountUp.js** | `inorganik/countUp.js` | 8k+ | Animowane liczniki |
| **Lottie-web** | `airbnb/lottie-web` | 30k+ | Animacje After Effects w przeglądarce |
| **Mo.js** | `mojs/mojs` | 18k+ | Burst, swirl, stagger — grafika ruchowa |
| **ScrollMagic** | `janpaepke/ScrollMagic` | 14.8k | Pinning, parallax, scroll-triggered |

---

## 3. REKOMENDOWANE COMBO (Static HTML/CSS/JS)

```
Tier 1 (must-have):
  GSAP + ScrollTrigger  — animacje i scroll
  AOS                   — proste fade-in na scroll (data-atrybuty)

Tier 2 (wow-factor):
  tsParticles           — particle background
  Vanilla-tilt.js       — 3D hover na kartach
  Typed.js              — typing effect w hero sekcji

Tier 3 (opcjonalnie):
  Arwes                 — pełny sci-fi look (alpha)
  Lottie-web            — wektorowe animacje
```

---

## 4. CSS SNIPPETY (Copy-paste ready)

### Glassmorphism
```css
.glass {
    backdrop-filter: blur(12px);
    background: rgba(255, 255, 255, 0.05);
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: 16px;
}
```

### Neon Glow Border
```css
.neon {
    box-shadow: 0 0 5px #0ff, 0 0 15px #0ff, 0 0 30px #0ff;
    border: 1px solid #0ff;
}
```

### Neon Glow Text
```css
.neon-text {
    color: #0ff;
    text-shadow: 0 0 10px rgba(0, 255, 255, 0.6),
                 0 0 30px rgba(0, 255, 255, 0.3),
                 0 0 60px rgba(0, 255, 255, 0.1);
}
```

### Animated Gradient Background
```css
.gradient-bg {
    background: linear-gradient(270deg, #0ff, #f0f, #ff0, #0ff);
    background-size: 800% 800%;
    animation: gradient-shift 8s ease infinite;
}
@keyframes gradient-shift {
    0% { background-position: 0% 50%; }
    50% { background-position: 100% 50%; }
    100% { background-position: 0% 50%; }
}
```

### Animated Gradient Border
```css
.gradient-border {
    position: relative;
    background: #0a0e14;
    border-radius: 12px;
}
.gradient-border::before {
    content: '';
    position: absolute;
    inset: -1px;
    border-radius: 13px;
    background: linear-gradient(270deg, #0ff, #a78bfa, #0ff);
    background-size: 400% 400%;
    animation: border-glow 4s ease infinite;
    z-index: -1;
}
@keyframes border-glow {
    0% { background-position: 0% 50%; }
    50% { background-position: 100% 50%; }
    100% { background-position: 0% 50%; }
}
```

### Pulse Glow (przycisk/badge)
```css
.pulse-glow {
    animation: pulse 2s ease-in-out infinite;
}
@keyframes pulse {
    0%, 100% { box-shadow: 0 0 8px rgba(0, 229, 255, 0.4); }
    50% { box-shadow: 0 0 20px rgba(0, 229, 255, 0.8), 0 0 40px rgba(0, 229, 255, 0.3); }
}
```

### Hover Lift + Glow
```css
.card-hover {
    transition: transform 0.2s, box-shadow 0.3s;
}
.card-hover:hover {
    transform: translateY(-3px);
    box-shadow: 0 8px 30px rgba(0, 229, 255, 0.12),
                0 0 1px rgba(0, 229, 255, 0.4);
}
```

### Scan Line (retro-futuristic)
```css
.scanline::after {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0;
    height: 2px;
    background: rgba(0, 255, 255, 0.1);
    animation: scan 4s linear infinite;
}
@keyframes scan {
    0% { top: 0; }
    100% { top: 100%; }
}
```

---

## 5. PALETY KOLORÓW (Dark Futuristic)

### Cyber Cyan (aktualna MALING)
```css
--bg: #0a0e14;
--surface: #111620;
--accent: #00e5ff;
--green: #00ffaa;
--text: #e0f0ff;
```

### Neon Purple
```css
--bg: #0d0b1a;
--surface: #15122b;
--accent: #a78bfa;
--green: #34d399;
--text: #e8e0ff;
```

### Matrix Green
```css
--bg: #0a0f0a;
--surface: #111a11;
--accent: #00ff41;
--secondary: #008f11;
--text: #d0ffd0;
```

### Holo Orange
```css
--bg: #0f0d0a;
--surface: #1a1610;
--accent: #ff6b2c;
--secondary: #ffa040;
--text: #fff0e0;
```

---

## 6. PLATFORMY AI DO GENEROWANIA UI

| Platforma | URL | Co robi |
|-----------|-----|---------|
| **v0.dev** | v0.dev | Generuje React/Tailwind z promptu — Vercel |
| **Lovable.dev** | lovable.dev | Full-stack app z promptu — $6.6B wycena |
| **Bolt.new** | bolt.new | Full-stack w przeglądarce — StackBlitz WebContainer |

---

## 7. INSPIRACJA

| Źródło | URL | Co tam |
|--------|-----|--------|
| **Dribbble** | dribbble.com/search/futuristic-dashboard | Tysiące projektów dashboardów |
| **Dribbble** | dribbble.com/search/cyberpunk-ui | Estetyka cyberpunk |
| **Behance** | behance.net/search/projects/futuristic+ui | Futurystyczne UI |
| **FreeFrontend** | freefrontend.com/css-glow-effects/ | 65 przykładów glow CSS |
| **FreeFrontend** | freefrontend.com/ui-micro-interaction/ | 76 mikro-interakcji |
| **CodePen** | codepen.io/search/pens?q=neon+glassmorphism | Gotowe efekty do kopiowania |

---

## 8. CDN — SZYBKI IMPORT (bez npm)

```html
<!-- GSAP + ScrollTrigger -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.5/gsap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.5/ScrollTrigger.min.js"></script>

<!-- AOS (Animate On Scroll) -->
<link href="https://unpkg.com/aos@2.3.4/dist/aos.css" rel="stylesheet">
<script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>
<script>AOS.init();</script>

<!-- tsParticles -->
<script src="https://cdn.jsdelivr.net/npm/tsparticles-slim@2/tsparticles.slim.bundle.min.js"></script>

<!-- Vanilla Tilt -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/vanilla-tilt/1.8.1/vanilla-tilt.min.js"></script>

<!-- Typed.js -->
<script src="https://unpkg.com/typed.js@2.1.0/dist/typed.umd.js"></script>

<!-- CountUp.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/countup.js/2.8.0/countUp.umd.min.js"></script>

<!-- Anime.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/animejs/3.2.2/anime.min.js"></script>

<!-- Lottie -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/lottie-web/5.12.2/lottie.min.js"></script>
```
