---
description: Generate new mobile screens from a text prompt using Stitch MCP.
---

# Workflow: Text-to-Design

Transform a text description into a high-fidelity mobile screen design for Sleepify.

## Steps

### 1. Enhance the User Prompt
Apply the [Prompt Enhancement Pipeline](../SKILL.md#-prompt-enhancement-pipeline):
- Set platform to **Mobile** and identify the screen type.
- Incorporate Sleepify design system from `.stitch/DESIGN.md` (if it exists).
- Use [Design Mappings](../references/design-mappings.md) and [Prompt Keywords](../references/prompt-keywords.md).
- Always include Sleepify defaults (dark theme, cyan accents, glassmorphism).

### 2. Identify the Project
Use `mcp_StitchMCP_list_projects` to find the correct `projectId` if not already known.

### 3. Generate the Screen
Call `mcp_StitchMCP_generate_screen_from_text` with the enhanced prompt:

```json
{
  "projectId": "...",
  "prompt": "[Enhanced Prompt with Sleepify design system]",
  "deviceType": "MOBILE"
}
```

> **Important**: This can take a few minutes. Do NOT retry.

### 4. Present AI Feedback
Show the text description and suggestions from `outputComponents` to the user.

### 5. Download Design Assets
After generation, save HTML and screenshot to `.stitch/designs/`:
- Use the screen name or a descriptive slug for the filename.
- Ensure `.stitch/designs/` directory exists.

### 6. Review and Refine
- If the result needs tweaks, use the [edit-design](edit-design.md) workflow.
- Do NOT re-generate from scratch unless the layout is fundamentally wrong.

## Tips
- **Be structural**: Break the screen into header, main content, bottom nav.
- **Specify colors**: Use hex codes (#0A0E21, #00BCD4, #7C4DFF).
- **Set the tone**: "Calming, ambient, nocturnal, soft-glow".
- **Include persistent elements**: Mini player bar, bottom navigation tabs.
