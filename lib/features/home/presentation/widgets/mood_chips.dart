import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';

/// Horizontal scrolling mood/filter chips.
///
/// Allows user to filter content by mood category.
class MoodChips extends StatefulWidget {
  const MoodChips({super.key});

  @override
  State<MoodChips> createState() => _MoodChipsState();
}

class _MoodChipsState extends State<MoodChips> {
  int _selectedIndex = 0;

  static const List<String> _moods = [
    'All',
    'Relax',
    'Deep Sleep',
    'Focus',
    'Peaceful',
    'Piano',
    'Nature',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _moods.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = index == _selectedIndex;
          return GestureDetector(
            onTap: () => setState(() => _selectedIndex = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.accent.withValues(alpha: 0.15)
                    : AppColors.surface.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? AppColors.accent.withValues(alpha: 0.5)
                      : AppColors.surface.withValues(alpha: 0.1),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                _moods[index],
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? AppColors.accent
                      : AppColors.textSecondary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
