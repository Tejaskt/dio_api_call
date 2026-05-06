import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../routes/route_name.dart';
import 'local_notification_service.dart';

class NotificationService {
  NotificationService._();

  static final NotificationService instance =
  NotificationService._();

  static bool _initialized = false;

  int? pendingRecipeId;

  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;

    final messaging = FirebaseMessaging.instance;

    await messaging.requestPermission();

    await LocalNotificationService.init();

    final token = await messaging.getToken();
    print('FCM Token: $token');

    FirebaseMessaging.onMessage.listen(_handleForeground);

    FirebaseMessaging.onMessageOpenedApp.listen(
      _handleBackgroundNavigation,
    );

    final initialMessage =
    await messaging.getInitialMessage();

    if (initialMessage != null) {
      _storePendingNavigation(initialMessage);
    }
  }

  Future<void> _handleForeground(
      RemoteMessage message,
      ) async {
    final notification = message.notification;

    if (notification == null) return;

    await LocalNotificationService.show(
      title: notification.title ?? '',
      body: notification.body ?? '',
    );
  }

  void _handleBackgroundNavigation(
      RemoteMessage message,
      ) {
    final id = message.data['id'];

    if (id == null) return;

    Get.toNamed(
      RouteName.recipeDetails,
      arguments: int.parse(id),
    );
  }

  void _storePendingNavigation(
      RemoteMessage message,
      ) {
    final id = message.data['id'];

    if (id == null) return;

    pendingRecipeId = int.tryParse(id);
  }
}