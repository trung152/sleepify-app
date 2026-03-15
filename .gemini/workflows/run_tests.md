---
description: Run Flutter tests with common options
---

# Run Tests Workflow

// turbo-all

## Steps

1. **Run all tests**
   ```bash
   flutter test
   ```

2. **Run specific feature tests**
   ```bash
   flutter test test/features/<feature_name>/
   ```

3. **Run single test file**
   ```bash
   flutter test test/features/<feature_name>/<test_file>_test.dart
   ```

4. **Run with coverage**
   ```bash
   flutter test --coverage
   ```

5. **Run with verbose output**
   ```bash
   flutter test --reporter expanded
   ```

## Test File Convention
- Mirror `lib/` structure under `test/`
- Suffix: `_test.dart`
- Example: `lib/features/player/domain/models/sound.dart` → `test/features/player/domain/models/sound_test.dart`
