
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resources/color_manger.dart';
import '../../../../resources/string_manger.dart';
import '../widget/attendance_widget.dart';
import '../widget/material_widget.dart';

class SessionsDetailsView extends StatelessWidget {
  const SessionsDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Column(
        children: [
          TabBar(
            tabs:  [
              Tab(
                icon: Text(AppStrings.attendance.tr),
              ),
              Tab(
                icon: Text(AppStrings.material.tr),
              ),
            ],
            labelStyle: Theme.of(context).textTheme.displayLarge,
            unselectedLabelColor: ColorManger.grey,
            labelColor: ColorManger.purple,
            indicatorColor: ColorManger.purple,
          ),
          const Expanded(
            child: TabBarView(children: [AttendanceWidget(), MaterialWidget()]),
          ),
        ],
      ),
    );
  }
}
