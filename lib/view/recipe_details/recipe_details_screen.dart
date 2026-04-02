import 'package:dio_api_call/core/component/shimmer_effect.dart';
import 'package:dio_api_call/res/app_fonts.dart';
import 'package:dio_api_call/res/app_strings.dart';
import 'package:dio_api_call/view/recipe_details/recipe_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../res/app_colors.dart';

class RecipeDetailScreen extends GetView<RecipeDetailsController> {
  const RecipeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Scaffold(body: ShimmerEffect());
      }

      if (controller.errorMessage.value.isNotEmpty) {
        return Scaffold(
          body: Center(child: Text(controller.errorMessage.value)),
        );
      }

      final recipe = controller.recipe.value!;
      final totalTime = recipe.prepTime + recipe.cookTime;

      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              iconTheme: const IconThemeData(color: AppColors.white),
              backgroundColor: AppColors.orangePrimary,
              expandedHeight: 250,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: ColoredBox(
                  color: AppColors.orangePrimary.withValues(alpha: 0.6),
                  child: Text(
                    recipe.name,
                    maxLines: 1,
                    style: const TextStyle(color: AppColors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                background: Hero(
                  tag: 'recipe_${recipe.id}',
                  child: Image.network(
                    recipe.image,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) =>
                    const Icon(Icons.broken_image, size: 100),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        _infoBox(
                          Row(
                            mainAxisAlignment: .center,
                            children: [
                              Icon(Icons.star,
                                  color: AppColors.orange, size: 18),
                              const SizedBox(width: 8),
                              Text('${recipe.rating}', style: AppFonts.txtStyle),
                            ],
                          ),
                        ),
                        _infoBox(
                          Center(
                            child: Text('$totalTime min', style: AppFonts.txtStyle),
                          ),
                        ),
                        _infoBox(
                          Center(
                            child: Text(
                              '${recipe.servings} servings',
                              style: AppFonts.txtStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _sectionChip(AppStrings.ingredients),
                    const SizedBox(height: 8),
                    ...recipe.ingredients.map(
                          (e) => _contentCard('• $e'),
                    ),
                    const SizedBox(height: 16),
                    _sectionChip(AppStrings.instructions),
                    const SizedBox(height: 8),
                    ...recipe.instructions.asMap().entries.map(
                          (entry) => _contentCard(
                        '${entry.key + 1}. ${entry.value}',
                      ),
                    ),
                    SizedBox(height: 4.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _infoBox(Widget child) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.black),
          borderRadius: BorderRadius.circular(0),
        ),
        child: child,
      ),
    );
  }

  Widget _sectionChip(String label) {
    return Center(
      child: Chip(
        label: Text(
          label,
          style: AppFonts.txtStyle.copyWith(
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget _contentCard(String text) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: AppColors.orangeLight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: AppFonts.txtStyle.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
