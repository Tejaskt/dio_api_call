import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../core/notifications/notification_route_manager.dart';
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

    if (NotificationRouteManager.hasPendingRecipe) {
      final id = int.parse(
        NotificationRouteManager.recipeId!,
      );

      NotificationRouteManager.clear();

      Get.offAllNamed(RouteName.bottomNavigation);

      Future.delayed(
        const Duration(milliseconds: 300),
            () {
          Get.toNamed(
            RouteName.recipeDetails,
            arguments: id,
          );
        },
      );

      return;
    }

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

    // Check dummy-json token (email login)
    final token = await SecureStorage.getToken();

    // Check Firebase User(Google / facebook)
    final firebaseUser = await SecureStorage.getFirebaseUser();

    final isLoggedIn = (token != null && token.isNotEmpty) || (firebaseUser != null);

    if (isLoggedIn) {
      Get.offAllNamed(RouteName.bottomNavigation);
    } else {
      Get.offAllNamed(RouteName.login);
    }
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}