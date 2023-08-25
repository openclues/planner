import 'storage/local_storage.dart';
import 'storage/secure_storage.dart';

class AuthTokenSaveAndGet {
  static Future<String?> getAuthToken() async {
    Storage storage = SecureStorageAdapter();
    String? authToken = await storage.getString('auth_token');
    print(authToken);
    return authToken;
  }

  static Future<void> saveAuthToken(String token) async {
    Storage storage = SecureStorageAdapter();
    await storage.setString('auth_token', "Token $token");
  }

  static Future<void> removeAuthToken() async {
    Storage storage = SecureStorageAdapter();

    await storage.remove('auth_token');
  }
}
