
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationApi{
  static final _notifications=FlutterLocalNotificationsPlugin();

  static Future _notificationDetails() async {
    return NotificationDetails(

      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'channel description',
        importance: Importance.max,
        playSound: true
      ),
      iOS: IOSNotificationDetails()
    );
  }

  static Future showNotification({
  int id=0, String?title,String?body
}) async=>({
    _notifications.show(id, title, body,   await _notificationDetails())
  });
}