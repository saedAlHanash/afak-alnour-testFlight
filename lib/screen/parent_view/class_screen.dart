import 'package:afaq_alnour_academy/screen/parent_view/afaq_layout.dart';
import 'package:afaq_alnour_academy/widget/toast.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../adaptive_widget/adabtive_indecator.dart';
import '../../bloc/home_bloc/home_cubit.dart';
import '../../bloc/home_bloc/home_state.dart';
import '../../constant/const.dart';
import '../../generated/l10n.dart';

import '../../model/class_model.dart';

class ClassScreen extends StatelessWidget {
  const ClassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is StartClassSuccessState) {
          HomeCubit.get(context).myCourseModel = null;
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Container(
                      width: width * 0.8,
                      height: height * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.02,
                          ),
                          AutoSizeText(
                            S.of(context).Start_Course_Successfully,
                            style: Theme.of(context).textTheme.headline3,
                            textScaleFactor: 1,
                            minFontSize: 16,
                            maxFontSize: 18,
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Icon(
                            Icons.check,
                            color: Colors.green,
                            size: height * 0.06,
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                            child: AutoSizeText(
                              S.of(context).payment_message,
                              style: Theme.of(context).textTheme.headline3,
                              textScaleFactor: 1,
                              minFontSize: 16,
                              maxFontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          InkWell(
                            onTap: () async {
                              var url =
                                  'https://wa.me/${447553553626}/?text= ${S.of(context).enrool_Course_whatsApp}';
                              if (await launchUrl(Uri.parse(url),
                                  mode: LaunchMode.externalApplication)) {}
                            },
                            child: Icon(
                              Icons.whatshot,
                              color: Colors.green,
                              size: height * 0.04,
                            ),
                          ),
                        ],
                      ),
                    ),
                    titlePadding: const EdgeInsets.all(0),
                  ));
        }
      },
      builder: (context, state) {
        var get = HomeCubit.get(context);

        return Scaffold(
          appBar: AppBar(),
          body: get.classModel != null
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height * 0.03,
                        ),
                        SizedBox(
                          height: height * 0.85,
                          child: ListView.separated(
                              itemBuilder: (context, index) => Courses(
                                    context,
                                    height: height,
                                    width: width,
                                    model: get.classModel,
                                    index: index,
                                  ),
                              separatorBuilder: (context, index) => SizedBox(
                                    height: height * 0.03,
                                  ),
                              itemCount: get.classModel!.data.length),
                        )
                      ],
                    ),
                  ),
                )
              : Center(child: AdabtiveIndecator(os: getOS())),
        );
      },
    );
  }

  Widget Courses(context,
      {double? height, double? width, ClassModel? model, int? index}) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is AddChildToCardSuccessState) {
          var get = HomeCubit.get(context);
          get.ChangeBottomBar(index: 3);
          get.initCardList();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => AfaqLayout(),
            ),
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        var get = HomeCubit.get(context);
        int studentCount = 0;
        get.cardModel.forEach((element) {
          if (model!.data[index!].id == element.classId) {
            studentCount += 1;
          }
        });
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
                    Center(
                      child: Container(
                        width: width! * 0.8,
                        height: height * 0.3,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            image: DecorationImage(
                                image: NetworkImage(get.lang == "ar"
                                    ? ImageUrl + model.data[index].ar_image_url!
                                    : ImageUrl + model.data[index].en_image_url!),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.05,
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
                    //       '${S.of(context).remaining_seats} ${model.data[index].max_participants!- model.data[index].students_count! -  studentCount}',
                    //       style: Theme.of(context).textTheme.headline3,
                    //       textScaleFactor: 1,
                    //       minFontSize: 21,
                    //       maxFontSize: 23,
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Icon(Icons.account_balance_wallet_outlined, size: height * 0.035),
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
                    get.isPackage
                        ? const SizedBox()
                        : Center(
                            child: ConditionalBuilder(
                              condition: state is! AddChildToCardLoadingState,
                              builder: (context) => InkWell(
                                onTap: () {
                                  if (model.data[index].students_count! + studentCount <
                                      model.data[index].max_participants!) {
                                    get.addChildToCard(
                                        model.data[index].id,
                                        get.lang == 'ar'
                                            ? model.data[index].ar_name
                                            : model.data[index].en_name,
                                        model.data[index].price!,
                                        false);
                                  } else {
                                    toast(msg: S.of(context).close, color: Colors.red);
                                  }
                                },
                                child: Container(
                                  width: width * 0.6,
                                  height: height * 0.05,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.teal),
                                  child: Center(
                                    child: AutoSizeText(
                                      S.of(context).add_to_cart,
                                      style:
                                          Theme.of(context).textTheme.headline3!.copyWith(
                                                color: Colors.white,
                                              ),
                                      textScaleFactor: 1,
                                      minFontSize: 21,
                                      maxFontSize: 23,
                                    ),
                                  ),
                                ),
                              ),
                              fallback: (context) =>
                                  Center(child: AdabtiveIndecator(os: getOS())),
                            ),
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
      },
    );
  }
}
