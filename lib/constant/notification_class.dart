import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationApi {
static final _notification = FlutterLocalNotificationsPlugin();
var initializationSettingsAndroid =
new AndroidInitializationSettings('ic_launcher_foreground');


static Future showNotification({
  int id = 0,
  String? title,
  String? body,
  String? payload
}) async => _notification.show(
    id,
    title,
    body,
    NotificationDetails(
        android: AndroidNotificationDetails(
          'channel Id',
          'channel Name',
          enableVibration: true,
          playSound: true,
          enableLights: true,
          icon: "ic_launcher_foreground",
          importance: Importance.max,
        ),
    ),
  payload: payload
);
}