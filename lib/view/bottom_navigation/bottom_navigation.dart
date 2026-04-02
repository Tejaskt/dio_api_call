import 'package:dio_api_call/view/bottom_navigation/bottom_navigation_controller.dart';
import 'package:dio_api_call/view/home/home_screen.dart';
import 'package:dio_api_call/view//profile/profile_screen.dart';
import 'package:dio_api_call/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/app_strings.dart';

class BottomNavigationView extends GetView<BottomNavigationController> {
  const BottomNavigationView({super.key});

  static const List<Widget> _pages = [HomeScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return  Obx(() =>  (Scaffold(

        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: AppColors.white,
            selectedItemColor: AppColors.orangePrimary,
            currentIndex: controller.currentIndex.value,
            onTap: controller.changePage,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: AppStrings.home),
              BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: AppStrings.profile),
            ]
        ),

        body: IndexedStack(
          index: controller.currentIndex.value,
          children: _pages,
        ),
      )),
    );
  }
}
