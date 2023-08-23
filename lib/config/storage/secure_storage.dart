
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'local_storage.dart';

class SecureStorageAdapter extends Storage {
  final _storage = FlutterSecureStorage();

  @override
  Future<void> setString(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  @override
  Future<String?> getString(String key) async {
    return await _storage.read(key: key);
  }

  @override
  Future<void> setBool(String key, bool value) async {
    await _storage.write(key: key, value: value.toString());
  }

  @override
  Future<bool?> getBool(String key) async {
    final value = await _storage.read(key: key);
    return value == 'true';
  }

  @override
  Future<void> init() {
    throw UnimplementedError();
  }

  @override
  Future<void> remove(String key) async {
    await _storage.delete(key: key);
  }
}

