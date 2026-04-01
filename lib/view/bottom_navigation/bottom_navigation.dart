import 'package:dio_api_call/view/bottom_navigation/bottom_navigation_controller.dart';
import 'package:dio_api_call/view/home/home_screen.dart';
import 'package:dio_api_call/view//profile/profile_screen.dart';
import 'package:dio_api_call/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationView extends StatelessWidget {
  BottomNavigationView({super.key});

  // Looked up once as a field, not on every build()
  final ctrl = Get.put(BottomNavigationController());

  static const List<Widget> _pages = [HomeScreen(), ProfileScreen()];


  @override
  Widget build(BuildContext context) {
    return  Obx(() =>  (Scaffold(

        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: AppColors.white,
            selectedItemColor: AppColors.orangePrimary,
            currentIndex: ctrl.currentIndex.value,
            onTap: ctrl.changePage,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
            ]
        ),

        body: IndexedStack(
          index: ctrl.currentIndex.value,
          children: _pages,
        ),
      )),
    );
  }
}
