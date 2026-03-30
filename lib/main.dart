import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:dio_api_call/core/routes/route.dart';
import 'package:dio_api_call/core/routes/route_name.dart';
import 'package:dio_api_call/res/app_strings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          title: AppStrings.appName,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF6C63FF),
              brightness: Brightness.light,
            ),
            textTheme: const TextTheme(
              headlineLarge: TextStyle(
                fontSize: 34,
                fontWeight: .bold
              ),
              bodyLarge: TextStyle(
                fontSize: 16
              )
            )
          ),
          initialRoute: RoutesName.splash,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}
