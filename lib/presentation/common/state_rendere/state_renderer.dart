
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../app/constants.dart';
import '../../resources/assets_manger.dart';
import '../../resources/color_manger.dart';
import '../../resources/font_manger.dart';
import '../../resources/string_manger.dart';
import '../../resources/styles_manger.dart';
import '../../resources/values_manger.dart';

enum PopUpStateRendererType { popupLoadingState, popupErrorState, successState }

enum FullScreenRendererType {
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,
}

Widget _getItemsColumn(List<Widget> children) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: children,
  );
}

Widget _getAnimatedImage(String animationName, double height, double width) {
  return SizedBox(
    height: height,
    width: width,
    child: Lottie.asset(animationName),
  );
}

Widget _getMessage(String message) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(AppPadding.p18),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: getRegularStyle(color: ColorManger.dark, fontSize: FontSize.s18),
      ),
    ),
  );
}

Future getPopUpDialog(Widget child) async {
  return await Get.defaultDialog(
    radius: AppSize.s14,
    backgroundColor: Colors.transparent,
    content: Container(
      decoration: BoxDecoration(
        color: ColorManger.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(AppSize.s14),
        boxShadow: const [BoxShadow(color: Colors.black26)],
      ),
      child: child,
    ),
    title: Constants.empty
  );
}


Future getPopUpStateRenderer(PopUpStateRendererType popUpStateRendererType,
    {String? errorMessage, String? successMessage}) async {
  switch (popUpStateRendererType) {
    case PopUpStateRendererType.popupLoadingState:
      if (Get.isDialogOpen!) Get.back();
      return getPopUpDialog(_getItemsColumn([
        _getAnimatedImage(JsonAssets.loading, AppSize.s150, AppSize.s150),
        _getMessage(AppStrings.loading.tr),
      ]));
    case PopUpStateRendererType.popupErrorState:
      if (Get.isDialogOpen!) Get.back();
      return getPopUpDialog(_getItemsColumn([
        _getAnimatedImage(JsonAssets.error, AppSize.s150, AppSize.s150),
        _getMessage(errorMessage!),
      ]));
    case PopUpStateRendererType.successState:
      if (Get.isDialogOpen!) Get.back();
      return getPopUpDialog(_getItemsColumn([
        _getAnimatedImage(JsonAssets.success, AppSize.s150, AppSize.s150),
        _getMessage(successMessage!),
      ]));
    default:
      break;
  }
}

Widget getFullScreenStateRenderer(FullScreenRendererType fullScreenRendererType,
    {String? errorMessage, String? emptyMessage}) {
  switch (fullScreenRendererType) {
    case FullScreenRendererType.fullScreenLoadingState:
      return _getItemsColumn([
        _getAnimatedImage(JsonAssets.loading, AppSize.s200, AppSize.s200),
        _getMessage(AppStrings.loading.tr),
      ]);
    case FullScreenRendererType.fullScreenErrorState:
      return _getItemsColumn([
        _getAnimatedImage(JsonAssets.error, AppSize.s200, AppSize.s200),
        _getMessage(errorMessage!),
      ]);
    case FullScreenRendererType.fullScreenEmptyState:
      return _getItemsColumn([
        _getAnimatedImage(JsonAssets.empty, AppSize.s200, AppSize.s200),
        _getMessage(emptyMessage!),
      ]);
  }
}

void appSnackBar(String title, String message) {
  Get.snackbar(title, message,
      titleText: Text(
        title,
        style: Theme.of(Get.context!).textTheme.bodyLarge,
      ),
      messageText: Text(
        message,
        style: Theme.of(Get.context!).textTheme.bodyMedium,
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: ColorManger.purple);
}
