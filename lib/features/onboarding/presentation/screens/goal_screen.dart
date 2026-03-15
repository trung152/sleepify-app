import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/onboarding_scaffold.dart';

/// Onboarding Step 1 — Goal selection.
///
/// User selects one or more goals: Sleep, Relax, Focus, Breathe.
class GoalScreen extends ConsumerStatefulWidget {
  const GoalScreen({super.key});

  @override
  ConsumerState<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends ConsumerState<GoalScreen> {
  final Set<String> _selectedGoals = {};

  static const List<_GoalItem> _goals = [
    _GoalItem(id: 'sleep', label: 'Sleep', subtitle: 'Improve your sleep quality and cycles', icon: Icons.nightlight_round),
    _GoalItem(id: 'relax', label: 'Relax', subtitle: 'Unwind and reduce stress levels', icon: Icons.spa_outlined),
    _GoalItem(id: 'focus', label: 'Focus', subtitle: 'Deep concentration for work and study', icon: Icons.center_focus_strong_outlined),
    _GoalItem(id: 'breathe', label: 'Breathe', subtitle: 'Breathing exercises for mindfulness', icon: Icons.air_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      currentStep: 1,
      totalSteps: 4,
      title: 'What is your main goal today?',
      subtitle: 'Tailor your experience for better wellbeing.',
      onBack: () => context.go('/onboarding/language'),
      onContinue: () => context.go('/onboarding/bedtime'),
      isContinueEnabled: _selectedGoals.isNotEmpty,
      content: ListView.separated(
        itemCount: _goals.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final goal = _goals[index];
          final isSelected = _selectedGoals.contains(goal.id);
          return _GoalTile(
            goal: goal,
            isSelected: isSelected,
            onTap: () {
              setState(() {
                if (isSelected) {
                  _selectedGoals.remove(goal.id);
                } else {
                  _selectedGoals.add(goal.id);
                }
              });
            },
          );
        },
      ),
    );
  }
}

class _GoalTile extends StatelessWidget {
  const _GoalTile({
    required this.goal,
    required this.isSelected,
    required this.onTap,
  });

  final _GoalItem goal;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
            // Icon
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
                goal.icon,
                color: isSelected ? AppColors.accent : AppColors.textSecondary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    goal.label,
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
                    goal.subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            // Check
            if (isSelected)
              Icon(Icons.check_circle, color: AppColors.accent, size: 24)
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
  }
}

class _GoalItem {
  const _GoalItem({
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
