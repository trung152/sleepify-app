import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../providers/library_notifier.dart';
import '../widgets/saved_mix_card.dart';

/// Library screen with Favorites / My Mixes tabbed layout.
///
/// Matches the Stitch design: segmented tab control at top,
/// list of saved mix cards in "My Mixes" tab, placeholder in "Favorites".
class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({super.key});

  @override
  ConsumerState<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends ConsumerState<LibraryScreen> {
  int _tabIndex = 1; // Default to My Mixes

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0D1B2A), AppColors.background],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Text(
                'Library',
                style: GoogleFonts.manrope(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ── Tab bar ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _SegmentedTabs(
                selectedIndex: _tabIndex,
                onChanged: (i) => setState(() => _tabIndex = i),
              ),
            ),
            const SizedBox(height: 20),

            // ── Tab content ──
            Expanded(
              child: _tabIndex == 0
                  ? _buildFavoritesTab()
                  : _buildMyMixesTab(),
            ),

            // Space for nav bar + mini player
            const SizedBox(height: 140),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoritesTab() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.favorite_border_rounded,
            size: 48,
            color: AppColors.accent.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 12),
          Text(
            'No favorites yet',
            style: GoogleFonts.manrope(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Your favorite sounds will appear here',
            style: GoogleFonts.manrope(
              fontSize: 13,
              color: AppColors.textSecondary.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyMixesTab() {
    final mixesAsync = ref.watch(libraryProvider);

    return mixesAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppColors.accent),
      ),
      error: (e, _) => Center(
        child: Text(
          'Error: $e',
          style: const TextStyle(color: AppColors.error),
        ),
      ),
      data: (mixes) {
        if (mixes.isEmpty) {
          return _buildEmptyMixes();
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: mixes.length + 1, // +1 for "Create New Mix"
          itemBuilder: (context, index) {
            if (index < mixes.length) {
              final mix = mixes[index];
              return SavedMixCard(
                mix: mix,
                onPlay: () {
                  ref.read(libraryProvider.notifier).loadMix(mix);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Playing "${mix.name}"',
                        style: GoogleFonts.manrope(),
                      ),
                      backgroundColor: const Color(0xFF1A2332),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
                onDelete: () => _confirmDelete(mix.id, mix.name),
              );
            }

            // ── "Create New Mix" card ──
            return _buildCreateNewMixCard();
          },
        );
      },
    );
  }

  Widget _buildEmptyMixes() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.library_music_outlined,
            size: 48,
            color: AppColors.accent.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 12),
          Text(
            'No mixes saved',
            style: GoogleFonts.manrope(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Create a mix and save it from the player',
            style: GoogleFonts.manrope(
              fontSize: 13,
              color: AppColors.textSecondary.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateNewMixCard() {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 16),
      child: GestureDetector(
        onTap: () {
          // Navigate to Sounds tab (index 1 on shell)
          // This is handled by going back to shell and switching tab
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Go to Sounds tab to create a new mix!',
                style: GoogleFonts.manrope(),
              ),
              backgroundColor: const Color(0xFF1A2332),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        },
        child: Container(
          height: 72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.accent.withValues(alpha: 0.2),
              width: 1.5,
              // Dashed effect via custom painting is complex;
              // using a prominent accent border as a visual cue instead.
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accent.withValues(alpha: 0.1),
                ),
                child: const Icon(
                  Icons.add_rounded,
                  size: 20,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Create New Mix',
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.accent.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDelete(String id, String name) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A2332),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Delete Mix',
          style: GoogleFonts.manrope(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        content: Text(
          'Delete "$name"? This cannot be undone.',
          style: GoogleFonts.manrope(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancel',
              style: GoogleFonts.manrope(color: AppColors.textSecondary),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ref.read(libraryProvider.notifier).deleteMix(id);
            },
            child: Text(
              'Delete',
              style: GoogleFonts.manrope(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Segmented tab control (Favorites / My Mixes)
// ─────────────────────────────────────────────────────────────────────────────

class _SegmentedTabs extends StatelessWidget {
  const _SegmentedTabs({
    required this.selectedIndex,
    required this.onChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  static const _tabs = ['Favorites', 'My Mixes'];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: 44,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.surface.withValues(alpha: 0.08),
            ),
          ),
          child: Row(
            children: List.generate(_tabs.length, (i) {
              final isSelected = i == selectedIndex;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onChanged(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.accent
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Text(
                      _tabs[i],
                      style: GoogleFonts.manrope(
                        fontSize: 13,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected
                            ? const Color(0xFF0B0F19)
                            : AppColors.textSecondary.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
