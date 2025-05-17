class SurahModel {
  int? id;
  String? name;
  String? type;
  int? totalVerses;

  SurahModel({this.id, this.name, this.type, this.totalVerses});

  @override
  String toString() {
    return 'Surah(id: $id, name: $name, type: $type, totalVerses: $totalVerses)';
  }

  factory SurahModel.fromJson(Map<String, dynamic> json) => SurahModel(
    id: json['id'] as int?,
    name: json['name'] as String?,
    type: json['type'] as String?,
    totalVerses: json['total_verses'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'type': type,
    'total_verses': totalVerses,
  };
}
