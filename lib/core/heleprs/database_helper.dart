import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:words_app/core/heleprs/print_helper.dart';
import 'package:words_app/features/home/models/osmani_word.dart';

class DataBaseHelper {
  static Database? _database;

  static Database get database => _database!;
  static const String _dataBaseName = 'dlalat_qurann.db';
  static const String _sura = 'sura';
  static const String _tag = 'tags';
  static const String _articles = 'articles';
  static const String _articlesSeries = 'articles-series';
  static const String _series = 'articles-series';
  static const String _ayat = 'ayat';
  static const String _recitersTable = 'reciters';
  static const String _videosTable = 'videos';
  static const String _videoCats = 'video_categories';
  static DataBaseHelper? _baseHelper;

  static DataBaseHelper dataBaseInstance() {
    _baseHelper ??= DataBaseHelper();
    return _baseHelper!;
  }

  Future initDb() async {
    if (_database == null) {
      var dbPath = await getDatabasesPath();
      final path = join(dbPath, _dataBaseName);

      final exist = await databaseExists(path);

      if (exist) {
        //print("Data Base State = Exist");
        await openDatabase(path);
      } else {
        //print('Data Base State = Not Exist');

        try {
          await Directory(dirname(path)).create(recursive: true);
        } catch (_) {}

        ByteData data = await rootBundle.load(join("assets", _dataBaseName));
        List<int> bytes = data.buffer.asUint8ClampedList(data.offsetInBytes, data.lengthInBytes);
        await File(path).writeAsBytes(bytes, flush: true);
        //print('Opened');
      }
      _database = await openDatabase(path, version: 1);
    }
    // List<Map> list = await database.rawQuery('SELECT * FROM quran WHERE field1 = 9996');
    // //print('List ${list.toString()}');
  }

  Future<List<OsmaniWord>> getDetails2(int surahId, int verseNumber) async {
    pr(surahId, 'verse.surahId');
    pr(verseNumber, 'verse.verseNumber');
    String query = '''
SELECT
    id,
    ayat_id,
    sura_id,
    word_ar,
    simple,
    class_name,
    code,
    char_type , 
    page
FROM
    words
WHERE
    sura_id = $surahId
    AND ayat_id = $verseNumber;
''';
    List<Map<String, dynamic>> list = (await _database!.rawQuery(query));
    List<OsmaniWord> osmaniWords = list.map((json) => OsmaniWord.fromJson(json)).toList();
    // pr(osmaniWords, 'query result - getDetails2');
    return osmaniWords;
  }

  // Future<List<List<SuraSearchResultModel>>> getDetails(int suraId, String key) async {
  //   List<List<SuraSearchResultModel>> result = [];

  //   String query =
  //       " select words.code as word_ar, sura.sura_ar, words.simple, words.ayat_id , words.page , ayat.id as ayaId"
  //       " from words, ayat, sura"
  //       " on ayat.ayah=words.ayat_id "
  //       " and words.sura_id=ayat.sura_id "
  //       " and words.sura_id=$suraId "
  //       " and sura.id = $suraId"
  //       " and ayat.simple "
  //       // " and ayat.text_ar "
  //       " 	like"
  //       " 	'%$key%'"
  //       " group by words.id";

  //   List<Map<String, dynamic>> list = await _database!.rawQuery(query);
  //   Map<dynamic, List<Map<String, dynamic>>> newMap = groupBy(list, (Map obj) => obj['ayat_id']);
  //   int linesCount = int.parse(list[list.length - 1]['ayat_id'].toString());

  //   for (var x = 0; x < linesCount; x++) {
  //     if (newMap[newMap.keys.first + x] != null) {
  //       var newMap2 = newMap[newMap.keys.first + x];
  //       List<SuraSearchResultModel> singleAya = [];

  //       for (var i = 0; i < newMap2!.length; i++) {
  //         var aya = SuraSearchResultModel();
  //         pr('finalResult ${newMap2[i]}');
  //         aya.textAr = newMap2[i]['word_ar'];
  //         aya.searchKey = key;
  //         aya.page = newMap2[i]['page'];
  //         aya.simple = newMap2[i]['simple'] ?? " ";
  //         aya.suraAr = newMap2[i]['sura_ar'];
  //         aya.ayaId = newMap2[i]['ayaId'];
  //         pr('finalResult Aya $x - $i ${aya.toJson()}}');

  //         singleAya.add(aya);
  //       }
  //       result.add(singleAya);
  //     }
  //   }

  //   // log('finalResulty ${result[0][0].toJson()}}');
  //   return result;
  // }
}
