
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:get/get.dart';

import '../../../../../app/function.dart';
import '../../../../../app_controller.dart';
import '../../../../../domain/models/my_available_model.dart';
import '../../../../resources/color_manger.dart';
import '../../../../resources/string_manger.dart';
import '../../../../resources/values_manger.dart';
import '../../../../widget/app_loading.dart';
import '../../../../widget/custom_text_filed.dart';
import '../view_model/set_my_available_controller.dart';

class SetMyAvailableView extends GetView<SetMyAvailabelController> {
  final _formKey = GlobalKey<FormState>();

  SetMyAvailableView({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Obx(() => controller.loading.value
        ? Column(
            children: [
              AppLoading(
                height: Get.height * 0.1,
                width: Get.width,
                borderRadius: 16,
              ),
              AppLoading(
                height: Get.height * 0.1,
                width: Get.width,
                borderRadius: 16,
              ),
              AppLoading(
                height: Get.height * 0.1,
                width: Get.width,
                borderRadius: 16,
              ),
              AppLoading(
                height: Get.height * 0.1,
                width: Get.width,
                borderRadius: 16,
              ),
              AppLoading(
                height: Get.height * 0.1,
                width: Get.width,
                borderRadius: 16,
              ),
            ],
          )
        : SizedBox(
            width: width,
            height: height,
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p18),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  SizedBox(
                    height: height * 0.77,
                    child: ListView.separated(
                      itemBuilder: (context, index) => myTimeItems(context,
                          model: controller.models.value[index], width: width),
                      separatorBuilder: (context, index) => SizedBox(
                        height: height * 0.02,
                      ),
                      itemCount: controller.models.value.length,
                    ),
                  ),
                  if (controller.edit.value)
                    Positioned(
                      top: height * 0.7,
                      left: Get.find<AppController>().lang.value == arabicLocale
                          ? 0
                          : width * 0.5,
                      right:
                          Get.find<AppController>().lang.value == arabicLocale
                              ? width * 0.5
                              : 0,
                      child: ElevatedButton(
                          onPressed: () {
                            addDateTimeSheet(context, width, height);
                          },
                          child: Text(AppStrings.addTime.tr)),
                    )
                ],
              ),
            ),
          ));
  }

  Widget myTimeItems(context,
      {required MyAvailableTimeModel model, double? width}) {
    return Container(
      height: AppSize.s70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s10),
        color: ColorManger.primary,
      ),
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.days,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textScaleFactor: 1,
                ),
                Text(
                  '${AppStrings.from.tr} ${model.fromTime} ${AppStrings.to.tr} ${model.toTime}',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textScaleFactor: 1,
                ),
              ],
            ),
          ),
          if (controller.edit.value)
            Positioned(
              left: Get.find<AppController>().lang.value == arabicLocale ? 0 : width! * 0.79,
              right: Get.find<AppController>().lang.value == arabicLocale ? width! * 0.79 : 0,
              child: Container(
                  height: AppSize.s70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorManger.purple),
                  child: IconButton(
                    icon: Icon(
                      Icons.delete_forever,
                      color: ColorManger.primary,
                    ),
                    onPressed: () {
                      controller.deleteItem(model);
                    },
                    padding: const EdgeInsets.all(AppPadding.p0),
                  )),
            )
        ],
      ),
    );
  }

  addDateTimeSheet(context, double width, double height) {
    showModalBottomSheet(
      context: context,
      elevation: AppSize.s4,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSize.s16),
              topRight: Radius.circular(AppSize.s16))),
      builder: (context) {
        return Obx(() => SizedBox(
              height: height * 0.44,
              child: Form(
                key: _formKey,
                child: SizedBox(
                  height: height * 0.49,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(AppPadding.p18),
                      child: Column(
                        children: [
                          CustomTextFiled(
                            keyboardType: TextInputType.none,
                            controller: controller.timeFromController,
                            validator: (String? value) {
                              if (value!.isEmpty) return AppStrings.valid.tr;
                              return null;
                            },
                            label: AppStrings.from.tr,
                            suffixIcon: Icons.access_time,
                            onTap: () {
                              showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  builder:
                                      (BuildContext context, Widget? child) {
                                    return Theme(
                                      data: ThemeData.light().copyWith(
                                          colorScheme: ColorScheme(
                                              brightness: Brightness.light,
                                              primary: ColorManger.primary,
                                              onPrimary: ColorManger.white,
                                              secondary: ColorManger.white,
                                              onSecondary: ColorManger.purple,
                                              error: ColorManger.dark,
                                              onError: ColorManger.error,
                                              background: ColorManger.grey,
                                              onBackground:
                                                  ColorManger.darkPrimary,
                                              surface: ColorManger.purple,
                                              onSurface: ColorManger.white)),
                                      child: child!,
                                    );
                                  }).then((value) {
                                controller.timeFromController.text =
                                    '${value!.hour < 10 ? '0${value.hour}' : value.hour}:${value.minute < 10 ? '0${value.minute}' : value.minute}';
                              });
                            },
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          CustomTextFiled(
                            keyboardType: TextInputType.none,
                            controller: controller.timeToController,
                            validator: (String? value) {
                              if (value!.isEmpty) return AppStrings.valid.tr;
                              return null;
                            },
                            onTap: () {
                              showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  builder:
                                      (BuildContext context, Widget? child) {
                                    return Theme(
                                      data: ThemeData.light().copyWith(
                                          colorScheme: ColorScheme(
                                              brightness: Brightness.light,
                                              primary: ColorManger.primary,
                                              onPrimary: ColorManger.white,
                                              secondary: ColorManger.white,
                                              onSecondary: ColorManger.purple,
                                              error: ColorManger.dark,
                                              onError: ColorManger.error,
                                              background: ColorManger.grey,
                                              onBackground:
                                                  ColorManger.darkPrimary,
                                              surface: ColorManger.purple,
                                              onSurface: ColorManger.white)),
                                      child: child!,
                                    );
                                  }).then((value) {
                                controller.timeToController.text =
                                    '${value!.hour == 0 ? '00' : value.hour}:${value.minute == 0 ? '00' : value.minute}';
                              });
                            },
                            label: AppStrings.to.tr,
                            suffixIcon: Icons.access_time,
                          ),
                          SizedBox(
                            height: height * 0.18,
                            width: width,
                            child: GridView.count(
                              crossAxisCount: 3,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(AppPadding.p0),
                              scrollDirection: Axis.vertical,
                              childAspectRatio: (height / 120) / (width / 140),
                              children: controller.days.value.map((item) {
                                return RadioListTile(
                                  activeColor: ColorManger.purple,
                                  value: item.apiName.value,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  onChanged: (dynamic value) {
                                    controller.groupValue.value = value;
                                  },
                                  title: Text(
                                    item.title.value,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                    textScaleFactor: 1,
                                  ),
                                  groupValue: controller.groupValue.value,
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                    controller.clearData();
                                  },
                                  child: Text(AppStrings.cancel.tr)),
                              SizedBox(
                                width: width * 0.03,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      if (controller.groupValue.value != '') {
                                        Get.back();
                                        controller.models.value.add(
                                            MyAvailableTimeModel(
                                                days:
                                                    controller.groupValue.value,
                                                fromTime: controller
                                                    .timeFromController.text,
                                                toTime: controller
                                                    .timeToController.text));
                                        controller.models.refresh();
                                        controller.clearData();
                                      } else {
                                        Get.snackbar(AppStrings.error.tr,
                                            AppStrings.daysRequired.tr,
                                            snackPosition:
                                                SnackPosition.BOTTOM);
                                      }
                                    }
                                  },
                                  child: Text(AppStrings.add.tr)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }
}
