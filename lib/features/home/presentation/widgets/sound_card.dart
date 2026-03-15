import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/models/sound.dart';

/// Horizontal scrollable sound card for Home sections.
///
/// Shows thumbnail, name, and artist in a compact card.
class SoundCard extends StatelessWidget {
  const SoundCard({super.key, required this.sound});

  final Sound sound;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: play sound / add to mix
      },
      child: SizedBox(
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                image: DecorationImage(
                  image: AssetImage(sound.thumbnailPath),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              // Premium lock overlay
              child: sound.isPremium
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.black.withValues(alpha: 0.4),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.lock_outline,
                          color: AppColors.gold,
                          size: 28,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(height: 8),
            // Name
            Text(
              sound.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
            if (sound.artist.isNotEmpty)
              Text(
                sound.artist,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: AppColors.textSecondary.withValues(alpha: 0.7),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
