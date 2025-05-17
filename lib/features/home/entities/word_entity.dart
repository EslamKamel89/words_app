// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:words_app/features/home/models/root_model/root_model.dart';

class WordEntity {
  String? rootOrigin;
  String? rootName;
  String? word;
  String? wordTashkeel;
  String? surahName;
  String? verseText;
  int? verseNumber;
  WordEntity({
    this.rootOrigin,
    this.rootName,
    this.word,
    this.wordTashkeel,
    this.surahName,
    this.verseText,
    this.verseNumber,
  });
  static List<WordEntity> transformRootToWordsEntity(RootModel root) {
    List<WordEntity> result = [];
    root.words?.forEach((word) {
      result.add(
        WordEntity(
          rootOrigin: root.originWord,
          rootName: root.name,
          word: word.word,
          wordTashkeel: word.wordTashkeel,
          surahName: word.surah?.name,
          verseText: word.verse?.text,
          verseNumber: word.verse?.verseNumber,
        ),
      );
    });
    return result;
  }

  static List<WordEntity> transformRootsToWordsEntity(List<RootModel> roots) {
    List<WordEntity> result = [];
    for (var root in roots) {
      result = [...result, ...WordEntity.transformRootToWordsEntity(root)];
      // result.addAll(
      //   prx(
      //     WordEntity.transformRootToWordsEntity(root),
      //     'transformRootsToWordsEntity - result.addAll- test',
      //   ),
      // );
    }
    return result;
  }
}
