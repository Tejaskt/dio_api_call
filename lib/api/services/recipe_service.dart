import 'package:dio/dio.dart';
import 'package:dio_api_call/api/api_client.dart';
import 'package:dio_api_call/api/model/response/recipe_details_response.dart';
import 'package:dio_api_call/core/error/app_exception.dart';
import '../api_end_point.dart';
import '../model/response/recipe_response.dart';

class RecipeService {
  static var shared = RecipeService();

  // get Request for recipes.
  Future<ApiResponse<List<Recipe>>> getRecipe() {
    return client.request<List<Recipe>>(
      url: apiEndPoint.getRecipe,
      method: HttpMethod.get,
      fromJson: (data) {
        final List list = data['recipes'];
        return list.map((e) => Recipe.fromJson(e)).toList();
      },
    );
  }

  // get recipe by id
  Future<ApiResponse<RecipeDetail>> getRecipeDetails(int id) {
    return client.request<RecipeDetail>(
      url: '${apiEndPoint.getRecipe}/$id',
      method: HttpMethod.get,
      fromJson: (data) => RecipeDetail.fromJson(data),
    );
  }

}
