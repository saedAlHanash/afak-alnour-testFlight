import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:afak_tetcher/firebase_options.dart';
import 'app/app.dart';
import 'app/app_pref.dart';
import 'app/di.dart';
import 'app/notofication.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(MyApp());

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final AppPreferences appPreferences = instance<AppPreferences>();

  FirebaseMessaging.onMessage.listen((event) {
    NotificationApi.showNotification(
      title: event.notification!.title,
      body: event.notification!.body,
    );
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {});

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  try {
    var firebaseToken = await FirebaseMessaging.instance.getToken();
    appPreferences.setFirebaseToken(firebaseToken!);
  } catch (error) {
    log(error.toString());
  }
}

