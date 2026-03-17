# Sleepify — Current Context

> Cập nhật: 2026-03-18T00:21 (Session 4)

## Phase hiện tại

**Phase 3: Audio Features — Sounds, Player, Sleep Timer, Library**

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

#### Sounds & Player
- **SoundsScreen** — Grid layout, SoundCircle widgets, active glow + volume ring
- **MiniPlayerBar** — Compact player bar, play/pause, tap-to-expand
- **CurrentMixScreen** — Full screen player (slide-up from MiniPlayerBar)
  - Sound list with volume sliders, icon circles, percentage labels
  - CLEAR ALL MIX button, bookmark/save header (wired to SaveMixBottomSheet)
  - Controls bar: Timer / Play-Pause (cyan glow) / Add Sound
- **SleepTimerScreen** — Full screen (slide-up from CurrentMixScreen timer button)
  - Scroll-wheel time picker (HOURS : MINUTES), large numbers (48px)
  - Ending Sound setting (default: None, dropdown style)
  - Fade Out stepper (1-60 Sec, subtitle "Length sounds will fade out")
  - Vibration toggle with description
  - START TIMER button with cyan glow

#### Library (Session 4 — NEW ✅)
- **SavedMix model** — @freezed (sealed class), id/name/sounds/volumes/createdAt
- **LibraryRepository** — abstract interface (getAllMixes, saveMix, deleteMix)
- **LibraryLocalSource** — SharedPreferences JSON persistence
- **LibraryRepositoryImpl** — delegates to local source
- **LibraryNotifier** — @riverpod AsyncNotifier (save, delete, loadMix → ActiveSoundsProvider)
- **SaveMixBottomSheet** — blurred bottom sheet, name input, cyan save button, cancel
- **SavedMixCard** — glassmorphism card, circular icon, name, sound list, play/delete
- **LibraryScreen** — segmented tabs (Favorites placeholder / My Mixes list)
  - My Mixes: saved mix cards + "Create New Mix" card
  - Delete confirmation dialog
  - Play → loads mix into ActiveSoundsProvider
- **MainShell** — Library placeholder replaced with real LibraryScreen

### 🔧 Đang làm (In Progress)

| Feature | Status | Notes |
|---------|--------|-------|
| Player feature | 🔧 | UI done, cần `just_audio` integration, actual audio playback |
| Sleep Timer | 🔧 | UI done, cần actual timer logic (countdown, fade out, device lock) |

### ⬜ Chưa hoàn thành

| Feature | Priority | Notes |
|---------|----------|-------|
| Breathwork Screen | MEDIUM | Visualizer, breathing patterns |
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
- **Freezed 3.x**: Use `sealed class` (not `class`) for freezed models — mixin generates abstract members
- **Riverpod 3.x naming**: Generator strips `Notifier` suffix → `LibraryNotifier` generates `libraryProvider`
- **Riverpod 3.x Ref**: Use `Ref` (not legacy `LibraryRepositoryRef`) for functional providers

## Session 4 — Key Decisions

1. **Library feature**: Full MVVM architecture (domain/data/presentation layers)
2. **SavedMix persistence**: SharedPreferences with JSON serialization (simple, no Hive/Isar needed)
3. **SavedMix model**: `sealed class` for Freezed 3.x compatibility
4. **Save flow**: CurrentMixScreen bookmark → SaveMixBottomSheet → LibraryNotifier → SharedPreferences
5. **Load flow**: LibraryScreen play → LibraryNotifier.loadMix → clearAll + toggleSound + setVolume

## Session 4 — Bugs Fixed

1. **`libraryNotifierProvider` undefined**: Riverpod generates `libraryProvider` (strips Notifier suffix) — fixed in 4 files
2. **`LibraryRepositoryRef` undefined**: Riverpod 3.x uses `Ref` — fixed in library_notifier.dart
3. **`_$SavedMix` missing implementations**: Freezed 3.x generates mixin, needs `sealed class` — fixed

## Next Session — Gợi ý

1. **`just_audio` integration** — actual audio playback cho SoundsScreen + CurrentMixScreen
2. **Sleep Timer logic** — countdown timer, fade out audio, device lock
3. **Breathwork Screen** — breathing visualizer, patterns
4. **Settings Screen** — settings items

## Blockers / Issues

- Cần integrate `just_audio` + `audio_service` cho actual playback
- Favorites tab trong Library chưa có logic (placeholder)
