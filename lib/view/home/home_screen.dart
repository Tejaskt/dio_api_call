import 'package:dio_api_call/core/component/shimmer_effect.dart';
import 'package:dio_api_call/view/home/home_controller.dart';
import 'package:dio_api_call/res/app_colors.dart';
import 'package:dio_api_call/res/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../api/api_client.dart';
import '../../api/model/response/recipe_response.dart';
import '../../api/services/recipe_service.dart';
import '../recipe_details/recipe_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeController(RecipeService(apiClient.dio))..getRecipe(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.home),
          centerTitle: true,
          backgroundColor: AppColors.orangePrimary,
          foregroundColor: AppColors.white,
        ),

        body: Consumer<HomeController>(
          builder: (context, vm, _) {
            if (vm.isLoading) {
              return const ShimmerEffect();
              //return const Center(child: CircularProgressIndicator());
            }

            if (vm.error != null) {
              return Center(child: Text(vm.error!));
            }

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              //padding: EdgeInsets.symmetric(horizontal : 5.w, vertical: 4.h),
              itemCount: vm.recipes.length,
              itemBuilder: (context, index) {
                return recipeCard(recipe: vm.recipes[index],context: context);
              },
            );
          },
        ),
      ),
    );
  }
}

Widget recipeCard({required Recipe recipe, required BuildContext context}) {
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RecipeDetailScreen(recipeId: recipe.id),
              ),
            );
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
