import 'package:afaq_alnour_academy/constant/notification_class.dart';
import 'package:bloc/bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'bloc/bloc_observer.dart';
import 'package:flutter/services.dart';

import 'data/local/cache_helper.dart';
import 'data/remote/dio_helper.dart';
import 'firebase_options.dart';
import 'main_controller.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  final notification = message.notification;

  String title = '';
  String body = '';

  if (notification != null) {
    title = notification.title ?? '';
    body = notification.body ?? '';
  } else {
    title = message.data['title'] ?? '';
    body = message.data['body'] ?? '';
  }

  Note.showBigTextNotification(title: title, body: body);
}

/*
keytool -list -v -alias androiddebugkey -keystore %USERPROFILE%\.android\debug.keystore
 */
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Note.initialize();
  await FlutterDownloader.initialize(debug: false, ignoreSsl: true);

  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((message) {
    final notification = message.notification;

    String title = '';
    String body = '';

    if (notification != null) {
      title = notification.title ?? '';
      body = notification.body ?? '';
    } else {
      title = message.data['title'] ?? '';
      body = message.data['body'] ?? '';
    }
    Note.showBigTextNotification(title: title, body: body);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {});

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await CacheHelper.init();
  await DioHelper.init();
  Stripe.publishableKey =
      'pk_test_51LDmtnIaXvRCgKNekxlvu2rSujnL8kidAnZ4W7tYmqAFr6VHGOIAJQTCg0ZpS6cRQVla6J4p56i6pZAjk4pRda670010Zn3GeH';
  try {
    var token = await FirebaseMessaging.instance.getToken();
    CacheHelper.setData(key: 'fireBase_token', value: token);
  } catch (e) {}

  BlocOverrides.runZoned(
    () {
      runApp(
          // DevicePreview(builder: (context) =>
          MyApp()
          // )
          );
    },
    blocObserver: MyBlocObserver(),
  );
}

class Note {
  static Future initialize() async {
    var androidInitialize = const AndroidInitializationSettings('mipmap/ic_launcher');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    await flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  }

  static Future showBigTextNotification({
    var id = 0,
    required String title,
    required String body,
    var payload,
  }) async {
    // var vibrationPattern = Int64List(2);
    // vibrationPattern[0] = 1000;
    // vibrationPattern[1] = 1000;

    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'Afak',
      'Afak App',
      playSound: true,
      importance: Importance.defaultImportance,
      priority: Priority.high,
    );

    var not = const NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.show(
        (DateTime.now().millisecondsSinceEpoch ~/ 1000), title, body, not);
  }
}
