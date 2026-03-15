# Sleepify — Global Rules (Gemini / Antigravity)

## Project Overview

**Sleepify** is a Flutter sleep & relaxation app featuring: audio playback, sound mixing, sleep timers, breathing exercises, onboarding, and a user library.

- **Architecture:** Feature-First MVVM + Repository + Riverpod
- **State Management:** Riverpod 3.x with code generation (`@riverpod`)
- **Language:** Dart (Flutter SDK ^3.11.1)
- **Platforms:** Android, iOS (primary), Web (secondary)

---

## Architecture Rules

### Layer Structure (per feature)

```
features/<feature>/
├── data/
│   ├── data_sources/    # Remote/local data access
│   ├── repositories/    # Repository implementation
│   ├── dto/             # Data Transfer Objects (optional)
│   └── mappers/         # DTO ↔ Domain model mapping (optional)
├── domain/
│   ├── models/          # @freezed domain models
│   ├── repositories/    # Abstract repository interface
│   └── services/        # ONLY when combining multiple repos or complex logic
└── presentation/
    ├── providers/       # @riverpod ViewModels / Notifiers
    ├── screens/         # Full-page widgets
    └── widgets/         # Reusable UI components
```

### Dependency Rules

- **UI → ViewModel → Repository → DataSource** (standard flow)
- **UI → ViewModel → Service → Repository → DataSource** (complex features only)
- **NEVER** import `data/` from `domain/`. Domain layer MUST NOT know about data implementations.
- **NEVER** import `presentation/` from `data/` or `domain/`.
- Cross-feature imports go through `shared/` or the feature's `domain/` layer only.
- When a feature is used globally (e.g., `player`), other features reference its `domain/models/` and `presentation/providers/`, NOT its `data/`.

### When to Add a Service/UseCase Layer

- ✅ ADD when: combining 2+ repositories, complex business logic, logic reused across multiple ViewModels
- ❌ SKIP when: ViewModel simply calls a single repository method (pass-through)
- When in doubt, start without it. Add it when the ViewModel grows too complex.

---

## Coding Standards

### Dart/Flutter

- Use `@freezed` for all domain models — immutable, with `copyWith`, `toJson/fromJson`
- Use `@riverpod` annotation (code generation) for all providers — no manual `Provider()`
- Use `AsyncNotifier` / `Notifier` for stateful logic, `FutureProvider` / `StreamProvider` for read-only data
- Prefer `ConsumerWidget` / `ConsumerStatefulWidget` over `Consumer` builder
- Use `ref.watch()` in `build()`, `ref.read()` in callbacks — never the reverse
- Widgets should be lean: display data and forward events. **No business logic in widgets.**
- Use `const` constructors wherever possible
- Follow official Dart effective style: `snake_case` files, `PascalCase` classes, `camelCase` methods
- Max file length: ~300 lines. If longer, split by responsibility.
- Use `sealed class` or `enum` for finite state types

### Error Handling

- Use `Result<T>` or `AsyncValue<T>` for operations that can fail — never throw unhandled exceptions
- Repository layer catches data exceptions and converts to domain `Failure` types
- UI displays errors via `AsyncValue.when(error: ...)` pattern

### Naming Conventions

| Type | Convention | Example |
|---|---|---|
| Feature folder | `snake_case` | `sleep_timer/` |
| Model | `PascalCase` + `@freezed` | `SleepSession` |
| Repository (abstract) | `PascalCase` + suffix `Repository` | `PlayerRepository` |
| Repository (impl) | suffix `Impl` | `PlayerRepositoryImpl` |
| ViewModel/Provider | `@riverpod` + `Notifier` suffix | `HomeNotifier` |
| Screen | suffix `Screen` | `HomeScreen` |
| Widget | descriptive name | `MiniPlayerBar` |
| DataSource | suffix `Source` or `DataSource` | `SoundsRemoteSource` |

---

## Development Workflow (Inspired by Superpowers)

### 1. Think Before Coding

- **NEVER jump straight to code.** Understand the requirement first.
- For any non-trivial feature: brainstorm → design → plan → implement
- Ask clarifying questions if the requirement is ambiguous — one question at a time
- Propose 2-3 approaches with trade-offs when applicable

### 2. YAGNI & DRY

- **YAGNI (You Aren't Gonna Need It):** Don't add features, abstractions, or parameters that aren't needed RIGHT NOW. Build the simplest thing that works.
- **DRY (Don't Repeat Yourself):** Extract shared logic only after it appears in 2+ places. Don't preemptively abstract.

### 3. Test-Driven Development (TDD)

Follow Red-Green-Refactor cycle:

1. **RED** — Write a failing test that describes the desired behavior
2. **VERIFY RED** — Run the test, confirm it fails for the right reason
3. **GREEN** — Write the minimal code to make the test pass
4. **VERIFY GREEN** — Run the test, confirm it passes (and no other tests broke)
5. **REFACTOR** — Clean up code while keeping tests green
6. **COMMIT** — Small, focused commits

**Exceptions** (only with explicit user permission):
- Throwaway prototypes
- Generated code (freezed, riverpod_generator output)
- Pure UI/visual work (widgets without business logic)

### 4. Implementation Plans

For any feature spanning multiple files:
- Write an implementation plan with exact file paths
- Break into bite-sized tasks (2-5 minutes each)
- Each task: test → implement → verify → commit
- Get user approval before executing the plan

### 5. Systematic Debugging

When fixing bugs:
1. Reproduce the issue first
2. Form a hypothesis about the root cause
3. Verify the hypothesis (don't assume)
4. Fix the root cause, not symptoms
5. Write a test that would have caught the bug
6. Verify the fix doesn't break other things

### 6. Git Discipline

- Commit after each completed task (not after hours of work)
- Commit messages: `type: description` (feat, fix, refactor, test, chore, docs)
- Never commit broken code or failing tests

---

## Project-Specific Rules

### Audio

- All audio state (playback, volume, position) lives in the `player` feature as global providers
- Use `just_audio` for playback, `audio_service` for background audio
- Audio must continue playing across screen navigation
- Always dispose audio resources properly via `ref.onDispose()`

### UI/Theme

- Dark theme with cyan/teal accent colors (matching design)
- Use glassmorphism effects for cards
- Smooth transitions and micro-animations
- Responsive: support various screen sizes
- Bottom navigation bar is persistent across main screens

### Navigation

- Use `go_router` for declarative routing
- Bottom nav screens use `StatefulShellRoute`
- Onboarding flow uses sequential routes (not bottom nav)

### Data

- Cache-first strategy: check local → fetch remote → update cache
- Use `Hive` or `Isar` for local persistence
- Use `Dio` for HTTP requests with interceptors
- All async data operations return `AsyncValue<T>` through Riverpod

---

## Do NOT

- ❌ Use `setState()` for anything other than local widget animation state
- ❌ Put business logic in widgets or screens
- ❌ Create God classes / files over 300 lines
- ❌ Import `data/` layer from `domain/` layer
- ❌ Skip writing tests for repositories and ViewModels
- ❌ Use `print()` for logging — use a proper logger
- ❌ Hardcode strings — use constants or localization
- ❌ Use `dynamic` type — always specify types
- ❌ Commit generated files (`.g.dart`, `.freezed.dart`) — add to `.gitignore`
