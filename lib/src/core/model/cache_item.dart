import 'dart:convert';

class CacheItem<T> {
  final T data;
  final DateTime expiration;

  CacheItem({
    required this.data,
    required this.expiration,
  });

  Map<String, dynamic> toJson(dynamic Function(T data) toJsonT) {
    return {
      'data': jsonEncode(toJsonT(data)),
      'expiration': expiration.toIso8601String(),
    };
  }

  factory CacheItem.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return CacheItem<T>(
      data: fromJsonT(jsonDecode(json['data'])),
      expiration: DateTime.parse(json['expiration']),
    );
  }

  /// Verinin geçerli olup olmadığını kontrol eder.
  bool get isValid => expiration.isAfter(DateTime.now());
}
