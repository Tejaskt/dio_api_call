import 'package:flutter/cupertino.dart';

import '../../api/model/response/recipe_response.dart';
import '../../api/services/recipe_service.dart';

class HomeController extends ChangeNotifier {
  final RecipeService _recipeApi;

  HomeController(this._recipeApi);

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