---
name: enhance-prompt
description: "Transforms vague UI ideas into polished, Stitch-optimized prompts for Sleepify screen generation. Adds design system context, UI/UX keywords, and proper structure."
---

# Enhance Prompt for Stitch — Sleepify

## Prerequisites
- Access to the Stitch MCP Server
- Refer to the Stitch Effective Prompting Guide: https://stitch.withgoogle.com/docs/learn/prompting/

## When to Use This Skill
Activate when a user wants to:
- Polish a UI prompt before sending to Stitch
- Improve a prompt that produced poor results
- Add Sleepify design consistency to a vague idea
- Structure a concept into an actionable Stitch prompt

## Enhancement Pipeline

### Step 1: Assess the Input
Evaluate what's missing:

| Element | Check for | If missing... |
|---------|-----------|---------------|
| **Platform** | "mobile" mentioned | Add: "Mobile, Mobile-first" |
| **Screen type** | "home", "sounds", "player" | Infer from description |
| **Structure** | Numbered sections | Create logical screen structure |
| **Visual style** | Mood, adjectives | Add: "Calming, nocturnal, ambient" |
| **Colors** | Hex values or roles | Add Sleepify defaults |
| **Components** | UI-specific terms | Translate using design-mappings |

### Step 2: Check for DESIGN.md
Look for `.stitch/DESIGN.md`:

**If it exists:**
1. Read and extract design system tokens
2. Include palette, typography, and component styles
3. Format as "DESIGN SYSTEM (REQUIRED)" section

**If it does not exist:**
Add this tip at the end:
```
---
💡 **Tip:** For consistent designs across screens, create a DESIGN.md
using the `design-md` skill or the `stitch-design` generate-design-md workflow.
```

### Step 3: Apply Enhancements

#### A. Add UI/UX Keywords
| Vague | Enhanced |
|-------|----------|
| "player" | "mini player bar with play/pause, track info, and progress indicator" |
| "sound grid" | "2-column card grid with glassmorphism sound cards and active glow state" |
| "timer" | "circular countdown ring with animated progress and pulsing glow" |
| "button" | "pill-shaped CTA button with cyan-to-purple gradient and glow effect" |
| "list" | "vertical scrollable list with frosted glass cards and subtle elevation" |
| "breathing page" | "breathing exercise screen with expanding/contracting circle visualizer" |

#### B. Amplify the Vibe
| Basic | Enhanced |
|-------|----------|
| "dark" | "deep navy canvas (#0A0E21) with ambient glow accents" |
| "modern" | "clean, minimal, with generous whitespace and soft glassmorphism" |
| "relaxing" | "serene, nocturnal mood with soft cyan (#00BCD4) accents on dark surfaces" |
| "premium" | "luxurious, spacious, with frosted glass cards and selective neon glow" |

#### C. Structure the Screen
```markdown
**SCREEN STRUCTURE:**
1. **Status Bar:** System indicators (time, battery)
2. **Header:** [Back button / Title / Action button]
3. **Main Content:** [Primary content area]
4. **Mini Player:** [Now-playing bar if audio is active]
5. **Bottom Nav:** [Home, Sounds, Breathwork, Library tabs]
```

#### D. Format Colors
Use descriptive name + hex + role:
- "Midnight Navy (#0A0E21) for primary canvas"
- "Cyan Glow (#00BCD4) for active states and CTAs"
- "Frosted Glass (rgba(255,255,255,0.08)) for card surfaces"

### Step 4: Format the Output
```markdown
[One-line description of screen purpose and mood]

**DESIGN SYSTEM (REQUIRED):**
- Platform: Mobile, Mobile-first
- Theme: Dark, calming, sleep-oriented
- Background: Midnight Navy (#0A0E21)
- Primary Accent: Cyan Glow (#00BCD4) for CTAs and highlights
- Secondary Accent: Soft Purple (#7C4DFF) for gradients
- Text Primary: Pure White (#FFFFFF)
- Text Secondary: Muted Silver (#B0BEC5)
- Cards: Glassmorphism, frosted glass, thin border
- Buttons: Pill-shaped, gradient fill, glow effect

**SCREEN STRUCTURE:**
1. **[Section]:** [Description]
2. **[Section]:** [Description]
...
```

---

## Examples

### Example 1: Vague → Structured
**User:** "make me a sounds page"

**Enhanced:**
```markdown
A calming, ambient sounds browsing screen with categorized sound cards for mixing and playback.

**DESIGN SYSTEM (REQUIRED):**
- Platform: Mobile, Mobile-first
- Theme: Dark, nocturnal, serene
- Background: Midnight Navy (#0A0E21)
- Primary Accent: Cyan Glow (#00BCD4) for active/selected sounds
- Cards: Glassmorphism with frosted glass, subtle cyan border when active
- Icons: Line-style sound category icons in muted silver

**SCREEN STRUCTURE:**
1. **Header:** "Sounds" title centered, settings icon right
2. **Category Chips:** Horizontal scrollable pill-shaped chips (Nature, Rain, City, White Noise...)
3. **Sound Grid:** 2-column card grid with icon, name, and active glow state
4. **Active Sounds Bar:** Shows currently playing sounds with individual volume controls
5. **Mini Player:** Play/Pause, mix name, timer shortcut
6. **Bottom Nav:** Home, Sounds (active/cyan), Breathwork, Library
```

### Example 2: Edit Request
**User:** "add a timer button"

**Enhanced:**
```markdown
Add a sleep timer button to the mini player bar.

**Specific changes:**
- Location: Mini player bar, right side before the close button
- Style: Circular icon button with moon/clock icon
- Color: Muted silver (#B0BEC5), turns cyan (#00BCD4) when timer is active
- Size: 32×32px touch target within 44px tappable area
- Behavior: Tapping opens bottom sheet with timer presets (10, 15, 20, 25 min)

**Context:** Targeted edit. Preserve all existing mini player elements.
```
