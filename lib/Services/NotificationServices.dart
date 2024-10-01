import 'package:flutter/cupertino.dart';

class NotificationServices {
  NotificationServices._();

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
                          });
  }

  static Future<void> sendNotificationToAll(String title, String body) async {
    // Send notification to all users
  }
}
