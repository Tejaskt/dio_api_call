import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await _plugin.initialize(settings: const InitializationSettings(android: android));
  }

  static Future<void> show(String title, String body) async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'recipe_channel',
        'Recipe Notifications',
        importance: Importance.max,
        priority: Priority.high,
      )
    );

    await _plugin.show(
        id: 0,
        title: title,
        body: body,
        notificationDetails: details
    );
  }
}