import 'package:dio_api_call/api/model/request/login_request.dart';
import 'package:dio_api_call/core/routes/route_name.dart';
import 'package:dio_api_call/res/app_colors.dart';
import 'package:dio_api_call/res/app_fonts.dart';
import 'package:dio_api_call/res/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../api/api_client.dart';
import '../../api/services/auth_service.dart';
import '../../res/app_images.dart';
import 'login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          LoginController(AuthService(apiClient.dio)),
      child: Scaffold(
        body: Consumer<LoginController>(
          builder: (context, vm, _) {
            return SafeArea(
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

                      // username input field
                      inputField(
                        Icons.person_outline,
                        AppStrings.enterUsername,
                        usernameController,
                        isPassword: false,
                      ),
                      SizedBox(height: 3.h),
                      // password input field
                      inputField(
                        Icons.lock_outline,
                        AppStrings.enterPassword,
                        passwordController,
                        isPassword: true,
                      ),

                      SizedBox(height: 5.h),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            final success = await vm.login(
                              usernameController.text.trim(),
                              passwordController.text.trim(),
                            );
                            if (success && mounted) {
                              Navigator.pushReplacementNamed(
                                context,
                                RoutesName.bottomNavigation,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.orangePrimary,
                            padding: EdgeInsets.symmetric(vertical: 1.5.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: vm.isLoading
                              ? const CircularProgressIndicator(
                                  color: AppColors.white,
                                  constraints: BoxConstraints(
                                    minWidth: 22,
                                    minHeight: 22,
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

                      if (vm.error != null)
                        Padding(
                          padding: EdgeInsets.only(top: 2.h),
                          child: Text(
                            vm.error!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: AppColors.red),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget inputField(
    IconData icon,
    String hintText,
    TextEditingController controller, {
    required bool isPassword,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? isPasswordVisible : false,
      style: AppFonts.latoRegular.copyWith(color: AppColors.orangeDark),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.orangeDark),
        hintText: hintText,
        suffixIcon: isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
                icon: Icon(
                  isPasswordVisible
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.orangeDark,
                ),
              )
            : null,
        hintStyle: TextStyle(
          color: AppColors.orangeDark,
        ),
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
}
