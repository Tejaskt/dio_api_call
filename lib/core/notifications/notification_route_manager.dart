class NotificationRouteManager {
  static String? recipeId;

  static bool get hasPendingRecipe =>
      recipeId != null;

  static void clear() {
    recipeId = null;
  }
}