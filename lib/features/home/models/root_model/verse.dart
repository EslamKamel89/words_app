import 'package:words_app/features/home/models/root_model/word.dart';

class VerseModel {
  int? id;
  int? surahId;
  int? verseNumber;
  String? text;
  List<WordModel>? words;

  VerseModel({this.id, this.surahId, this.verseNumber, this.text, this.words});

  @override
  String toString() {
    return 'Verse(id: $id, surahId: $surahId, verseNumber: $verseNumber, text: $text , words: $words)';
  }

  factory VerseModel.fromJson(Map<String, dynamic> json) => VerseModel(
    id: json['id'] as int?,
    surahId: json['surah_id'] as int?,
    verseNumber: json['verse_number'] as int?,
    text: json['text'] as String?,
    words:
        (json['words'] as List<dynamic>?)
            ?.map((e) => WordModel.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'surah_id': surahId,
    'verse_number': verseNumber,
    'text': text,
    'words': words,
  };
}
