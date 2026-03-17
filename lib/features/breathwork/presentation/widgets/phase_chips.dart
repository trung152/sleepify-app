import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/models/breathing_pattern.dart';
import '../../domain/models/breathing_phase.dart';

/// Row of circular phase indicator chips matching Stitch design.
///
/// Shows each step in the breathing pattern with its icon, label,
/// and duration. The active phase is highlighted in cyan with glow.
class PhaseChips extends StatelessWidget {
  const PhaseChips({
    super.key,
    required this.pattern,
    required this.currentStepIndex,
    required this.isRunning,
  });

  final BreathingPattern pattern;
  final int currentStepIndex;
  final bool isRunning;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: pattern.steps.asMap().entries.map((entry) {
        final index = entry.key;
        final step = entry.value;
        final isActive = isRunning && index == currentStepIndex;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: _PhaseChip(
            phase: step.phase,
            duration: step.durationSeconds,
            isActive: isActive,
          ),
        );
      }).toList(),
    );
  }
}

class _PhaseChip extends StatelessWidget {
  const _PhaseChip({
    required this.phase,
    required this.duration,
    required this.isActive,
  });

  final BreathingPhase phase;
  final int duration;
  final bool isActive;

  IconData _iconForPhase(BreathingPhase phase) {
    switch (phase) {
      case BreathingPhase.inhale:
        return Icons.air_rounded;
      case BreathingPhase.holdIn:
        return Icons.pause_circle_outline_rounded;
      case BreathingPhase.exhale:
        return Icons.waves_rounded;
      case BreathingPhase.holdOut:
        return Icons.pause_circle_outline_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isActive
            ? AppColors.accent.withValues(alpha: 0.15)
            : AppColors.surface.withValues(alpha: 0.06),
        border: Border.all(
          color: isActive
              ? AppColors.accent.withValues(alpha: 0.5)
              : AppColors.surface.withValues(alpha: 0.1),
        ),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.2),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _iconForPhase(phase),
            size: 20,
            color: isActive
                ? AppColors.accent
                : AppColors.textSecondary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 4),
          Text(
            phase.label,
            style: GoogleFonts.manrope(
              fontSize: 11,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              color: isActive
                  ? AppColors.accent
                  : AppColors.textSecondary.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '${duration}s',
            style: GoogleFonts.manrope(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: isActive
                  ? AppColors.accent.withValues(alpha: 0.7)
                  : AppColors.textSecondary.withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }
}
