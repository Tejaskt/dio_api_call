import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../routes/route_name.dart';
import 'notification_payload.dart';
import 'notification_route_manager.dart';

class NotificationNavigation {
  static void handle(RemoteMessage message) {
    final payload = NotificationPayload.fromMap(message.data);

    switch (payload.type) {
      case 'recipe':
        _handleRecipe(payload.id);
        break;
    }
  }

  static void _handleRecipe(String id) {
    if (Get.currentRoute == '/') {
      NotificationRouteManager.recipeId = id;
      return;
    }

    Get.toNamed(
      RouteName.recipeDetails,
      arguments: int.parse(id),
    );
  }
}