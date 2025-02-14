import 'package:cache_manager/src/core/base/cache_base_model.dart';
import 'package:cache_manager/src/core/base/cache_manager.dart';
import 'package:cache_manager/src/core/model/cache_item.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

/// [TR] HiveCacheManager sınıfı, Hive veritabanı kullanarak önbellek yönetimi sağlar.
/// Bu sınıf, verileri önbelleğe eklemek, almak ve silmek için gerekli işlemleri içerir.
/// Ayrıca, önbellek öğelerinin belirli bir süre için geçerli olmasını sağlar.
/// [EN] The HiveCacheManager class provides cache management using the Hive database.
/// This class includes operations for adding, retrieving, and deleting cached data,
/// and also ensures that cache items are valid for a certain duration.

class HiveCacheManager extends CacheManager {
  HiveCacheManager({super.path});

  @override
  Future<void> init({required List<CacheModel> items}) async {
    final directory = path ?? (await getApplicationDocumentsDirectory()).path;
    Hive.init(directory);

    /*    for (final item in items) {
      Hive.registerAdapter(item.runtimeType);
    } */
  }

  @override
  void remove() => Hive.deleteFromDisk();

  Future<Box> _openBox(String boxName) async => await Hive.openBox(boxName);

  @override
  Future<void> setCache<T>(
    String boxName,
    String key,
    T value, {
    required dynamic Function(T data) toJsonT,
    Duration cacheDuration = const Duration(hours: 1),
  }) async {
    final box = await _openBox(boxName);

    final cacheItem = CacheItem<T>(
        data: value, expiration: DateTime.now().add(cacheDuration));

    await box.put(key, cacheItem.toJson(toJsonT));
  }

  @override
  Future<T?> getCache<T>(
    String boxName,
    String key,
    T Function(Map<String, dynamic> json) fromJsonT,
  ) async {
    final box = await _openBox(boxName);
    final cachedData = box.get(key);
    if (cachedData != null && cachedData is Map) {
      try {
        final cacheItem = CacheItem<T>.fromJson(
          Map<String, dynamic>.from(cachedData),
          fromJsonT,
        );
        if (cacheItem.isValid) {
          return cacheItem.data;
        } else {
          await box.delete(key);
        }
      } catch (e) {
        await box.delete(key);
      }
    }
    return null;
  }
}
