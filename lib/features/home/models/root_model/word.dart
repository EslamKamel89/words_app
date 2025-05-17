import 'surah.dart';
import 'verse.dart';

class WordModel {
  int? id;
  int? rootId;
  int? verseId;
  int? surahId;
  String? word;
  String? wordTashkeel;
  SurahModel? surah;
  VerseModel? verse;

  WordModel({
    this.id,
    this.rootId,
    this.verseId,
    this.surahId,
    this.word,
    this.wordTashkeel,
    this.surah,
    this.verse,
  });

  @override
  String toString() {
    return 'Word(id: $id, rootId: $rootId, verseId: $verseId, surahId: $surahId, word: $word, wordTashkeel: $wordTashkeel, surah: $surah, verse: $verse)';
  }

  factory WordModel.fromJson(Map<String, dynamic> json) => WordModel(
    id: json['id'] as int?,
    rootId: json['root_id'] as int?,
    verseId: json['verse_id'] as int?,
    surahId: json['surah_id'] as int?,
    word: json['word'] as String?,
    wordTashkeel: json['word_tashkeel'] as String?,
    surah:
        json['surah'] == null ? null : SurahModel.fromJson(json['surah'] as Map<String, dynamic>),
    verse:
        json['verse'] == null ? null : VerseModel.fromJson(json['verse'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'root_id': rootId,
    'verse_id': verseId,
    'surah_id': surahId,
    'word': word,
    'word_tashkeel': wordTashkeel,
    'surah': surah?.toJson(),
    'verse': verse?.toJson(),
  };
}
