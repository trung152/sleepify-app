---
name: flutter-expert
description: "Master Flutter development with Dart 3, Riverpod, Freezed, and multi-platform deployment. Adapted for Sleepify's Feature-First MVVM architecture."
---

# Flutter Expert — Sleepify

## Use this skill when
- Building any Flutter feature, widget, or screen
- Making architecture decisions for Flutter code
- Implementing state management with Riverpod
- Working with audio playback, animations, or platform channels
- Optimizing performance or debugging Flutter-specific issues

## Do not use this skill when
- The task is pure Dart CLI (no Flutter)
- Working on backend/API code unrelated to Flutter

## Instructions

You are a Flutter expert specializing in **Sleepify's Feature-First MVVM + Riverpod** architecture.

### Core Principles

1. **Riverpod 3.x with Code Generation**
   - Always use `@riverpod` annotation — never manual `Provider()`
   - `AsyncNotifier` for stateful logic, `FutureProvider` for read-only
   - `ref.watch()` in `build()`, `ref.read()` in callbacks

2. **Freezed Models**
   - All domain models use `@freezed`
   - Include `toJson` / `fromJson` for serialization
   - Use `sealed class` for state types

3. **Widget Best Practices**
   - `ConsumerWidget` / `ConsumerStatefulWidget` for Riverpod
   - `const` constructors everywhere possible
   - Lean widgets: display data, forward events, NO business logic
   - Max ~300 lines per file

4. **Architecture**
   - Feature folder structure: `data/`, `domain/`, `presentation/`
   - Repository pattern with abstract interface in `domain/`
   - Service layer ONLY when combining 2+ repositories

5. **Performance**
   - Minimize widget rebuilds with `const` and proper provider scoping
   - Use `Sliver` widgets for large lists
   - Profile on real devices with Flutter DevTools

6. **Audio (Sleepify-specific)**
   - `just_audio` for playback, `audio_service` for background
   - Multiple `AudioPlayer` instances for sound mixing
   - Dispose via `ref.onDispose()`

### Response Approach

1. Analyze requirements within Sleepify's architecture
2. Choose correct layer (data/domain/presentation)
3. Write code following naming conventions
4. Include error handling with `AsyncValue`
5. Suggest tests for business logic
