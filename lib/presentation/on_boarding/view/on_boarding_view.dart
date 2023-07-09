
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../domain/models/slider_object_model.dart';
import '../../resources/color_manger.dart';
import '../../resources/constants_manger.dart';
import '../../resources/string_manger.dart';
import '../../resources/values_manger.dart';
import '../view_model/on_boarding_controller.dart';

class OnBoardingScreen extends GetView<OnBoardingController> {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.white,
      body: PageView.builder(
        controller: controller.pageController,
        itemCount: controller.item.length,
        onPageChanged: (index) {
          controller.currentIndex.value = index;
        },
        itemBuilder: (context, index) {
          return OnBoardingPage(controller.item[index]);
        },
      ),
      appBar: PreferredSize(
          preferredSize: const Size(0, 0),
          child: Obx(
              ()=> AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: controller.currentIndex.value == 0
                      ? ColorManger.onBoardingColor1
                      : controller.currentIndex.value == 1
                          ? ColorManger.onBoardingColor2
                          : ColorManger.onBoardingColor3),
            ),
          )),
      // bottomSheet: BottomSheetOnBoardingWidget(
      //     controller.item[controller.currentIndex], _pageController),
    );
  }
}

class OnBoardingPage extends GetWidget<OnBoardingController> {
  final SliderObject _sliderObject;

  const OnBoardingPage(this._sliderObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: _sliderObject.color,
          child: Center(
            child: Image.asset(
              _sliderObject.image,
              width: AppSize.s300,
              height: AppSize.s300,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          color: _sliderObject.color,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (controller.currentIndex != 0)
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p14),
                  child: GestureDetector(
                    onTap: () {
                      controller.pageController.animateToPage(
                          controller.goPrevious(),
                          duration: const Duration(
                              milliseconds: AppConstants.sliderAnimation),
                          curve: Curves.bounceInOut);
                    },
                    child: Text(
                      AppStrings.back.tr,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textScaleFactor: 1,
                    ),
                  ),
                ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(AppPadding.p14),
                child: GestureDetector(
                  onTap: () {
                    controller.pageController.animateToPage(controller.goNext(),
                        duration: const Duration(
                            milliseconds: AppConstants.sliderAnimation),
                        curve: Curves.bounceInOut);
                  },
                  child: Text(
                    AppStrings.next.tr,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textScaleFactor: 1,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
