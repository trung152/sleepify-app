import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/models/breathing_phase.dart';

/// Animated circular breathing visualizer matching the Stitch design.
///
/// Features:
/// - Concentric outer rings with N/S/E/W crosshair tick marks
/// - Glowing inner circle that scales with breathing phases
/// - Phase text ("INHALE" / "HOLD" / "EXHALE") centered
/// - Smooth animation driven by [progress] (0.0 → 1.0)
class BreathingVisualizer extends StatelessWidget {
  const BreathingVisualizer({
    super.key,
    required this.phase,
    required this.progress,
    required this.isRunning,
  });

  /// Current breathing phase.
  final BreathingPhase phase;

  /// Progress within current phase (0.0 → 1.0).
  final double progress;

  /// Whether a session is actively running.
  final bool isRunning;

  @override
  Widget build(BuildContext context) {
    // Calculate scale based on phase and progress
    final scale = _calculateScale();

    return SizedBox(
      width: 280,
      height: 280,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ── Outer rings with crosshair ─────────────────
          CustomPaint(
            size: const Size(280, 280),
            painter: _RingsPainter(
              progress: isRunning ? progress : 0.0,
              phase: phase,
            ),
          ),

          // ── Glowing inner circle ──────────────────────
          AnimatedScale(
            scale: scale,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeInOut,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.accent.withValues(alpha: 0.8),
                    AppColors.accent.withValues(alpha: 0.3),
                    AppColors.accent.withValues(alpha: 0.05),
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.3),
                    blurRadius: 40,
                    spreadRadius: 8,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  isRunning ? phase.displayText : 'START',
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    letterSpacing: 3,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _calculateScale() {
    if (!isRunning) return 0.8;

    switch (phase) {
      case BreathingPhase.inhale:
        // Expand from 0.6 to 1.0
        return 0.6 + (0.4 * progress);
      case BreathingPhase.holdIn:
        // Hold at 1.0 with subtle pulse
        return 1.0 + (0.02 * sin(progress * pi * 4));
      case BreathingPhase.exhale:
        // Shrink from 1.0 to 0.6
        return 1.0 - (0.4 * progress);
      case BreathingPhase.holdOut:
        // Hold at 0.6 with subtle pulse
        return 0.6 + (0.02 * sin(progress * pi * 4));
    }
  }
}

/// Custom painter for the concentric rings and crosshair tick marks.
class _RingsPainter extends CustomPainter {
  _RingsPainter({
    required this.progress,
    required this.phase,
  });

  final double progress;
  final BreathingPhase phase;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // ── Outer ring ──
    final outerRingPaint = Paint()
      ..color = AppColors.accent.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawCircle(center, 130, outerRingPaint);

    // ── Middle ring ──
    final midRingPaint = Paint()
      ..color = AppColors.accent.withValues(alpha: 0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawCircle(center, 110, midRingPaint);

    // ── Inner ring ──
    final innerRingPaint = Paint()
      ..color = AppColors.accent.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    canvas.drawCircle(center, 90, innerRingPaint);

    // ── Crosshair tick marks (N, S, E, W) ──
    final tickPaint = Paint()
      ..color = AppColors.accent.withValues(alpha: 0.5)
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    const tickLength = 12.0;
    const outerRadius = 130.0;

    // North
    canvas.drawLine(
      Offset(center.dx, center.dy - outerRadius + tickLength),
      Offset(center.dx, center.dy - outerRadius - tickLength),
      tickPaint,
    );
    // South
    canvas.drawLine(
      Offset(center.dx, center.dy + outerRadius - tickLength),
      Offset(center.dx, center.dy + outerRadius + tickLength),
      tickPaint,
    );
    // East
    canvas.drawLine(
      Offset(center.dx + outerRadius - tickLength, center.dy),
      Offset(center.dx + outerRadius + tickLength, center.dy),
      tickPaint,
    );
    // West
    canvas.drawLine(
      Offset(center.dx - outerRadius + tickLength, center.dy),
      Offset(center.dx - outerRadius - tickLength, center.dy),
      tickPaint,
    );

    // ── Progress arc (active ring) ──
    if (progress > 0) {
      final progressPaint = Paint()
        ..color = AppColors.accent.withValues(alpha: 0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.0
        ..strokeCap = StrokeCap.round;

      final rect = Rect.fromCircle(center: center, radius: 110);
      // Start from top (-pi/2), sweep clockwise
      canvas.drawArc(rect, -pi / 2, 2 * pi * progress, false, progressPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _RingsPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.phase != phase;
}
