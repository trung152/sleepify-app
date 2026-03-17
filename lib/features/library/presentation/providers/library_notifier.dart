import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/active_sounds_provider.dart';
import '../../data/data_sources/library_local_source.dart';
import '../../data/repositories/library_repository_impl.dart';
import '../../domain/models/saved_mix.dart';
import '../../domain/repositories/library_repository.dart';

part 'library_notifier.g.dart';

/// Provides the [LibraryRepository] singleton.
@Riverpod(keepAlive: true)
LibraryRepository libraryRepository(Ref ref) {
  return LibraryRepositoryImpl(LibraryLocalSource());
}

/// Manages saved mixes state (load, save, delete, load-into-player).
@riverpod
class LibraryNotifier extends _$LibraryNotifier {
  @override
  FutureOr<List<SavedMix>> build() async {
    final repo = ref.watch(libraryRepositoryProvider);
    return repo.getAllMixes();
  }

  /// Save a new mix from the current active sounds.
  Future<bool> saveMix({
    required String name,
    required Map<String, String> sounds,
    required Map<String, double> volumes,
  }) async {
    if (name.trim().isEmpty || sounds.isEmpty) return false;

    final mix = SavedMix(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name.trim(),
      sounds: sounds,
      volumes: volumes,
      createdAt: DateTime.now(),
    );

    final repo = ref.read(libraryRepositoryProvider);
    await repo.saveMix(mix);

    // Refresh the list
    ref.invalidateSelf();
    return true;
  }

  /// Delete a saved mix.
  Future<void> deleteMix(String id) async {
    final repo = ref.read(libraryRepositoryProvider);
    await repo.deleteMix(id);
    ref.invalidateSelf();
  }

  /// Load a saved mix into the active sounds player.
  void loadMix(SavedMix mix) {
    final notifier = ref.read(activeSoundsProvider.notifier);

    // Clear current sounds first
    notifier.clearAll();

    // Add each sound from the saved mix
    for (final entry in mix.sounds.entries) {
      notifier.toggleSound(entry.key, entry.value);
    }

    // Set volumes
    for (final entry in mix.volumes.entries) {
      notifier.setVolume(entry.key, entry.value);
    }
  }
}
