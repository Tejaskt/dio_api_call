import 'package:dio_api_call/core/component/shimmer_effect.dart';
import 'package:dio_api_call/core/routes/route_name.dart';
import 'package:dio_api_call/view/home/home_controller.dart';
import 'package:dio_api_call/res/app_colors.dart';
import 'package:dio_api_call/res/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../api/model/response/recipe_response.dart';
import '../recipe_details/recipe_details_screen.dart';

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
            //return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage.value.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(controller.errorMessage.value),
                  SizedBox(height: 2.h),
                  ElevatedButton(
                    onPressed: controller.fetchRecipes,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }


          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            //padding: EdgeInsets.symmetric(horizontal : 5.w, vertical: 4.h),
            itemCount: controller.recipes.length,
            itemBuilder: (context, index) {
              return recipeCard(recipe: controller.recipes[index]);
            },
          );
        },
      ),
    );
  }
}


Widget recipeCard({required Recipe recipe}) {
  final totalTime = recipe.prepTime + recipe.cookTime;

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: AppColors.white,
      boxShadow: [
        BoxShadow(blurRadius: 8, color: AppColors.black.withValues(alpha: 0.1)),
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
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Hero(
              tag: 'recipe_${recipe.id}',
              child: Image.network(
                recipe.image,
                height: 10.h,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_,_,_) => const Icon(Icons.broken_image,size: 100),
              ),
            ),
          ),
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: .spaceBetween,
              children: [
                // Name
                Text(
                  recipe.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Rating
                    Row(
                      children: [
                        const Icon(Icons.star, color: AppColors.orange, size: 18),
                        const SizedBox(width: 4),
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
