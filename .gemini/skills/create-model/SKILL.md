---
name: create-model
description: "Create a @freezed domain model with proper part directives, toJson/fromJson, and run build_runner."
---

# Create Freezed Model — Sleepify

## Use this skill when
- Creating a new domain model
- Adding a DTO or data class

## Instructions

### Template

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part '<model_name>.freezed.dart';
part '<model_name>.g.dart';

@freezed
class <ModelName> with _$<ModelName> {
  const factory <ModelName>({
    required String id,
    required String name,
    @Default(false) bool isActive,
    DateTime? createdAt,
  }) = _<ModelName>;

  factory <ModelName>.fromJson(Map<String, dynamic> json) =>
      _$<ModelName>FromJson(json);
}
```

### Sealed State Classes

For state management with finite states:

```dart
@freezed
sealed class <FeatureName>State with _$<FeatureName>State {
  const factory <FeatureName>State.initial() = _Initial;
  const factory <FeatureName>State.loading() = _Loading;
  const factory <FeatureName>State.loaded(List<Item> items) = _Loaded;
  const factory <FeatureName>State.error(String message) = _Error;
}
```

### File Location
- Domain models → `lib/features/<feature>/domain/models/`
- DTOs → `lib/features/<feature>/data/dto/`
- Shared models → `lib/shared/models/`

### After Creating
Run code generation:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Checklist
- [ ] `part` directives match filename exactly
- [ ] `@freezed` annotation present
- [ ] `fromJson` factory if JSON serialization needed
- [ ] `@Default()` for optional fields with defaults
- [ ] `const factory` constructor
- [ ] File is in correct domain/models/ folder
