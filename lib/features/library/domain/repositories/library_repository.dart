import '../models/saved_mix.dart';

/// Abstract contract for saved-mix persistence.
abstract class LibraryRepository {
  /// Retrieve all saved mixes, most recent first.
  Future<List<SavedMix>> getAllMixes();

  /// Persist a new mix.
  Future<void> saveMix(SavedMix mix);

  /// Delete a saved mix by its [id].
  Future<void> deleteMix(String id);
}
