import 'package:dio_api_call/view/home/home_controller.dart';
import 'package:get/get.dart';
import '../../api/api_client.dart';
import '../../api/services/recipe_service.dart';

class HomeBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<RecipeService>(() => RecipeService(apiClient.dio));
    Get.lazyPut<HomeController>(() => HomeController(Get.find<RecipeService>()));
  }

}