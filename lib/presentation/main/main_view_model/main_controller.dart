
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/string_manger.dart';
import '../pages/home_page/view/home_view.dart';
import '../pages/profile_page/view/profile_view.dart';
import '../pages/session/view/session_view.dart';
import '../pages/session/view_model/session_controller.dart';
import '../pages/set_my_available_page/view/set_my_available_view.dart';

class MainController extends GetxController {
  List<Widget> pages = [
    const HomeView(),
    SetMyAvailableView(),
    const SessionsDetailsView(),
    const ProfileView()
  ];

  List<String> titles = [
    AppStrings.home.tr,
    AppStrings.myAvailable.tr,
    AppStrings.sessionsDetails.tr,
    AppStrings.profile.tr,
  ];
  RxString title = AppStrings.home.tr.obs;
  RxInt currentIndex = 0.obs;

  onTap(int index) {
    currentIndex.value = index;
    title.value = titles[index];
    if (index == 2) {
      Get.find<SessionController>().getCourseItems();
    }
  }
}
