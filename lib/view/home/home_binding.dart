import 'package:dio_api_call/view/home/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings{

  @override
  void dependencies() {
    // Get.lazyPut<RecipeService>(() => RecipeService(apiClient.dio));
    Get.lazyPut<HomeController>(() => HomeController());
  }

}