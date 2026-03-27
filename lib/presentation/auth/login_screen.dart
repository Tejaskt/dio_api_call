import 'package:dio_api_call/res/app_colors.dart';
import 'package:dio_api_call/res/app_fonts.dart';
import 'package:dio_api_call/res/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../data/repository/auth_repository_impl.dart';
import '../../core/storage/secure_storage.dart';
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
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          LoginViewModel(AuthRepositoryImpl(AuthService(apiClient.dio))),

      child: Scaffold(
        body: Consumer<LoginViewModel>(
          builder: (context, vm, _) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                child: Column(
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      AppStrings.welcomeString,
                      style: AppFonts.latoRegular.copyWith(
                        fontWeight: .bold,
                        fontSize: 22.sp,
                        color: AppColors.orangePrimary,
                      ),
                    ),

                    SizedBox(height: 4.h),

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
                      isPassword: true
                    ),

                    SizedBox(height: 4.h),

                    SizedBox(
                      width: .infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          vm.login(
                            usernameController.text,
                            passwordController.text,
                          );

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.orangePrimary,
                        ),
                        child: Text(
                          AppStrings.login,
                          style: AppFonts.latoRegular.copyWith(
                            fontSize: 16.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),

                    if (vm.error != null)
                      Text(
                        vm.error!,
                        style: const TextStyle(color: Colors.red),
                      ),

                    SizedBox(height: 4.h),

                    if (vm.isLoading) const CircularProgressIndicator(),
                  ],
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
    style: AppFonts.latoRegular.copyWith(
      color: AppColors.orangeDark
    ),
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: AppColors.orangeDark),
      hintText: hintText,
      hintStyle: TextStyle(color: AppColors.orangePrimary),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.orangePrimary),
        borderRadius: .circular(50),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.orangePrimary),
        borderRadius: .circular(50),
      ),
    ),
  );
}
