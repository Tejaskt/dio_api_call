import 'package:dio_api_call/view/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:dio_api_call/res/app_colors.dart';
import 'package:dio_api_call/res/app_fonts.dart';
import 'package:dio_api_call/res/app_strings.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.profile),
        centerTitle: true,
        backgroundColor: AppColors.orangePrimary,
        foregroundColor: AppColors.white,
        actions: [
          IconButton(
              onPressed: controller.logout, icon: const Icon(Icons.logout)),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // make proper flow of showing user data into profile screen.
        // if (controller.user.value == null) {
        //   return const Center(child: Text(AppStrings.userNotFound));
        // }

        final user = controller.firebaseUser.value;//controller.user.value ?? controller.firebaseUser.value;
        return SingleChildScrollView(
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
                      user.provider,//'${user.firstName } ${user.lastName}',
                      style: AppFonts.latoRegular.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                    Text(
                       user.name,//'@${user.username}',
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
                      user.uid.toString(),
                    ),
                    _buildInfoTile(
                      Icons.email,
                      AppStrings.email,
                      user.email,
                    ),
                    /*
                    _buildInfoTile(
                      Icons.person,
                      AppStrings.gender,
                      user.gender,
                    ),
                     */
                  ],
                ),
              ),
              SizedBox(height: 4.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: ElevatedButton(
                  onPressed: controller.logout,
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
              SizedBox(height: 4.h)
            ],
          ),
        );
      }),
    );
  }
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

