class VerseModel {
  int? id;
  int? surahId;
  int? verseNumber;
  String? text;

  VerseModel({this.id, this.surahId, this.verseNumber, this.text});

  @override
  String toString() {
    return 'Verse(id: $id, surahId: $surahId, verseNumber: $verseNumber, text: $text)';
  }

  factory VerseModel.fromJson(Map<String, dynamic> json) => VerseModel(
    id: json['id'] as int?,
    surahId: json['surah_id'] as int?,
    verseNumber: json['verse_number'] as int?,
    text: json['text'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'surah_id': surahId,
    'verse_number': verseNumber,
    'text': text,
  };
}
