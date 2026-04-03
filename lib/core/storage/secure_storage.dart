import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../api/model/common/firebase_user.dart';
import '../../api/model/response/login_response.dart';

class SecureStorage {
  static final _storage = const FlutterSecureStorage();

  static const _tokenKey = 'access_token';
  static const _userKey = 'user_data';

  /// Future : “I don’t have the result now, but I promise I’ll give it to you later.”
  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  static Future<void> saveUser(LoginResponse user) async {
    await _storage.write(key: _userKey, value: jsonEncode(user.toJson()));
  }

  static Future<LoginResponse?> getUser() async {
    String? userStr = await _storage.read(key: _userKey);
    if (userStr != null) {
      return LoginResponse.fromJson(jsonDecode(userStr));
    }
    return null;
  }

  static Future<void> clear() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _userKey);
    await _storage.delete(key: _firebaseUserKey);

  }

  // --- Firebase integration --- \\

// Add these methods alongside your existing saveToken/getToken/saveUser/getUser

  static const _firebaseUserKey = 'firebase_user';

  static Future<void> saveFirebaseUser(FirebaseUser user) async {
    await _storage.write(
      key: _firebaseUserKey,
      value: jsonEncode(user.toJson()),
    );
  }

  static Future<FirebaseUser?> getFirebaseUser() async {
    final str = await _storage.read(key: _firebaseUserKey);
    if (str != null) return FirebaseUser.fromJson(jsonDecode(str));
    return null;
  }

}
