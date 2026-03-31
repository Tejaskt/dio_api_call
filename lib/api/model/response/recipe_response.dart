class Recipe {
  final int id;
  final String name;
  final String image;
  final double rating;
  final int prepTime;
  final int cookTime;

  Recipe({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.prepTime,
    required this.cookTime,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      rating: (json['rating'] as num).toDouble(),
      prepTime: json['prepTimeMinutes'],
      cookTime: json['cookTimeMinutes'],
    );
  }
}