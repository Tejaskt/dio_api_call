import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {

  static final _storage = const FlutterSecureStorage();

  /// Future : “I don’t have the result now, but I promise I’ll give it to you later.”
  static Future<void> saveToken (String token) async{
    await _storage.write(key: 'access_token', value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: "access_token");
  }

  static Future<void> clear() async {
    await _storage.delete(key: "access_token");
  }

}