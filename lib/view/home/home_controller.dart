import 'package:get/get.dart';

import '../../api/model/response/recipe_response.dart';
import '../../api/services/recipe_service.dart';

class HomeController extends GetxController {

  final RecipeService _recipeService = RecipeService();
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
      final result = await _recipeService.getRecipe();
      recipes.assignAll(result);
    }catch(e){
      errorMessage.value = e.toString();
    }finally{
      isLoading.value = false;
    }
  }
}