import 'package:dio_api_call/core/notifications/notification_service.dart';
import 'package:dio_api_call/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:dio_api_call/core/routes/route.dart';
import 'package:dio_api_call/core/routes/route_name.dart';
import 'package:dio_api_call/res/app_strings.dart';

@pragma('vm:entry-point')
Future<void> firebaseBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase - uses the generated firebase_option.dart
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Register Background handler
  FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler);

  await NotificationService().init();

  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          navigatorKey: navigatorKey,
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
          initialRoute: RouteName.splash,
          getPages: AppRoutes.appRoutes ,
        );
      },
    );
  }
}
