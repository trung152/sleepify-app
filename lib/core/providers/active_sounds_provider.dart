import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'active_sounds_provider.g.dart';

/// Global state for currently active (playing) sounds.
///
/// Holds the set of active sound IDs and playback status.
/// Used by SoundsScreen to toggle sounds and MainShell to show MiniPlayerBar.
@Riverpod(keepAlive: true)
class ActiveSounds extends _$ActiveSounds {
  @override
  ActiveSoundsState build() {
    return const ActiveSoundsState();
  }

  void toggleSound(String id, String label) {
    final current = Map<String, String>.from(state.activeSounds);
    if (current.containsKey(id)) {
      current.remove(id);
    } else {
      current[id] = label;
    }
    state = state.copyWith(
      activeSounds: current,
      isPlaying: current.isNotEmpty,
    );
  }

  void togglePlayback() {
    if (state.activeSounds.isEmpty) return;
    state = state.copyWith(isPlaying: !state.isPlaying);
  }

  void clearAll() {
    state = const ActiveSoundsState();
  }
}

/// Immutable state for active sounds.
class ActiveSoundsState {
  const ActiveSoundsState({
    this.activeSounds = const {},
    this.isPlaying = false,
  });

  /// Map of sound ID → display label.
  final Map<String, String> activeSounds;
  final bool isPlaying;

  int get count => activeSounds.length;
  List<String> get labels => activeSounds.values.toList();
  bool get hasActiveSounds => activeSounds.isNotEmpty;

  bool isActive(String id) => activeSounds.containsKey(id);

  ActiveSoundsState copyWith({
    Map<String, String>? activeSounds,
    bool? isPlaying,
  }) {
    return ActiveSoundsState(
      activeSounds: activeSounds ?? this.activeSounds,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}
