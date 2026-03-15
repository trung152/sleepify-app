---
name: create-feature
description: "Scaffold a new Sleepify feature with full MVVM folder structure, boilerplate files, and provider setup."
---

# Create Feature — Sleepify

## Use this skill when
- Creating a new feature module from scratch
- Need the full data/domain/presentation scaffold

## Instructions

### Step 1: Create Folder Structure

For a feature named `<feature_name>`:

```
lib/features/<feature_name>/
├── data/
│   ├── data_sources/
│   │   └── <feature_name>_local_source.dart
│   └── repositories/
│       └── <feature_name>_repository_impl.dart
├── domain/
│   ├── models/
│   │   └── <feature_name>_model.dart
│   └── repositories/
│       └── <feature_name>_repository.dart
└── presentation/
    ├── providers/
    │   └── <feature_name>_notifier.dart
    ├── screens/
    │   └── <feature_name>_screen.dart
    └── widgets/
```

### Step 2: Domain Model (`@freezed`)

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part '<feature_name>_model.freezed.dart';
part '<feature_name>_model.g.dart';

@freezed
class <FeatureName>Model with _$<FeatureName>Model {
  const factory <FeatureName>Model({
    required String id,
    required String name,
    // ... fields
  }) = _<FeatureName>Model;

  factory <FeatureName>Model.fromJson(Map<String, dynamic> json) =>
      _$<FeatureName>ModelFromJson(json);
}
```

### Step 3: Abstract Repository

```dart
abstract class <FeatureName>Repository {
  Future<List<<FeatureName>Model>> getAll();
  Future<<FeatureName>Model> getById(String id);
}
```

### Step 4: Repository Implementation

```dart
class <FeatureName>RepositoryImpl implements <FeatureName>Repository {
  final <FeatureName>LocalSource _localSource;

  <FeatureName>RepositoryImpl(this._localSource);

  @override
  Future<List<<FeatureName>Model>> getAll() => _localSource.getAll();
  // ...
}
```

### Step 5: Provider (`@riverpod`)

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '<feature_name>_notifier.g.dart';

@riverpod
class <FeatureName>Notifier extends _$<FeatureName>Notifier {
  @override
  FutureOr<List<<FeatureName>Model>> build() async {
    final repo = ref.watch(<featureName>RepositoryProvider);
    return repo.getAll();
  }
}
```

### Step 6: Screen

```dart
class <FeatureName>Screen extends ConsumerWidget {
  const <FeatureName>Screen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(<featureName>NotifierProvider);
    return state.when(
      data: (items) => /* UI */,
      loading: () => const CircularProgressIndicator(),
      error: (e, st) => Text('Error: $e'),
    );
  }
}
```

### Step 7: Run Code Generation

```bash
dart run build_runner build --delete-conflicting-outputs
```
