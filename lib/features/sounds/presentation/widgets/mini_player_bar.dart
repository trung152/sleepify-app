import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';

/// Floating mini player bar — matches Stitch design.
///
/// Shows when ≥1 sounds are active. Capsule shape, dark glass,
/// displays count and active sound names with play/pause + expand.
class MiniPlayerBar extends StatelessWidget {
  const MiniPlayerBar({
    super.key,
    required this.count,
    required this.labels,
    required this.isPlaying,
    required this.onPlayPause,
    required this.onExpand,
  });

  final int count;
  final List<String> labels;
  final bool isPlaying;
  final VoidCallback onPlayPause;
  final VoidCallback onExpand;

  @override
  Widget build(BuildContext context) {
    final subtitle = labels.join(' & ').toUpperCase();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: GestureDetector(
        onTap: onExpand,
        child: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF1A2332),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: AppColors.surface.withValues(alpha: 0.1),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Music icon
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accent.withValues(alpha: 0.15),
                ),
                child: Icon(
                  Icons.music_note_rounded,
                  color: AppColors.accent,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),

              // Text
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$count sound${count > 1 ? 's' : ''} playing',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    if (labels.isNotEmpty)
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary.withValues(alpha: 0.6),
                          letterSpacing: 0.5,
                        ),
                      ),
                  ],
                ),
              ),

              // Play/Pause button
              GestureDetector(
                onTap: onPlayPause,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accent,
                  ),
                  child: Icon(
                    isPlaying
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    color: AppColors.background,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // Expand chevron
              Icon(
                Icons.keyboard_arrow_up_rounded,
                color: AppColors.textSecondary.withValues(alpha: 0.5),
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
