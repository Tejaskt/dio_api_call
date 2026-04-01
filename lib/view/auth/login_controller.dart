import 'package:dio_api_call/api/services/auth_service.dart';
import 'package:dio_api_call/core/routes/route_name.dart';
import 'package:dio_api_call/core/storage/secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../api/model/request/login_request.dart';

class LoginController extends GetxController {
  /// TextEditingControllers live here so they survive widget rebuilds
  /// and are disposed properly in onClose()
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // .obs makes a variable reactive - Obx() watches it automatically
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final isPasswordVisible = false.obs;

  // Injected via Binding - not created here
  final AuthService _authService;

  LoginController(this._authService);

  // --- LIFECYCLE ---
  // onClose is called automatically by GetX when the controller
  // is removed from memory (when you leave the route).
  // This replaces the dispose() you had in StatefulWidget.
  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // --- Actions ---
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    // validate before hitting the network
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      errorMessage.value = 'Please enter username and password';
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    //notifyListeners(); get x remove this

    try {
      final user = await _authService.login(
        LoginRequest(username: username, password: password),
      );

      await SecureStorage.saveToken(user.accessToken);
      await SecureStorage.saveUser(user);

      // navigation should stay only here not in screen
      Get.offAllNamed(RouteName.bottomNavigation);

    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
