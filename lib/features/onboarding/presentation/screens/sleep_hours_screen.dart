import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/onboarding_scaffold.dart';

/// Onboarding Step 3 — Sleep hours selection.
///
/// User selects how many hours of sleep they need using a slider.
class SleepHoursScreen extends ConsumerStatefulWidget {
  const SleepHoursScreen({super.key});

  @override
  ConsumerState<SleepHoursScreen> createState() => _SleepHoursScreenState();
}

class _SleepHoursScreenState extends ConsumerState<SleepHoursScreen> {
  double _hours = 7.5;

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      currentStep: 3,
      totalSteps: 4,
      title: 'How many hours of sleep do you need?',
      subtitle:
          "We'll tailor your sleep schedule based on your personal needs.",
      onBack: () => context.go('/onboarding/bedtime'),
      onContinue: () => context.go('/onboarding/notification'),
      bottomWidget: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Center(
          child: Text(
            'You can change this anytime in settings',
            style: GoogleFonts.inter(
              fontSize: 12,
              color: AppColors.textSecondary.withValues(alpha: 0.5),
            ),
          ),
        ),
      ),
      content: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(),

            // ── Large Hours Display ───────────────────────────
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.accent.withValues(alpha: 0.3),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.15),
                    blurRadius: 60,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _hours % 1 == 0
                        ? '${_hours.toInt()}'
                        : _hours.toStringAsFixed(1),
                    style: GoogleFonts.inter(
                      fontSize: 56,
                      fontWeight: FontWeight.w700,
                      color: AppColors.accent,
                    ),
                  ),
                  Text(
                    'hours',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // ── Slider ──────────────────────────────────────
            Row(
              children: [
                Text(
                  '4h',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                Expanded(
                  child: SliderTheme(
                    data: SliderThemeData(
                      activeTrackColor: AppColors.accent,
                      inactiveTrackColor:
                          AppColors.surface.withValues(alpha: 0.15),
                      thumbColor: AppColors.accent,
                      overlayColor: AppColors.accent.withValues(alpha: 0.15),
                      trackHeight: 4,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 12,
                      ),
                    ),
                    child: Slider(
                      value: _hours,
                      min: 4,
                      max: 12,
                      divisions: 16, // 0.5h steps
                      onChanged: (value) => setState(() => _hours = value),
                    ),
                  ),
                ),
                Text(
                  '12h',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ── Recommended badge ─────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.surface.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _getSleepLabel(),
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ),

            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }

  String _getSleepLabel() {
    if (_hours < 6) return '⚠️ Less than recommended';
    if (_hours <= 8) return '✅ Recommended range (7-8h)';
    return '😴 Extra recovery time';
  }
}
