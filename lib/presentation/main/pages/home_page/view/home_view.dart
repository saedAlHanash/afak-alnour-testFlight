
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../resources/color_manger.dart';
import '../../../../resources/font_manger.dart';
import '../view_model/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(8.0),
        child: controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SfCalendar(
                view: CalendarView.schedule,
                dataSource:
                    MeetingDataSource(controller.getAppointment(context)),
                allowedViews: const [
                  CalendarView.day,
                  CalendarView.month,
                  CalendarView.schedule,
                ],
                allowViewNavigation: true,
                showCurrentTimeIndicator: false,
                todayHighlightColor: Colors.teal,
                cellBorderColor: Colors.black,
                controller: controller.calendarController,
                cellEndPadding: 5,
                onTap: (CalendarTapDetails details) async {
                  if (details.targetElement == CalendarElement.appointment ||
                      details.targetElement == CalendarElement.agenda) {
                    final Appointment appointmentDetails =
                        details.appointments![0];
                    if (appointmentDetails.notes != null) {
                      var url = appointmentDetails.notes;
                      if (await launchUrl(Uri.parse(url!),
                          mode: LaunchMode.externalNonBrowserApplication)) {}
                    }
                  }
                  controller.calendarController.displayDate = DateTime.now();
                },
                allowAppointmentResize: true,
                scheduleViewSettings: ScheduleViewSettings(
                    monthHeaderSettings: MonthHeaderSettings(
                        backgroundColor: ColorManger.teal,
                        height: Get.height * 0.1,
                        monthTextStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: FontSize.s18)),
                    appointmentTextStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: FontSize.s14)),
                monthViewSettings: const MonthViewSettings(
                    appointmentDisplayMode:
                        MonthAppointmentDisplayMode.appointment),
              ),
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
