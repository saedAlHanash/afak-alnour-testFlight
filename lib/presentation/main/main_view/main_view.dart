
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/string_manger.dart';
import '../../resources/values_manger.dart';
import '../main_view_model/main_controller.dart';
import '../pages/home_page/view_model/home_controller.dart';
import '../pages/set_my_available_page/view_model/set_my_available_controller.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text(controller.title.value.tr),
            actions: controller.currentIndex.value == 1
                ? [
                    const SizedBox(
                      width: AppSize.s20,
                    ),
                    if (!Get.find<SetMyAvailabelController>().edit.value)
                      IconButton(
                        onPressed: () {
                          Get.find<SetMyAvailabelController>().edit.value =
                              true;
                        },
                        icon: const Icon(Icons.edit),
                        padding: const EdgeInsets.all(AppPadding.p0),
                      ),
                    if (Get.find<SetMyAvailabelController>().edit.value)
                      IconButton(
                        onPressed: () async {
                          Get.find<SetMyAvailabelController>().edit.value =
                              false;
                          await Get.find<SetMyAvailabelController>()
                              .getSchedule();
                        },
                        icon: const Icon(Icons.close),
                        padding: const EdgeInsets.all(AppPadding.p0),
                      ),
                    if (Get.find<SetMyAvailabelController>().edit.value)
                      IconButton(
                        onPressed: () {
                          Get.find<SetMyAvailabelController>().edit.value =
                              false;
                          Get.find<SetMyAvailabelController>().onSaveElement();
                        },
                        icon: const Icon(Icons.save),
                        padding: const EdgeInsets.all(AppPadding.p0),
                      ),
                    const SizedBox(
                      width: AppSize.s10,
                    ),
                  ]
                : controller.currentIndex.value == 0
                    ? [
                        TextButton(
                            onPressed: () {
                              Get.find<HomeController>()
                                  .calendarController
                                  .displayDate = DateTime.now();
                            },
                            child: Text(
                              AppStrings.today.tr,
                              style: Theme.of(context).textTheme.displayLarge,
                              textScaleFactor: 1,
                            )),
                        SizedBox(width: Get.width * 0.05)
                      ]
                    : [],
          ),
          body: controller.pages[controller.currentIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: (int index) {
              controller.onTap(index);
            },
            items:  [
              BottomNavigationBarItem(
                  icon: const Icon(Icons.home_outlined), label: AppStrings.home.tr),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.calendar_month),
                  label: AppStrings.myAvailable.tr),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.table_rows_rounded),
                  label: AppStrings.sessions.tr),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.person), label: AppStrings.profile.tr),
            ],
          ),
        ));
  }
}
