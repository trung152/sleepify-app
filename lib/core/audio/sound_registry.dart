import 'package:flutter/material.dart';

/// Static registry mapping sound IDs to asset paths and metadata.
///
/// Used by both SoundsScreen (mixer) and Breathwork (ambient sound selection).
/// All sounds are local assets bundled with the app.
class SoundRegistry {
  SoundRegistry._();

  static const List<SoundInfo> allSounds = [
    SoundInfo(
      id: 'rain',
      label: 'Rain',
      assetPath: 'assets/sound/nature-sound/light-rain-109591.mp3',
      icon: Icons.water_drop,
      outlinedIcon: Icons.water_drop_outlined,
    ),
    SoundInfo(
      id: 'waves',
      label: 'Waves',
      assetPath:
          'assets/sound/nature-sound/gentle-ocean-waves-birdsong-and-gull-7109.mp3',
      icon: Icons.waves,
      outlinedIcon: Icons.waves_outlined,
    ),
    SoundInfo(
      id: 'fire',
      label: 'Fire',
      assetPath: 'assets/sound/nature-sound/crackling-fire-14759.mp3',
      icon: Icons.local_fire_department,
      outlinedIcon: Icons.local_fire_department_outlined,
    ),
    SoundInfo(
      id: 'piano',
      label: 'Piano',
      assetPath: 'assets/sound/nature-sound/peaceful-piano-loop-6903.mp3',
      icon: Icons.piano,
      outlinedIcon: Icons.piano_outlined,
    ),
    SoundInfo(
      id: 'wind',
      label: 'Wind',
      assetPath: 'assets/sound/nature-sound/a-gentle-breeze-wind-4-14681.mp3',
      icon: Icons.air,
      outlinedIcon: Icons.air_outlined,
      isPremium: true,
    ),
    SoundInfo(
      id: 'forest',
      label: 'Forest',
      assetPath: 'assets/sound/nature-sound/just-relax-11157.mp3',
      icon: Icons.park,
      outlinedIcon: Icons.park_outlined,
    ),
    SoundInfo(
      id: 'birds',
      label: 'Birds',
      assetPath: 'assets/sound/nature-sound/birds-chirping-75156.mp3',
      icon: Icons.flutter_dash,
      outlinedIcon: Icons.flutter_dash_outlined,
    ),
    SoundInfo(
      id: 'noise',
      label: 'Noise',
      assetPath:
          'assets/sound/nature-sound/soothing-deep-sleep-music-432-hz-191708.mp3',
      icon: Icons.blur_on,
      outlinedIcon: Icons.blur_on,
    ),
    SoundInfo(
      id: 'storm',
      label: 'Storm',
      assetPath: 'assets/sound/relax-sound/ambient-background-music-312295.mp3',
      icon: Icons.thunderstorm,
      outlinedIcon: Icons.thunderstorm_outlined,
      isPremium: true,
    ),
    SoundInfo(
      id: 'river',
      label: 'River',
      assetPath: 'assets/sound/nature-sound/calm-zen-river-flowing-228223.mp3',
      icon: Icons.water,
      outlinedIcon: Icons.water_outlined,
    ),
    SoundInfo(
      id: 'night',
      label: 'Night',
      assetPath:
          'assets/sound/nature-sound/a-gentle-light-within-i-327262.mp3',
      icon: Icons.nightlight,
      outlinedIcon: Icons.nightlight_outlined,
    ),
    SoundInfo(
      id: 'cafe',
      label: 'Café',
      assetPath: 'assets/sound/relax-sound/soft-jazz-piano-music-233868.mp3',
      icon: Icons.coffee,
      outlinedIcon: Icons.coffee_outlined,
    ),
  ];

  /// Look up a sound by its ID. Returns null if not found.
  static SoundInfo? getById(String id) {
    for (final sound in allSounds) {
      if (sound.id == id) return sound;
    }
    return null;
  }

  /// Get the asset path for a sound ID. Returns null if not found.
  static String? getAssetPath(String id) => getById(id)?.assetPath;

  /// Get only non-premium sounds (for free users).
  static List<SoundInfo> get freeSounds =>
      allSounds.where((s) => !s.isPremium).toList();
}

/// Metadata for a single sound asset.
class SoundInfo {
  const SoundInfo({
    required this.id,
    required this.label,
    required this.assetPath,
    required this.icon,
    required this.outlinedIcon,
    this.isPremium = false,
  });

  final String id;
  final String label;
  final String assetPath;
  final IconData icon;
  final IconData outlinedIcon;
  final bool isPremium;
}
