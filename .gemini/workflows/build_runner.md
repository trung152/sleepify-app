---
description: Run Dart/Flutter code generation with build_runner
---

# Build Runner Workflow

// turbo-all

## When to Run
- After creating/modifying `@freezed` models
- After creating/modifying `@riverpod` providers
- After creating/modifying `@JsonSerializable` classes
- After any change to files with `part` directives

## Steps

1. **Run build_runner**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

2. **If conflicts persist, clean first**
   ```bash
   dart run build_runner clean
   dart run build_runner build --delete-conflicting-outputs
   ```

3. **For continuous watch mode (during development)**
   ```bash
   dart run build_runner watch --delete-conflicting-outputs
   ```

## Troubleshooting
- If `build_runner` not found: run `flutter pub get` first
- If generated files have errors: check `part` directives match filename exactly
- If freezed fails: ensure `@freezed` annotation and `_$ClassName` mixin are correct
