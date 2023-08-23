import 'storage/local_storage.dart';
import 'storage/secure_storage.dart';

class AuthTokenSaveAndGet {
  static Future<String?> getAuthToken() async {
    Storage storage = SecureStorageAdapter();
    String? authToken = await storage.getString('auth_token');
    return authToken;
  }

  static Future<void> saveAuthToken(String token) async {
    Storage storage = SecureStorageAdapter();
    await storage.setString('auth_token', token);
  }

  static Future<void> removeAuthToken() async {
    Storage storage = SecureStorageAdapter();

    await storage.remove('auth_token');
  }
}
