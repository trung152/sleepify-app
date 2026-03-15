# Stitch MCP → Flutter Code Workflow

## Optimal Steps (No Browser Required)

When converting a Stitch design to Flutter code:

1. **`get_screen`** — Retrieve screen metadata (screenshot URL + HTML code URL)
2. **`read_url_content`** — Download and read the HTML code directly to understand layout structure, components, spacing, colors, and typography
3. **`view_file`** on the screenshot image — If visual confirmation is needed, download the screenshot and use `view_file` (supports image files) instead of opening Chrome
4. **Write Flutter code** — Convert the HTML structure + visual design into Flutter widgets

## ❌ Do NOT

- Do NOT use `browser_subagent` to view Stitch screenshots — this is slow and unnecessary
- Do NOT open Chrome/browser to view design images — `view_file` handles images directly

## Key Notes

- Stitch `get_screen` returns `screenshot.downloadUrl` (image) and `htmlCode.downloadUrl` (HTML source)
- The HTML code contains all structural info: layout, fonts, colors, spacing, icons
- The screenshot image is useful only for visual confirmation of ambiguous details
- Stitch project ID for Sleepify: `15275561946752396567`
- Design theme uses: dark mode, Manrope font, full roundness, custom color `#06e0f9`

## PowerShell (Windows)

- **Nối lệnh**: Dùng `;` thay vì `&&` (PowerShell không hỗ trợ `&&`)
  - ❌ `git add -A && git commit -m "msg"` → **lỗi**
  - ✅ `git add -A; git commit -m "msg"` → **đúng**
- **Download file**: Dùng `Invoke-WebRequest -Uri "..." -OutFile "..."` thay vì `curl -L -o`
