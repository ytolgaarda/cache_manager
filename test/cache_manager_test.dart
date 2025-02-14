import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cache_manager/cache_manager.dart';
import 'package:cache_manager/example/model/user_model.dart';
import 'package:cache_manager/example/model/user_cache.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized(); // Flutter servislerini başlat

  late HiveCacheManager cacheManager;
  late UserModel user;

  setUpAll(() async {
    final binding = TestDefaultBinaryMessengerBinding.instance;
    binding.defaultBinaryMessenger.setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/path_provider'),
      (MethodCall methodCall) async {
        if (methodCall.method == 'getApplicationDocumentsDirectory') {
          return Directory.systemTemp.path; // Test için geçici bir dizin döndür
        }
        return null;
      },
    );
  });

  setUp(() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    cacheManager = HiveCacheManager();

    user = UserModel(
      id: '1',
      name: 'John Doe',
      email: 'john.doe@example.com',
      createdAt: DateTime.now(),
    );

    await cacheManager.init(items: []);
  });

  tearDown(() async {
    await Hive.deleteFromDisk();
  });

  test('UserCache set ve get işlemleri', () async {
    final userCache = UserCache(cacheUser: user);

    await cacheManager.setCache<UserCache>(
      'user_cache',
      user.id,
      userCache,
      toJsonT: (data) => data.toJson(),
      cacheDuration: Duration(minutes: 1),
    );

    final cachedUserCache = await cacheManager.getCache<UserCache>(
      'user_cache',
      user.id,
      (json) => UserCache(cacheUser: UserModel.fromMap(json['user'])),
    );

    expect(cachedUserCache, isNotNull);
    expect(cachedUserCache!.id, '1');
    expect(cachedUserCache.cacheUser.name, 'John Doe');
  });
}
