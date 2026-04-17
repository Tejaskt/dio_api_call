import 'package:dio_api_call/core/constants.dart';
import 'package:dio_api_call/res/app_colors.dart';
import 'package:dio_api_call/res/app_fonts.dart';
import 'package:dio_api_call/res/app_strings.dart';
import 'package:dio_api_call/res/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../res/app_images.dart';
import 'login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) => Obx(
    () => Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Constants.padding20,
              vertical: Constants.padding20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 48.sp,
                  height: 48.sp,
                  decoration: BoxDecoration(
                    color: AppColors.orangePrimary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(
                      Constants.cornerRadius40,
                    ),
                  ),
                  child: Image.asset(AppImages.chefLogo),
                ),

                SpaceH15(),

                Text(
                  AppStrings.welcomeString,
                  style: AppFonts.latoRegular.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: constants.fontSize28px,
                    color: AppColors.orangePrimary,
                  ),
                ),

                SpaceH30(),

                // Controllers now come from the controller, not local fields
                _buildInputField(
                  icon: Icons.person_outline,
                  hint: AppStrings.enterUsername,
                  controller: controller.usernameController,
                  isPassword: false,
                ),

                SpaceH20(),

                //eye icon reacts to isPasswordVisible changes
                _buildInputField(
                  icon: Icons.lock_outline,
                  hint: AppStrings.enterPassword,
                  controller: controller.passwordController,
                  isPassword: true,
                  isVisible: controller.isPasswordVisible.value,
                  onToggleVisibility: controller.togglePasswordVisibility,
                ),

                SpaceH30(),

                // make const widget which doesn't required rebuild
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        // No more async here — controller handles everything
                        onPressed: controller.isLoading.value
                            ? null
                            : controller.login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.orangePrimary,
                          disabledBackgroundColor: AppColors.orangePrimary
                              .withValues(alpha: 0.6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              Constants.cornerRadius40,
                            ),
                          ),
                        ),
                        child: controller.isLoading.value
                            ? SizedBox(
                                width: 20.sp,
                                height: 20.sp,
                                child: CircularProgressIndicator(
                                  color: AppColors.white,
                                ),
                              )
                            : Text(
                                AppStrings.login,
                                style: AppFonts.latoRegular.copyWith(
                                  fontSize: constants.fontSize18px,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),

                    SpaceH30(),

                    // --- DIVIDER ---
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: Constants.padding16,
                      ),
                      child: Row(
                        children: [
                          const Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Constants.padding12,
                            ),
                            child: Text(
                              AppStrings.or,
                              style: TextStyle(
                                color: AppColors.orangeDark,
                                fontSize: constants.fontSize14px,
                              ),
                            ),
                          ),
                          const Expanded(child: Divider()),
                        ],
                      ),
                    ),

                    // --- GOOGLE BUTTON ---
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: controller.isLoading.value
                            ? null
                            : controller.signInWithGoogle,
                        icon: SvgPicture.asset(
                          AppImages.googleIcon,
                          height: 20.sp,
                          width: 20.sp,
                        ),
                        label: Text(
                          AppStrings.continueWithGoogle,
                          style: AppFonts.latoRegular.copyWith(
                            fontSize: constants.fontSize15px,
                            fontWeight: .w600,
                            color: AppColors.black,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColors.orangePrimary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              Constants.cornerRadius40,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SpaceH20(),

                    // --- FACEBOOK BUTTON ---
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: controller.isLoading.value
                            ? null
                            : controller.signInWithFacebook,
                        icon: Icon(
                          Icons.facebook,
                          color: AppColors.white,
                          size: 20.sp,
                        ),
                        label: Text(
                          AppStrings.continueWithFacebook,
                          style: AppFonts.latoRegular.copyWith(
                            fontSize: constants.fontSize15px,
                            fontWeight: .w600,
                            color: AppColors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.fbBtnColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              Constants.cornerRadius40,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SpaceH20(),

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
              ],
            ),
          ),
        ),
      ),
    ),
  );
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
        borderRadius: BorderRadius.circular(Constants.cornerRadius40),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.orangePrimary,
          width: Constants.borderWidth6px,
        ),
        borderRadius: BorderRadius.circular(Constants.cornerRadius40),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: Constants.padding12,
        vertical: Constants.padding16,
      ),
    ),
  );
}
