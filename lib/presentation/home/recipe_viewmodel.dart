import 'package:dio_api_call/data/model/response/recipe_response.dart';
import 'package:dio_api_call/data/remote/api/services/recipe_service.dart';
import 'package:flutter/cupertino.dart';

class RecipeViewModel extends ChangeNotifier {
  final RecipeService _recipeApi;

  RecipeViewModel(this._recipeApi);

  List<Recipe> recipes = [];
  bool isLoading = false;
  String? error;

  Future<void> getRecipe() async{
    isLoading = true;
    error = null;
    notifyListeners();

    try{
      recipes = await _recipeApi.getRecipe();
    }catch(e){
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}