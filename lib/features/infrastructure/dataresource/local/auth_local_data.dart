import 'dart:convert';
import 'package:expatrio_tax_task/core/core.dart';
import 'package:expatrio_tax_task/features/features.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AuthLocalData {
  // get data when there data in present
  Future<User?> getUserData();
  // should to save data when there no data from remote
  Future<void> cacheUserData(User user);
}

const String CACHED_USER_DATA = "CACHED_USER_DATA";

class AuthLocalDataImpl extends AuthLocalData {
  final FlutterSecureStorage storage;
  User? _user;
  User? get user => _user;
  AuthLocalDataImpl({required this.storage});

  @override
  Future<void> cacheUserData(User user) async {
    try {
      await storage.write(
        key: CACHED_USER_DATA,
        value: jsonEncode((user as UserModel).toJson()),
      );
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<User?> getUserData() async {
    User? user;
    try {
      final value = await storage.read(key: CACHED_USER_DATA);
      if (value != null) {
        final jsonData = json.decode(value);
        user = UserModel.fromJson(jsonData);
      }
    } catch (_) {
      throw CacheException();
    }
    _user = user;
    return user;
  }
}
