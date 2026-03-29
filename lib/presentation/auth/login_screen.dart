import 'package:dio_api_call/core/routes/route_name.dart';
import 'package:dio_api_call/res/app_colors.dart';
import 'package:dio_api_call/res/app_fonts.dart';
import 'package:dio_api_call/res/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../data/repository/auth_repository_impl.dart';
import '../../data/remote/api/api_client.dart';
import '../../data/remote/api/services/auth_service.dart';
import 'login_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(AuthRepositoryImpl(AuthService(apiClient.dio))),
      child: Scaffold(
        body: Consumer<LoginViewModel>(
          builder: (context, vm, _) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 5.h),
                      Text(
                        AppStrings.welcomeString,
                        style: AppFonts.latoRegular.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.sp,
                          color: AppColors.orangePrimary,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      // username input field
                      inputField(
                        Icons.person_outline,
                        AppStrings.enterUsername,
                        usernameController,
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
                      if (vm.isLoading)
                        const CircularProgressIndicator()
                      else
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              final success = await vm.login(
                                usernameController.text.trim(),
                                passwordController.text.trim(),
                              );
                              if (success && mounted) {
                                Navigator.pushReplacementNamed(context, RoutesName.home);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.orangePrimary,
                              padding: EdgeInsets.symmetric(vertical: 1.5.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: Text(
                              AppStrings.login,
                              style: AppFonts.latoRegular.copyWith(
                                fontSize: 17.sp,
                                color: AppColors.white,
                                fontWeight: FontWeight.bold
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
                            style: const TextStyle(color: Colors.red),
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
}

Widget inputField(
  IconData icon,
  String hintText,
  TextEditingController controller, {
  bool isPassword = false,
}) {
  return TextField(
    controller: controller,
    obscureText: isPassword,
    style: AppFonts.latoRegular.copyWith(color: AppColors.orangeDark),
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: AppColors.orangeDark),
      hintText: hintText,
      hintStyle: TextStyle(color: AppColors.orangePrimary.withOpacity(0.5)),
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
