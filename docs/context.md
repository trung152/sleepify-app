# Sleepify — Current Context

> Cập nhật: 2026-03-16T00:52 (Session 3)

## Phase hiện tại

**Phase 3: Audio Features — Sounds, Player, Sleep Timer**

## Tiến độ

### ✅ Đã hoàn thành

#### Infrastructure
- Localization EN + VI (ARB files + auto-generated `AppLocalizations`)
- `locale_provider` — lưu ngôn ngữ vào SharedPreferences
- `onboarding_provider` — lưu trạng thái onboarding
- `AppColors` — Midnight Navy dark theme + Neon Cyan accent
- `AppRouter` — go_router setup cho toàn bộ onboarding + home flow
- Stitch MCP project setup (project ID: `15275561946752396567`)
- `.gemini/` → `.agents/` migration (skills, workflows, learned, rules)

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
- **MainShell** — IndexedStack for tab state preservation + MiniPlayerBar integration

#### Sounds & Player (Session 3 — NEW)
- **SoundsScreen** — Grid layout, SoundCircle widgets, active glow + volume ring
- **MiniPlayerBar** — Compact player bar, play/pause, tap-to-expand
- **CurrentMixScreen** — Full screen player (slide-up from MiniPlayerBar)
  - Sound list with volume sliders, icon circles, percentage labels
  - CLEAR ALL MIX button, bookmark/save header
  - Controls bar: Timer / Play-Pause (cyan glow) / Add Sound
- **CurrentMixSheet** — DraggableScrollableSheet (also created, user's backup)
- **SleepTimerScreen** — Full screen (slide-up from CurrentMixScreen timer button)
  - Scroll-wheel time picker (HOURS : MINUTES), large numbers (48px)
  - Ending Sound setting (default: None, dropdown style)
  - Fade Out stepper (1-60 Sec, subtitle "Length sounds will fade out")
  - Vibration toggle with description
  - START TIMER button with cyan glow

### 🔧 Đang làm (In Progress)

| Feature | Status | Notes |
|---------|--------|-------|
| Player feature | 🔧 | UI done, cần `just_audio` integration, actual audio playback |
| Sleep Timer | 🔧 | UI done, cần actual timer logic (countdown, fade out, device lock) |

### ⬜ Chưa hoàn thành

| Feature | Priority | Notes |
|---------|----------|-------|
| Breathwork Screen | MEDIUM | Visualizer, breathing patterns |
| Library Screen | LOW | Saved mixes |
| Settings Screen | LOW | Settings items |
| Premium Screen | LOW | UI-only paywall |

## Quyết định kiến trúc

- **State management**: Riverpod 3.x + code generation (`@riverpod`)
- **Navigation**: go_router, MainShell + IndexedStack (not StatefulShellRoute)
- **Sound data**: Static local assets, `Sound` model class (not @freezed yet)
- **Navbar style**: Minimal edge-to-edge (was capsule, user preferred simpler)
- **Top 5 layout**: Vertical ranked list (Stitch-style tiles), not horizontal cards
- **CurrentMixScreen**: Full screen (PageRouteBuilder slide-up), NOT DraggableScrollableSheet
- **SleepTimerScreen**: Full screen (PageRouteBuilder slide-up), NOT dialog/modal
- **Config dir**: `.agents/` (migrated from `.gemini/`)

## Session 3 — Key Decisions

1. **CurrentMixSheet → CurrentMixScreen**: User preferred full-screen player over bottom sheet, slide-up animation via PageRouteBuilder
2. **SleepTimerModal → SleepTimerScreen**: User preferred full-screen over centered dialog, with scroll-wheel time picker from Stitch design
3. **Fade Out unit**: Changed from minutes to seconds (matching Stitch design)
4. **Ending Sound default**: "None" instead of "Rain Forest"

## Next Session — Gợi ý

1. **`just_audio` integration** — actual audio playback cho SoundsScreen + CurrentMixScreen
2. **Sleep Timer logic** — countdown timer, fade out audio, device lock
3. **Breathwork Screen** — breathing visualizer, patterns
4. **Library Screen** — saved mixes, bookmarks

## Blockers / Issues

- Warning: `_SettingTile.onTap` parameter unused (minor, can keep for future use)
- Cần integrate `just_audio` + `audio_service` cho actual playback
