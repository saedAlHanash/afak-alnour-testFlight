
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color_manger.dart';
import 'font_manger.dart';
import 'styles_manger.dart';
import 'values_manger.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    primaryColor: ColorManger.primary,
    primaryColorLight: ColorManger.lightPrimary,
    primaryColorDark: ColorManger.darkPrimary,
    disabledColor: ColorManger.grey,
    splashColor: ColorManger.purple,
    unselectedWidgetColor: ColorManger.purple,


    cardTheme: CardTheme(
        color: ColorManger.white,
        shadowColor: ColorManger.grey,
        elevation: AppSize.s4),


    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: AppSize.s10,
        type: BottomNavigationBarType.fixed,
        backgroundColor: ColorManger.background,
        selectedLabelStyle:
            getBoldStyle(color: ColorManger.purple, fontSize: FontSize.s16),
        unselectedLabelStyle:
            getRegularStyle(color: ColorManger.grey, fontSize: FontSize.s14),
        selectedItemColor: ColorManger.purple,
        unselectedItemColor: ColorManger.grey),


    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManger.background,
      elevation: AppSize.s0,
      shadowColor: ColorManger.grey,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      titleTextStyle:
          getBoldStyle(color: ColorManger.purple, fontSize: FontSize.s20),
      actionsIconTheme: IconThemeData(
        color: ColorManger.purple,
        size: AppSize.s28
      )
    ),

    scaffoldBackgroundColor: ColorManger.background,


    buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        disabledColor: ColorManger.grey,
        buttonColor: ColorManger.purple,
        splashColor: ColorManger.primary),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle:
                getBoldStyle(color: ColorManger.white, fontSize: FontSize.s18), backgroundColor: ColorManger.purple,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12)))),


    textTheme: TextTheme(
      bodySmall:
          getLightStyle(color: ColorManger.white, fontSize: FontSize.s12),
      bodyMedium:
          getRegularStyle(color: ColorManger.white, fontSize: FontSize.s16),
      bodyLarge: getBoldStyle(color: ColorManger.white, fontSize: FontSize.s20),
      titleSmall:
          getLightStyle(color: ColorManger.textColor, fontSize: FontSize.s12),
      titleMedium:
          getRegularStyle(color: ColorManger.textColor, fontSize: FontSize.s16),
      titleLarge: getBoldStyle(color: ColorManger.textColor, fontSize: FontSize.s20),
      displaySmall:
          getLightStyle(color: ColorManger.purple, fontSize: FontSize.s12),
      displayMedium:
          getRegularStyle(color: ColorManger.purple, fontSize: FontSize.s16),
      displayLarge:
          getBoldStyle(color: ColorManger.purple, fontSize: FontSize.s20),
    ),


    inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        hintStyle:
            getRegularStyle(color: ColorManger.purple, fontSize: FontSize.s18),
        labelStyle:
            getLightStyle(color: ColorManger.purple, fontSize: FontSize.s18),
        errorStyle: getRegularStyle(color: ColorManger.error),
        filled: true,
        fillColor: ColorManger.primary,
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManger.primary, width: AppSize.s1_5),
            borderRadius: BorderRadius.circular(AppSize.s8)),
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManger.primary, width: AppSize.s1_5),
            borderRadius: BorderRadius.circular(AppSize.s8)),
        errorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManger.error, width: AppSize.s1_5),
            borderRadius: BorderRadius.circular(AppSize.s8)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManger.primary, width: AppSize.s1_5),
            borderRadius: BorderRadius.circular(AppSize.s8))),
  );
}
