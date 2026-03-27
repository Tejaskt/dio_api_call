import 'package:dio_api_call/core/storage/secure_storage.dart';
import 'package:dio_api_call/data/model/request/login_request.dart';
import 'package:dio_api_call/data/model/response/login_response.dart';
import 'package:dio_api_call/domain/repository/auth_repository.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository repository;

  bool isLoading = false;
  String? error;
  LoginResponse? user;

  LoginViewModel(this.repository);

  Future<void> login(String username, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      user = await repository.login(
        LoginRequest(username: username, password: password),
      );

      SecureStorage.saveToken(user!.accessToken);
    } catch (e) {
      error = e.toString();
    }
    notifyListeners();
  }

}
