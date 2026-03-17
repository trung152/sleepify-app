import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/providers/active_sounds_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../library/presentation/providers/library_notifier.dart';
import '../../../library/presentation/widgets/save_mix_bottom_sheet.dart';
import 'sleep_timer_screen.dart';

/// Current Mix — Full screen player.
///
/// Shows active sounds with volume sliders, play/pause controls,
/// timer and add sound buttons. Slides up from bottom via [show].
class CurrentMixScreen extends ConsumerStatefulWidget {
  const CurrentMixScreen({super.key});

  @override
  ConsumerState<CurrentMixScreen> createState() => _CurrentMixScreenState();

  /// Navigate to this screen with a slide-up animation.
  static void show(BuildContext context) {
    Navigator.of(context).push(_slideUpRoute());
  }

  static Route<void> _slideUpRoute() {
    return PageRouteBuilder<void>(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const CurrentMixScreen(),
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
            begin: const Offset(0, 1), // Start from bottom
            end: Offset.zero,
          ).animate(curved),
          child: child,
        );
      },
    );
  }
}

class _CurrentMixScreenState extends ConsumerState<CurrentMixScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(activeSoundsProvider);
    final entries = state.activeSounds.entries.toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0F1923),
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ──────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 50),
              child: Row(
                children: [
                  // Down-arrow dismiss button
                  _HeaderIconButton(
                    icon: Icons.keyboard_arrow_down_rounded,
                    onTap: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  // Centered title
                  Text(
                    'Current Mix',
                    style: GoogleFonts.manrope(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  // Save / Bookmark button
                  _HeaderIconButton(
                    icon: Icons.bookmark_border_rounded,
                    onTap: () => _showSaveMixSheet(context, ref),
                  ),
                ],
              ),
            ),

            // ── Sound List ─────────────────────────────────
            Expanded(
              child: entries.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: entries.length + 1, // +1 for CLEAR ALL MIX
                      itemBuilder: (context, index) {
                        if (index < entries.length) {
                          final entry = entries[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _SoundRow(
                              id: entry.key,
                              label: entry.value,
                              volume: state.getVolume(entry.key),
                              onVolumeChanged: (v) {
                                ref
                                    .read(activeSoundsProvider.notifier)
                                    .setVolume(entry.key, v);
                              },
                              onRemove: () {
                                ref
                                    .read(activeSoundsProvider.notifier)
                                    .toggleSound(entry.key, entry.value);
                              },
                            ),
                          );
                        }
                        // ── CLEAR ALL MIX button ──────────────
                        return _buildClearAllButton();
                      },
                    ),
            ),

            // ── Controls Bar ───────────────────────────────
            _ControlsBar(
              isPlaying: state.isPlaying,
              onPlayPause: () {
                ref.read(activeSoundsProvider.notifier).togglePlayback();
              },
              onTimer: () async {
                final result = await SleepTimerScreen.show(context);
                if (result != null) {
                  // TODO: start actual sleep timer with duration
                  debugPrint(
                    'Sleep timer: ${result.hours}h ${result.minutes}m, '
                    'fade out: ${result.fadeOutSeconds}s, '
                    'vibrate: ${result.vibrate}',
                  );
                }
              },
              onAddSound: () {
                Navigator.pop(context);
                // Navigate back to Sounds tab
              },
            ),

            const SizedBox(height: 8),

            // ── Footer note ────────────────────────────────
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.headphones_rounded,
                    size: 14,
                    color: AppColors.textSecondary.withValues(alpha: 0.3),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Optimization for AirPods Pro',
                    style: GoogleFonts.manrope(
                      fontSize: 11,
                      color: AppColors.textSecondary.withValues(alpha: 0.3),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.music_off_rounded,
            size: 48,
            color: AppColors.accent.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 12),
          Text(
            'No sounds in mix',
            style: GoogleFonts.manrope(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  void _showSaveMixSheet(BuildContext context, WidgetRef ref) {
    final state = ref.read(activeSoundsProvider);
    if (!state.hasActiveSounds) return;

    // Suggest a name from the sound labels
    final defaultName = state.labels.take(3).join(', ');

    SaveMixBottomSheet.show(
      context,
      defaultName: defaultName,
      onSave: (name) async {
        final saved = await ref
            .read(libraryProvider.notifier)
            .saveMix(
              name: name,
              sounds: state.activeSounds,
              volumes: state.volumes,
            );

        if (saved && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Mix "$name" saved to Library!',
                style: GoogleFonts.manrope(),
              ),
              backgroundColor: const Color(0xFF1A2332),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildClearAllButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Center(
        child: GestureDetector(
          onTap: () {
            ref.read(activeSoundsProvider.notifier).clearAll();
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColors.surface.withValues(alpha: 0.15),
              ),
            ),
            child: Text(
              'CLEAR ALL MIX',
              style: GoogleFonts.manrope(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Header icon button (circular, subtle background)
// ─────────────────────────────────────────────────────────────────────────────

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.surface.withValues(alpha: 0.08),
        ),
        child: Icon(icon, color: AppColors.textSecondary, size: 20),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Sound row: Stitch "Refined Item Style"
// Top row: icon + name + percentage + close
// Bottom: full-width gradient slider (cyan → purple)
// ─────────────────────────────────────────────────────────────────────────────

class _SoundRow extends StatelessWidget {
  const _SoundRow({
    required this.id,
    required this.label,
    required this.volume,
    required this.onVolumeChanged,
    required this.onRemove,
  });

  final String id;
  final String label;
  final double volume;
  final ValueChanged<double> onVolumeChanged;
  final VoidCallback onRemove;

  IconData _iconFor(String soundId) {
    const map = {
      'rain': Icons.water_drop,
      'waves': Icons.waves,
      'fire': Icons.local_fire_department,
      'piano': Icons.piano,
      'wind': Icons.air,
      'forest': Icons.park,
      'birds': Icons.flutter_dash,
      'noise': Icons.blur_on,
      'storm': Icons.thunderstorm,
      'river': Icons.water,
      'night': Icons.nightlight,
      'cafe': Icons.coffee,
    };
    return map[soundId] ?? Icons.music_note;
  }

  @override
  Widget build(BuildContext context) {
    final pct = (volume * 100).round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Top row: icon + name + pct + close ──
        Row(
          children: [
            // Compact icon circle (dark teal bg)
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF0D2424),
              ),
              child: Icon(_iconFor(id), size: 22, color: AppColors.accent),
            ),
            const SizedBox(width: 12),

            // Sound name
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.manrope(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // Volume percentage
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Text(
                '$pct%',
                style: GoogleFonts.manrope(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary.withValues(alpha: 0.6),
                ),
              ),
            ),

            // Close / remove button
            GestureDetector(
              onTap: onRemove,
              behavior: HitTestBehavior.opaque,
              child: SizedBox(
                width: 32,
                height: 32,
                child: Center(
                  child: Icon(
                    Icons.close_rounded,
                    size: 18,
                    color: AppColors.textSecondary.withValues(alpha: 0.45),
                  ),
                ),
              ),
            ),
          ],
        ),

        // ── Full-width gradient slider ──
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 3,
            trackShape: _GradientSliderTrackShape(
              activeGradient: const LinearGradient(
                colors: [Color(0xFF00E5FF), Color(0xFFB06AB3)],
              ),
              inactiveColor: AppColors.surface.withValues(alpha: 0.08),
            ),
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 6,
              elevation: 2,
              pressedElevation: 4,
            ),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
            thumbColor: Colors.white,
            overlayColor: Colors.white.withValues(alpha: 0.12),
            // Active/inactive colors are handled by custom track shape
            activeTrackColor: AppColors.accent,
            inactiveTrackColor: Colors.transparent,
          ),
          child: Slider(value: volume, onChanged: onVolumeChanged),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Custom slider track that paints a gradient on the active portion
// ─────────────────────────────────────────────────────────────────────────────

class _GradientSliderTrackShape extends SliderTrackShape {
  const _GradientSliderTrackShape({
    required this.activeGradient,
    required this.inactiveColor,
  });

  final LinearGradient activeGradient;
  final Color inactiveColor;

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 3;
    final double trackLeft = offset.dx + 8;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width - 16;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isEnabled = false,
    bool isDiscrete = false,
    required TextDirection textDirection,
  }) {
    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
    );
    final double radius = trackRect.height / 2;

    // ── Inactive track (full width, behind) ──
    final inactivePaint = Paint()..color = inactiveColor;
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(trackRect, Radius.circular(radius)),
      inactivePaint,
    );

    // ── Active track (gradient, up to thumb) ──
    final activeRect = Rect.fromLTRB(
      trackRect.left,
      trackRect.top,
      thumbCenter.dx,
      trackRect.bottom,
    );

    if (activeRect.width > 0) {
      final gradientPaint = Paint()
        ..shader = activeGradient.createShader(activeRect);
      context.canvas.drawRRect(
        RRect.fromRectAndRadius(activeRect, Radius.circular(radius)),
        gradientPaint,
      );
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Bottom controls: Timer | Play/Pause | Add Sound
// ─────────────────────────────────────────────────────────────────────────────

class _ControlsBar extends StatelessWidget {
  const _ControlsBar({
    required this.isPlaying,
    required this.onPlayPause,
    required this.onTimer,
    required this.onAddSound,
  });

  final bool isPlaying;
  final VoidCallback onPlayPause;
  final VoidCallback onTimer;
  final VoidCallback onAddSound;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Timer
          _ControlButton(
            icon: Icons.timer_outlined,
            label: '30 MIN',
            onTap: onTimer,
          ),

          // Play/Pause — large cyan glow
          GestureDetector(
            onTap: onPlayPause,
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.4),
                    blurRadius: 24,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Icon(
                isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                color: AppColors.background,
                size: 32,
              ),
            ),
          ),

          // Add Sound
          _ControlButton(
            icon: Icons.library_add_rounded,
            label: 'ADD SOUND',
            onTap: onAddSound,
          ),
        ],
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  const _ControlButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.surface.withValues(alpha: 0.08),
            ),
            child: Icon(icon, color: AppColors.textSecondary, size: 22),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary.withValues(alpha: 0.6),
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
