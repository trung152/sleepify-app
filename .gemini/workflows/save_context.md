---
description: Save current working context (progress, decisions, next steps) so future sessions can resume seamlessly
---

# Save Context Workflow

// turbo-all

## Purpose
Lưu lại trạng thái hiện tại của dự án: đang làm gì, đã hoàn thành gì, quyết định gì, và bước tiếp theo là gì. File context được lưu tại `docs/context.md` để mỗi session mới có thể đọc và tiếp tục.

## Steps

1. **Read current context file** (nếu có) tại `docs/context.md` để biết trạng thái trước đó.

2. **Scan recent changes** — Xem các file đã thay đổi gần đây:
   ```bash
   git diff --name-only HEAD~5 2>$null; git status --short
   ```

3. **Review project structure** — Scan `lib/` để nắm cấu trúc hiện tại.

4. **Update `docs/context.md`** với format sau:

   ```markdown
   # Sleepify — Development Context
   
   > Last updated: [timestamp]
   
   ## Current Phase
   [Phase nào trong roadmap: 0/1/2/3/4]
   
   ## Completed Features
   - [x] Feature đã xong + tóm tắt ngắn
   
   ## In Progress
   - [/] Feature đang làm
     - Đã xong: [sub-tasks done]
     - Đang làm: [current sub-task]
     - Còn lại: [remaining sub-tasks]
   
   ## Key Decisions Made
   - [Decision 1]: [lý do]
   - [Decision 2]: [lý do]
   
   ## Known Issues / Blockers
   - [Issue nếu có]
   
   ## Next Steps
   1. [Bước tiếp theo cụ thể]
   2. [Bước sau đó]
   
   ## Dependencies Installed
   [List packages đã cài — chỉ update khi có thay đổi]
   
   ## File Structure Snapshot
   [Tree output của lib/ — chỉ update khi có thay đổi lớn]
   ```

5. **Commit context** (nếu user muốn):
   ```bash
   git add docs/context.md && git commit -m "docs: update development context"
   ```

## When to Use
- **Cuối mỗi session** trước khi kết thúc
- **Sau khi hoàn thành 1 feature** hoặc milestone
- **Khi user yêu cầu** `/save-context`
- **Trước khi bắt đầu feature mới** (đọc context cũ trước)

## Notes
- Luôn đọc `docs/context.md` cũ trước khi ghi đè — giữ lại lịch sử decisions
- Tham chiếu `docs/screen_spec.md` để biết feature nào đã implement vs chưa
- Giữ file ngắn gọn, tập trung vào thông tin actionable
