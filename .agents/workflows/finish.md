---
description: End-of-session wrap-up — update docs, save context, and summarize the session
---

# Finish Session Workflow

// turbo-all

## Purpose
Chạy khi kết thúc buổi làm việc. Tự động cập nhật tài liệu, lưu context, và tạo tóm tắt session để buổi sau tiếp tục mượt mà.

## Steps

1. **Scan what was done this session**
   ```bash
   git status --short
   ```
   ```bash
   git diff --stat
   ```

2. **Run `/update-doc`** — Cập nhật tài liệu liên quan:
   - `docs/screen_spec.md` — nếu có screen mới/sửa
   - `.agents/learned/feature_map.md` — nếu có feature mới/sửa
   - `.agents/rules/project_specific.md` — nếu thêm package

3. **Run `/save-context`** — Lưu trạng thái vào `docs/context.md`:
   - Phase hiện tại
   - Feature đã xong / đang làm / còn lại
   - Decisions & blockers
   - Next steps cụ thể

4. **Check for analysis errors** before closing:
   ```bash
   dart analyze
   ```

5. **Generate session summary** — Tạo tóm tắt ngắn gọn cho user:
   ```
   📋 Session Summary — [date]
   ✅ Completed: [list]
   🔧 In Progress: [list]
   ⏭️ Next Session: [what to do]
   ⚠️ Issues: [nếu có]
   ```

6. **Commit** — Tự chạy commit (PowerShell syntax):
   ```powershell
   git add -A; git commit -m "feat/fix/chore: [mô tả ngắn gọn từ session summary]"
   ```

## Notes
- **PowerShell**: Dùng `;` để nối lệnh (KHÔNG dùng `&&`)
- Luôn chạy `dart analyze` trước khi kết thúc để đảm bảo không để lại lỗi
- Nếu có test failures, báo cho user biết trước khi kết thúc
- Context file (`docs/context.md`) là nguồn chính để session sau đọc lại
