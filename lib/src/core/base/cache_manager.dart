import 'package:cache_manager/src/core/base/cache_base_model.dart';

/// [TR] Bu sınıf, Cache yönetimini sağlayan bir temel yapı sunar.
/// CacheModel öğelerini yönetmek ve önbellek işlevlerini başlatmak ve kaldırmak için gerekli metodları tanımlar.
/// [EN] This class provides a foundational structure for cache management. It defines the necessary methods to manage CacheModel items
/// and to initialize and remove cache functionality.

abstract class CacheManager {
  const CacheManager({required this.path});

  final String? path;

  Future<void> init({required List<CacheModel> items});

  Future<void> setCache<T>(
    String boxName,
    String key,
    T value, {
    required dynamic Function(T data) toJsonT,
    Duration cacheDuration,
  });

  Future<T?> getCache<T>(
    String boxName,
    String key,
    T Function(Map<String, dynamic> json) fromJsonT,
  );
  void remove();
}
