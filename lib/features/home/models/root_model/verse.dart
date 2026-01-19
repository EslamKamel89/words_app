import 'package:words_app/features/home/models/root_model/surah.dart';
import 'package:words_app/features/home/models/root_model/word.dart';

class VerseModel {
  int? id;
  int? surahId;
  int? verseNumber;
  int? wordId;
  int? rootId;
  String? text;
  List<WordModel>? words;
  SurahModel? surah;

  VerseModel({
    this.id,
    this.surahId,
    this.rootId,
    this.wordId,
    this.verseNumber,
    this.text,
    this.words,
    this.surah,
  });

  @override
  String toString() {
    return 'Verse(id: $id, surahId: $surahId, rootId: $rootId , wordId: $wordId, verseNumber: $verseNumber, text: $text , words: $words)';
  }

  factory VerseModel.fromJson(Map<String, dynamic> json) => VerseModel(
    id: json['id'] as int?,
    surahId: json['surah_id'] as int?,
    verseNumber: json['verse_number'] as int?,
    text: json['text'] as String?,
    rootId: json['root_id'] as int?,
    wordId: json['word_id'] as int?,
    words:
        (json['words'] as List<dynamic>?)
            ?.map((e) => WordModel.fromJson(e as Map<String, dynamic>))
            .toList(),
    surah: json['surah'] == null ? null : SurahModel.fromJson(json['surah']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'surah_id': surahId,
    'verse_number': verseNumber,
    'text': text,
    'words': words,
  };
}
