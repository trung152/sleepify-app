import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../theme/app_colors.dart';

/// Reusable glassmorphism [BoxDecoration] for Sleepify cards & surfaces.
BoxDecoration glassDecoration({
  double borderRadius = AppConstants.glassBorderRadius,
  double surfaceOpacity = AppConstants.glassSurfaceOpacity,
  double borderOpacity = AppConstants.glassBorderOpacity,
}) {
  return BoxDecoration(
    color: AppColors.surface.withValues(alpha: surfaceOpacity),
    borderRadius: BorderRadius.circular(borderRadius),
    border: Border.all(
      color: AppColors.surface.withValues(alpha: borderOpacity),
      width: AppConstants.glassBorderWidth,
    ),
  );
}
