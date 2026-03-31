import 'package:dio/dio.dart';
import 'package:dio_api_call/api/model/response/recipe_details_response.dart';
import 'package:dio_api_call/core/error/app_exception.dart';
import '../api_end_point.dart';
import '../model/response/recipe_response.dart';

class RecipeService {
  final Dio dio;

  RecipeService(this.dio);

  // get Request for recipes.
  Future<List<Recipe>> getRecipe() async {
    try {
      final response = await dio.get(apiEndPoint.getRecipe);
      final data = response.data;
      final List list = data['recipes'];

      return list.map((e) => Recipe.fromJson(e)).toList();
    } on DioException catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  // get recipe by id
  Future<RecipeDetail> getRecipeDetails(int id) async {
    try {
      final response = await dio.get('${apiEndPoint.getRecipe}/$id');
      final data = response.data;
      return RecipeDetail.fromJson(data);
    } on DioException catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

}
