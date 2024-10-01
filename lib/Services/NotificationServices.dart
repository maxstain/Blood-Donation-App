import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  NotificationServices();

  static Future<void> sendNotification(String title, String body) async {
    // Send notification to the user
    FlutterLocalNotificationsPlugin().show(
      0,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId',
          'channelName',
          enableVibration: true,
          importance: Importance.max,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  static Future<void> sendNotificationToAll(String title, String body) async {
// Send notification to all users
  }
}
