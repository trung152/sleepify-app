# Coding Standards — Sleepify

## Dart / Flutter

- `@freezed` for ALL domain models — immutable, `copyWith`, `toJson/fromJson`
- `@riverpod` annotation (code generation) for ALL providers — no manual `Provider()`
- `AsyncNotifier` / `Notifier` for stateful logic; `FutureProvider` / `StreamProvider` for read-only
- `ConsumerWidget` / `ConsumerStatefulWidget` over `Consumer` builder
- `ref.watch()` in `build()`, `ref.read()` in callbacks — never reversed
- `const` constructors wherever possible
- `sealed class` or `enum` for finite state types
- Max file length: ~300 lines — split by responsibility if longer

## Naming Conventions

| Type             | Convention                          | Example              |
|------------------|-------------------------------------|----------------------|
| Feature folder   | `snake_case`                        | `sleep_timer/`       |
| Model            | `PascalCase` + `@freezed`           | `SleepSession`       |
| Repository       | suffix `Repository` / `Impl`        | `PlayerRepositoryImpl` |
| ViewModel        | `@riverpod` + suffix `Notifier`     | `HomeNotifier`       |
| Screen           | suffix `Screen`                     | `HomeScreen`         |
| Widget           | descriptive `PascalCase`            | `MiniPlayerBar`      |
| DataSource       | suffix `Source` or `DataSource`     | `SoundsRemoteSource` |
| File names       | `snake_case.dart`                   | `home_screen.dart`   |

## Error Handling

- `Result<T>` or `AsyncValue<T>` for fallible operations — never throw unhandled
- Repository catches data exceptions → domain `Failure` types
- UI displays errors via `AsyncValue.when(error: ...)`

## Do NOT

- ❌ `setState()` for anything other than local widget animation state
- ❌ Business logic in widgets or screens
- ❌ God classes / files over 300 lines
- ❌ `print()` — use a logger
- ❌ Hardcode strings — use constants or localization
- ❌ `dynamic` type — always specify types
- ❌ Commit `.g.dart`, `.freezed.dart` files
