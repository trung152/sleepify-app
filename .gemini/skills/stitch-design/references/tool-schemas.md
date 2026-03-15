# Stitch MCP Tool Schemas

Use these examples to format your tool calls to the Stitch MCP server correctly.

---

## 🏗️ Project Management

### `mcp_StitchMCP_list_projects`
Lists all Stitch projects accessible to you.
```json
{}
```

### `mcp_StitchMCP_get_project`
Retrieves details of a specific project.
```json
{
  "name": "projects/4044680601076201931"
}
```

### `mcp_StitchMCP_create_project`
Creates a new Stitch project.
```json
{
  "title": "Sleepify"
}
```

---

## 🎨 Design Generation

### `mcp_StitchMCP_generate_screen_from_text`
Generates a new screen from a text description.
```json
{
  "projectId": "4044680601076201931",
  "prompt": "A calming dark-themed home screen for a sleep app with hero section, mood chips, and sound categories. Deep navy background (#0A0E21), cyan accents (#00BCD4).",
  "deviceType": "MOBILE"
}
```

> **Note**: For Sleepify, always use `"deviceType": "MOBILE"` unless designing for tablet.

### `mcp_StitchMCP_edit_screens`
Edits existing screens with a text prompt.
```json
{
  "projectId": "4044680601076201931",
  "selectedScreenIds": ["98b50e2ddc9943efb387052637738f61"],
  "prompt": "Change the CTA button to a pill-shaped gradient (cyan to purple) and add a subtle glow effect."
}
```

> **Note**: This action can take a few minutes. Do NOT retry.

---

## 🖼️ Screen Management

### `mcp_StitchMCP_list_screens`
Lists all screens within a project.
```json
{
  "projectId": "4044680601076201931"
}
```

### `mcp_StitchMCP_get_screen`
Retrieves details of a specific screen (HTML code, screenshot, dimensions).
```json
{
  "projectId": "4044680601076201931",
  "screenId": "98b50e2ddc9943efb387052637738f61",
  "name": "projects/4044680601076201931/screens/98b50e2ddc9943efb387052637738f61"
}
```

---

## 🎭 Variants

### `mcp_StitchMCP_generate_variants`
Generates alternative versions of existing screens.
```json
{
  "projectId": "4044680601076201931",
  "selectedScreenIds": ["98b50e2ddc9943efb387052637738f61"],
  "prompt": "Generate a variant with a more minimal layout and brighter accent colors.",
  "variantOptions": {
    "numVariants": 2
  }
}
```
