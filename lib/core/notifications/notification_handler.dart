import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../routes/route_name.dart';

class NotificationHandler {
  static void handle(RemoteMessage message) {
    final data = message.data;

    switch (data['type']) {
      case 'recipe':
        final id = int.parse(data['id']);
        Get.toNamed(RouteName.recipeDetails, arguments: id);
        break;
    }
  }
}