import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/providers/active_sounds_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/sound_circle.dart';

/// Sounds Mixer screen — browse and mix ambient sounds.
///
/// Circular icon grid, tap to toggle active/inactive.
/// Active sounds glow cyan. Reads/writes global ActiveSoundsProvider.
class SoundsScreen extends ConsumerWidget {
  const SoundsScreen({super.key});

  static const List<_SoundItem> _sounds = [
    _SoundItem(
      id: 'rain',
      label: 'Rain',
      icon: Icons.water_drop_outlined,
      activeIcon: Icons.water_drop,
    ),
    _SoundItem(
      id: 'waves',
      label: 'Waves',
      icon: Icons.waves_outlined,
      activeIcon: Icons.waves,
    ),
    _SoundItem(
      id: 'fire',
      label: 'Fire',
      icon: Icons.local_fire_department_outlined,
      activeIcon: Icons.local_fire_department,
    ),
    _SoundItem(
      id: 'piano',
      label: 'Piano',
      icon: Icons.piano_outlined,
      activeIcon: Icons.piano,
    ),
    _SoundItem(
      id: 'wind',
      label: 'Wind',
      icon: Icons.air_outlined,
      activeIcon: Icons.air,
      isPremium: true,
    ),
    _SoundItem(
      id: 'forest',
      label: 'Forest',
      icon: Icons.park_outlined,
      activeIcon: Icons.park,
    ),
    _SoundItem(
      id: 'birds',
      label: 'Birds',
      icon: Icons.flutter_dash_outlined,
      activeIcon: Icons.flutter_dash,
    ),
    _SoundItem(
      id: 'noise',
      label: 'Noise',
      icon: Icons.blur_on,
      activeIcon: Icons.blur_on,
    ),
    _SoundItem(
      id: 'storm',
      label: 'Storm',
      icon: Icons.thunderstorm_outlined,
      activeIcon: Icons.thunderstorm,
      isPremium: true,
    ),
    _SoundItem(
      id: 'river',
      label: 'River',
      icon: Icons.water_outlined,
      activeIcon: Icons.water,
    ),
    _SoundItem(
      id: 'night',
      label: 'Night',
      icon: Icons.nightlight_outlined,
      activeIcon: Icons.nightlight,
    ),
    _SoundItem(
      id: 'cafe',
      label: 'Café',
      icon: Icons.coffee_outlined,
      activeIcon: Icons.coffee,
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeSoundsState = ref.watch(activeSoundsProvider);

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [const Color(0xFF0D1B2A), AppColors.background],
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: Text(
                'Relaxing Sounds',
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Mix and match to find your perfect sleep environment.',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // ── Sound Grid ──────────────────────────────────
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GridView.builder(
                  padding: EdgeInsets.only(
                    bottom: activeSoundsState.hasActiveSounds ? 80 : 100,
                  ),
                  itemCount: _sounds.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.80,
                  ),
                  itemBuilder: (context, index) {
                    final sound = _sounds[index];
                    final isActive = activeSoundsState.isActive(sound.id);
                    return SoundCircle(
                      icon: isActive ? sound.activeIcon : sound.icon,
                      label: sound.label,
                      isActive: isActive,
                      isPremium: sound.isPremium,
                      onTap: () {
                        ref
                            .read(activeSoundsProvider.notifier)
                            .toggleSound(sound.id, sound.label);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SoundItem {
  const _SoundItem({
    required this.id,
    required this.label,
    required this.icon,
    required this.activeIcon,
    this.isPremium = false,
  });
  final String id;
  final String label;
  final IconData icon;
  final IconData activeIcon;
  final bool isPremium;
}
