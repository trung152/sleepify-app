import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/providers/onboarding_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/onboarding_scaffold.dart';

/// Onboarding Step 4 — Notification permission.
///
/// User can enable notifications or skip.
/// Marks onboarding as complete.
class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OnboardingScaffold(
      currentStep: 4,
      totalSteps: 4,
      title: 'Get notified for better rest',
      subtitle:
          "Stay on track with your sleep goals. We'll send you gentle reminders to wind down and celebrate your daily progress.",
      onBack: () => context.go('/onboarding/sleep-hours'),
      onContinue: () => _enableNotifications(context, ref),
      continueLabel: 'Enable Notifications',
      bottomWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: TextButton(
            onPressed: () => _skip(context, ref),
            child: Text(
              "I'll do it later",
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary.withValues(alpha: 0.6),
              ),
            ),
          ),
        ),
      ),
      content: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Illustration ─────────────────────────────────
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent.withValues(alpha: 0.08),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.15),
                    blurRadius: 40,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: Icon(
                Icons.notifications_active_outlined,
                size: 56,
                color: AppColors.accent,
              ),
            ),

            const SizedBox(height: 28),

            // ── Feature list ─────────────────────────────────
            _FeatureRow(
              icon: Icons.home_outlined,
              label: 'Bedtime reminders',
            ),
            const SizedBox(height: 12),
            _FeatureRow(
              icon: Icons.bedtime_outlined,
              label: 'Sleep quality insights',
            ),
            const SizedBox(height: 12),
            _FeatureRow(
              icon: Icons.bar_chart_outlined,
              label: 'Weekly progress reports',
            ),
            const SizedBox(height: 12),
            _FeatureRow(
              icon: Icons.person_outlined,
              label: 'Personalized suggestions',
            ),
          ],
        ),
      ),
    );
  }

  void _enableNotifications(BuildContext context, WidgetRef ref) {
    // TODO: Request OS notification permission
    _completeOnboarding(context, ref);
  }

  void _skip(BuildContext context, WidgetRef ref) {
    _completeOnboarding(context, ref);
  }

  void _completeOnboarding(BuildContext context, WidgetRef ref) {
    ref.read(onboardingStatusProvider.notifier).markOnboarded();
    context.go('/home');
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.accent.withValues(alpha: 0.1),
          ),
          child: Icon(icon, color: AppColors.accent, size: 20),
        ),
        const SizedBox(width: 14),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }
}
