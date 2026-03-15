---
description: Analyze a Stitch project and synthesize its design system into .stitch/DESIGN.md.
---

# Workflow: Generate .stitch/DESIGN.md

Create a "source of truth" for Sleepify's design language to ensure consistency across all screens.

## 📥 Retrieval

Retrieve metadata and assets using Stitch MCP tools:

1. **Project lookup**: Use `mcp_StitchMCP_list_projects` to find the target `projectId`.
2. **Screen lookup**: Use `mcp_StitchMCP_list_screens` to find representative screens (e.g., "Home", "Sounds").
3. **Metadata fetch**: Call `mcp_StitchMCP_get_screen` to get `screenshot.downloadUrl` and `htmlCode.downloadUrl`.
4. **Asset download**: Use `read_url_content` to fetch the HTML code for analysis.

## 🧠 Analysis & Synthesis

### 1. Identify Identity
- Capture Project Title and Project ID.

### 2. Define Atmosphere
- Analyze HTML and screenshot for the overall "vibe".
- For Sleepify: "Serene, nocturnal, ambient — designed for bedtime relaxation."

### 3. Map Color Palette
- Extract hex codes and assign functional roles.
- Example: "Midnight Navy (#0A0E21) — Primary canvas, evoking deep night sky."

### 4. Translate Geometry
- Convert CSS/Tailwind values into descriptive language.
- Example: `rounded-full` → "Pill-shaped", `rounded-2xl` → "Generously rounded (16px)"

### 5. Document Depth
- Describe shadow styles and layering.
- For Sleepify: "Soft cyan glow beneath elevated elements, glassmorphism card surfaces."

## 📝 Output Structure

Create `.stitch/DESIGN.md`:

```markdown
# Design System: Sleepify
**Project ID:** [Insert Project ID]

## 1. Visual Theme & Atmosphere
Serene, nocturnal, and ambient. Deep dark backgrounds evoke a peaceful
night sky. Soft-glow cyan and purple accents provide gentle visual
hierarchy without disrupting the calming mood.

## 2. Color Palette & Roles
- Midnight Navy (#0A0E21) — Primary canvas
- Cyan Glow (#00BCD4) — Primary actions, active states, highlights
- Soft Purple (#7C4DFF) — Gradient endpoints, secondary accents
- Pure White (#FFFFFF) — Headings, primary text
- Muted Silver (#B0BEC5) — Body text, secondary labels
- Frosted Glass (rgba(255,255,255,0.08)) — Card surfaces

## 3. Typography Rules
- Headings: Sans-serif, bold weight, white
- Body: Sans-serif, regular weight, muted silver
- Accent text: Sans-serif, medium weight, cyan

## 4. Component Stylings
* **Buttons:** Pill-shaped, gradient fill (cyan→purple), subtle glow on press
* **Cards:** Glassmorphism — frosted glass surface, thin white border, soft shadow
* **Inputs:** Rounded, dark surface, subtle border, cyan focus ring
* **Mini Player:** Fixed bottom bar with blurred background, playback controls

## 5. Layout Principles
- Mobile-first, single-column
- Generous vertical spacing for calming feel
- Bottom navigation bar (4 tabs)
- Mini player bar above nav when audio is playing
- Content areas use comfortable margins (16-24px)
```

## 💡 Best Practices
- **Be Precise**: Include hex codes in parentheses after descriptive names.
- **Be Descriptive**: "Midnight Navy" not just "dark blue".
- **Be Functional**: Explain what each element is used for.
- **Be Sleepify**: Always maintain the calming, sleep-oriented aesthetic.
