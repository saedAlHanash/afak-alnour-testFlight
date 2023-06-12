import 'package:afaq_alnour_academy/adaptive_widget/adabtive_indecator.dart';
import 'package:afaq_alnour_academy/bloc/home_bloc/home_cubit.dart';
import 'package:afaq_alnour_academy/constant/const.dart';
import 'package:afaq_alnour_academy/generated/l10n.dart';
import 'package:afaq_alnour_academy/model/my_course_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bloc/home_bloc/home_state.dart';

class ChildCoursesDetailsScreen extends StatelessWidget {
  String childName;
  ChildCoursesDetailsScreen({required this.childName});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(childName,
            style: Theme.of(context).textTheme.headline3,
            minFontSize: 16,
            maxFontSize: 18,
            textScaleFactor: 1),
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var get = HomeCubit.get(context);
          return  state is ! GetMyCoursesLoadingState ? get.myCourseModel!.data.isNotEmpty ? Padding(
            padding:  EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
                SizedBox(
                  height: height * 0.86,
                  child: ListView.separated(
                      itemBuilder: (context, index) => childCourses(context,
                          width: width,
                          index: index,
                          height: height,
                          model: get.myCourseModel,
                          get: get),
                      separatorBuilder: (context, index) => SizedBox(
                            height: height * 0.02,
                          ),
                      itemCount: get.myCourseModel!.data.length),
                )
              ],
            ),
          ) : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('image/child_courses.json',
                    fit: BoxFit.cover),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: AutoSizeText(
                    S.of(context).add_child_to_courses,
                    style: Theme.of(context).textTheme.headline3,
                    textScaleFactor: 1,
                    maxFontSize: 20,
                    minFontSize: 18,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ) : Center(
            child: AdabtiveIndecator(os: getOS()),
          );
        },
      ),
    );
  }
}

Widget childCourses(context,
    {double? height,
    double? width,
    MyCourseModel? model,
    int? index,
    var get}) {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(color: Colors.teal),
        borderRadius: BorderRadius.circular(20)),
    child: ExpansionTile(
      title: AutoSizeText(
        '${get.lang == 'ar' ? model!.data[index!].ar_name : model!.data[index!].en_name}',
        style: Theme.of(context).textTheme.headline3,
        textScaleFactor: 1,
        minFontSize: 26,
        maxFontSize: 28,
      ),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      collapsedIconColor: Colors.black,
      collapsedTextColor: Colors.black,
      textColor: Colors.black,
      iconColor: Colors.black,
      children: [
        Container(
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height! * 0.03,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width! * 0.05,
                  ),
                  Icon(
                    Icons.calendar_month,
                    size: height * 0.035,
                  ),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  AutoSizeText(
                    '${S.of(context).start_date} ${model.data[index].start_date}',
                    style: Theme.of(context).textTheme.headline3,
                    textScaleFactor: 1,
                    minFontSize: 21,
                    maxFontSize: 23,
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width * 0.05,
                  ),
                  Icon(Icons.calendar_month, size: height * 0.035),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  AutoSizeText(
                    '${S.of(context).end_date} ${model.data[index].end_date}',
                    style: Theme.of(context).textTheme.headline3,
                    textScaleFactor: 1,
                    minFontSize: 21,
                    maxFontSize: 23,
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width * 0.05,
                  ),
                  Icon(Icons.access_alarm_outlined, size: height * 0.035),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  AutoSizeText(
                    '${S.of(context).start_hour} ${model.data[index].start_time}',
                    style: Theme.of(context).textTheme.headline3,
                    textScaleFactor: 1,
                    minFontSize: 21,
                    maxFontSize: 23,
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width * 0.05,
                  ),
                  Icon(Icons.access_time_outlined, size: height * 0.035),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  AutoSizeText(
                    '${S.of(context).duration} ${model.data[index].session_duration} Min',
                    style: Theme.of(context).textTheme.headline3,
                    textScaleFactor: 1,
                    minFontSize: 21,
                    maxFontSize: 23,
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width * 0.05,
                  ),
                  Icon(Icons.calendar_month, size: height * 0.035),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  SizedBox(
                    width: width * 0.7,
                    height: height * 0.04,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index1) => AutoSizeText(
                              '${model.data[index].days[index1]}',
                              style: Theme.of(context).textTheme.headline3,
                              textScaleFactor: 1,
                              minFontSize: 21,
                              maxFontSize: 23,
                            ),
                        separatorBuilder: (context, index) => SizedBox(
                              width: width * 0.02,
                            ),
                        itemCount: model.data[index].days.length),
                  )
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width * 0.05,
                  ),
                  Icon(
                    Icons.share_outlined,
                    size: height * 0.035,
                  ),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: ()async{
                        final url = model.data[index].location;
                        if (await launchUrl(Uri.parse(url!),
                            mode: LaunchMode.externalNonBrowserApplication)) {}
                      },
                      child: AutoSizeText(
                        '${model.data[index].location}',
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Colors.blue
                        ),
                        textScaleFactor: 1,
                        minFontSize: 21,
                        maxFontSize: 23,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width * 0.05,
                  ),
                  Icon(
                    Icons.person,
                    size: height * 0.035,
                  ),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  AutoSizeText(
                    '${model.data[index].gender}',
                    style: Theme.of(context).textTheme.headline3,
                    textScaleFactor: 1,
                    minFontSize: 21,
                    maxFontSize: 23,
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width * 0.05,
                  ),
                  Icon(
                    Icons.group,
                    size: height * 0.035,
                  ),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  AutoSizeText(
                    '${model.data[index].population}',
                    style: Theme.of(context).textTheme.headline3,
                    textScaleFactor: 1,
                    minFontSize: 21,
                    maxFontSize: 23,
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              // Row(
              //   children: [
              //     SizedBox(
              //       width: width * 0.05,
              //     ),
              //     Icon(Icons.group, size: height * 0.035),
              //     SizedBox(
              //       width: width * 0.05,
              //     ),
              //     AutoSizeText(
              //       '${S.of(context).min_participants} ${model.data[index].min_participants}',
              //       style: Theme.of(context).textTheme.headline3,
              //       textScaleFactor: 1,
              //       minFontSize: 21,
              //       maxFontSize: 23,
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: height * 0.01,
              // ),
              // Row(
              //   children: [
              //     SizedBox(
              //       width: width * 0.05,
              //     ),
              //     Icon(Icons.group, size: height * 0.035),
              //     SizedBox(
              //       width: width * 0.05,
              //     ),
              //     AutoSizeText(
              //       '${S.of(context).max_participants} ${model.data[index].max_participants}',
              //       style: Theme.of(context).textTheme.headline3,
              //       textScaleFactor: 1,
              //       minFontSize: 21,
              //       maxFontSize: 23,
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: height * 0.01,
              // ),
              Row(
                children: [
                  SizedBox(
                    width: width * 0.05,
                  ),
                  Icon(Icons.account_balance_wallet_outlined,
                      size: height * 0.035),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  AutoSizeText(
                    '${S.of(context).price} ${model.data[index].price}£',
                    style: Theme.of(context).textTheme.headline3,
                    textScaleFactor: 1,
                    minFontSize: 21,
                    maxFontSize: 23,
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
