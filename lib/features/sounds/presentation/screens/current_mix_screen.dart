import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/providers/active_sounds_provider.dart';
import '../../../../core/theme/app_colors.dart';
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
  // Local volume map (0.0 – 1.0) per sound ID
  final Map<String, double> _volumes = {};

  double _getVolume(String id) => _volumes[id] ?? 0.8;

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
                    onTap: () {
                      // TODO: save current mix
                    },
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
                              volume: _getVolume(entry.key),
                              onVolumeChanged: (v) {
                                setState(() => _volumes[entry.key] = v);
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
// Sound row: icon + name + percentage + slider + remove
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

    return Row(
      children: [
        // Icon circle
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.accent.withValues(alpha: 0.12),
          ),
          child: Icon(_iconFor(id), size: 24, color: AppColors.accent),
        ),
        const SizedBox(width: 14),

        // Name + slider
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title row with percentage
              Row(
                children: [
                  Expanded(
                    child: Text(
                      label,
                      style: GoogleFonts.manrope(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '$pct%',
                    style: GoogleFonts.manrope(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.accent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              // Volume slider
              SliderTheme(
                data: SliderThemeData(
                  trackHeight: 4,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 0,
                  ),
                  overlayShape: const RoundSliderOverlayShape(
                    overlayRadius: 12,
                  ),
                  activeTrackColor: AppColors.accent,
                  inactiveTrackColor: AppColors.surface.withValues(alpha: 0.1),
                  thumbColor: Colors.transparent,
                  overlayColor: AppColors.accent.withValues(alpha: 0.15),
                  trackShape: const RoundedRectSliderTrackShape(),
                ),
                child: Slider(value: volume, onChanged: onVolumeChanged),
              ),
            ],
          ),
        ),
        const SizedBox(width: 4),

        // Remove button — larger tap target
        GestureDetector(
          onTap: onRemove,
          behavior: HitTestBehavior.opaque,
          child: SizedBox(
            width: 36,
            height: 36,
            child: Center(
              child: Icon(
                Icons.close_rounded,
                size: 20,
                color: AppColors.textSecondary.withValues(alpha: 0.5),
              ),
            ),
          ),
        ),
      ],
    );
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
