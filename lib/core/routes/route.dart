import 'package:get/get_navigation/src/routes/get_route.dart';
import '../../core/routes/route_name.dart';
import '../../view/bottom_navigation/bottom_navigation.dart';
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
  static List<GetPage<dynamic>> appRoutes() => [

    // SPLASH
    GetPage(
      name: RouteName.splash,
      page: () => SplashScreen(),
      //binding: ClientBottomNavBinding(),
      //transition: Constants.transition,
    ),

    // LOGIN
    GetPage(
        name: RouteName.login,
        page: () => LoginScreen()
    ),

    // HOME
    GetPage(
        name: RouteName.home,
        page: () => HomeScreen()
    ),

    // PROFILE
    GetPage(
        name: RouteName.profile,
        page: () => ProfileScreen()
    ),

    // BOTTOM NAVIGATION
    GetPage(
        name: RouteName.bottomNavigation,
        page: () => BottomNavigationView()
    ),

  ];
}
