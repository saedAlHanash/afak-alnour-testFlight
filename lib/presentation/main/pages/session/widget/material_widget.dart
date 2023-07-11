
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resources/color_manger.dart';
import '../../../../resources/string_manger.dart';
import '../view_model/session_controller.dart';
import 'resources_item.dart';

class MaterialWidget extends GetView<SessionController> {
  const MaterialWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.05, vertical: Get.height * 0.05),
      child: controller.sessionByIdModel == null
          ? Center(
              child: Text(
                AppStrings.selectCourseToShowMaterials.tr,
                style: Theme.of(context).textTheme.titleLarge,
                textScaleFactor: 1,
              ),
            )
          : Column(
              children: [
                Text(
                  AppStrings.downloadFile.tr,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                if (controller.sessionByIdModel!.homework != null)
                  Obx(
                    () => !controller.getSessionByIdLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    if (await controller.checkFile(controller
                                        .sessionByIdModel!.homework!.url)) {
                                      controller.openLocalFile(controller
                                          .sessionByIdModel!.homework!.url);
                                    } else {
                                      controller.downloadFile(controller
                                          .sessionByIdModel!.homework!.url);
                                    }
                                  },
                                  child: Text(
                                    controller.sessionByIdModel!.homework!.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            color:
                                                ColorManger.onBoardingColor3),
                                    textScaleFactor: 1,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                if (controller.sessionByIdModel!.resources.isNotEmpty ||
                    controller.sessionByIdModel!.resources != null)
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return ResourcesItem(index);
                      },
                      itemCount: controller.sessionByIdModel!.resources.length,
                    ),
                  ),
              ],
            ),
    );
  }
}
