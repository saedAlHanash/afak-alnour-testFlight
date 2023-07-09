
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/app_pref.dart';
import '../../../app/di.dart';
import '../../../domain/models/slider_object_model.dart';
import '../../resources/assets_manger.dart';
import '../../resources/color_manger.dart';
import '../../resources/routes_manger.dart';

class OnBoardingController extends GetxController{
  RxInt currentIndex = 0.obs;
  List<SliderObject>  item = [];
  final AppPreferences _appPreferences = instance<AppPreferences>();

  final PageController pageController = PageController();
  List<SliderObject> getSliderData() => [
    SliderObject(
        ImageAssets.onBoardingImage1, ColorManger.onBoardingColor1),
    SliderObject(
        ImageAssets.onBoardingImage2, ColorManger.onBoardingColor2),
    SliderObject(
        ImageAssets.onBoardingImage3, ColorManger.onBoardingColor3),
  ];



  int goNext() {
    int nextIndex = ++currentIndex.value;
    if (nextIndex == item.length) {
      Get.offAllNamed(Routes.loginRoute);
      _appPreferences.setOnBoardingView(true);
    }
    return nextIndex;
  }

  int goPrevious() {
    int previousIndex = --currentIndex.value;
    if (previousIndex == -1) {
      previousIndex = item.length;
    }
    return previousIndex;
  }

  @override
  void onInit() {
    item = getSliderData();
    super.onInit();
  }

}