import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../core/notifications/notification_service.dart';
import '../../core/routes/route_name.dart';
import '../../core/storage/secure_storage.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;

  bool _ran = false;

  @override
  void onInit() {
    super.onInit();

    if(_ran) return;
    _ran = true;

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    fadeAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );

    scaleAnimation = Tween<double>(begin: 0.92, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutBack,
      ),
    );

    controller.forward();

    _checkLoginStatus();

  }

  /* What mounted does
     * mounted == true → widget is still in the tree → safe to use context
     * Error :
     * If you try to use context after disposal, Flutter throws an error like:
     * “Looking up a deactivated widget's ancestor is unsafe”

    if (mounted) {
      if (token != null && token.isNotEmpty) {
        Navigator.pushReplacementNamed(context, RouteName.bottomNavigation);
      } else {
        Navigator.pushReplacementNamed(context, RouteName.login);
      }
    }
    */

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2));

    final token = await SecureStorage.getToken();

    final firebaseUser = await SecureStorage.getFirebaseUser();

    final isLoggedIn =
        (token != null && token.isNotEmpty) ||
            (firebaseUser != null);

    if (!isLoggedIn) {
      Get.offAllNamed(RouteName.login);
      return;
    }

    final pendingRecipeId =
        NotificationService.instance.pendingRecipeId;

    if (pendingRecipeId != null) {
      NotificationService.instance.pendingRecipeId = null;

      Get.offAllNamed(RouteName.bottomNavigation);

      await Future.delayed(
        const Duration(milliseconds: 300),
      );

      Get.toNamed(
        RouteName.recipeDetails,
        arguments: pendingRecipeId,
      );

      return;
    }

    Get.offAllNamed(RouteName.bottomNavigation);
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}