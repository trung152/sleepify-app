import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';

/// Sleep Timer — Full screen with scroll-wheel time picker.
///
/// Shows hour/minute scroll wheels, ending sound, fade out stepper,
/// vibration toggle, and START TIMER button.
/// Slides up from bottom via [show]. Matches Stitch "Advanced Sleep Timer".
class SleepTimerScreen extends StatefulWidget {
  const SleepTimerScreen({super.key});

  /// Navigate to this screen with a slide-up animation.
  static Future<SleepTimerResult?> show(BuildContext context) {
    return Navigator.of(context).push<SleepTimerResult>(_slideUpRoute());
  }

  static Route<SleepTimerResult> _slideUpRoute() {
    return PageRouteBuilder<SleepTimerResult>(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const SleepTimerScreen(),
      transitionDuration: const Duration(milliseconds: 350),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        );
      },
    );
  }

  @override
  State<SleepTimerScreen> createState() => _SleepTimerScreenState();
}

/// Result returned when user starts the timer.
class SleepTimerResult {
  const SleepTimerResult({
    required this.hours,
    required this.minutes,
    required this.fadeOutSeconds,
    required this.vibrate,
  });

  final int hours;
  final int minutes;
  final int fadeOutSeconds;
  final bool vibrate;

  int get totalMinutes => hours * 60 + minutes;
}

class _SleepTimerScreenState extends State<SleepTimerScreen> {
  late final FixedExtentScrollController _hoursController;
  late final FixedExtentScrollController _minutesController;

  int _selectedHours = 0;
  int _selectedMinutes = 30;
  int _fadeOutSeconds = 7;
  bool _vibrate = true;

  @override
  void initState() {
    super.initState();
    _hoursController = FixedExtentScrollController(initialItem: _selectedHours);
    _minutesController = FixedExtentScrollController(
      initialItem: _selectedMinutes,
    );
  }

  @override
  void dispose() {
    _hoursController.dispose();
    _minutesController.dispose();
    super.dispose();
  }

  void _startTimer() {
    if (_selectedHours == 0 && _selectedMinutes == 0) return;
    Navigator.pop(
      context,
      SleepTimerResult(
        hours: _selectedHours,
        minutes: _selectedMinutes,
        fadeOutSeconds: _fadeOutSeconds,
        vibrate: _vibrate,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1019),
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ──────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    behavior: HitTestBehavior.opaque,
                    child: SizedBox(
                      width: 36,
                      height: 36,
                      child: Center(
                        child: Icon(
                          Icons.close_rounded,
                          color: AppColors.textSecondary,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'SLEEP TIMER',
                    style: GoogleFonts.manrope(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textSecondary,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      // TODO: Timer settings
                    },
                    behavior: HitTestBehavior.opaque,
                    child: SizedBox(
                      width: 36,
                      height: 36,
                      child: Center(
                        child: Icon(
                          Icons.settings_outlined,
                          color: AppColors.textSecondary,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── Time Picker ─────────────────────────────────
            Expanded(
              child: Column(
                children: [
                  // Scroll wheel area
                  SizedBox(height: 240, child: _buildTimePicker()),

                  const SizedBox(height: 22),

                  // ── Settings Section ──────────────────────
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          // Ending Sound
                          _SettingTile(
                            icon: Icons.music_note_rounded,
                            title: 'Ending Sound',
                            trailing: GestureDetector(
                              onTap: () {
                                // TODO: Pick ending sound
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'None',
                                    style: GoogleFonts.manrope(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: AppColors.textSecondary.withValues(
                                      alpha: 0.5,
                                    ),
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Fade Out
                          _SettingTile(
                            icon: Icons.graphic_eq_rounded,
                            title: 'Fade Out',
                            subtitle: 'Length sounds will fade out',
                            trailing: _StepperControl(
                              value: _fadeOutSeconds,
                              unit: 'Sec',
                              onDecrement: () {
                                if (_fadeOutSeconds > 1) {
                                  setState(() => _fadeOutSeconds--);
                                }
                              },
                              onIncrement: () {
                                if (_fadeOutSeconds < 60) {
                                  setState(() => _fadeOutSeconds++);
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Vibration
                          _SettingTile(
                            icon: Icons.vibration_rounded,
                            title: 'Vibration',
                            subtitle: 'Phone will vibrate at end of timer',
                            trailing: Switch.adaptive(
                              value: _vibrate,
                              onChanged: (v) => setState(() => _vibrate = v),
                              thumbColor: WidgetStateProperty.resolveWith(
                                (states) => states.contains(WidgetState.selected)
                                    ? AppColors.accent
                                    : AppColors.textSecondary,
                              ),
                              trackColor: WidgetStateProperty.resolveWith(
                                (states) => states.contains(WidgetState.selected)
                                    ? AppColors.accent.withValues(alpha: 0.3)
                                    : AppColors.surface.withValues(alpha: 0.15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Start Timer Button ──────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
              child: GestureDetector(
                onTap: _startTimer,
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: AppColors.accent,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accent.withValues(alpha: 0.35),
                        blurRadius: 24,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.play_arrow_rounded,
                        color: AppColors.background,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'START TIMER',
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.background,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ── Footer ─────────────────────────────────────
            Padding(
              padding: const EdgeInsets.only(bottom: 16, top: 8),
              child: Text(
                'DEVICE WILL LOCK AFTER TIME ENDS',
                style: GoogleFonts.manrope(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary.withValues(alpha: 0.35),
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePicker() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Hours wheel
          _ScrollWheel(
            controller: _hoursController,
            itemCount: 24,
            selectedValue: _selectedHours,
            onChanged: (v) => setState(() => _selectedHours = v),
            label: 'HOURS',
          ),

          // Colon separator
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Text(
              ':',
              style: GoogleFonts.manrope(
                fontSize: 48,
                fontWeight: FontWeight.w700,
                color: AppColors.accent,
              ),
            ),
          ),

          // Minutes wheel
          _ScrollWheel(
            controller: _minutesController,
            itemCount: 60,
            selectedValue: _selectedMinutes,
            onChanged: (v) => setState(() => _selectedMinutes = v),
            label: 'MINUTES',
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Scroll wheel for time selection
// ─────────────────────────────────────────────────────────────────────────────

class _ScrollWheel extends StatelessWidget {
  const _ScrollWheel({
    required this.controller,
    required this.itemCount,
    required this.selectedValue,
    required this.onChanged,
    required this.label,
  });

  final FixedExtentScrollController controller;
  final int itemCount;
  final int selectedValue;
  final ValueChanged<int> onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Column(
        children: [
          SizedBox(
            height: 180,
            child: ListWheelScrollView.useDelegate(
              controller: controller,
              itemExtent: 56,
              physics: const FixedExtentScrollPhysics(),
              squeeze: 0.8,
              perspective: 0.003,
              diameterRatio: 10,
              onSelectedItemChanged: onChanged,
              childDelegate: ListWheelChildBuilderDelegate(
                builder: (context, index) {
                  if (index < 0 || index >= itemCount) return null;
                  final isSelected = index == selectedValue;
                  return Center(
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: GoogleFonts.manrope(
                        fontSize: isSelected ? 48 : 46,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w400,
                        color: isSelected
                            ? AppColors.accent
                            : AppColors.textSecondary.withValues(alpha: 0.3),
                      ),
                      child: Text(index.toString().padLeft(2, '0')),
                    ),
                  );
                },
                childCount: itemCount,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary.withValues(alpha: 0.4),
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Setting tile
// ─────────────────────────────────────────────────────────────────────────────

class _SettingTile extends StatelessWidget {
  const _SettingTile({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.trailing,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.surface.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accent.withValues(alpha: 0.1),
            ),
            child: Icon(icon, color: AppColors.accent, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.manrope(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: GoogleFonts.manrope(
                      fontSize: 12,
                      color: AppColors.textSecondary.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Stepper control (− value +)
// ─────────────────────────────────────────────────────────────────────────────

class _StepperControl extends StatelessWidget {
  const _StepperControl({
    required this.value,
    required this.onDecrement,
    required this.onIncrement,
    this.unit = '',
  });

  final int value;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;
  final String unit;

  @override
  Widget build(BuildContext context) {
    final display = unit.isNotEmpty ? '$value $unit' : '$value';
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _stepButton(Icons.remove_rounded, onDecrement),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              display,
              style: GoogleFonts.manrope(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          _stepButton(Icons.add_rounded, onIncrement),
        ],
      ),
    );
  }

  Widget _stepButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Icon(icon, size: 18, color: AppColors.textSecondary),
      ),
    );
  }
}
