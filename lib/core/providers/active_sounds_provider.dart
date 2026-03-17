import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../audio/audio_engine.dart';

part 'active_sounds_provider.g.dart';

/// Global state for currently active (playing) sounds.
///
/// Integrates with [AudioEngine] for real audio playback.
/// Holds active sound IDs, volumes, and playback status.
/// Used by SoundsScreen, MiniPlayerBar, and CurrentMixScreen.
@Riverpod(keepAlive: true)
class ActiveSounds extends _$ActiveSounds {
  @override
  ActiveSoundsState build() {
    return const ActiveSoundsState();
  }

  AudioEngine get _engine => ref.read(audioEngineProvider);

  /// Toggle a sound on/off. Starts/stops actual audio playback.
  ///
  /// Updates state optimistically FIRST so UI responds instantly,
  /// then triggers audio in the background.
  void toggleSound(String id, String label) {
    final current = Map<String, String>.from(state.activeSounds);
    final currentVolumes = Map<String, double>.from(state.volumes);

    if (current.containsKey(id)) {
      current.remove(id);
      currentVolumes.remove(id);
      // Fire-and-forget: stop audio in background
      _engine.stop(id);
    } else {
      current[id] = label;
      currentVolumes[id] = 0.8;
      // Fire-and-forget: start audio in background
      _engine.play(id);
    }

    // Update state IMMEDIATELY so UI responds on first tap
    state = state.copyWith(
      activeSounds: current,
      volumes: currentVolumes,
      isPlaying: current.isNotEmpty,
    );
  }

  /// Toggle global play/pause for all active sounds.
  Future<void> togglePlayback() async {
    if (state.activeSounds.isEmpty) return;

    if (state.isPlaying) {
      await _engine.pauseAll();
    } else {
      await _engine.resumeAll();
    }

    state = state.copyWith(isPlaying: !state.isPlaying);
  }

  /// Set volume for a specific sound (0.0 – 1.0).
  Future<void> setVolume(String id, double volume) async {
    final currentVolumes = Map<String, double>.from(state.volumes);
    currentVolumes[id] = volume;
    await _engine.setVolume(id, volume);
    state = state.copyWith(volumes: currentVolumes);
  }

  /// Clear all sounds and stop audio.
  Future<void> clearAll() async {
    await _engine.stopAll();
    state = const ActiveSoundsState();
  }
}

/// Immutable state for active sounds.
class ActiveSoundsState {
  const ActiveSoundsState({
    this.activeSounds = const {},
    this.volumes = const {},
    this.isPlaying = false,
  });

  /// Map of sound ID → display label.
  final Map<String, String> activeSounds;

  /// Map of sound ID → volume (0.0 – 1.0).
  final Map<String, double> volumes;

  final bool isPlaying;

  int get count => activeSounds.length;
  List<String> get labels => activeSounds.values.toList();
  bool get hasActiveSounds => activeSounds.isNotEmpty;

  bool isActive(String id) => activeSounds.containsKey(id);
  double getVolume(String id) => volumes[id] ?? 0.8;

  ActiveSoundsState copyWith({
    Map<String, String>? activeSounds,
    Map<String, double>? volumes,
    bool? isPlaying,
  }) {
    return ActiveSoundsState(
      activeSounds: activeSounds ?? this.activeSounds,
      volumes: volumes ?? this.volumes,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}
