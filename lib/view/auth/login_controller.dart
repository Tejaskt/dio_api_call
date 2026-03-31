import 'package:dio_api_call/api/services/auth_service.dart';
import 'package:dio_api_call/core/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:dio_api_call/core/storage/secure_storage.dart';
import 'package:get/get.dart';
import '../../api/model/request/login_request.dart';
import '../../api/model/response/login_response.dart';

class LoginController extends GetxController {

  // .obs makes a variable reactive - Obx() watches it automatically
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  final AuthService _authApi;
  LoginController(this._authApi);

  LoginResponse? user;


  Future<void> login(String username, String password) async {
    isLoading.value = true;
    errorMessage.value = '';

    //notifyListeners(); get x remove this

    try {
      user = await _authApi.login(
        LoginRequest(username: username, password: password),
      );

      await SecureStorage.saveToken(user!.accessToken);
      await SecureStorage.saveUser(user!);

      Get.offAllNamed(RouteName.home);
    } catch (e) {
      errorMessage.value = e.toString();
    }finally{
      isLoading.value = false;
    }
  }
}
