
import 'package:flutter/material.dart';

import '../../app/constants.dart';
import '../resources/color_manger.dart';
import '../resources/values_manger.dart';

showSnackBar(context, {required String msg}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      msg,
      style: Theme.of(context).textTheme.bodyLarge,
      textScaleFactor: 1,
    ),
    behavior: SnackBarBehavior.floating,
    backgroundColor: ColorManger.purple,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s10)),
    duration: const Duration(seconds: Constants.snackBarSecond),
  ));
}
