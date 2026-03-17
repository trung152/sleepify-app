import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'sound_registry.dart';

part 'audio_engine.g.dart';

/// Global audio engine managing a pool of [AudioPlayer] instances.
///
/// Supports simultaneous sound mixing, per-player volume control,
/// looping, fade-out, and global play/pause. Used by both the
/// Sounds mixer and Breathwork ambient sound features.
///
/// Each sound ID maps to one [AudioPlayer]. Players are created on
/// demand and disposed when stopped.
///
/// Note: We use just_audio directly (without just_audio_background)
/// because the background plugin doesn't support multiple simultaneous
/// players needed for sound mixing. Audio still plays in background
/// via Android/iOS audio session; only media notification is missing.
@Riverpod(keepAlive: true)
AudioEngine audioEngine(Ref ref) {
  final engine = AudioEngine();
  ref.onDispose(engine.dispose);
  return engine;
}

class AudioEngine {
  final Map<String, AudioPlayer> _players = {};
  final Map<String, double> _volumes = {};
  bool _globalPaused = false;

  /// Whether any player is currently active.
  bool get hasActivePlayers => _players.isNotEmpty;

  /// Whether global playback is paused.
  bool get isGlobalPaused => _globalPaused;

  /// Set of currently active sound IDs.
  Set<String> get activeSoundIds => _players.keys.toSet();

  /// Get volume for a specific sound (default 0.8).
  double getVolume(String soundId) => _volumes[soundId] ?? 0.8;

  // ─── Play / Stop ─────────────────────────────────────────────

  /// Start playing a sound by ID. Creates a new [AudioPlayer] if needed.
  ///
  /// The sound loops infinitely and starts at the stored volume level.
  /// If the sound is already playing, this is a no-op.
  Future<void> play(String soundId) async {
    if (_players.containsKey(soundId)) {
      debugPrint('AudioEngine: "$soundId" already playing, skipping');
      return;
    }

    final assetPath = SoundRegistry.getAssetPath(soundId);
    if (assetPath == null) {
      debugPrint('AudioEngine: ❌ Unknown sound ID "$soundId"');
      return;
    }

    debugPrint('AudioEngine: ▶️ Playing "$soundId" from $assetPath');

    try {
      final player = AudioPlayer();
      _players[soundId] = player;

      await player.setAsset(assetPath);
      await player.setLoopMode(LoopMode.all);
      await player.setVolume(_volumes[soundId] ?? 0.8);

      if (!_globalPaused) {
        await player.play();
        debugPrint('AudioEngine: ✅ "$soundId" playing successfully');
      } else {
        debugPrint(
          'AudioEngine: ⏸️ "$soundId" loaded but paused (global pause)',
        );
      }
    } catch (e) {
      debugPrint('AudioEngine: ❌ Error playing "$soundId": $e');
      await _disposePlayer(soundId);
    }
  }

  /// Stop and dispose a single sound player.
  Future<void> stop(String soundId) async {
    await _disposePlayer(soundId);
  }

  /// Stop and dispose all players.
  Future<void> stopAll() async {
    final ids = List<String>.from(_players.keys);
    for (final id in ids) {
      await _disposePlayer(id);
    }
    _globalPaused = false;
  }

  // ─── Volume ──────────────────────────────────────────────────

  /// Set volume for a specific sound (0.0 to 1.0).
  Future<void> setVolume(String soundId, double volume) async {
    final clamped = volume.clamp(0.0, 1.0);
    _volumes[soundId] = clamped;
    await _players[soundId]?.setVolume(clamped);
  }

  // ─── Global Playback Control ─────────────────────────────────

  /// Pause all active players.
  Future<void> pauseAll() async {
    _globalPaused = true;
    final players = List<AudioPlayer>.from(_players.values);
    for (final player in players) {
      await player.pause();
    }
  }

  /// Resume all paused players.
  Future<void> resumeAll() async {
    _globalPaused = false;
    final players = List<AudioPlayer>.from(_players.values);
    for (final player in players) {
      await player.play();
    }
  }

  // ─── Fade Out ────────────────────────────────────────────────

  /// Gradually reduce volume on all players over [duration], then stop.
  Future<void> fadeOutAndStop(Duration duration) async {
    if (_players.isEmpty) return;

    const steps = 20;
    final stepDuration = duration ~/ steps;

    // Capture original volumes — snapshot entries to avoid concurrent mod
    final entries = List<MapEntry<String, AudioPlayer>>.from(_players.entries);
    final originalVolumes = <String, double>{};
    for (final entry in entries) {
      originalVolumes[entry.key] = entry.value.volume;
    }

    for (int i = steps; i >= 0; i--) {
      final factor = i / steps;
      for (final entry in entries) {
        if (_players.containsKey(entry.key)) {
          final original = originalVolumes[entry.key] ?? 0.8;
          await entry.value.setVolume(original * factor);
        }
      }
      await Future<void>.delayed(stepDuration);
    }

    await stopAll();

    // Restore original volume settings (for next play)
    _volumes.addAll(originalVolumes);
  }

  // ─── Cleanup ─────────────────────────────────────────────────

  Future<void> _disposePlayer(String soundId) async {
    final player = _players.remove(soundId);
    if (player != null) {
      await player.stop();
      await player.dispose();
    }
  }

  /// Dispose all resources. Called by Riverpod [ref.onDispose].
  Future<void> dispose() async {
    await stopAll();
    _volumes.clear();
  }
}
