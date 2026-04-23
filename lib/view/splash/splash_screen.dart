import 'package:dio_api_call/res/app_colors.dart';
import 'package:dio_api_call/res/app_images.dart';
import 'package:dio_api_call/res/app_strings.dart';
import 'package:dio_api_call/res/spaces.dart';
import 'package:dio_api_call/view/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          //final h = constraints.maxHeight;

          final iconSize = w * 0.22;
          final logoSize = w * 0.7;

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.orangeLight, AppColors.orangeDark],
                begin: .topCenter,
                end: .bottomCenter,
              ),
            ),
            child: Center(
              child: FadeTransition(
                opacity: controller.fadeAnimation,
                child: ScaleTransition(
                  scale: controller.scaleAnimation,
                  child: Column(
                    mainAxisAlignment: .center,
                    children: [
                      // logo container
                      Container(
                        width: iconSize,
                        height: iconSize,
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(iconSize / 3),
                        ),
                        child: Image.asset(AppImages.chefLogo),
                      ),

                      SpaceH10(),

                      // Title
                      Text(
                        AppStrings.appName,
                        style: theme.textTheme.headlineLarge?.copyWith(
                          color: AppColors.white,
                          letterSpacing: 0.5,
                        ),
                      ),

                      SpaceH10(),

                      // Subtitle
                      Text(
                        AppStrings.appMoto,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.white.withValues(alpha: 0.85),
                        ),
                      ),

                      SpaceH10(),

                      // Logo
                      Image.asset(
                        AppImages.appLogo,
                        width: logoSize,
                        height: logoSize,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
