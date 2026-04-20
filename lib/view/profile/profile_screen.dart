import 'package:dio_api_call/core/constants.dart';
import 'package:dio_api_call/res/spaces.dart';
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
            onPressed: controller.logout,
            icon: const Icon(Icons.logout),
          ),
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

        dynamic user = controller.user.value;
        /*
        if (controller.userLoggedInUsingFirebase.value) {
          user = controller.user.value;
        } else {
          user ??= controller.user.value;
        }
        */

        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: Constants.padding20),
                decoration: BoxDecoration(
                  color: AppColors.orangePrimary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Constants.cornerRadius24),
                    bottomRight: Radius.circular(Constants.cornerRadius24),
                  ),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: Constants.cornerRadius30,
                      backgroundColor: AppColors.white,
                      backgroundImage: NetworkImage(user.image),
                    ),

                    SpaceH20(),

                    Text(
                      controller.userLoggedInUsingFirebase.value
                          ? user.name
                          : '${user.firstName} ${user.lastName}',
                      style: AppFonts.latoRegular.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),

                    Text(
                      controller.userLoggedInUsingFirebase.value
                          ? user.provider
                          : '@${user.username}',
                      style: AppFonts.latoRegular.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(Constants.padding16),
                child: Column(
                  children: [
                    _buildInfoTile(
                      Icons.numbers,
                      AppStrings.userId,
                      controller.userLoggedInUsingFirebase.value ? user.uid.toString() : user.id.toString(),
                    ),
                    _buildInfoTile(Icons.email, AppStrings.email, user.email),

                    controller.userLoggedInUsingFirebase.value
                        ? SizedBox.shrink()
                        : _buildInfoTile(
                            Icons.person,
                            AppStrings.gender,
                            user.gender,
                          ),
                  ],
                ),
              ),
              SpaceH30(),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: Constants.padding16),
                child: ElevatedButton(
                  onPressed: controller.logout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.redAccent,
                    minimumSize: Size(double.infinity, Constants.logoutButtonHeight),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Constants.cornerRadius40),
                    ),
                  ),
                  child: Text(
                    AppStrings.logout,
                    style: AppFonts.latoRegular.copyWith(
                      fontSize: constants.fontSize16px,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              spaceH20
            ],
          ),
        );
      }),
    );
  }
}

Widget _buildInfoTile(IconData icon, String label, String value) {
  return Card(
    margin: EdgeInsets.symmetric(vertical: Constants.padding10),
    elevation: Constants.elevation,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: ListTile(
      leading: Icon(icon, color: AppColors.orangePrimary),
      title: Text(
        label,
        style: TextStyle(fontSize: constants.fontSize14px, color: AppColors.listTileLabel),
      ),
      subtitle: Text(
        value,
        style: TextStyle(
          fontSize: constants.fontSize16px,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
      ),
    ),
  );
}
