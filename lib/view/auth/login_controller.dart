import 'package:dio_api_call/api/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:dio_api_call/core/storage/secure_storage.dart';
import '../../api/model/request/login_request.dart';
import '../../api/model/response/login_response.dart';

class LoginController extends ChangeNotifier {
  final AuthService _authApi;

  bool isLoading = false;
  String? error;
  LoginResponse? user;

  LoginController(this._authApi);

  Future<bool> login(String username, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      user = await _authApi.login(
        LoginRequest(username: username, password: password),
      );

      await SecureStorage.saveToken(user!.accessToken);
      await SecureStorage.saveUser(user!);

      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      error = e.toString();
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
