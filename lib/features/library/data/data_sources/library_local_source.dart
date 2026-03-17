import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/saved_mix.dart';

/// SharedPreferences-backed storage for saved mixes.
///
/// Stores the full list as a JSON-encoded string list under [_key].
class LibraryLocalSource {
  static const String _key = 'saved_mixes';

  /// Read all saved mixes from local storage.
  Future<List<SavedMix>> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_key);
    if (raw == null || raw.isEmpty) return [];

    return raw.map((json) {
      final map = jsonDecode(json) as Map<String, dynamic>;
      return SavedMix.fromJson(map);
    }).toList();
  }

  /// Add a mix and persist the updated list.
  Future<void> save(SavedMix mix) async {
    final all = await getAll();
    all.insert(0, mix); // newest first
    await _persist(all);
  }

  /// Remove a mix by [id] and persist.
  Future<void> delete(String id) async {
    final all = await getAll();
    all.removeWhere((m) => m.id == id);
    await _persist(all);
  }

  Future<void> _persist(List<SavedMix> mixes) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = mixes.map((m) => jsonEncode(m.toJson())).toList();
    await prefs.setStringList(_key, encoded);
  }
}
