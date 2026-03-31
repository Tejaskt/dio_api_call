class RecipeDetail {
  final int id;
  final String name;
  final String image;
  final double rating;
  final int prepTime;
  final int cookTime;
  final int servings;
  final String difficulty;
  final String cuisine;
  final int calories;
  final List<String> ingredients;
  final List<String> instructions;

  RecipeDetail({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.prepTime,
    required this.cookTime,
    required this.servings,
    required this.difficulty,
    required this.cuisine,
    required this.calories,
    required this.ingredients,
    required this.instructions,
  });

  factory RecipeDetail.fromJson(Map<String, dynamic> json) {
    return RecipeDetail(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      rating: (json['rating'] as num).toDouble(),
      prepTime: json['prepTimeMinutes'],
      cookTime: json['cookTimeMinutes'],
      servings: json['servings'],
      difficulty: json['difficulty'],
      cuisine: json['cuisine'],
      calories: json['caloriesPerServing'],
      ingredients: List<String>.from(json['ingredients']),
      instructions: List<String>.from(json['instructions']),
    );
  }
}