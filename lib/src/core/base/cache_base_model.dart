mixin CacheModel {
  String get id;

  CacheModel fromJson(dynamic json);

  Map<String, dynamic> toJson();
}
