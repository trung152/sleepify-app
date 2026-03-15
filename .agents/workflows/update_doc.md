---
description: Update project documentation (screen spec, feature map, context) after code changes
---

# Update Documentation Workflow

// turbo-all

## Purpose
Đồng bộ tài liệu dự án với code thực tế. Khi implement xong feature hoặc thay đổi thiết kế, chạy workflow này để cập nhật docs.

## Steps

1. **Identify what changed** — Xác định thay đổi cần cập nhật:
   ```bash
   git diff --name-only HEAD~3 2>$null; git status --short
   ```

2. **Read current docs** — Đọc các tài liệu liên quan:
   - `docs/screen_spec.md` — đặc tả màn hình
   - `docs/context.md` — development context
   - `.gemini/learned/feature_map.md` — feature map
   - `.gemini/learned/project_overview.md` — project overview

3. **Determine which docs need updates** based on changes:

   | Loại thay đổi | Doc cần update |
   |---------------|----------------|
   | Thêm/sửa screen | `docs/screen_spec.md` |
   | Thêm/sửa feature | `.gemini/learned/feature_map.md` |
   | Thêm package mới | `.gemini/rules/project_specific.md` |
   | Thay đổi UI/design | `.gemini/rules/ui_design.md` |
   | Thay đổi architecture | `.gemini/rules/architecture.md` |
   | Bất kỳ thay đổi nào | `docs/context.md` (via `/save-context`) |

4. **Update the relevant doc(s)** — Chỉ sửa phần liên quan, giữ nguyên phần còn lại.

5. **Verify consistency** — Cross-check giữa các docs:
   - Screen spec khớp với feature map?
   - Feature map khớp với code thực tế?
   - Routes trong spec khớp với `app_router.dart`?

6. **Commit docs**:
   ```bash
   git add docs/ .gemini/learned/ .gemini/rules/ && git commit -m "docs: update documentation after [tên thay đổi]"
   ```

## Common Scenarios

### Sau khi implement xong 1 feature
1. Update `docs/screen_spec.md` — đánh dấu screens đã implement
2. Update `.gemini/learned/feature_map.md` — cập nhật trạng thái
3. Chạy `/save-context`

### Sau khi thay đổi thiết kế
1. Update `docs/screen_spec.md` — sửa UI elements, interactions
2. Update `.gemini/rules/ui_design.md` nếu design tokens thay đổi

### Sau khi thêm package mới
1. Update `.gemini/rules/project_specific.md` — thêm vào bảng dependencies

### Sau khi user cung cấp mockup mới
1. Phân tích mockup
2. Update `docs/screen_spec.md` — thêm/sửa screen specs
3. Update `.gemini/learned/feature_map.md` nếu có feature mới

## Notes
- **Không ghi đè toàn bộ** — chỉ edit phần liên quan
- **Giữ format nhất quán** với docs hiện tại
- Mỗi lần update nên kèm theo lý do thay đổi
- Nếu thay đổi lớn, hỏi user confirm trước khi ghi
