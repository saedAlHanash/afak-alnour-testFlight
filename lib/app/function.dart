import 'package:flutter/material.dart';

bool validate(String value){
  return value.isEmpty;
}

enum AppLanguage {
  ar,
  en,
}

const englishLocale = Locale('en', 'US');
const arabicLocale = Locale('ar', 'KW');