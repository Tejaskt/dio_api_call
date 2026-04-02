import 'package:dio_api_call/view/auth/login_binding.dart';
import 'package:dio_api_call/view/bottom_navigation/bottom_navigation_binding.dart';
import 'package:dio_api_call/view/profile/profile_binding.dart';
import 'package:dio_api_call/view/recipe_details/recipe_details_binding.dart';
import 'package:dio_api_call/view/recipe_details/recipe_details_screen.dart';
import 'package:dio_api_call/view/splash/splash_binding.dart';
import 'package:get/get.dart';
import '../../core/routes/route_name.dart';
import '../../view/bottom_navigation/bottom_navigation.dart';
import '../../view/home/home_binding.dart';
import '../../view/profile/profile_screen.dart';
import '../../view/splash/splash_screen.dart';
import '../../view/auth/login_screen.dart';
import '../../view/home/home_screen.dart';

class AppRoutes {
  /* old approach

  static Map<String, WidgetBuilder> routes = {
    RouteName.splash: (_) => SplashScreen(),
    RouteName.login: (_) => LoginScreen(),
    RouteName.home: (_) => HomeScreen(),
    RouteName.profile: (_) => ProfileScreen(),
    RouteName.bottomNavigation: (_) => BottomNavigationView(),
    //  RoutesName.recipeDetails: (_) => RecipeDetailScreen(recipeId: recipeId),
  };
   */

  // get approach
  static final List<GetPage<dynamic>> appRoutes = [
    // SPLASH
    GetPage(
      name: RouteName.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),

    // LOGIN
    GetPage(
      name: RouteName.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),

    // HOME
    GetPage(
      name: RouteName.home,
      page: () => const HomeScreen(),
      binding: HomeBinding()
    ),

    // RECIPE DETAILS
    GetPage(
      name: RouteName.recipeDetails,
      page: () => const RecipeDetailScreen(),
      binding: RecipeDetailsBinding()
    ),

    // PROFILE
    GetPage(
      name: RouteName.profile,
      page: () => const ProfileScreen(),
      binding: ProfileBinding()
    ),

    // BOTTOM NAVIGATION
    GetPage(
      name: RouteName.bottomNavigation,
      page: () => const BottomNavigationView(),
        // HomeBinding and ProfileBinding are registered here because
        // BottomNavigationView hosts both screens simultaneously.
        // BindingsBuilder.put lets you combine multiple bindings.
      binding: BottomNavigationBinding()
    ),
  ];
}
