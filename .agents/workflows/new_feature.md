---
description: End-to-end workflow for creating a new feature in Sleepify
---

# New Feature Workflow

// turbo-all

## Steps

1. **Brainstorm & Plan** — Use `@brainstorming` skill to clarify requirements, explore approaches, and validate design.

2. **Create Implementation Plan** — Write `implementation_plan.md` with exact file paths, broken into small tasks. Get user approval.

3. **Scaffold Feature** — Use `@create-feature` skill to generate folder structure:
   ```bash
   # Creates: lib/features/<name>/data/, domain/, presentation/
   ```

4. **Create Domain Models** — Use `@create-model` skill for `@freezed` models in `domain/models/`.

5. **Run Code Generation**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

6. **Create Repository Interface** — Abstract class in `domain/repositories/`.

7. **Implement Repository** — Concrete class in `data/repositories/` with data source.

8. **Write Repository Tests** — Follow TDD: RED → verify → GREEN → verify → REFACTOR.
   ```bash
   flutter test test/features/<name>/
   ```

9. **Create Provider/ViewModel** — `@riverpod` notifier in `presentation/providers/`.

10. **Write Provider Tests** — Test state transitions and error handling.
    ```bash
    flutter test test/features/<name>/
    ```

11. **Build Screen & Widgets** — UI in `presentation/screens/` and `presentation/widgets/`.

12. **Add Route** — Register in `go_router` configuration.

13. **Integration Test** — Full flow test if applicable.

14. **Verify All Tests Pass**
    ```bash
    flutter test
    ```

15. **Commit**
    ```bash
    git add -A && git commit -m "feat: add <feature_name> feature"
    ```
