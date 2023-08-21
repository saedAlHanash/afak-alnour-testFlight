import 'dart:ui';

import 'package:afaq_alnour_academy/bloc/child_bloc/child_cubit.dart';
import 'package:afaq_alnour_academy/bloc/child_bloc/child_state.dart';
import 'package:afaq_alnour_academy/bloc/home_bloc/home_cubit.dart';
import 'package:afaq_alnour_academy/data/local/cache_helper.dart';
import 'package:afaq_alnour_academy/generated/l10n.dart';
import 'package:afaq_alnour_academy/screen/about_screen.dart';
import 'package:afaq_alnour_academy/screen/child_view/child_screen.dart';
import 'package:afaq_alnour_academy/screen/child_view/homework_screen.dart';
import 'package:afaq_alnour_academy/screen/welcome_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/remote/dio_helper.dart';
import '../login_screen.dart';
import '../parent_view/afaq_layout.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  List<Widget> screen = [ChildScreen(), HomeWorkScreen()];

  var loading = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocConsumer<ChildCubit, ChildState>(
      listener: (context, state) {},
      builder: (context, state) {
        var get = ChildCubit.get(context);
        List<AppBar> appBar = [
          AppBar(
            title: AutoSizeText(S.of(context).my_courses,
                style: Theme.of(context).textTheme.bodyText2,
                maxFontSize: 20,
                minFontSize: 18,
                textScaleFactor: 1),
            actions: [
              TextButton(
                  onPressed: () {
                    get.goToToday();
                  },
                  child: Text(
                    S.of(context).today,
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontSize: 20,
                        ),
                    textScaleFactor: 1,
                  )),
              SizedBox(
                width: width * 0.05,
              )
            ],
          ),
          AppBar(
            title: AutoSizeText(S.of(context).homework,
                style: Theme.of(context).textTheme.bodyText2,
                maxFontSize: 20,
                minFontSize: 18,
                textScaleFactor: 1),
          ),
        ];
        return Scaffold(
          appBar: appBar[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: S.of(context).home,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.cast_for_education),
                label: S.of(context).homework,
              ),
            ],
            onTap: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            currentIndex: currentIndex,
          ),
          body: screen[currentIndex],
          drawer: Drawer(
            backgroundColor: Colors.teal,
            child: Container(
              width: width * 0.7,
              height: height,
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.07,
                  ),
                  AutoSizeText(
                    S.of(context).name_company,
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: Colors.white),
                    maxFontSize: 30,
                    minFontSize: 27,
                    textScaleFactor: 1,
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * 0.03,
                          ),
                          Icon(
                            Icons.home,
                            color: Colors.white,
                            size: height * 0.035,
                          ),
                          SizedBox(
                            width: width * 0.1,
                          ),
                          AutoSizeText(
                            S.of(context).home,
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(color: Colors.white),
                            textScaleFactor: 1,
                            minFontSize: 23,
                            maxFontSize: 25,
                          ),
                        ],
                      )),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutScreen(),
                            ));
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * 0.03,
                          ),
                          Icon(
                            Icons.info_outline,
                            color: Colors.white,
                            size: height * 0.035,
                          ),
                          SizedBox(
                            width: width * 0.1,
                          ),
                          AutoSizeText(
                            S.of(context).info,
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(color: Colors.white),
                            textScaleFactor: 1,
                            minFontSize: 23,
                            maxFontSize: 25,
                          ),
                        ],
                      )),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        CacheHelper.removeData(key: 'token_child');
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WelcomeScreen(),
                            ),
                            (route) => false);
                        get.model = null;
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * 0.03,
                          ),
                          Icon(
                            Icons.logout,
                            color: Colors.white,
                            size: height * 0.035,
                          ),
                          SizedBox(
                            width: width * 0.1,
                          ),
                          AutoSizeText(
                            S.of(context).log_out,
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(color: Colors.white),
                            textScaleFactor: 1,
                            minFontSize: 23,
                            maxFontSize: 25,
                          ),
                        ],
                      )),
                  Spacer(),
                  Row(
                    children: [
                      SizedBox(
                        width: width * 0.03,
                      ),
                      Switch.adaptive(
                          value: HomeCubit.get(context).lang == 'en' ? true : false,
                          onChanged: (value) {
                            if (value) {
                              CacheHelper.setData(key: 'lang', value: 'en');
                              S.load(Locale('en'));
                              HomeCubit.get(context).lang = 'en';
                              HomeCubit.get(context).changeLocal(lang: 'en');
                              get.getMyCourses();
                            } else {
                              CacheHelper.setData(key: 'lang', value: 'ar');
                              S.load(Locale('ar'));
                              HomeCubit.get(context).lang = 'ar';
                              HomeCubit.get(context).changeLocal(lang: 'ar');
                              get.getMyCourses();
                            }
                          },
                          activeColor: Colors.white),
                      SizedBox(
                        width: width * 0.1,
                      ),
                      AutoSizeText(
                        S.of(context).lang,
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: Colors.white),
                        textScaleFactor: 1,
                        minFontSize: 23,
                        maxFontSize: 25,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  TextButton(
                      child: AutoSizeText(
                        'Made By CHI-Co Team',
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: Colors.white),
                        textScaleFactor: 1,
                        minFontSize: 20,
                        maxFontSize: 22,
                      ),
                      onPressed: () async {
                        var url = 'https://chi-team.com';
                        if (await launchUrl(Uri.parse(url),
                            mode: LaunchMode.inAppWebView)) {}
                      }),
                  StatefulBuilder(builder: (context, mState) {
                    if (loading) return CircularProgressIndicator.adaptive();
                    return TextButton(
                      child: AutoSizeText(
                        'Delete Account',
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: Colors.grey),
                        textScaleFactor: 1,
                        minFontSize: 20,
                        maxFontSize: 22,
                      ),
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return DeleteAccountDialog();
                          },
                        ).then((confirmed) {
                          if (!confirmed) return;

                          mState(() => loading = true);
                          DioHelper.deleteData(
                                  url: 'guardian/delete',
                                  data: {},
                                  token: CacheHelper.getData(key: 'token_student'))
                              .then((value) {
                            mState(() => loading = false);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                                (route) => false);
                          });
                        });
                      },
                    );
                  }),
                  SizedBox(
                    height: height * 0.01,
                  ),
                ],
              ),
            ),
          ),
          drawerEdgeDragWidth: width * 0.2,
        );
      },
    );
  }
}
