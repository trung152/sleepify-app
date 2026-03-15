import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/onboarding_scaffold.dart';

/// Onboarding Step 2 — Bedtime selection.
///
/// User selects their typical bedtime range.
class BedtimeScreen extends ConsumerStatefulWidget {
  const BedtimeScreen({super.key});

  @override
  ConsumerState<BedtimeScreen> createState() => _BedtimeScreenState();
}

class _BedtimeScreenState extends ConsumerState<BedtimeScreen> {
  String _selectedBedtime = '10pm_12am'; // default

  static const List<_BedtimeOption> _options = [
    _BedtimeOption(
      id: '9pm_10pm',
      label: '9 PM - 10 PM',
      subtitle: 'Early Bird Enthusiast',
      icon: Icons.wb_sunny_outlined,
    ),
    _BedtimeOption(
      id: '10pm_12am',
      label: '10 PM - 12 AM',
      subtitle: 'Balanced & Consistent',
      icon: Icons.nights_stay_outlined,
    ),
    _BedtimeOption(
      id: '12am_2am',
      label: '12 AM - 2 AM',
      subtitle: 'Night Owl Energy',
      icon: Icons.dark_mode_outlined,
    ),
    _BedtimeOption(
      id: 'after_2am',
      label: 'After 2 AM',
      subtitle: 'Extreme Night Shift',
      icon: Icons.bedtime_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      currentStep: 2,
      totalSteps: 4,
      title: 'When do you usually sleep?',
      subtitle:
          'Select your typical bedtime to help us optimize your circadian rhythm.',
      onBack: () => context.go('/onboarding/goal'),
      onContinue: () => context.go('/onboarding/sleep-hours'),
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
      content: ListView.separated(
        itemCount: _options.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final option = _options[index];
          final isSelected = option.id == _selectedBedtime;
          return GestureDetector(
            onTap: () => setState(() => _selectedBedtime = option.id),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.accent.withValues(alpha: 0.12)
                    : AppColors.surface.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected
                      ? AppColors.accent.withValues(alpha: 0.5)
                      : AppColors.surface.withValues(alpha: 0.1),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? AppColors.accent.withValues(alpha: 0.2)
                          : AppColors.surface.withValues(alpha: 0.1),
                    ),
                    child: Icon(
                      option.icon,
                      color: isSelected
                          ? AppColors.accent
                          : AppColors.textSecondary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          option.label,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? AppColors.textPrimary
                                : AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          option.subtitle,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: AppColors.textSecondary
                                .withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    Icon(
                      Icons.check_circle,
                      color: AppColors.accent,
                      size: 24,
                    )
                  else
                    Icon(
                      Icons.circle_outlined,
                      color: AppColors.surface.withValues(alpha: 0.2),
                      size: 24,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BedtimeOption {
  const _BedtimeOption({
    required this.id,
    required this.label,
    required this.subtitle,
    required this.icon,
  });
  final String id;
  final String label;
  final String subtitle;
  final IconData icon;
}
