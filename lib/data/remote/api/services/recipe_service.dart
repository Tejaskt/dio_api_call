import 'package:dio/dio.dart';
import 'package:dio_api_call/core/error/app_exception.dart';
import 'package:dio_api_call/data/model/response/recipe_response.dart';
import 'package:dio_api_call/data/remote/api/api_end_point.dart';

class RecipeService {
  final Dio dio;
  RecipeService(this.dio);

  // get Request for recipes.
  Future<List<Recipe>> getRecipe() async{
    try{
      final response = await dio.get(
        apiEndPoint.getRecipe,
      );
      final data = response.data;
      final List list = data['recipes'];

      return list.map((e) =>  Recipe.fromJson(e)).toList();
    }on DioException catch(e){
      throw ErrorHandler.handle(e);
    }
  }

}