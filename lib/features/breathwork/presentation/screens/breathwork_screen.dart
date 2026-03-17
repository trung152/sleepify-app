import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/models/breathing_pattern.dart';
import '../providers/breathwork_provider.dart';
import '../widgets/breathing_visualizer.dart';
import '../widgets/phase_chips.dart';
import '../widgets/session_settings.dart';

/// Breathwork screen — breathing exercise with animated visualizer.
///
/// Matches the Stitch "🌬️ Breathwork" design with:
/// - Header (back + title + info icon)
/// - Pattern name + description
/// - Animated breathing circle
/// - Phase indicator chips
/// - Timer + ambient sound settings
/// - Play/stop button
class BreathworkScreen extends ConsumerWidget {
  const BreathworkScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(breathworkProvider);
    final notifier = ref.read(breathworkProvider.notifier);

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [const Color(0xFF0D1B2A), AppColors.background],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // ── Header ──────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Row(
                children: [
                  // Back (only show when session running, to dismiss)
                  const SizedBox(width: 36, height: 36),
                  const Spacer(),
                  Text(
                    'Breathwork',
                    style: GoogleFonts.manrope(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  // Info icon
                  GestureDetector(
                    onTap: () => _showPatternPicker(context, ref),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.surface.withValues(alpha: 0.08),
                      ),
                      child: Icon(
                        Icons.swap_horiz_rounded,
                        color: AppColors.textSecondary,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── Pattern Title ─────────────────────────────
            Text(
              state.selectedPattern.name,
              style: GoogleFonts.manrope(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              state.selectedPattern.description,
              style: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.accent,
              ),
            ),

            // ── Breathing Visualizer ─────────────────────
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BreathingVisualizer(
                      phase: state.currentPhase,
                      progress: state.phaseProgress,
                      isRunning: state.isRunning,
                    ),

                    const SizedBox(height: 8),

                    // Session time remaining
                    if (state.isRunning)
                      Text(
                        state.remainingTimeFormatted,
                        style: GoogleFonts.manrope(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary.withValues(alpha: 0.6),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // ── Phase Chips ──────────────────────────────
            PhaseChips(
              pattern: state.selectedPattern,
              currentStepIndex: state.currentStepIndex,
              isRunning: state.isRunning,
            ),

            const SizedBox(height: 24),

            // ── Session Settings ─────────────────────────
            SessionSettings(
              durationMinutes: state.sessionDurationMinutes,
              ambientSoundId: state.ambientSoundId,
              onDurationChanged: notifier.setSessionDuration,
              onAmbientChanged: notifier.setAmbientSound,
            ),

            const SizedBox(height: 24),

            // ── Play / Stop Button ──────────────────────
            _PlayButton(
              isRunning: state.isRunning,
              isPaused: state.isPaused,
              onPlay: notifier.startSession,
              onPause: notifier.pauseSession,
              onResume: notifier.resumeSession,
              onStop: notifier.stopSession,
            ),

            // ── Cycles counter ──────────────────────────
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 100),
              child: state.isRunning && state.completedCycles > 0
                  ? Text(
                      '${state.completedCycles} cycle${state.completedCycles > 1 ? 's' : ''} completed',
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary.withValues(alpha: 0.5),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  void _showPatternPicker(BuildContext context, WidgetRef ref) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF151D2B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final currentPattern =
            ref.read(breathworkProvider).selectedPattern;
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(top: 12),
                decoration: BoxDecoration(
                  color: AppColors.surface.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Breathing Pattern',
                  style: GoogleFonts.manrope(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              ...BreathingPatterns.all.map((pattern) {
                final isSelected = pattern.id == currentPattern.id;
                return ListTile(
                  leading: Icon(
                    pattern.icon,
                    color: isSelected
                        ? AppColors.accent
                        : AppColors.textSecondary,
                  ),
                  title: Text(
                    pattern.name,
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: isSelected
                          ? AppColors.accent
                          : AppColors.textPrimary,
                    ),
                  ),
                  subtitle: Text(
                    pattern.description,
                    style: GoogleFonts.manrope(
                      fontSize: 12,
                      color: AppColors.textSecondary.withValues(alpha: 0.6),
                    ),
                  ),
                  trailing: isSelected
                      ? Icon(Icons.check_circle, color: AppColors.accent)
                      : null,
                  onTap: () {
                    ref
                        .read(breathworkProvider.notifier)
                        .setPattern(pattern);
                    Navigator.pop(context);
                  },
                );
              }),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}

/// Large play/pause/stop button with cyan glow.
class _PlayButton extends StatelessWidget {
  const _PlayButton({
    required this.isRunning,
    required this.isPaused,
    required this.onPlay,
    required this.onPause,
    required this.onResume,
    required this.onStop,
  });

  final bool isRunning;
  final bool isPaused;
  final VoidCallback onPlay;
  final VoidCallback onPause;
  final VoidCallback onResume;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Stop button (only when running)
        if (isRunning)
          GestureDetector(
            onTap: onStop,
            child: Container(
              width: 44,
              height: 44,
              margin: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surface.withValues(alpha: 0.1),
                border: Border.all(
                  color: AppColors.surface.withValues(alpha: 0.15),
                ),
              ),
              child: Icon(
                Icons.stop_rounded,
                color: AppColors.textSecondary,
                size: 24,
              ),
            ),
          ),

        // Main play / pause button
        GestureDetector(
          onTap: () {
            if (!isRunning) {
              onPlay();
            } else if (isPaused) {
              onResume();
            } else {
              onPause();
            }
          },
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accent,
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.4),
                  blurRadius: 24,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: Icon(
              isRunning
                  ? (isPaused ? Icons.play_arrow_rounded : Icons.pause_rounded)
                  : Icons.play_arrow_rounded,
              color: AppColors.background,
              size: 32,
            ),
          ),
        ),
      ],
    );
  }
}
