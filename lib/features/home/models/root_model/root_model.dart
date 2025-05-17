import 'word.dart';

class RootModel {
  int? id;
  String? originWord;
  String? name;
  List<WordModel>? words;

  RootModel({this.id, this.originWord, this.name, this.words});

  @override
  String toString() {
    return 'RootModel(id: $id, originWord: $originWord, name: $name, words: $words)';
  }

  factory RootModel.fromJson(Map<String, dynamic> json) => RootModel(
    id: json['id'] as int?,
    originWord: json['origin_word'] as String?,
    name: json['name'] as String?,
    words:
        (json['words'] as List<dynamic>?)
            ?.map((e) => WordModel.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'origin_word': originWord,
    'name': name,
    'words': words?.map((e) => e.toJson()).toList(),
  };
}
