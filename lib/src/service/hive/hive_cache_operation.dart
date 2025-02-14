import 'package:hive/hive.dart';

import '../../core/base/cache_base_model.dart';
import '../../core/operation/cache_operation.dart';

class HiveCacheOperation<T extends CacheModel> extends CacheOperation<T> {
  late final Box<T> _box;
  HiveCacheOperation() {
    _box = Hive.box<T>(T.toString());
  }

  @override
  void addItem(T item) {
    _box.put(item.id, item);
  }

  @override
  void addAllItems(List<T> items) {
    _box.putAll({for (var e in items) e.id: e});
  }

  @override
  void clear() {
    _box.clear();
  }

  @override
  T? get(String id) {
    return _box.get(id);
  }

  @override
  List<T> getAll() {
    return _box.keys
        .map((key) => _box.get(key))
        .where((element) => element != null)
        .cast<T>()
        .toList();
  }

  @override
  void remove(String id) {
    _box.delete(id);
  }
}
