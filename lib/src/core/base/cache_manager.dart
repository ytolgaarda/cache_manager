import 'package:cache_manager/src/core/base/cache_base_model.dart';

abstract class CacheManager {
  const CacheManager({required this.path});

  final String? path;

  Future<void> init({required List<CacheModel> items});

  void remove();
}
