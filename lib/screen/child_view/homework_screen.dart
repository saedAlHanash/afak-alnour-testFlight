import 'dart:ui';

import 'package:afaq_alnour_academy/adaptive_widget/adabtive_indecator.dart';
import 'package:afaq_alnour_academy/bloc/child_bloc/child_cubit.dart';
import 'package:afaq_alnour_academy/bloc/child_bloc/child_state.dart';
import 'package:afaq_alnour_academy/bloc/home_bloc/home_cubit.dart';
import 'package:afaq_alnour_academy/constant/const.dart';
import 'package:afaq_alnour_academy/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class HomeWorkScreen extends StatefulWidget {
  @override
  State<HomeWorkScreen> createState() => _HomeWorkScreenState();
}

class _HomeWorkScreenState extends State<HomeWorkScreen> {


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;

    return BlocConsumer<ChildCubit, ChildState>(
      listener: (context, state) {},
      builder: (context, state) {
        var get = ChildCubit.get(context);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.04,
              ),
              if (get.model != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S
                          .of(context)
                          .pleaseSelectCourse,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText2,
                      textScaleFactor: 1,
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    SizedBox(
                      height: height * 0.07,
                      child: DropdownButtonFormField(
                        items: get.model!.date.map((e) {
                          return DropdownMenuItem(
                            child: Text(
                              HomeCubit
                                  .get(context)
                                  .lang == "ar"
                                  ? e.ar_name!
                                  : e.en_name!,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1,
                              textScaleFactor: 1,
                            ),
                            value: e.id,
                            onTap: () {
                              get.getSessions(e.level_id!);
                            },
                          );
                        }).toList(),
                        onChanged: (dynamic value) {},
                        decoration: InputDecoration(
                          focusedBorder:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          enabledBorder:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: height * 0.03,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).pleaseSelectNumberSession,
                    style: Theme.of(context).textTheme.bodyText2,
                    textScaleFactor: 1,
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  state is! GetAllSessionsLoadingState
                      ? SizedBox(
                          height: height * 0.07,
                          child: DropdownButtonFormField(
                            items: get.allSessionsModel != null
                                ? get.allSessionsModel!.sessions.map((e) {
                                    return DropdownMenuItem(
                                      child: Text(
                                        e.order.toString(),
                                        textScaleFactor: 1,
                                        style: Theme.of(context).textTheme.bodyText2,
                                      ),
                                      value: e.id,
                                      onTap: () {
                                        get.getSessionById(e.id!);
                                      },
                                    );
                                  }).toList()
                                : [],
                            onChanged: (dynamic value) {},
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        )
                      : Center(
                    child: AdabtiveIndecator(os: getOS()),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.03,
              ),
              state is! GetSessionsLoadingState
                  ? get.sessionModel != null
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S
                        .of(context)
                        .selectHomeworkToDownloadOrOpen,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText2,
                    textScaleFactor: 1,
                  ),
                  TextButton(
                      onPressed: () {
                        get.checkFile(get.sessionModel!.homeWork!.url!);
                      },
                      child: Text(
                        get.sessionModel!.homeWork!.name!,
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(
                          color: Colors.blue,
                        ),
                      ))
                ],
              )
                  : SizedBox()
                  : Center(child: AdabtiveIndecator(os: getOS())),
            ],
          ),
        );
      },
    );
  }
}
