import '../../domain/models/saved_mix.dart';
import '../../domain/repositories/library_repository.dart';
import '../data_sources/library_local_source.dart';

/// Concrete [LibraryRepository] backed by [LibraryLocalSource].
class LibraryRepositoryImpl implements LibraryRepository {
  LibraryRepositoryImpl(this._localSource);

  final LibraryLocalSource _localSource;

  @override
  Future<List<SavedMix>> getAllMixes() => _localSource.getAll();

  @override
  Future<void> saveMix(SavedMix mix) => _localSource.save(mix);

  @override
  Future<void> deleteMix(String id) => _localSource.delete(id);
}
