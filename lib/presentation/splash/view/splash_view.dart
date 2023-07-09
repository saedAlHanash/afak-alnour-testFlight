import 'dart:async';


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/app_pref.dart';
import '../../../app/di.dart';
import '../../resources/assets_manger.dart';
import '../../resources/color_manger.dart';
import '../../resources/constants_manger.dart';
import '../../resources/font_manger.dart';
import '../../resources/routes_manger.dart';
import '../../resources/string_manger.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  _startDelay() {
    _timer =
        Timer(const Duration(milliseconds: AppConstants.splashDelay), _goNext);
  }

  _goNext() {
    if (_appPreferences.getOnBoardingView() != null) {
      if (_appPreferences.getUserToken() != null) {
        Get.offAllNamed(Routes.mainRoute);
      } else {
        Get.offAllNamed(Routes.loginRoute);
      }
    } else {
      Get.offAllNamed(Routes.onBoardingRoute);
    }
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorManger.splashBackGround,
      body: _getContentWidget(height, width),
    );
  }

  Widget _getContentWidget(double height, double width) {
    return Column(
      children: [
        SizedBox(
          height: height * 0.3,
        ),
        Image.asset(
          ImageAssets.logoPath,
          fit: BoxFit.fitHeight,
          width: width,
          height: height * 0.4,
        ),
        SizedBox(
          height: height * 0.03,
        ),
        Text(
          AppStrings.nameAcademy.tr,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontSize: FontSize.s22),
          textScaleFactor: 1,
        ),
        const Spacer(),
        Text(
          AppStrings.poweredBy.tr,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontSize: FontSize.s18),
          textScaleFactor: 1,
        ),
        SizedBox(
          height: height * 0.02,
        ),
      ],
    );
  }
}
