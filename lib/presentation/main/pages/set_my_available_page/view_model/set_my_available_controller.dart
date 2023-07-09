import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../app/app_pref.dart';
import '../../../../../app/constants.dart';
import '../../../../../app/di.dart';
import '../../../../../data/network/requstes/test_request.dart';
import '../../../../../domain/models/check_box_item.dart';
import '../../../../../domain/models/my_available_model.dart';
import '../../../../../domain/usecase/schedule_usecase.dart';
import '../../../../../domain/usecase/set_schedule_usecase.dart';
import '../../../../common/state_rendere/state_renderer.dart';
import '../../../../resources/string_manger.dart';

class SetMyAvailabelController extends GetxController {
  final timeFromController = TextEditingController();
  final timeToController = TextEditingController();
  String schedule = '';
  RxBool edit = false.obs;
  RxBool loading = false.obs;
  final SetScheduleUseCase _useCase = instance<SetScheduleUseCase>();
  final ScheduleUseCase _scheduleUseCase = instance<ScheduleUseCase>();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  RxList<CheckBoxItemGet> days = <CheckBoxItemGet>[
    CheckBoxItemGet(
        title: AppStrings.sun.tr.obs,
        apiName: AppStrings.sunday.tr.obs,
        value: false.obs),
    CheckBoxItemGet(
        title: AppStrings.mon.tr.obs,
        apiName: AppStrings.monday.tr.obs,
        value: false.obs),
    CheckBoxItemGet(
        title: AppStrings.tue.tr.obs,
        apiName: AppStrings.tuesday.tr.obs,
        value: false.obs),
    CheckBoxItemGet(
        title: AppStrings.wed.tr.obs,
        apiName: AppStrings.wednesday.tr.obs,
        value: false.obs),
    CheckBoxItemGet(
        title: AppStrings.thu.tr.obs,
        apiName: AppStrings.thursday.tr.obs,
        value: false.obs),
    CheckBoxItemGet(
        title: AppStrings.fri.tr.obs,
        apiName: AppStrings.friday.tr.obs,
        value: false.obs),
    CheckBoxItemGet(
        title: AppStrings.sat.tr.obs,
        apiName: AppStrings.saturday.tr.obs,
        value: false.obs),
  ].obs;

  RxString groupValue = ''.obs;

  void clearData() {
    timeFromController.clear();
    timeToController.clear();
    groupValue.value = '';
  }

  Future<void> getSchedule() async {
    loading.value = true;
    (await _scheduleUseCase.execute(ScheduleUseCaseInput(
            "${Constants.bearer} ${_appPreferences.getUserToken() ?? Constants.empty}")))
        .fold((l) {
      appSnackBar('Error', l.message);
    }, (r) {
      schedule = r.data;
      editModels();
    });
    loading.value = false;
  }

  void editModels() {
    models.clear();
    print(schedule);
    if(schedule != "[]" && schedule.isNotEmpty) {
      var scheduleList = jsonDecode(schedule);
      scheduleList.forEach((key, value) {
        value.forEach((element) {
          if (value.isNotEmpty) {
            schedule.split('-');
            var list = element.split('-');
            models.add(MyAvailableTimeModel(
                days: key.toUpperCase(), fromTime: list[0], toTime: list[1]));
          }
        });
      });
    }
    models.refresh();
  }

  RxList<MyAvailableTimeModel> models = <MyAvailableTimeModel>[].obs;

  deleteItem(MyAvailableTimeModel model) {
    models.remove(model);
    models.refresh();
  }

  onSaveElement() async {
    TestRequest testRequest = TestRequest({});
    Map<String, List<String>> s = {
      'sunday': [],
      'monday': [],
      'tuesday': [],
      'wednesday': [],
      'thursday': [],
      'friday': [],
      'saturday': [],
    };
    for (var element in models) {
      s[element.days.toLowerCase()]
          ?.add('${element.fromTime}-${element.toTime}');
    }
    testRequest.schedule = s;

    (await _useCase.execute(SetScheduleUseCaseInputs(
            "${Constants.bearer} ${_appPreferences.getUserToken() ?? Constants.empty}",
            testRequest)))
        .fold((l) {
      appSnackBar('Error', l.message);
    }, (r) {});
  }

  @override
  void onInit() async{
    super.onInit();
    await getSchedule();
  }
}
