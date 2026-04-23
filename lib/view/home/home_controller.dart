import 'package:dio_api_call/res/app_strings.dart';
import 'package:get/get.dart';

import '../../api/model/response/recipe_response.dart';
import '../../api/services/recipe_service.dart';
import '../../core/error/app_exception.dart';

class HomeController extends GetxController {

  final RecipeService _recipeService = RecipeService.shared;
  HomeController();

  // RxList - the ui reacts when items are added/cleared
  final recipes = <Recipe>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  // onInit is called automatically by GetX after the controller
  // is put into memory. Replaces the old ..getRecipe() call-chain
  // you had on ChangeNotifierProvider's create:
  @override
  void onInit() {
    super.onInit();
    fetchRecipes();
  }

  Future<void> fetchRecipes() async{
    isLoading.value = true;
    errorMessage.value = '';

    try{
      final response = await _recipeService.getRecipe();
      final data = response.data;

      if(data == null){
        throw Exception(response.message ?? AppStrings.failedRecipes);
      }
      recipes.assignAll(data);
    }catch(e){
      if (e is AppException) {
        errorMessage.value = e.message;
      } else {
        errorMessage.value = "Something went wrong";
      }
    }finally{
      isLoading.value = false;
    }
  }
}