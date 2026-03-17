import 'package:flutter/material.dart';

import 'breathing_phase.dart';

/// A single step in a breathing pattern (one phase with its duration).
class BreathingStep {
  const BreathingStep({
    required this.phase,
    required this.durationSeconds,
  });

  final BreathingPhase phase;
  final int durationSeconds;
}

/// A complete breathing pattern definition with metadata and steps.
class BreathingPattern {
  const BreathingPattern({
    required this.id,
    required this.name,
    required this.description,
    required this.steps,
    this.icon = Icons.air,
  });

  final String id;
  final String name;
  final String description;
  final List<BreathingStep> steps;
  final IconData icon;

  /// Total duration of one complete cycle in seconds.
  int get cycleDurationSeconds =>
      steps.fold(0, (sum, step) => sum + step.durationSeconds);
}

/// Predefined breathing patterns available in the app.
class BreathingPatterns {
  BreathingPatterns._();

  /// Box Breathing (4-4-4-4) — used by Navy SEALs for stress relief.
  static const boxBreathing = BreathingPattern(
    id: 'box',
    name: 'Box Breathing',
    description: 'Calm your mind and focus',
    icon: Icons.check_box_outline_blank_rounded,
    steps: [
      BreathingStep(phase: BreathingPhase.inhale, durationSeconds: 4),
      BreathingStep(phase: BreathingPhase.holdIn, durationSeconds: 4),
      BreathingStep(phase: BreathingPhase.exhale, durationSeconds: 4),
      BreathingStep(phase: BreathingPhase.holdOut, durationSeconds: 4),
    ],
  );

  /// 4-7-8 Relaxing Breath — promotes deep relaxation and sleep.
  static const relaxing478 = BreathingPattern(
    id: '478',
    name: '4-7-8 Relaxing',
    description: 'Deep relaxation for sleep',
    icon: Icons.nights_stay_rounded,
    steps: [
      BreathingStep(phase: BreathingPhase.inhale, durationSeconds: 4),
      BreathingStep(phase: BreathingPhase.holdIn, durationSeconds: 7),
      BreathingStep(phase: BreathingPhase.exhale, durationSeconds: 8),
    ],
  );

  /// Wim Hof style — energizing power breathing.
  static const wimHof = BreathingPattern(
    id: 'wimhof',
    name: 'Wim Hof',
    description: 'Energizing power breathing',
    icon: Icons.bolt_rounded,
    steps: [
      BreathingStep(phase: BreathingPhase.inhale, durationSeconds: 2),
      BreathingStep(phase: BreathingPhase.exhale, durationSeconds: 2),
    ],
  );

  /// All available patterns, ordered for display.
  static const List<BreathingPattern> all = [
    boxBreathing,
    relaxing478,
    wimHof,
  ];
}
