import 'package:flutter/material.dart';
import '../../core/routes/route_name.dart';
import '../../view/bottom_navigation/bottom_navigation.dart';
import '../../view/profile/profile_screen.dart';
import '../../view/splash/splash_screen.dart';
import '../../view/auth/login_screen.dart';
import '../../view/home/home_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder>  routes = {
    RoutesName.splash: (_) => SplashScreen(),
    RoutesName.login: (_) => LoginScreen(),
    RoutesName.home: (_) => HomeScreen(),
    RoutesName.profile: (_) => ProfileScreen(),
    RoutesName.bottomNavigation: (_) => BottomNavigationView(),
  };
}