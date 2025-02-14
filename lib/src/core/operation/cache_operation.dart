import 'package:cache_manager/src/core/base/cache_base_model.dart';

abstract class CacheOperation<T extends CacheModel> {
  const CacheOperation();

  void addItem(T item);

  void addAllItems(List<T> items);

  void clear();

  List<T> getAll();

  T? get(String id);

  void remove(String id);
}
