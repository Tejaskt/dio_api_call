import 'package:dio_api_call/view/recipe_details/recipe_details_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class RecipeDetailsBinding extends Bindings {
  @override
  void dependencies() {
    // RecipeService may already be registered from HomeBinding.
    // fenix: true means GetX won't throw if it already exists —
    // it will reuse the existing instance.
    Get.lazyPut<RecipeDetailsController>(
          () => RecipeDetailsController(),
    );
  }
}