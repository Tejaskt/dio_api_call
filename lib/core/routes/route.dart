import 'package:flutter/material.dart';
import '../../core/routes/route_name.dart';
import '../../presentation/profile/profile_screen.dart';
import '../../presentation/splash/splash_screen.dart';
import '../../presentation/auth/login_screen.dart';
import '../../presentation/home/home_screen.dart';
import '../../presentation/widgets/bottom_navigation.dart';

class AppRoutes {
  static Map<String, WidgetBuilder>  routes = {
    RoutesName.splash: (_) => SplashScreen(),
    RoutesName.login: (_) => LoginScreen(),
    RoutesName.home: (_) => HomeScreen(),
    RoutesName.profile: (_) => ProfileScreen(),
    RoutesName.bottomNavigation: (_) => BottomNavigationView(),
  };
}