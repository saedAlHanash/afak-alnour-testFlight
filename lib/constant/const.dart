import 'dart:io';

import 'package:flutter/material.dart';

var primaryfont = 'Cocon';
const BaseUrl = 'http://afaq-alnour.chi-team.com/api/';
const ImageUrl = 'http://afaq-alnour.chi-team.com/';
const MaterialColor AppBarColor = MaterialColor(
  _AppBarColor,
  <int, Color>{
    50: Color(0xFFF3E5F5),
    100: Color(0xFFE1BEE7),
    200: Color(0xFFCE93D8),
    300: Color(0xFFBA68C8),
    400: Color(0xFFAB47BC),
    500: Color(_AppBarColor),
    600: Color(0xFF8E24AA),
    700: Color(0xFF7B1FA2),
    800: Color(0xFF6A1B9A),
    900: Color(0xFF4A148C),
  },
);
const int _AppBarColor = 0xFFFFFFFF;


String getOS()
{
  return Platform.operatingSystem;
}

