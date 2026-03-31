import 'package:dio_api_call/view/home/home_screen.dart';
import 'package:dio_api_call/view//profile/profile_screen.dart';
import 'package:dio_api_call/res/app_colors.dart';
import 'package:flutter/material.dart';

class BottomNavigationView extends StatefulWidget {
  const BottomNavigationView({super.key});

  @override
  State<BottomNavigationView> createState() => _BottomNavigationViewState();
}

class _BottomNavigationViewState extends State<BottomNavigationView> {

  int currentPage = 0;
  List<Widget> pages = const [HomeScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.white,
          onTap: (value){
            setState(() {
              currentPage = value;
            });
          },
          selectedItemColor: AppColors.orangePrimary,
          currentIndex: currentPage,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
          ]
      ),

      body: IndexedStack(
        index: currentPage,
        children: pages,
      ),
    );
  }

}
