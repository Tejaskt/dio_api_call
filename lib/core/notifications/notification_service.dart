import 'package:dio_api_call/core/notifications/local_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'notification_handler.dart';

class NotificationService {
  static bool _initialized = false;

  Future<void> init() async{
    if(_initialized) return;
    _initialized = true;

    final messaging = FirebaseMessaging.instance;

    // request permission - important for android 13+ & ios
    await messaging.requestPermission();
    await LocalNotificationService.init();

    // Get token(for testing)
    String? token = await FirebaseMessaging.instance.getToken();
    print('fcm token : $token');

    // Foreground State Push Notification
    FirebaseMessaging.onMessage.listen(_onForeground);

    // Background State Push Notification
    FirebaseMessaging.onMessageOpenedApp.listen(_onOpened);

    // Terminated State Push Notification
    final initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      _onOpened(initialMessage);
    }
  }

  void _onForeground(RemoteMessage message) {
    final title = message.data['title'] ?? '';
    final body = message.data['body'] ?? '';

    LocalNotificationService.show(title, body);
  }

  void _onOpened(RemoteMessage message) {
    NotificationHandler.handle(message);
  }
}