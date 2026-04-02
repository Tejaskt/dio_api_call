import 'package:get/get.dart';
import '../home/home_binding.dart';
import '../profile/profile_binding.dart';
import 'bottom_navigation_controller.dart';

class BottomNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavigationController>(() => BottomNavigationController());
    HomeBinding().dependencies();
    ProfileBinding().dependencies();
  }

}