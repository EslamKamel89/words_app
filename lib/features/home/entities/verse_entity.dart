// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:words_app/features/home/models/root_model/word.dart';

class VerseEntity {
  int? surahId;
  String? surahName;
  int? verseId;
  int? verseNumber;
  String? verseText;
  int? wordId;
  int? rootId;
  String? rootName;
  String? rootOriginWord;

  VerseEntity({
    this.surahId,
    this.surahName,
    this.verseId,
    this.verseNumber,
    this.verseText,
    this.wordId,
    this.rootId,
    this.rootName,
    this.rootOriginWord,
  });
  static VerseEntity transformWordToVerse(WordModel word) {
    return VerseEntity(
      surahId: word.surah?.id,
      surahName: word.surah?.name,
      verseId: word.verse?.id,
      verseNumber: word.verse?.verseNumber,
      verseText: word.verse?.text,
      wordId: word.id,
      rootId: word.rootId,
      rootName: word.root?.name,
      rootOriginWord: word.root?.originWord,
    );
  }

  static List<VerseEntity> transformWordsToVerses(List<WordModel> words) {
    return words.map((word) => transformWordToVerse(word)).toList();
  }
}
