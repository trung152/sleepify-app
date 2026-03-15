import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/models/sound.dart';

/// Vertical ranked list for "Top 5 Selection" — Stitch design.
///
/// Each item is a glassmorphism card with circular thumbnail,
/// rank badge overlay, title, artist, and options icon.
class Top5List extends StatelessWidget {
  const Top5List({super.key, required this.sounds});

  final List<Sound> sounds;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(sounds.length, (index) {
        final sound = sounds[index];
        final rank = index + 1;
        return Padding(
          padding: EdgeInsets.only(bottom: index < sounds.length - 1 ? 10 : 0),
          child: _Top5Tile(sound: sound, rank: rank),
        );
      }),
    );
  }
}

class _Top5Tile extends StatelessWidget {
  const _Top5Tile({required this.sound, required this.rank});

  final Sound sound;
  final int rank;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: play sound
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surface.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.surface.withValues(alpha: 0.08),
          ),
        ),
        child: Row(
          children: [
            // ── Circular thumbnail + rank badge ──────────────
            SizedBox(
              width: 56,
              height: 56,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Thumbnail
                  ClipOval(
                    child: Image.asset(
                      sound.thumbnailPath,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Rank badge
                  Positioned(
                    bottom: -2,
                    right: -2,
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.accent,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        rank.toString().padLeft(2, '0'),
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.background,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 14),

            // ── Title + Subtitle ─────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sound.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    sound.artist.isNotEmpty
                        ? '${sound.artist} • ${sound.category}'
                        : sound.category,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppColors.textSecondary.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),

            // ── More options ─────────────────────────────────
            Icon(
              Icons.more_vert,
              color: AppColors.textSecondary.withValues(alpha: 0.5),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
