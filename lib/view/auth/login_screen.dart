import 'package:dio_api_call/res/app_colors.dart';
import 'package:dio_api_call/res/app_fonts.dart';
import 'package:dio_api_call/res/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../res/app_images.dart';
import 'login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: AppColors.orangePrimary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Image.asset(AppImages.chefLogo),
                ),

                SizedBox(height: 5.h),
                Text(
                  AppStrings.welcomeString,
                  style: AppFonts.latoRegular.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.sp,
                    color: AppColors.orangePrimary,
                  ),
                ),
                SizedBox(height: 5.h),

                // Controllers now come from the controller, not local fields
                _buildInputField(
                  icon: Icons.person_outline,
                  hint: AppStrings.enterUsername,
                  controller: controller.usernameController,
                  isPassword: false,
                ),
                SizedBox(height: 3.h),

                // Obx here so the eye icon reacts to isPasswordVisible changes
                Obx(
                  () => _buildInputField(
                    icon: Icons.lock_outline,
                    hint: AppStrings.enterPassword,
                    controller: controller.passwordController,
                    isPassword: true,
                    isVisible: controller.isPasswordVisible.value,
                    onToggleVisibility: controller.togglePasswordVisibility,
                  ),
                ),

                SizedBox(height: 5.h),

                // Obx wraps the button AND error text together.
                // They are the only things that need to rebuild.
                // The logo, title, and input fields above do NOT rebuild.
                Obx(
                  () => Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          // No more async here — controller handles everything
                          onPressed: controller.isLoading.value ? null : controller.login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.orangePrimary,
                            disabledBackgroundColor: AppColors.orangePrimary
                                .withValues(alpha: 0.6),
                            padding: EdgeInsets.symmetric(vertical: 1.5.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: controller.isLoading.value
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    color: AppColors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : Text(
                                  AppStrings.login,
                                  style: AppFonts.latoRegular.copyWith(
                                    fontSize: 17.sp,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),

                      if (controller.errorMessage.value.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: 2.h),
                          child: Text(
                            controller.errorMessage.value,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: AppColors.red),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Extracted to a private method — cleaner than a method inside State
Widget _buildInputField({
  required IconData icon,
  required String hint,
  required TextEditingController controller,
  required bool isPassword,
  bool isVisible = false,
  VoidCallback? onToggleVisibility,
}) {
  return TextField(
    controller: controller,
    obscureText: isPassword && !isVisible,
    style: AppFonts.latoRegular.copyWith(color: AppColors.orangeDark),
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: AppColors.orangeDark),
      hintText: hint,
      hintStyle: TextStyle(color: AppColors.orangeDark),
      suffixIcon: isPassword
          ? IconButton(
              onPressed: onToggleVisibility,
              icon: Icon(
                isVisible
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.orangeDark,
              ),
            )
          : null,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.orangePrimary),
        borderRadius: BorderRadius.circular(50),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.orangePrimary, width: 2),
        borderRadius: BorderRadius.circular(50),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
    ),
  );
}

