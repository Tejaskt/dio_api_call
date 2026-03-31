import 'package:dio_api_call/api/services/recipe_service.dart';
import 'package:flutter/material.dart';

import '../../api/model/response/recipe_details_response.dart';

class RecipeDetailsController extends ChangeNotifier {
  final RecipeService _service;

  RecipeDetailsController(this._service);

  RecipeDetail? recipe;
  bool isLoading = false;
  String? error;

  Future<void> fetchRecipe(int id) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      recipe = await _service.getRecipeDetails(id);
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}