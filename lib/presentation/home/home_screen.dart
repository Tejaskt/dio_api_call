import 'package:dio_api_call/data/remote/api/services/recipe_service.dart';
import 'package:dio_api_call/presentation/home/recipe_viewmodel.dart';
import 'package:dio_api_call/res/app_colors.dart';
import 'package:dio_api_call/res/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../data/model/response/recipe_response.dart';
import '../../data/remote/api/api_client.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RecipeViewModel(RecipeService(apiClient.dio))..getRecipe(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.home),
          centerTitle: true,
          backgroundColor: AppColors.orangePrimary,
          foregroundColor: AppColors.white,
        ),

        body: Consumer<RecipeViewModel>(
          builder: (context, vm, _) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (vm.error != null) {
              return Center(child: Text(vm.error!));
            }

            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              itemCount: vm.recipes.length,
              itemBuilder: (context, index) {
                return recipeCard(recipe: vm.recipes[index]);
              },
            );
          },
        ),
      ),
    );
  }
}

Widget recipeCard({required Recipe recipe}) {
  final totalTime = recipe.prepTime + recipe.cookTime;

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
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
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Image.network(
            recipe.image,
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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

              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Rating
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 18),
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
      ],
    ),
  );
}
