
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_controller.dart';
import 'lang/ar_AR.dart';
import 'lang/en_EN.dart';

class LocalizationService extends Translations {
  static const fallbackLocale = Locale('en', 'US');

  static final langs = [
    'en',
    'ar',
  ];

  static final locales = [
    const Locale('en', 'US'),
    const Locale('ar', 'KW'),
  ];

  @override
  Map<String, Map<String, String>> get keys => {'en_US': en_EN, 'ar_AR': ar_AR};

  static void changeLocale(String lang) {
    final locale = getLocaleFromLanguage(lang);
    Get.find<AppController>().lang.value = locale;
    Get.find<AppController>().setAppLanguage(lang);
    Get.updateLocale(locale);
    print(Get.find<AppController>().lang.value);
    //StorageController().lang = lang;
  }

  static Locale getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale ?? const Locale('ar', 'KW');
  }
}