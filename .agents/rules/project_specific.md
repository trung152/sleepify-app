# Project-Specific Rules — Sleepify

## Audio

- All audio state (playback, volume, position) → `player` feature as global providers
- `just_audio` for playback, `audio_service` for background/lock-screen audio
- Audio MUST continue playing across screen navigation
- Always dispose audio resources via `ref.onDispose()`
- Sound mixing: multiple `AudioPlayer` instances managed by a `MixerNotifier`

## Navigation

- `go_router` for declarative routing
- Bottom nav screens → `StatefulShellRoute` (persistent state)
- Onboarding flow → sequential routes (no bottom nav)
- Deep linking support for future features

## Data Strategy

- **Cache-first:** check local → fetch remote → update cache
- `Hive` or `Isar` for local persistence
- `Dio` for HTTP with interceptors (auth, logging, retry)
- All async data → `AsyncValue<T>` through Riverpod

## Dependencies (Key Packages)

| Package                 | Purpose                          |
|-------------------------|----------------------------------|
| `flutter_riverpod`      | State management                 |
| `riverpod_annotation`   | `@riverpod` code gen             |
| `freezed_annotation`    | `@freezed` models                |
| `freezed`               | Code gen for models              |
| `json_annotation`       | JSON serialization               |
| `json_serializable`     | Code gen for JSON                |
| `build_runner`          | Code generation runner           |
| `go_router`             | Navigation                       |
| `just_audio`            | Audio playback                   |
| `audio_service`         | Background audio                 |
| `hive` / `isar`         | Local database                   |
| `dio`                   | HTTP client                      |
| `google_fonts`          | Typography                       |

## Git

- Commit after each completed task
- Format: `type: description` (feat, fix, refactor, test, chore, docs)
- Never commit broken code or failing tests
- `.gitignore`: include `*.g.dart`, `*.freezed.dart`
