import 'package:afaq_alnour_academy/constant/notification_class.dart';
import 'package:bloc/bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'bloc/bloc_observer.dart';
import 'package:flutter/services.dart';

import 'data/local/cache_helper.dart';
import 'data/remote/dio_helper.dart';
import 'main_controller.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {

}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterDownloader.initialize(debug: false, ignoreSsl: true);

  FirebaseMessaging.onMessage.listen((event) {
    NotificationApi.showNotification(
      title: event.notification!.title,
      body: event.notification!.body,
    );
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
  });

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
  } catch (e) {
  }

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
