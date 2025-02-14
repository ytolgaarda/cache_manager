import 'dart:convert';

/// [TR] CacheItem sınıfı, belirtilen türde verileri saklamak için kullanılır.
/// Bu sınıf verileri JSON formatına dönüştürüp, JSON verisinden nesne oluşturabilir.
/// Ayrıca, her öğenin geçerliliğini kontrol eden bir fonksiyona sahiptir.
/// [EN] The CacheItem class is used to store data of a specified type.
/// It can convert data to and from JSON format and has a method to check the validity of the item.

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

  bool get isValid => expiration.isAfter(DateTime.now());
}
