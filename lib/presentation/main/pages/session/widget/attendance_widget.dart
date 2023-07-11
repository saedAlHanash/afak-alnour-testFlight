
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/state_rendere/state_renderer.dart';
import '../../../../resources/color_manger.dart';
import '../../../../resources/string_manger.dart';
import '../../../../resources/values_manger.dart';
import '../../../../widget/app_loading.dart';
import '../view_model/session_controller.dart';

class AttendanceWidget extends GetView<SessionController> {
  const AttendanceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.15, vertical: Get.height * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.pleaseSelectCourse.tr,
            style: Theme.of(context).textTheme.displayLarge,
            textScaleFactor: 1,
          ),
          SizedBox(
            width: Get.width * 0.7,
            child: DropdownButtonFormField(
                items: controller.myCourseModel.data
                    .map((e) => DropdownMenuItem(
                          value: e.id,
                          onTap: () {
                            controller.getMySessionsModel(e.level_id);
                            controller.getStudentInCourse(e.id);
                          },
                          child: Text(e.en_name,
                              style: Theme.of(context).textTheme.titleLarge,
                              textScaleFactor: 1),
                        ))
                    .toList(),
                onChanged: (dynamic value) {},
                iconDisabledColor: ColorManger.purple,
                iconEnabledColor: ColorManger.purple),
          ),
          Text(
            AppStrings.pleaseSelectSession.tr,
            style: Theme.of(context).textTheme.displayLarge,
            textScaleFactor: 1,
          ),
          Obx(
            () => controller.mySessionsLoading.value
                ? AppLoading(
                    borderRadius: AppSize.s14,
                    width: Get.width * 0.7,
                    height: Get.height * 0.065,
                  )
                : SizedBox(
                    width: Get.width * 0.7,
                    child: DropdownButtonFormField(
                        items: controller.mySessionsModel != null
                            ? controller.mySessionsModel!.sessions
                                .map((e) => DropdownMenuItem(
                                      value: e.id,
                                      onTap: () {
                                        controller.getSessionById(e.id);
                                        controller.sessionById = e.id;
                                      },
                                      child: Text(e.order.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                          textScaleFactor: 1),
                                    ))
                                .toList()
                            : [],
                        onChanged: (dynamic value) {},
                        iconDisabledColor: ColorManger.purple,
                        iconEnabledColor: ColorManger.purple),
                  ),
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Obx(
            () => controller.getStudentByCourseLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : controller.studentInCourseModel != null
                    ? SizedBox(
                        height: Get.height * 0.49,
                        width: Get.width,
                        child: Column(
                          children: [
                            if(controller.studentInCourseModel!.data.isNotEmpty)
                            Expanded(
                              child: ListView.separated(
                                  itemBuilder: (context, index) => Obx(
                                        () => CheckboxListTile(
                                          value: controller.childAttendance
                                              .contains(controller
                                                  .studentInCourseModel!
                                                  .data[index]
                                                  .id),
                                          onChanged: (dynamic value) {
                                            controller.addOrRemoveChildInList(
                                                controller.studentInCourseModel!
                                                    .data[index].id);
                                          },
                                          activeColor: ColorManger.purple,
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                          title: Text(
                                            '${controller.studentInCourseModel!.data[index].forename} ${controller.studentInCourseModel!.data[index].surname}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                            textScaleFactor: 1,
                                          ),
                                        ),
                                      ),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: Get.height * 0.0),
                                  itemCount: controller
                                      .studentInCourseModel!.data.length),
                            ),
                            if(controller.studentInCourseModel!.data.isEmpty)
                              Center(
                                child: Text(
                                  AppStrings.thereAreNoStudentsCurrently.tr,
                                  style: Theme.of(context).textTheme.titleLarge,
                                  textScaleFactor: 1,
                                ),
                              ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            Center(
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (controller.sessionById == 0) {
                                        appSnackBar(AppStrings.error.tr,
                                            AppStrings.errorAttendance.tr);
                                      } else {
                                        if (controller
                                            .childAttendance.isNotEmpty) {
                                          controller.setAttendance(
                                              controller.sessionById);
                                        } else {
                                          appSnackBar(
                                              AppStrings.error.tr,
                                              AppStrings
                                                  .errorStudentAttendance.tr);
                                        }
                                      }
                                    },
                                    child: Text(
                                        AppStrings.attendanceRegistration.tr)))
                          ],
                        ),
                      )
                    : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
