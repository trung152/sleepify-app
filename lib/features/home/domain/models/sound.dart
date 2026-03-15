/// Represents a sound/track that can be played in Sleepify.
class Sound {
  const Sound({
    required this.id,
    required this.name,
    required this.category,
    required this.audioPath,
    required this.thumbnailPath,
    this.artist = '',
    this.duration,
    this.isPremium = false,
  });

  final String id;
  final String name;
  final String category;
  final String audioPath;
  final String thumbnailPath;
  final String artist;
  final Duration? duration;
  final bool isPremium;
}

/// Sound categories.
enum SoundCategory {
  relax('Relax'),
  nature('Nature'),
  sleep('Sleep'),
  focus('Focus');

  const SoundCategory(this.label);
  final String label;
}
