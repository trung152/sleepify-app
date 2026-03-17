/// Phases of a breathing exercise cycle.
///
/// Each phase represents a distinct action in a breathing pattern.
/// The visualizer animates differently for each phase.
enum BreathingPhase {
  /// Breathe in — visualizer circle expands.
  inhale,

  /// Hold breath after inhaling — visualizer holds expanded.
  holdIn,

  /// Breathe out — visualizer circle shrinks.
  exhale,

  /// Hold breath after exhaling — visualizer holds contracted.
  holdOut;

  /// Human-readable label for UI display.
  String get label {
    switch (this) {
      case BreathingPhase.inhale:
        return 'Inhale';
      case BreathingPhase.holdIn:
        return 'Hold';
      case BreathingPhase.exhale:
        return 'Exhale';
      case BreathingPhase.holdOut:
        return 'Hold';
    }
  }

  /// Uppercase label for the visualizer center text.
  String get displayText => label.toUpperCase();
}
