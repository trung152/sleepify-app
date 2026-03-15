# Sleepify — Project Overview

## About
**Sleepify** là ứng dụng di động cao cấp thuộc lĩnh vực Sức khỏe & Lối sống. Tập trung vào trải nghiệm âm thanh thư giãn, hỗ trợ giấc ngủ và rèn luyện hơi thở (Breathwork).

## Tech Stack
- **Framework:** Flutter (SDK ^3.11.1)
- **Architecture:** Feature-First MVVM + Repository + Riverpod
- **State:** Riverpod 3.x with code generation (`@riverpod`)
- **Platforms:** Android, iOS (primary), Web (secondary)

## Design Language
- Ultra-Premium Glassmorphism
- Dark theme: Midnight Navy (#0B0F19)
- Accent: Neon Cyan (#00E5FF), Soft Gold (#FFD700)
- Floating Capsule Navbar, blur 24-30px, border-radius 24-32px

## User Flow

### Onboarding (4 steps)
1. Splash Screen → branding + loading
2. Chọn mục tiêu (Ngủ ngon, Thư giãn, Tập trung, Luyện thở)
3. Thói quen đi ngủ → thời gian ngủ thường xuyên
4. Nhu cầu giấc ngủ → slider số giờ ngủ mong muốn
5. Bật thông báo → nhắc đi ngủ hàng ngày

### Main App (Bottom Nav)
- **Home:** Lời chào cá nhân, Quick Mood Chips, Hero Section, Top 5, Healing Ambient
- **Sounds:** Grid âm thanh thiên nhiên, Active Glow, Volume Ring, Mini Player
- **Breathwork:** Visualizer nhịp thở, hướng dẫn Inhale/Hold/Exhale
- **Library:** Bản phối yêu thích, nội dung đã lưu
- **Settings:** Thông báo, ngôn ngữ, hỗ trợ, about

### Supplementary
- **Sleep Timer:** Modal chọn thời gian tự tắt (10-25 phút)
- **Current Mix:** Bottom Sheet chi tiết điều chỉnh âm lượng từng sound
- **Premium Paywall:** Giới thiệu gói Premium, CTA 7-day trial
- **Language Picker:** Danh sách ngôn ngữ + quốc kỳ
