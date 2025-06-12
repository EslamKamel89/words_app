class OsmaniWord {
  int? id;
  int? ayatId;
  int? suraId;
  String? wordAr;
  String? simple;
  String? className;
  String? code;
  String? charType;
  int? page;
  OsmaniWord({
    this.id,
    this.ayatId,
    this.suraId,
    this.wordAr,
    this.simple,
    this.className,
    this.code,
    this.charType,
    this.page,
  });

  @override
  String toString() {
    return 'OsmaniWord(id: $id, ayatId: $ayatId, suraId: $suraId, wordAr: $wordAr, simple: $simple, className: $className, page: $page, code: $code, charType: $charType)';
  }

  factory OsmaniWord.fromJson(Map<String, dynamic> json) => OsmaniWord(
    id: json['id'] as int?,
    ayatId: json['ayat_id'] as int?,
    suraId: json['sura_id'] as int?,
    wordAr: json['word_ar'] as String?,
    simple: json['simple'] as String?,
    className: json['class_name'] as String?,
    page: json['page'] as int?,
    code: json['code'] as String?,
    charType: json['char_type'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'ayat_id': ayatId,
    'sura_id': page,
    'word_ar': wordAr,
    'simple': simple,
    'class_name': className,
    'page': page,
    'code': code,
    'char_type': charType,
  };

  OsmaniWord copyWith({
    int? id,
    int? ayatId,
    int? suraId,
    String? wordAr,
    String? simple,
    String? className,
    int? page,
    String? code,
    String? charType,
  }) {
    return OsmaniWord(
      id: id ?? this.id,
      ayatId: ayatId ?? this.ayatId,
      suraId: suraId ?? this.suraId,
      wordAr: wordAr ?? this.wordAr,
      simple: simple ?? this.simple,
      className: className ?? this.className,
      page: page ?? this.page,
      code: code ?? this.code,
      charType: charType ?? this.charType,
    );
  }
}
