
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_controller.dart';
import '../presentation/resources/local_service.dart';
import '../presentation/resources/routes_manger.dart';
import '../presentation/resources/theme_manger.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal();

  static const _instance = MyApp._internal();

  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        title: 'Afaq Alnour Academy Teacher',
        useInheritedMediaQuery: true,
        getPages: pages,
        initialRoute: Routes.splashRoute,
        debugShowCheckedModeBanner: false,
        theme: getApplicationTheme(),
        locale: Get.find<AppController>().lang.value,
        fallbackLocale: LocalizationService.fallbackLocale,
        translations: LocalizationService(),
      ),
    );
  }
}
