import 'package:cache_manager/cache_manager.dart';
import 'package:cache_manager/example/model/user_model.dart';

class UserCache extends CacheModel {
  final UserModel cacheUser;

  UserCache({required this.cacheUser}) : super(cacheUser.id);

  @override
  UserCache fromJson(Map<String, dynamic> json) {
    return UserCache(
      cacheUser: UserModel.fromMap(json['user']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': cacheUser.toMap(),
    };
  }
}
