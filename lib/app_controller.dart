
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/app_pref.dart';
import 'app/di.dart';
import 'app/function.dart';

class AppController extends GetxController {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  late Rx<Locale> lang;

  Future<void> setAppLanguage(String languageType) async {
    await _appPreferences.setLocal(languageType);
  }

  Future<String> getAppLanguage() async {
    String? language = _appPreferences.getLocal() ?? AppLanguage.en.name;
    if (language.isNotEmpty) {
      return language;
    } else {
      // return default lang
      return AppLanguage.en.name;
    }
  }


  @override
  void onInit() async{
    String langCode = await getAppLanguage();
    if (langCode == AppLanguage.en.name) {
      lang = englishLocale.obs;
    } else {
      lang = arabicLocale.obs;
    }
    super.onInit();
  }
}
