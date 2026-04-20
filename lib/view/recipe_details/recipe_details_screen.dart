import 'package:dio_api_call/core/component/shimmer_effect.dart';
import 'package:dio_api_call/core/constants.dart';
import 'package:dio_api_call/res/app_fonts.dart';
import 'package:dio_api_call/res/app_strings.dart';
import 'package:dio_api_call/res/spaces.dart';
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
              expandedHeight: 70.sp,
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
                     Icon(Icons.broken_image, size: 16.sp),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(Constants.padding16),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Constants.padding10),
                      child: Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          _infoBox(
                            Row(
                              mainAxisAlignment: .center,
                              children: [
                                Icon(Icons.star,
                                    color: AppColors.orange, size: 18.sp),

                                spaceW8,

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
                    ),
                    spaceH20,

                    _sectionChip(AppStrings.ingredients),
                    spaceH8,

                    ...recipe.ingredients.map(
                          (e) => _contentCard('• $e'),
                    ),

                    spaceH15,
                    _sectionChip(AppStrings.instructions),

                    spaceH8,
                    ...recipe.instructions.asMap().entries.map(
                          (entry) => _contentCard(
                        '${entry.key + 1}. ${entry.value}',
                      ),
                    ),
                    spaceH20
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
            fontSize: constants.fontSize18px,
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
          padding: EdgeInsets.all(Constants.padding12),
          child: Text(
            text,
            style: AppFonts.txtStyle.copyWith(
              fontSize: constants.fontSize16px,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
