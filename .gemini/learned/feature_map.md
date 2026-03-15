# Sleepify — Feature Map

## Feature → Screens → Core Functionality

| Feature | Screens | Chức năng chính |
|---------|---------|-----------------|
| `onboarding` | SplashScreen, GoalScreen, BedtimeScreen, SleepHoursScreen, NotificationScreen | Cá nhân hóa trải nghiệm, thu thập preferences |
| `home` | HomeScreen | Lời chào, Mood Chips, Hero Section, Top 5, Healing Ambient |
| `sounds` | SoundsScreen | Grid âm thanh, Active Glow, Volume Ring |
| `player` | MiniPlayerBar, CurrentMixSheet | Play/Pause/Stop, mix management, volume per sound |
| `breathwork` | BreathworkScreen | Visualizer, instructions (Inhale/Hold/Exhale), timer |
| `sleep_timer` | SleepTimerModal | Hẹn giờ tắt âm thanh (10/15/20/25 phút) |
| `library` | LibraryScreen | Saved mixes, bookmarked content |
| `settings` | SettingsScreen, LanguageScreen | Notifications, language, support, about |
| `premium` | PremiumScreen | Paywall, features preview, 7-day trial CTA |

## Shared Components

| Component | Location | Used By |
|-----------|----------|---------|
| `FloatingNavbar` | `shared/widgets/` | All main screens |
| `GlassCard` | `shared/widgets/` | Home, Sounds, Library |
| `AppTheme` | `core/theme/` | Global |
| `AppRouter` | `core/router/` | Global |
| `AppConstants` | `core/constants/` | Global |

## Feature Dependencies

```
home ──→ player (mini player bar)
sounds ──→ player (playback, mixing)
breathwork ──→ player (background audio)
sleep_timer ──→ player (auto-stop)
library ──→ player (saved mixes playback)
```

`player` is the central feature — all audio features depend on it.
