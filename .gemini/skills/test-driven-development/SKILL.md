---
name: test-driven-development
description: "Use when implementing any feature or bugfix. Write failing test first, then minimal code to pass."
---

# Test-Driven Development (TDD)

## The Iron Law
```
NO PRODUCTION CODE WITHOUT A FAILING TEST FIRST
```

Write code before the test? Delete it. Start over. No exceptions.

## When to Use
**Always:** New features, bug fixes, refactoring, behavior changes.

**Exceptions (ask user first):** Throwaway prototypes, generated code (`freezed`, `riverpod_generator`), pure UI/visual work.

## Red-Green-Refactor

### 🔴 RED — Write Failing Test
- One behavior per test
- Clear descriptive name
- Real code (no mocks unless unavoidable)

```dart
test('SleepTimerNotifier counts down and stops playback', () async {
  final container = ProviderContainer();
  final notifier = container.read(sleepTimerProvider.notifier);

  notifier.start(duration: Duration(minutes: 15));

  expect(notifier.state.isRunning, isTrue);
  expect(notifier.state.remaining, Duration(minutes: 15));
});
```

### ✅ Verify RED
Run: `flutter test path/to/test.dart`
- Confirm test **fails** (not errors)
- Fails because feature is missing

### 🟢 GREEN — Minimal Code
Write simplest code to make the test pass. No extras, no "improvements".

### ✅ Verify GREEN
Run tests again. Confirm:
- Test passes
- Other tests still pass

### 🔵 REFACTOR
After green only: remove duplication, improve names, extract helpers.
Keep tests green. Don't add behavior.

### 🔄 Repeat
Next failing test for next behavior.

## Flutter-Specific Testing

| Level        | Tool          | Target                        |
|-------------|---------------|-------------------------------|
| Unit         | `flutter_test` | Models, Repositories, Notifiers |
| Widget       | `testWidgets`  | Individual widgets             |
| Integration  | `integration_test` | Full flows                |
| Golden       | `matchesGoldenFile` | Visual regression         |

## Red Flags — STOP
- "Quick test after implementation" → Delete code, test first
- "Too complex to test" → Simplify the design
- "Just a small change" → Small changes have root causes too
