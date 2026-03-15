import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';

/// A glassmorphism card with blur backdrop and thin light border.
///
/// Usage:
/// ```dart
/// GlassCard(
///   child: Text('Content'),
/// )
/// ```
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? AppConstants.glassBorderRadius;

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: AppConstants.glassBlur,
            sigmaY: AppConstants.glassBlur,
          ),
          child: Container(
            padding: padding ?? const EdgeInsets.all(AppConstants.cardPadding),
            decoration: BoxDecoration(
              color: AppColors.surface.withValues(
                alpha: AppConstants.glassSurfaceOpacity,
              ),
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(
                color: AppColors.surface.withValues(
                  alpha: AppConstants.glassBorderOpacity,
                ),
                width: AppConstants.glassBorderWidth,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
