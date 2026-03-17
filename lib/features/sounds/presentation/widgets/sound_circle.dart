import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';

/// Circular sound button — matches Stitch Sounds Mixer design.
///
/// Inactive: muted circle with outline icon.
/// Active: cyan ring glow + filled icon + cyan label.
/// Premium: gold crown badge at top-right.
///
/// Uses LayoutBuilder + FractionallySizedBox to prevent overflow
/// on smaller screens.
class SoundCircle extends StatelessWidget {
  const SoundCircle({
    super.key,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
    this.isPremium = false,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final bool isPremium;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Circle takes 75% of available width, capped at 90px
          final circleSize =
              (constraints.maxWidth * 0.75).clamp(50.0, 90.0);
          final iconSize = circleSize * 0.31;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Circle with glow ────────────────────────────
              Stack(
                clipBehavior: Clip.none,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOut,
                    width: circleSize,
                    height: circleSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActive
                          ? AppColors.accent.withValues(alpha: 0.12)
                          : AppColors.surface.withValues(alpha: 0.06),
                      border: Border.all(
                        color: isActive
                            ? AppColors.accent.withValues(alpha: 0.6)
                            : AppColors.surface.withValues(alpha: 0.12),
                        width: isActive ? 2 : 1,
                      ),
                      boxShadow: isActive
                          ? [
                              BoxShadow(
                                color:
                                    AppColors.accent.withValues(alpha: 0.25),
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                            ]
                          : null,
                    ),
                    child: Icon(
                      icon,
                      size: iconSize,
                      color: isActive
                          ? AppColors.accent
                          : AppColors.textSecondary.withValues(alpha: 0.6),
                    ),
                  ),

                  // Active dot indicator on ring
                  if (isActive)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.accent,
                          border: Border.all(
                              color: AppColors.background, width: 2),
                        ),
                      ),
                    ),

                  // Premium crown badge
                  if (isPremium)
                    Positioned(
                      top: -2,
                      right: -2,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.gold,
                        ),
                        child: const Icon(
                          Icons.star_rounded,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 6),

              // ── Label ──────────────────────────────────────
              Text(
                label.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  color: isActive
                      ? AppColors.accent
                      : AppColors.textSecondary.withValues(alpha: 0.5),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
