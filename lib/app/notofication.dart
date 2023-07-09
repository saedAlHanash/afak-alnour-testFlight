import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationApi {
  static final _notification = FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid =
  const AndroidInitializationSettings('mipmap/ic_launcher');


  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload
  }) async => _notification.show(
      id,
      title,
      body,
      const NotificationDetails(
          android: AndroidNotificationDetails(
            'channel Id',
            'channel Name',
            enableVibration: true,
            playSound: true,
            enableLights: true,
            icon: "mipmap/ic_launcher",
            channelDescription: 'channel Description',
            importance: Importance.max,
          ),
          iOS: DarwinNotificationDetails(
            presentSound: true,
            presentAlert: true,
          )
      ),
      payload: payload
  );
}