import 'package:afaq_alnour_academy/adaptive_widget/adabtive_indecator.dart';
import 'package:afaq_alnour_academy/bloc/child_bloc/child_cubit.dart';
import 'package:afaq_alnour_academy/bloc/child_bloc/child_state.dart';
import 'package:afaq_alnour_academy/bloc/home_bloc/home_cubit.dart';
import 'package:afaq_alnour_academy/constant/const.dart';
import 'package:afaq_alnour_academy/data/local/cache_helper.dart';
import 'package:afaq_alnour_academy/model/my_courses_child_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

class ChildScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<ChildCubit, ChildState>(
      listener: (context, state) {},
      builder: (context, state) {
        var get = ChildCubit.get(context);
        return state is! GetMyCoursesLoadingState
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: SfCalendar(
                  view: CalendarView.schedule,
                  dataSource:
                      MeetingDataSource(getAppointment(context, model: get.model)),
                  controller: get.calendarController,
                  allowedViews: [
                    CalendarView.day,
                    CalendarView.month,
                    CalendarView.schedule,
                  ],
                  allowViewNavigation: true,
                  showCurrentTimeIndicator: false,
                  todayHighlightColor: Colors.teal,
                  cellBorderColor: Colors.black,
                  cellEndPadding: 5,
                  onTap: (CalendarTapDetails details) async {
                    if (details.targetElement == CalendarElement.appointment ||
                        details.targetElement == CalendarElement.agenda) {
                      final Appointment appointmentDetails = details.appointments![0];
                      if (appointmentDetails.notes != null) {
                        var url = appointmentDetails.notes;
                        if (await launchUrl(Uri.parse(url!),
                            mode: LaunchMode.externalNonBrowserApplication)) {}
                      }
                    }
                  },
                  allowAppointmentResize: true,
                  scheduleViewSettings: ScheduleViewSettings(
                      monthHeaderSettings: MonthHeaderSettings(
                          backgroundColor: Colors.teal,
                          height: height * 0.1,
                          monthTextStyle: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.white, fontSize: 18)),
                      appointmentTextStyle: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(color: Colors.white, fontSize: 14)),
                  monthViewSettings: MonthViewSettings(
                      appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
                ),
              )
            : Center(
                child: AdabtiveIndecator(
                os: getOS(),
              ));
      },
    );
  }
}

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

List<Appointment> getAppointment(context, {MyCoursesChildModel? model}) {
  List<Appointment> meetings = [];

  var startTime = DateTime(2022, 12, 1, 9, 0, 0);
  var endTime = startTime.add(const Duration(hours: 2));
  var ruleTime = DateTime(2023, 01, 30, 18, 30, 00);
  List<String> day = [];

  model!.date.forEach((element) {
    var startDate1 = element.start_date!.split('-');
    var startTime1 = element.start_time!.split(':');
    var endDate1 = element.end_date!.split('-');
    day = [];
    startTime = DateTime(
        int.parse(startDate1[0].numberOnly.toString()),
        int.parse(startDate1[1].numberOnly.toString()),
        int.parse(startDate1[2].numberOnly.toString()),
        int.parse(startTime1[0].numberOnly.toString()),
        int.parse(startTime1[1].numberOnly.toString()),);
    endTime = startTime.add(Duration(minutes: element.session_duration!));

    ruleTime = DateTime(int.parse(endDate1[0]), int.parse(endDate1[1]),
        int.parse(endDate1[2]), endTime.hour, endTime.minute, endTime.second);

    element.days.forEach((element1) {
      day.add(element1.substring(0, 2).toUpperCase());
    });

    meetings.add(Appointment(
        startTime: startTime,
        endTime: endTime,
        subject:
            HomeCubit.get(context).lang == 'ar' ? element.ar_name! : element.en_name!,
        color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
        notes: element.location,
        recurrenceRule:
            'FREQ=WEEKLY;BYDAY=${day.toString().substring(1, day.toString().length - 1)};UNTIL=$ruleTime'));
  });

  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
