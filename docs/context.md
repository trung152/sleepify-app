# Sleepify — Current Context

> Cập nhật: 2026-03-15T12:32 (Session 2)

## Phase hiện tại

**Phase 2: UI Screens — Onboarding + Home + Navigation**

## Tiến độ

### ✅ Đã hoàn thành

#### Infrastructure
- Localization EN + VI (ARB files + auto-generated `AppLocalizations`)
- `locale_provider` — lưu ngôn ngữ vào SharedPreferences
- `onboarding_provider` — lưu trạng thái onboarding
- `AppColors` — Midnight Navy dark theme + Neon Cyan accent
- `AppRouter` — go_router setup cho toàn bộ onboarding + home flow
- Stitch MCP project setup (project ID: `5040869211547201931`)

#### Onboarding (6 screens)
- **SplashScreen** — logo, loading bar, auto-navigate
- **LanguageScreen** — 8 ngôn ngữ, lưu locale
- **GoalScreen** — multi-select (Sleep, Relax, Focus, Breathe)
- **BedtimeScreen** — single-select 4 khung giờ
- **SleepHoursScreen** — slider 4-12h, recommended badge
- **NotificationScreen** — bell icon, feature list, Enable/Skip
- **OnboardingScaffold** — shared widget cho tất cả onboarding screens

#### Home Screen
- Top bar — avatar + dynamic greeting + bell
- Hero card — featured sound, gradient overlay, play button
- Mood chips — horizontal filter chips (All, Relax, Deep Sleep, etc.)
- Top 5 Selection — vertical ranked list, Stitch-style glassmorphism tiles
- Relaxing Sounds — horizontal scroll cards (15 tracks)
- Nature & Ambient — horizontal scroll cards (12 tracks)
- Sound data model + 27 local sound files mapped to thumbnails

#### Navigation
- **FloatingNavBar** — minimal edge-to-edge, blur backdrop, 5 tabs
- **MainShell** — IndexedStack for tab state preservation
- 4 placeholder screens (Sounds, Breathwork, Library, Settings)

### ⬜ Chưa hoàn thành

| Feature | Priority | Notes |
|---------|----------|-------|
| Sounds Screen | HIGH | Grid with active glow + volume ring |
| Player feature | HIGH | `just_audio`, MiniPlayerBar, CurrentMixSheet |
| Breathwork Screen | MEDIUM | Visualizer, breathing patterns |
| Sleep Timer | MEDIUM | Auto-stop modal |
| Library Screen | LOW | Saved mixes |
| Settings Screen | LOW | Settings items |
| Premium Screen | LOW | UI-only paywall |

## Quyết định kiến trúc

- **State management**: Riverpod 3.x + code generation (`@riverpod`)
- **Navigation**: go_router, MainShell + IndexedStack (not StatefulShellRoute)
- **Sound data**: Static local assets, `Sound` model class (not @freezed yet)
- **Navbar style**: Minimal edge-to-edge (was capsule, user preferred simpler)
- **Top 5 layout**: Vertical ranked list (Stitch-style tiles), not horizontal cards

## Next Session — Gợi ý

1. **Sounds Screen** — grid layout với active glow, volume ring
2. **Player feature** — just_audio integration, MiniPlayerBar
3. **CurrentMixSheet** — bottom sheet quản lý mix
4. **Sleep Timer** — modal hẹn giờ tắt

## Blockers / Issues

- Không có blockers hiện tại
- `dart analyze` → 0 errors ✅
