import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'dart:math' as math;

import '../../../../../app/di.dart';
import '../../../../../domain/models/my_course_model.dart';
import '../../../../../domain/usecase/my_course_usecase.dart';
import '../../../../common/state_rendere/state_renderer.dart';
import '../../../../resources/string_manger.dart';

extension SplitByLength on String {
  List<String> splitByLength1(int length, {bool ignoreEmpty = false}) {
    List<String> pieces = [];

    for (int i = 0; i < this.length; i += length) {
      int offset = i + length;
      var piece = substring(i, offset >= this.length ? this.length : offset);

      if (ignoreEmpty) {
        piece = piece.replaceAll(RegExp(r'\s+'), '');
      }

      pieces.add(piece);
    }
    return pieces;
  }

  int get numberOnly {
    final regex = RegExp(r'\d+');

    final numbers = regex.allMatches(this).map((match) => match.group(0)).join();

    try {
      return int.parse(numbers);
    } on Exception {
      return 0;
    }
  }
}

class HomeController extends GetxController {
  // late MyCourseModel model;
  final MyCourseUseCase _useCase = instance<MyCourseUseCase>();
  RxBool isLoading = false.obs;
  final CalendarController calendarController = CalendarController();

  List<Appointment> getAppointment(context) {
    List<Appointment> meetings = [];

    var startTime = DateTime(2022, 12, 1, 9, 0, 0);
    var endTime = startTime.add(const Duration(hours: 2));
    var ruleTime = DateTime(2023, 01, 30, 18, 30, 00);
    List<String> day = [];

    for (var element in model.data) {
      var startDate1 = element.start_date.split('-');
      var startTime1 = element.start_time.split(':');
      var endDate1 = element.end_date.split('-');
      day = [];
      startTime = DateTime(
        int.parse(startDate1[0].numberOnly.toString()),
        int.parse(startDate1[1].numberOnly.toString()),
        int.parse(startDate1[2].numberOnly.toString()),
        int.parse(startTime1[0].numberOnly.toString()),
        int.parse(startTime1[1].numberOnly.toString()),
      );
      endTime = startTime.add(Duration(minutes: element.session_duration));

      ruleTime = DateTime(int.parse(endDate1[0]), int.parse(endDate1[1]),
          int.parse(endDate1[2]), endTime.hour, endTime.minute, endTime.second);

      for (var element1 in element.days) {
        day.add(element1.substring(0, 2).toUpperCase());
      }

      meetings.add(Appointment(
          startTime: startTime,
          endTime: endTime,
          subject: element.en_name,
          color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
          notes: element.location,
          recurrenceRule:
              'FREQ=WEEKLY;BYDAY=${day.toString().substring(1, day.toString().length - 1)};UNTIL=$ruleTime'));
    }

    return meetings;
  }

  getMyCourses() async {
    isLoading.value = true;
    (await _useCase.execute(Void)).fold((l) {
      appSnackBar(AppStrings.error.tr, l.message);
    }, (r) {
      model = r;
    });
    isLoading.value = false;
  }

  @override
  void onInit() async {
    await getMyCourses();
    super.onInit();
  }
}
