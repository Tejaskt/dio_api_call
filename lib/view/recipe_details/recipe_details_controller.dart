import 'package:dio_api_call/api/services/recipe_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api/model/response/recipe_details_response.dart';

class RecipeDetailsController extends GetxController {

  final RecipeService _recipeService;
  RecipeDetailsController(this._recipeService);

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
      recipe.value = await _recipeService.getRecipeDetails(id);
    } catch (e) {
      errorMessage.value = e.toString();
    }finally{
      isLoading.value = false;
    }

  }
}