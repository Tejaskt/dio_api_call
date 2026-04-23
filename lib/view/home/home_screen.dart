import 'package:dio_api_call/core/component/shimmer_effect.dart';
import 'package:dio_api_call/core/constants.dart';
import 'package:dio_api_call/core/routes/route_name.dart';
import 'package:dio_api_call/res/spaces.dart';
import 'package:dio_api_call/view/home/home_controller.dart';
import 'package:dio_api_call/res/app_colors.dart';
import 'package:dio_api_call/res/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../api/model/response/recipe_response.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.home),
        centerTitle: true,
        backgroundColor: AppColors.orangePrimary,
        foregroundColor: AppColors.white,
      ),
      body: Obx(() {

          if (controller.isLoading.value) {
            return const ShimmerEffect();
          }

          if (controller.errorMessage.value.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  Text(controller.errorMessage.value),
                  SpaceH10(),
                  ElevatedButton(
                    onPressed: controller.fetchRecipes,
                    child: const Text(AppStrings.retry),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: controller.recipes.length,
            itemBuilder: (context, index) {
              return _recipeCard(recipe: controller.recipes[index]);
            },
          );
        },
      ),
    );
  }
}


Widget _recipeCard({required Recipe recipe}) {
  final totalTime = recipe.prepTime + recipe.cookTime;

  return Container(
    margin: EdgeInsets.symmetric(horizontal: Constants.padding16, vertical: Constants.padding12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(Constants.cornerRadius18),
      color: AppColors.white,
      boxShadow: [
        BoxShadow(blurRadius: Constants.blurRadius8, color: AppColors.black.withValues(alpha: 0.1)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // Image
        GestureDetector(
          onTap: (){
            // RecipeDetailBinding reads id in onInit via Get.arguments.
            Get.toNamed(RouteName.recipeDetails,arguments: recipe.id);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(Constants.cornerRadius16)),
            child: Hero(
              tag: 'recipe_${recipe.id}',
              child: Image.network(
                recipe.image,
                height: 38.sp,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_,_,_) => const Icon(Icons.broken_image),
              ),
            ),
          ),
        ),

        Expanded(
          child: Padding(
            padding: EdgeInsets.all(Constants.padding10),
            child: Column(
              crossAxisAlignment: .start,
              mainAxisAlignment: .spaceBetween,
              children: [
                // Name
                Text(
                  recipe.name,
                  style: TextStyle(
                    fontSize: constants.fontSize16px,
                    fontWeight: .bold,
                  ),
                  maxLines: 2,
                  overflow: .ellipsis,
                ),

                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    // Rating
                    Row(
                      children: [
                        Icon(Icons.star, color: AppColors.orange, size: 16.sp),
                        SpaceW5(),
                        Text(recipe.rating.toString()),
                      ],
                    ),

                    // Time
                    Text('$totalTime min'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
