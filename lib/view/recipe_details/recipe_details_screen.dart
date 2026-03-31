import 'package:dio_api_call/api/api_client.dart';
import 'package:dio_api_call/core/component/shimmer_effect.dart';
import 'package:dio_api_call/view/recipe_details/recipe_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../api/services/recipe_service.dart';
import '../../res/app_colors.dart';

class RecipeDetailScreen extends StatelessWidget {
  final int recipeId;

  const RecipeDetailScreen({super.key, required this.recipeId});

  static final txtStyle = TextStyle(
    fontFamily: 'Lato',
    fontSize: 18.sp,
    fontWeight: .bold,
  );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          RecipeDetailsController(RecipeService(apiClient.dio))
            ..fetchRecipe(recipeId),
      child: Scaffold(
        body: Consumer<RecipeDetailsController>(
          builder: (context, vm, _) {
            if (vm.isLoading) {
              return const Scaffold(body: ShimmerEffect());
              //return const Center(child: CircularProgressIndicator());
            }

            if (vm.error != null) {
              return Center(child: Text(vm.error!));
            }

            final recipe = vm.recipe!;

            final totalTime = recipe.prepTime + recipe.cookTime;

            return CustomScrollView(
              slivers: [
                //  IMAGE APPBAR
                SliverAppBar(
                  iconTheme: IconThemeData(color: AppColors.white),
                  backgroundColor: AppColors.orangePrimary,
                  expandedHeight: 250,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: ColoredBox(
                      color: AppColors.orangePrimary.withValues(alpha: 0.6),
                      child: Text(
                        recipe.name,
                        maxLines: 1,
                        style: TextStyle(color: AppColors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    background: Hero(
                      tag: "recipe_${recipe.id}",
                      child: Image.network(
                        recipe.image,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) =>
                            const Icon(Icons.broken_image, size: 100),
                      ),
                    ),
                  ),
                ),

                // CONTENT
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // INFO ROW
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.black),
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                child: Row(
                                  mainAxisAlignment: .center,
                                  spacing: 8,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: AppColors.orange,
                                      size: 18.sp,
                                    ),
                                    Text("${recipe.rating}", style: txtStyle),
                                  ],
                                ),
                              ),
                            ),

                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.black),
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                child: Center(
                                  child: Text(
                                    "$totalTime min",
                                    style: txtStyle,
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.black),
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                child: Center(
                                  child: Text(
                                    "${recipe.servings} servings",
                                    style: txtStyle,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // INGREDIENTS
                        Center(
                          child: Chip(
                            label: Text(
                              "Ingredients",
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        ...recipe.ingredients.map(
                          (e) => SizedBox(
                            width: .infinity,
                            child: Card(
                              color: AppColors.orangeLight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "• $e",
                                  style: txtStyle.copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: .normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // INSTRUCTIONS
                        Center(
                          child: Chip(
                            label: Text(
                              "Instructions",
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        ...recipe.instructions.asMap().entries.map(
                          (entry) => SizedBox(
                            width: .infinity,
                            child: Card(
                              color: AppColors.orangeLight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${entry.key + 1}. ${entry.value}",
                                  style: txtStyle.copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: .normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
