---
name: design-md
description: "Analyzes Stitch projects and generates comprehensive DESIGN.md files documenting Sleepify's design system in semantic language optimized for consistent screen generation."
---

# Stitch DESIGN.md Skill — Sleepify

## Overview
This skill creates `.stitch/DESIGN.md` files that serve as the "source of truth" for prompting Stitch to generate new screens that align perfectly with Sleepify's existing design language.

## Prerequisites
- Access to the Stitch MCP Server
- A Stitch project with at least one designed screen
- Refer to: https://stitch.withgoogle.com/docs/learn/prompting/

## The Goal
The `DESIGN.md` file ensures all generated screens share the same visual language — Sleepify's dark, calming, mobile-first aesthetic with consistent colors, typography, and component styling.

## Retrieval

1. **Project lookup** (if ID unknown):
   - Call `mcp_StitchMCP_list_projects` to find the Sleepify project
   - Extract Project ID from the `name` field

2. **Screen lookup**:
   - Call `mcp_StitchMCP_list_screens` with the `projectId`
   - Identify representative screens (Home, Sounds, Player, etc.)

3. **Metadata fetch**:
   - Call `mcp_StitchMCP_get_screen` for target screen(s)
   - Retrieve `screenshot.downloadUrl` and `htmlCode.downloadUrl`

4. **Asset download**:
   - Use `read_url_content` to fetch HTML code
   - Parse HTML to extract colors, styles, and component patterns

5. **Project metadata**:
   - Call `mcp_StitchMCP_get_project` for `designTheme`, fonts, and color mode

## Analysis & Synthesis

### 1. Extract Project Identity
- Project Title: "Sleepify"
- Project ID from the Stitch project

### 2. Define the Atmosphere
Analyze screenshot and HTML to capture the "vibe":
- Use evocative adjectives: "Serene", "Nocturnal", "Ambient", "Soft-glow"
- Describe the mood: "Designed for bedtime — calming and gentle on the eyes"

### 3. Map the Color Palette
For each color, provide:
- **Descriptive name** conveying character (e.g., "Midnight Navy")
- **Hex code** in parentheses (e.g., "#0A0E21")
- **Functional role** (e.g., "Primary canvas background")

### 4. Translate Geometry & Shape
Convert technical values into physical descriptions:
- `rounded-full` → "Pill-shaped"
- `rounded-xl` → "Generously rounded corners"
- Blur + transparency → "Glassmorphism / Frosted glass effect"

### 5. Describe Depth & Elevation
- How does the UI handle layers?
- For Sleepify: "Soft cyan glow beneath elevated elements, glassmorphism surfaces with subtle inner brightness"

## Output Format

Create `.stitch/DESIGN.md`:

```markdown
# Design System: Sleepify
**Project ID:** [ID]

## 1. Visual Theme & Atmosphere
[Mood description — serene, nocturnal, ambient, calming]

## 2. Color Palette & Roles
[Descriptive Name + (Hex) + Functional Role for each color]

## 3. Typography Rules
[Font families, weights, usage for headings vs body vs accent]

## 4. Component Stylings
* **Buttons:** [Shape, gradient, glow]
* **Cards:** [Glassmorphism, border, shadow]
* **Mini Player:** [Layout, blur, controls]
* **Bottom Nav:** [Tabs, active indicator]
* **Inputs:** [Style, focus ring color]

## 5. Layout Principles
[Mobile-first, spacing strategy, persistent elements]
```

## Best Practices
- **Be Precise**: Include exact hex codes after descriptive names
- **Be Descriptive**: "Midnight Navy" not "dark blue"
- **Be Functional**: Explain what each element is for
- **Be Consistent**: Use the same terms throughout
- **Be Sleepify**: Maintain calming, sleep-oriented aesthetic in all descriptions

## Common Pitfalls
- ❌ Using only technical jargon without translation
- ❌ Omitting hex codes or using only descriptive names
- ❌ Forgetting to explain functional roles
- ❌ Being too generic — always tie back to Sleepify's sleep/relaxation purpose
