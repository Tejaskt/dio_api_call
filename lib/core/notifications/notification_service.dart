import 'package:firebase_messaging/firebase_messaging.dart';

import 'local_notification_service.dart';
import 'notification_navigation.dart';

class NotificationService {
  NotificationService._();

  static final NotificationService instance =
  NotificationService._();

  static bool _initialized = false;

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
      NotificationNavigation.handle,
    );

    final initialMessage = await messaging.getInitialMessage();

    if (initialMessage != null) {
      NotificationNavigation.handle(initialMessage);
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
}