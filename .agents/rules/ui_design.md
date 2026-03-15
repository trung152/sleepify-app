# UI / Design System — Sleepify

## Design Language

Ultra-Premium Glassmorphism — dark, immersive, serene.

## Color Palette

| Token          | Hex       | Usage                              |
|----------------|-----------|------------------------------------|
| Midnight Navy  | `#0B0F19` | Primary background                 |
| Neon Cyan      | `#00E5FF` | Accent, active states, glows       |
| Soft Gold      | `#FFD700` | Rankings, premium badges           |
| Surface        | `#FFFFFF` | 5-10% opacity glass surfaces      |
| Text Primary   | `#FFFFFF` | Headings, body text               |
| Text Secondary | `#B0BEC5` | Subtitles, captions               |

## Glassmorphism Tokens

- **Blur:** 24px – 30px (`BackdropFilter`)
- **Border Radius:** 24px – 32px (iOS-style smooth corners)
- **Border:** 1px `#FFFFFF` at 8-12% opacity (ultra-thin light border)
- **Surface Fill:** `#FFFFFF` at 5-10% opacity

## Typography

- Use Google Fonts (e.g., Inter, Outfit, or Poppins)
- Font weights: Regular (400), Medium (500), SemiBold (600), Bold (700)

## Navigation

- **Floating Capsule Navbar** — lơ lửng (floating) above bottom edge
- 5 tabs: Home, Sounds, **Breathwork** (center, highlighted), Library, Settings
- Center Breathwork icon is elevated/accented with Neon Cyan

## Component Guidelines

- **Cards:** Glassmorphism with blur backdrop, thin light border
- **Active State Glow:** Cyan glow (`boxShadow` with `#00E5FF` spread) for active sounds
- **Volume Ring:** Circular progress indicator integrated on sound icons
- **Mini Player:** Floating bar above navbar showing active mix count + play/pause
- **Bottom Sheet:** For detailed player controls (Current Mix)
- **Smooth Transitions:** Use `Hero`, `AnimatedContainer`, `SlideTransition`
- **Micro-animations:** Subtle scale, fade, pulse for interactive elements

## Responsive

- Support various screen sizes (phones, tablets)
- Use `LayoutBuilder` / `MediaQuery` for adaptive layouts
- Test on both small (375px) and large (428px+) phone widths
