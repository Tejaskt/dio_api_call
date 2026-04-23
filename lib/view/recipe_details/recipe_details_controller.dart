import 'package:dio_api_call/api/services/recipe_service.dart';
import 'package:dio_api_call/res/app_strings.dart';
import 'package:get/get.dart';
import '../../api/model/response/recipe_details_response.dart';
import '../../core/error/app_exception.dart';

class RecipeDetailsController extends GetxController {

  final RecipeService _recipeService = RecipeService.shared;
  RecipeDetailsController();

 final recipe = Rxn<RecipeDetail>();
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit(){
    super.onInit();
    // Get.arguments is how GetX passes data between routes.
    // HomeScreen calls Get.toNamed(RouteName.recipeDetails, arguments: recipe.id)
    // We read that id here — no constructor parameter needed on the screen.
    final recipeId = Get.arguments as int;
    fetchRecipe(recipeId);
  }

  Future<void> fetchRecipe(int id) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {

      final response = await _recipeService.getRecipeDetails(id);

      final data = response.data;

      if(data == null){
        throw Exception(response.message ?? AppStrings.failedRecipes);
      }

      recipe.value = data;
    } catch (e) {
      if (e is AppException) {
        errorMessage.value = e.message;
      } else {
        errorMessage.value = AppStrings.somethingWentWrong;
      }
    }finally{
      isLoading.value = false;
    }

  }
}