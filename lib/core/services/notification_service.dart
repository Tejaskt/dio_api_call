import 'package:dio_api_call/core/services/local_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> init() async{
    // request permission - important for android 13+ & ios
    await _messaging.requestPermission();

    // Get token(for testing)
    String? token = await _messaging.getToken();
    print('fcm token : $token');

    // Foreground message
    FirebaseMessaging.onMessage.listen((RemoteMessage message){
      print('clicked notification');
      final title = message.notification?.title ?? "";
      final body = message.notification?.body ?? "";

      print('foreground received: $title');

      LocalNotificationService.showNotification(title, body);
      //_handleNavigation(message);
    });
  }

  void _handleNavigation(RemoteMessage message){
    final data = message.data;

    if(data['screen'] == 'recipe'){
      final id = int.parse(data['id']);

      // for deep link.
      // navigatorKey.currentState?.pushNamed(
      //   RouteName.recipeDetails,
      //   arguments: id,
      // );
    }
  }
}