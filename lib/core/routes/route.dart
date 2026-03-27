import 'package:dio_api_call/core/routes/route_name.dart';
import 'package:dio_api_call/presentation/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import '../../presentation/auth/login_screen.dart';
import '../../presentation/home/home_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder>  routes = {
    RoutesName.splash: (_) => SplashScreen(),
    RoutesName.login: (_) => LoginScreen(),
    RoutesName.home: (_) => HomeScreen(),
  };
}