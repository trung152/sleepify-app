# Sleepify — Feature Map

## Feature → Screens → Core Functionality

| Feature | Screens | Chức năng chính | Status |
|---------|---------|-----------------|--------|
| `onboarding` | SplashScreen, LanguageScreen, GoalScreen, BedtimeScreen, SleepHoursScreen, NotificationScreen | Cá nhân hóa trải nghiệm, thu thập preferences | ✅ Done |
| `home` | HomeScreen | Lời chào, Mood Chips, Hero Section, Top 5 Ranked, Relaxing/Nature sections | ✅ Done |
| `shell` | MainShell | Tab navigation via IndexedStack + FloatingNavBar | ✅ Done |
| `sounds` | SoundsScreen | Grid âm thanh, Active Glow, Volume Ring | ✅ Done |
| `player` | MiniPlayerBar, CurrentMixScreen | Play/Pause/Stop, mix management, volume per sound | 🔧 In Progress |
| `breathwork` | BreathworkScreen | Visualizer, instructions (Inhale/Hold/Exhale), timer | ⬜ Not started |
| `sleep_timer` | SleepTimerScreen | Scroll-wheel picker (HH:MM), ending sound, fade out, vibration | 🔧 In Progress |
| `library` | LibraryScreen | Saved mixes, bookmarked content | ⬜ Not started |
| `settings` | SettingsScreen, LanguageScreen | Notifications, language, support, about | ⬜ Not started |
| `premium` | PremiumScreen | Paywall, features preview, 7-day trial CTA | ⬜ Not started |

## Shared Components

| Component | Location | Used By | Status |
|-----------|----------|---------|--------|
| `FloatingNavBar` | `shared/widgets/` | All main screens | ✅ Done |
| `OnboardingScaffold` | `features/onboarding/presentation/widgets/` | All onboarding screens | ✅ Done |
| `GlassCard` | `shared/widgets/` | Home, Sounds, Library | ✅ Created |
| `AppTheme` | `core/theme/` | Global | ✅ Done |
| `AppRouter` | `core/router/` | Global | ✅ Done |
| `AppConstants` | `core/constants/` | Global | ⬜ Not started |

## Feature Dependencies

```
home ──→ player (mini player bar)
sounds ──→ player (playback, mixing)
breathwork ──→ player (background audio)
sleep_timer ──→ player (auto-stop)
library ──→ player (saved mixes playback)
```

`player` is the central feature — all audio features depend on it.
