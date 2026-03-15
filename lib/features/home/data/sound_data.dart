import '../domain/models/sound.dart';

/// Pre-populated sound data using local assets.
///
/// Maps each audio file to a thumbnail and assigns metadata.
/// Thumbnails are assigned from the relax-thums directory.
class SoundData {
  SoundData._();

  static const List<Sound> relaxSounds = [
    Sound(
      id: 'relax_01',
      name: 'Ambient Background',
      category: 'Relax',
      artist: 'Sleepify',
      audioPath: 'assets/sound/relax-sound/ambient-background-music-312295.mp3',
      thumbnailPath: 'assets/images/relax-thums/09-00-39-170_200x200.jpg',
    ),
    Sound(
      id: 'relax_02',
      name: 'Ambient Piano',
      category: 'Relax',
      artist: 'Sleepify',
      audioPath: 'assets/sound/relax-sound/ambient-piano-215975.mp3',
      thumbnailPath: 'assets/images/relax-thums/09-18-25-495_200x200.jpg',
    ),
    Sound(
      id: 'relax_03',
      name: 'Childhood Memories',
      category: 'Relax',
      artist: 'Sleepify',
      audioPath: 'assets/sound/relax-sound/childhood-memories-nostalgic-ambient-music-305852.mp3',
      thumbnailPath: 'assets/images/relax-thums/09-36-17-605_200x200.jpg',
    ),
    Sound(
      id: 'relax_04',
      name: 'Melancholy Piano',
      category: 'Relax',
      artist: 'Sleepify',
      audioPath: 'assets/sound/relax-sound/disappointed-very-sad-piano-song-233865.mp3',
      thumbnailPath: 'assets/images/relax-thums/10-18-13-247_200x200.jpg',
    ),
    Sound(
      id: 'relax_05',
      name: 'Lonely Piano',
      category: 'Relax',
      artist: 'Sleepify',
      audioPath: 'assets/sound/relax-sound/lonely-beautiful-piano-music-233867.mp3',
      thumbnailPath: 'assets/images/relax-thums/10-45-31-582_200x200.jpg',
    ),
    Sound(
      id: 'relax_06',
      name: 'Moon Rain',
      category: 'Relax',
      artist: 'Clavier',
      audioPath: 'assets/sound/relax-sound/moon-rain-beautiful-piano-music-223674.mp3',
      thumbnailPath: 'assets/images/relax-thums/10-45-33-866_200x200.jpg',
    ),
    Sound(
      id: 'relax_07',
      name: 'Please Calm My Mind',
      category: 'Relax',
      artist: 'Sleepify',
      audioPath: 'assets/sound/relax-sound/please-calm-my-mind-125566.mp3',
      thumbnailPath: 'assets/images/relax-thums/10-54-16-674_200x200.jpg',
    ),
    Sound(
      id: 'relax_08',
      name: "I Ain't Worried",
      category: 'Relax',
      artist: 'Sleepify',
      audioPath: 'assets/sound/relax-sound/relaxing-piano-melody-i-ainx27t-worried-230350.mp3',
      thumbnailPath: 'assets/images/relax-thums/11-01-22-159_200x200.jpg',
    ),
    Sound(
      id: 'relax_09',
      name: 'Soft Background',
      category: 'Relax',
      artist: 'Sleepify',
      audioPath: 'assets/sound/relax-sound/relaxing-piano-music-soft-background-music-for-videos-229527.mp3',
      thumbnailPath: 'assets/images/relax-thums/11-09-36-996_200x200.jpg',
    ),
    Sound(
      id: 'relax_10',
      name: 'Soft Jazz Piano',
      category: 'Relax',
      artist: 'Sleepify',
      audioPath: 'assets/sound/relax-sound/soft-jazz-piano-music-233868.mp3',
      thumbnailPath: 'assets/images/relax-thums/11-12-59-227_200x200.jpg',
    ),
    Sound(
      id: 'relax_11',
      name: 'The Wellerman',
      category: 'Relax',
      artist: 'Sleepify',
      audioPath: 'assets/sound/relax-sound/the-wellerman-239513.mp3',
      thumbnailPath: 'assets/images/relax-thums/11-14-10-734_200x200.jpg',
    ),
    Sound(
      id: 'relax_12',
      name: 'Una Luna',
      category: 'Relax',
      artist: 'Sleepify',
      audioPath: 'assets/sound/relax-sound/una-luna-relaxing-piano-216337.mp3',
      thumbnailPath: 'assets/images/relax-thums/11-30-35-858_200x200.jpg',
    ),
    Sound(
      id: 'relax_13',
      name: 'Say Something',
      category: 'Relax',
      artist: 'Sleepify',
      audioPath: 'assets/sound/relax-sound/very-sad-piano-music-say-something-230353.mp3',
      thumbnailPath: 'assets/images/relax-thums/11-42-03-385_200x200.jpg',
    ),
    Sound(
      id: 'relax_14',
      name: 'Wake Me Up',
      category: 'Relax',
      artist: 'Sleepify',
      audioPath: 'assets/sound/relax-sound/wake-me-up-piano-230272.mp3',
      thumbnailPath: 'assets/images/relax-thums/11-43-37-725_200x200.jpg',
    ),
    Sound(
      id: 'relax_15',
      name: 'Hatikvah Piano',
      category: 'Relax',
      artist: 'Sleepify',
      audioPath: 'assets/sound/relax-sound/hatikvah-national-anthem-of-israel-piano-music-236516.mp3',
      thumbnailPath: 'assets/images/relax-thums/12-00-39-917_200x200.jpg',
    ),
  ];

  static const List<Sound> natureSounds = [
    Sound(
      id: 'nature_01',
      name: 'Gentle Breeze',
      category: 'Nature',
      audioPath: 'assets/sound/nature-sound/a-gentle-breeze-wind-4-14681.mp3',
      thumbnailPath: 'assets/images/relax-thums/12-02-58-221_200x200.jpg',
    ),
    Sound(
      id: 'nature_02',
      name: 'Gentle Light Within',
      category: 'Nature',
      audioPath: 'assets/sound/nature-sound/a-gentle-light-within-i-327262.mp3',
      thumbnailPath: 'assets/images/relax-thums/12-08-48-_200x200.jpg',
    ),
    Sound(
      id: 'nature_03',
      name: 'Birds Chirping',
      category: 'Nature',
      audioPath: 'assets/sound/nature-sound/birds-chirping-75156.mp3',
      thumbnailPath: 'assets/images/relax-thums/12-14-54-917_200x200.jpg',
    ),
    Sound(
      id: 'nature_04',
      name: 'Zen River',
      category: 'Nature',
      audioPath: 'assets/sound/nature-sound/calm-zen-river-flowing-228223.mp3',
      thumbnailPath: 'assets/images/relax-thums/12-39-06-714_200x200.jpg',
    ),
    Sound(
      id: 'nature_05',
      name: 'Crackling Fire',
      category: 'Nature',
      audioPath: 'assets/sound/nature-sound/crackling-fire-14759.mp3',
      thumbnailPath: 'assets/images/relax-thums/13-28-39-337_200x200.jpg',
    ),
    Sound(
      id: 'nature_06',
      name: 'Ocean Waves',
      category: 'Nature',
      audioPath: 'assets/sound/nature-sound/gentle-ocean-waves-birdsong-and-gull-7109.mp3',
      thumbnailPath: 'assets/images/relax-thums/13-40-41-182_200x200.jpg',
    ),
    Sound(
      id: 'nature_07',
      name: 'Just Relax',
      category: 'Nature',
      audioPath: 'assets/sound/nature-sound/just-relax-11157.mp3',
      thumbnailPath: 'assets/images/relax-thums/14-01-54-991_200x200.jpg',
    ),
    Sound(
      id: 'nature_08',
      name: 'Light Rain',
      category: 'Nature',
      audioPath: 'assets/sound/nature-sound/light-rain-109591.mp3',
      thumbnailPath: 'assets/images/relax-thums/14-02-24-948_200x200.jpg',
    ),
    Sound(
      id: 'nature_09',
      name: 'Peaceful Piano Loop',
      category: 'Nature',
      audioPath: 'assets/sound/nature-sound/peaceful-piano-loop-6903.mp3',
      thumbnailPath: 'assets/images/relax-thums/14-03-12-787_200x200.jpg',
    ),
    Sound(
      id: 'nature_10',
      name: 'Relaxing Piano',
      category: 'Nature',
      audioPath: 'assets/sound/nature-sound/relaxing-piano-music-248868.mp3',
      thumbnailPath: 'assets/images/relax-thums/14-08-36-922_200x200.jpg',
    ),
    Sound(
      id: 'nature_11',
      name: 'Deep Sleep 432 Hz',
      category: 'Nature',
      audioPath: 'assets/sound/nature-sound/soothing-deep-sleep-music-432-hz-191708.mp3',
      thumbnailPath: 'assets/images/relax-thums/15-04-21-159_200x200.jpg',
    ),
    Sound(
      id: 'nature_12',
      name: 'Good Time Piano',
      category: 'Nature',
      audioPath: 'assets/sound/nature-sound/thinking-of-good-time-soft-piano-music-201837.mp3',
      thumbnailPath: 'assets/images/relax-thums/15-10-44-782_200x200.jpg',
    ),
  ];

  static List<Sound> get allSounds => [...relaxSounds, ...natureSounds];
}
