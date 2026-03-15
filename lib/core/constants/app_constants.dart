/// App-wide constants for Sleepify.
abstract final class AppConstants {
  static const String appName = 'Sleepify';
  static const String appVersion = '0.1.0';

  // ── Glassmorphism tokens ─────────────────────────────────────────
  static const double glassBlur = 24.0;
  static const double glassBlurHigh = 30.0;
  static const double glassBorderRadius = 24.0;
  static const double glassBorderRadiusLarge = 32.0;
  static const double glassBorderWidth = 1.0;
  static const double glassSurfaceOpacity = 0.08; // 5-10%
  static const double glassBorderOpacity = 0.10; // 8-12%

  // ── Animation durations ──────────────────────────────────────────
  static const Duration animFast = Duration(milliseconds: 200);
  static const Duration animMedium = Duration(milliseconds: 350);
  static const Duration animSlow = Duration(milliseconds: 500);

  // ── Layout ───────────────────────────────────────────────────────
  static const double screenPadding = 20.0;
  static const double cardPadding = 16.0;
  static const double iconSizeSmall = 20.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;
}
