---
description: Edit an existing design screen using Stitch MCP.
---

# Workflow: Edit-Design

Make targeted changes to an already generated Sleepify design screen.

## Steps

### 1. Identify the Screen
Use `mcp_StitchMCP_list_screens` or `mcp_StitchMCP_get_screen` to find the correct `projectId` and `screenId`.

### 2. Formulate the Edit Prompt
Be specific about the changes:
- **Location**: "Change the color of the [play button] in the [mini player bar]..."
- **Visuals**: "...to a gradient from cyan (#00BCD4) to purple (#7C4DFF) with a soft glow."
- **Structure**: "Add a volume slider below the sound cards."

### 3. Apply the Edit
Call `mcp_StitchMCP_edit_screens`:

```json
{
  "projectId": "...",
  "selectedScreenIds": ["..."],
  "prompt": "[Specific edit prompt]"
}
```

> **Important**: This can take a few minutes. Do NOT retry.

### 4. Present AI Feedback
Show `outputComponents` text and suggestions to the user.

### 5. Download Updated Assets
Save updated HTML and screenshot to `.stitch/designs/`, overwriting previous versions.

### 6. Verify and Repeat
- Check if changes were applied correctly.
- For more polish, repeat with a new specific prompt.

## Tips
- **One change at a time**: More focused edits produce better results.
- **Use component names**: "navigation bar", "hero section", "mini player bar", "sound card grid".
- **Include hex codes**: Precise colors ensure consistency with Sleepify's palette.
- **Preserve context**: Add "Make only this change while preserving all existing elements."
