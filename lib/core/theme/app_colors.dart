import 'package:flutter/material.dart';

/// Sleepify color palette — Ultra-Premium Glassmorphism dark theme.
abstract final class AppColors {
  // ── Primary backgrounds ──────────────────────────────────────────
  static const Color background = Color(0xFF0B0F19); // Midnight Navy

  // ── Accents ──────────────────────────────────────────────────────
  static const Color accent = Color(0xFF00E5FF); // Neon Cyan
  static const Color gold = Color(0xFFFFD700); // Soft Gold

  // ── Surfaces (Glassmorphism) ─────────────────────────────────────
  static const Color surface = Colors.white; // Used at 5-10% opacity
  static const Color surfaceFill = Color(0x0DFFFFFF); // ~5% white
  static const Color surfaceBorder = Color(0x1FFFFFFF); // ~12% white

  // ── Text ─────────────────────────────────────────────────────────
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFB0BEC5);

  // ── Utility ──────────────────────────────────────────────────────
  static const Color error = Color(0xFFFF5252);
  static const Color success = Color(0xFF69F0AE);
}
