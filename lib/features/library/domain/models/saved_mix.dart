import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_mix.freezed.dart';
part 'saved_mix.g.dart';

/// A saved sound mix that users can store and replay.
@freezed
sealed class SavedMix with _$SavedMix {
  const factory SavedMix({
    /// Unique identifier (timestamp-based).
    required String id,

    /// User-given name for the mix.
    required String name,

    /// Map of sound ID → display label.
    required Map<String, String> sounds,

    /// Map of sound ID → volume (0.0 – 1.0).
    required Map<String, double> volumes,

    /// When the mix was saved.
    required DateTime createdAt,
  }) = _SavedMix;

  factory SavedMix.fromJson(Map<String, dynamic> json) =>
      _$SavedMixFromJson(json);
}
