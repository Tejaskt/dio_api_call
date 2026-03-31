import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:dio_api_call/core/routes/route_name.dart';
import 'package:dio_api_call/core/storage/secure_storage.dart';
import 'package:dio_api_call/res/app_colors.dart';
import 'package:dio_api_call/res/app_fonts.dart';
import 'package:dio_api_call/res/app_strings.dart';
import 'package:dio_api_call/api/model/response/login_response.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  LoginResponse? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await SecureStorage.getUser();
    setState(() {
      user = userData;
      isLoading = false;
    });
  }

  void _logout() async {
    await SecureStorage.clear();
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RouteName.login,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.profile),
        centerTitle: true,
        backgroundColor: AppColors.orangePrimary,
        foregroundColor: AppColors.white,
        actions: [
          IconButton(onPressed: _logout, icon: const Icon(Icons.logout)),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : user == null
          ? const Center(child: Text(AppStrings.userNotFound))
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColors.orangePrimary,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 12.w,
                          backgroundColor: AppColors.white,
                          backgroundImage: NetworkImage(user!.image),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          '${user!.firstName} ${user!.lastName}',
                          style: AppFonts.latoRegular.copyWith(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                        Text(
                          '@${user!.username}',
                          style: AppFonts.latoRegular.copyWith(
                            fontSize: 16.sp,
                            color: AppColors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.w),
                    child: Column(
                      children: [
                        _buildInfoTile(
                          Icons.numbers,
                          AppStrings.userId,
                          user!.id.toString(),
                        ),
                        _buildInfoTile(
                          Icons.email,
                          AppStrings.email,
                          user!.email,
                        ),
                        _buildInfoTile(
                          Icons.person,
                          AppStrings.gender,
                          user!.gender,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: ElevatedButton(
                      onPressed: _logout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.redAccent,
                        minimumSize: Size(double.infinity, 5.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text(
                        AppStrings.logout,
                        style: AppFonts.latoRegular.copyWith(
                          fontSize: 16.sp,
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 1.h),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, color: AppColors.orangePrimary),
        title: Text(
          label,
          style: TextStyle(fontSize: 14.sp, color: AppColors.listTileLabel),
        ),
        subtitle: Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
      ),
    );
  }
}
