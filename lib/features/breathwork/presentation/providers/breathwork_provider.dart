import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/audio/audio_engine.dart';
import '../../domain/models/breathing_pattern.dart';
import '../../domain/models/breathing_phase.dart';

part 'breathwork_provider.g.dart';

/// Session state for the Breathwork feature.
class BreathworkState {
  const BreathworkState({
    this.selectedPattern = BreathingPatterns.boxBreathing,
    this.isRunning = false,
    this.isPaused = false,
    this.currentStepIndex = 0,
    this.phaseProgress = 0.0,
    this.elapsedSeconds = 0,
    this.sessionDurationMinutes = 10,
    this.ambientSoundId,
    this.completedCycles = 0,
  });

  /// Currently selected breathing pattern.
  final BreathingPattern selectedPattern;

  /// Whether a session is actively running.
  final bool isRunning;

  /// Whether the session is paused.
  final bool isPaused;

  /// Index into the pattern's steps list.
  final int currentStepIndex;

  /// Progress within current phase (0.0 → 1.0) for animation.
  final double phaseProgress;

  /// Total elapsed seconds in this session.
  final int elapsedSeconds;

  /// Target session duration in minutes.
  final int sessionDurationMinutes;

  /// Ambient sound ID (null = no ambient sound).
  final String? ambientSoundId;

  /// Number of completed breathing cycles.
  final int completedCycles;

  // ── Derived getters ─────────────────────────────────────────

  /// Current breathing phase.
  BreathingPhase get currentPhase =>
      selectedPattern.steps[currentStepIndex].phase;

  /// Duration of current step in seconds.
  int get currentStepDuration =>
      selectedPattern.steps[currentStepIndex].durationSeconds;

  /// Whether session time has been reached.
  bool get isSessionComplete =>
      elapsedSeconds >= sessionDurationMinutes * 60;

  /// Remaining session time formatted as "MM:SS".
  String get remainingTimeFormatted {
    final remaining = (sessionDurationMinutes * 60) - elapsedSeconds;
    final mins = (remaining ~/ 60).clamp(0, 999);
    final secs = (remaining % 60).clamp(0, 59);
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  BreathworkState copyWith({
    BreathingPattern? selectedPattern,
    bool? isRunning,
    bool? isPaused,
    int? currentStepIndex,
    double? phaseProgress,
    int? elapsedSeconds,
    int? sessionDurationMinutes,
    String? ambientSoundId,
    int? completedCycles,
    bool clearAmbientSound = false,
  }) {
    return BreathworkState(
      selectedPattern: selectedPattern ?? this.selectedPattern,
      isRunning: isRunning ?? this.isRunning,
      isPaused: isPaused ?? this.isPaused,
      currentStepIndex: currentStepIndex ?? this.currentStepIndex,
      phaseProgress: phaseProgress ?? this.phaseProgress,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      sessionDurationMinutes:
          sessionDurationMinutes ?? this.sessionDurationMinutes,
      ambientSoundId:
          clearAmbientSound ? null : (ambientSoundId ?? this.ambientSoundId),
      completedCycles: completedCycles ?? this.completedCycles,
    );
  }
}

/// Breathwork session controller.
///
/// Manages breathing phase timing, animation progress, session timer,
/// and ambient sound playback via [AudioEngine].
@Riverpod(keepAlive: true)
class Breathwork extends _$Breathwork {
  Timer? _phaseTimer;
  Timer? _sessionTimer;

  /// Tick interval for smooth animation (50ms = 20fps).
  static const _tickInterval = Duration(milliseconds: 50);

  /// Elapsed ticks within the current phase step.
  int _phaseTicks = 0;

  @override
  BreathworkState build() {
    ref.onDispose(_cleanup);
    return const BreathworkState();
  }

  AudioEngine get _engine => ref.read(audioEngineProvider);

  // ─── Pattern & Settings ─────────────────────────────────────

  /// Select a breathing pattern. Stops session if running.
  void setPattern(BreathingPattern pattern) {
    if (state.isRunning) stopSession();
    state = state.copyWith(
      selectedPattern: pattern,
      currentStepIndex: 0,
      phaseProgress: 0.0,
      completedCycles: 0,
    );
  }

  /// Set session duration in minutes.
  void setSessionDuration(int minutes) {
    state = state.copyWith(sessionDurationMinutes: minutes);
  }

  /// Set ambient sound. Pass null to disable.
  void setAmbientSound(String? soundId) {
    if (soundId == null) {
      state = state.copyWith(clearAmbientSound: true);
    } else {
      state = state.copyWith(ambientSoundId: soundId);
    }
  }

  // ─── Session Control ────────────────────────────────────────

  /// Start a breathing session.
  void startSession() {
    if (state.isRunning) return;

    // Update state FIRST so UI responds instantly
    state = state.copyWith(
      isRunning: true,
      isPaused: false,
      currentStepIndex: 0,
      phaseProgress: 0.0,
      elapsedSeconds: 0,
      completedCycles: 0,
    );

    _phaseTicks = 0;
    _startPhaseTimer();
    _startSessionTimer();

    // Fire-and-forget: start ambient sound
    if (state.ambientSoundId != null) {
      _engine.play(state.ambientSoundId!);
    }
  }

  /// Pause the session.
  void pauseSession() {
    if (!state.isRunning || state.isPaused) return;

    _phaseTimer?.cancel();
    _sessionTimer?.cancel();

    // Update state FIRST
    state = state.copyWith(isPaused: true);

    // Fire-and-forget: pause ambient sound
    if (state.ambientSoundId != null) {
      _engine.pauseAll();
    }
  }

  /// Resume the session.
  void resumeSession() {
    if (!state.isRunning || !state.isPaused) return;

    // Update state FIRST
    state = state.copyWith(isPaused: false);

    _startPhaseTimer();
    _startSessionTimer();

    // Fire-and-forget: resume ambient sound
    if (state.ambientSoundId != null) {
      _engine.resumeAll();
    }
  }

  /// Stop the session and clean up.
  void stopSession() {
    _phaseTimer?.cancel();
    _sessionTimer?.cancel();
    _phaseTicks = 0;

    // Update state FIRST
    state = state.copyWith(
      isRunning: false,
      isPaused: false,
      currentStepIndex: 0,
      phaseProgress: 0.0,
    );

    // Fire-and-forget: stop ambient sound
    if (state.ambientSoundId != null) {
      _engine.stop(state.ambientSoundId!);
    }
  }

  // ─── Internal Timers ────────────────────────────────────────

  void _startPhaseTimer() {
    _phaseTimer?.cancel();
    _phaseTimer = Timer.periodic(_tickInterval, (_) => _onPhaseTick());
  }

  void _startSessionTimer() {
    _sessionTimer?.cancel();
    _sessionTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _onSessionTick(),
    );
  }

  void _onPhaseTick() {
    _phaseTicks++;

    final currentStep = state.selectedPattern.steps[state.currentStepIndex];
    final totalTicks =
        (currentStep.durationSeconds * 1000) ~/ _tickInterval.inMilliseconds;
    final progress = (_phaseTicks / totalTicks).clamp(0.0, 1.0);

    if (_phaseTicks >= totalTicks) {
      // Move to next step
      _phaseTicks = 0;
      final nextIndex = state.currentStepIndex + 1;

      if (nextIndex >= state.selectedPattern.steps.length) {
        // Completed a full cycle
        state = state.copyWith(
          currentStepIndex: 0,
          phaseProgress: 0.0,
          completedCycles: state.completedCycles + 1,
        );
      } else {
        state = state.copyWith(
          currentStepIndex: nextIndex,
          phaseProgress: 0.0,
        );
      }
    } else {
      state = state.copyWith(phaseProgress: progress);
    }
  }

  void _onSessionTick() {
    final newElapsed = state.elapsedSeconds + 1;

    if (newElapsed >= state.sessionDurationMinutes * 60) {
      // Session complete
      stopSession();
      return;
    }

    state = state.copyWith(elapsedSeconds: newElapsed);
  }

  void _cleanup() {
    _phaseTimer?.cancel();
    _sessionTimer?.cancel();
    if (state.ambientSoundId != null) {
      _engine.stop(state.ambientSoundId!);
    }
  }
}
