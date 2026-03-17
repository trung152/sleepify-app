import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/models/saved_mix.dart';

/// Glassmorphism card displaying a saved mix in the Library.
///
/// Shows: circular sound icon, mix name, comma-separated sound list,
/// and a play button on the right. Matches the Stitch "My Mixes" design.
class SavedMixCard extends StatelessWidget {
  const SavedMixCard({
    super.key,
    required this.mix,
    required this.onPlay,
    this.onDelete,
  });

  final SavedMix mix;
  final VoidCallback onPlay;
  final VoidCallback? onDelete;

  /// Pick an icon based on the first sound in the mix.
  IconData _iconForMix() {
    if (mix.sounds.isEmpty) return Icons.music_note;
    final firstId = mix.sounds.keys.first;
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
    return map[firstId] ?? Icons.music_note;
  }

  @override
  Widget build(BuildContext context) {
    final soundNames = mix.sounds.values.join(', ');

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.surface.withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.surface.withValues(alpha: 0.1),
              ),
            ),
            child: Row(
              children: [
                // ── Circular icon ──
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.accent.withValues(alpha: 0.2),
                        const Color(0xFF7C4DFF).withValues(alpha: 0.15),
                      ],
                    ),
                  ),
                  child: Icon(
                    _iconForMix(),
                    size: 22,
                    color: AppColors.accent,
                  ),
                ),
                const SizedBox(width: 14),

                // ── Name + sound list ──
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mix.name,
                        style: GoogleFonts.manrope(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        soundNames,
                        style: GoogleFonts.manrope(
                          fontSize: 12,
                          color: AppColors.textSecondary.withValues(alpha: 0.6),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // ── Delete button ──
                if (onDelete != null)
                  GestureDetector(
                    onTap: onDelete,
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Icon(
                        Icons.delete_outline_rounded,
                        size: 20,
                        color: AppColors.textSecondary.withValues(alpha: 0.4),
                      ),
                    ),
                  ),

                const SizedBox(width: 4),

                // ── Play button ──
                GestureDetector(
                  onTap: onPlay,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.accent.withValues(alpha: 0.15),
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      color: AppColors.accent,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
