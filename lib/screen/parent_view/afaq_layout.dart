import 'package:afaq_alnour_academy/bloc/home_bloc/home_cubit.dart';
import 'package:afaq_alnour_academy/data/local/cache_helper.dart';
import 'package:afaq_alnour_academy/generated/l10n.dart';
import 'package:afaq_alnour_academy/screen/about_screen.dart';
import 'package:afaq_alnour_academy/screen/parent_view/my_children_screen.dart';
import 'package:afaq_alnour_academy/screen/welcome_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bloc/home_bloc/home_state.dart';
import 'all_course_screen.dart';
import 'all_package_screen.dart';

class AfaqLayout extends StatefulWidget {
  const AfaqLayout({Key? key}) : super(key: key);

  @override
  State<AfaqLayout> createState() => _AfaqLayoutState();
}

class _AfaqLayoutState extends State<AfaqLayout>  with WidgetsBindingObserver{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.inactive) {}
    if (state == AppLifecycleState.detached) {}
    if (state == AppLifecycleState.paused) {
      if(CacheHelper.getData(key: 'card_time') == null)
      CacheHelper.setData(key: 'card_time', value: DateTime.now().toString());
    }

    if (state == AppLifecycleState.resumed) {}
  }

  @override
  Widget build(BuildContext context)  {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var get = HomeCubit.get(context);
        if(get.cardModel.isEmpty){
          CacheHelper.removeData(key: 'card_time');
        }
        List<AppBar> appBar = [
          AppBar(
            title: AutoSizeText(
              S.of(context).home,
              style: Theme.of(context)
                  .textTheme
                  .headline3,
              textScaleFactor: 1,
              minFontSize: 21,
              maxFontSize: 23,
            ),
            centerTitle: true,
          ),
          AppBar(
            title: AutoSizeText(
              S.of(context).child_courses,
              style: Theme.of(context)
                  .textTheme
                  .headline3,
              textScaleFactor: 1,
              minFontSize: 21,
              maxFontSize: 23,
            ),
            centerTitle: true,
          ),
          AppBar(
            title: AutoSizeText(
              S.of(context).payment_history,
              style: Theme.of(context)
                  .textTheme
                  .headline3,
              textScaleFactor: 1,
              minFontSize: 21,
              maxFontSize: 23,
            ),
            centerTitle: true,
          ),
          AppBar(
            title: AutoSizeText(
              S.of(context).all_courses,
              style: Theme.of(context)
                  .textTheme
                  .headline3,
              textScaleFactor: 1,
              minFontSize: 21,
              maxFontSize: 23,
            ),
            centerTitle: true,
          ),
        ];
        List<BottomNavigationBarItem> item = [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: S.of(context).home),
          BottomNavigationBarItem(
              icon: Icon(Icons.subject), label: S.of(context).child_courses),
          BottomNavigationBarItem(
              icon: Icon(Icons.payments_rounded), label: S.of(context).payment_history),
          BottomNavigationBarItem(
              icon: Icon(Icons.credit_card),
              label: "${S.of(context).card} ${get.cardModel.isNotEmpty ? get.cardModel.length : ""}"),
        ];
        return Directionality(
          textDirection:
              get.lang == 'ar' ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            drawerEdgeDragWidth: width * 0.2,
            drawer: drawer(context, width: width, height: height),
            appBar: appBar[get.bottomIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: item,
              onTap: (int index) {
                get.ChangeBottomBar(index: index);
                if (index == 1) {
                  get.myCourseModel = null;
                  get.myChildrenModel = null;
                  get.getMyChildren();
                }
                if(index == 2){
                  get.paymentHistoryModel = null;
                  get.getPaymentHistory();
                }
                if(index == 3){
                  get.initCardList();
                }
              },
              currentIndex: get.bottomIndex,
            ),
            body: get.screen[get.bottomIndex],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.addObserver(this);
  }
}

Widget drawer(context, {double? width, double? height}) {
  return BlocConsumer<HomeCubit, HomeState>(
    listener: (context, state) {},
    builder: (context, state) {
      var get = HomeCubit.get(context);
      return Drawer(
        width: width! * 0.7,
        backgroundColor: Colors.teal,
        child: Column(
          children: [
            SizedBox(
              height: height! * 0.07,
            ),
            AutoSizeText(
              S.of(context).name_company,
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: Colors.white),
              textScaleFactor: 1,
              minFontSize: 27,
              maxFontSize: 30,
            ),
            SizedBox(
              height: height * 0.03,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  get.ChangeBottomBar(index: 0);
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
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Colors.white),
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
                        builder: (context) => AllCourseScreen(),
                      ));
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: width * 0.03,
                    ),
                    Icon(
                      Icons.class_outlined,
                      color: Colors.white,
                      size: height * 0.035,
                    ),
                    SizedBox(
                      width: width * 0.1,
                    ),
                    AutoSizeText(
                      S.of(context).all_courses,
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Colors.white),
                      textScaleFactor: 1,
                      minFontSize: 23,
                      maxFontSize: 25,
                    ),
                  ],
                )),
            SizedBox(
              height: height * 0.01,
            ),
            // TextButton(
            //     onPressed: () {
            //       Navigator.pop(context);
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => AllPackageScreen(),
            //           ));
            //     },
            //     child: Row(
            //       children: [
            //         SizedBox(
            //           width: width * 0.03,
            //         ),
            //         Icon(
            //           Icons.class_outlined,
            //           color: Colors.white,
            //           size: height * 0.035,
            //         ),
            //         SizedBox(
            //           width: width * 0.1,
            //         ),
            //         AutoSizeText(
            //           S.of(context).all_packages,
            //           style: Theme.of(context).textTheme.headline3!.copyWith(
            //               color: Colors.white),
            //           textScaleFactor: 1,
            //           minFontSize: 23,
            //           maxFontSize: 25,
            //         ),
            //       ],
            //     )),
            // SizedBox(
            //   height: height * 0.01,
            // ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  get.ChangeBottomBar(index: 1);
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: width * 0.03,
                    ),
                    Icon(
                      Icons.subject,
                      color: Colors.white,
                      size: height * 0.035,
                    ),
                    SizedBox(
                      width: width * 0.1,
                    ),
                    AutoSizeText(
                      S.of(context).child_courses,
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Colors.white),
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
                  get.getMyChildren();
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyChildrenScreen(),));
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: width * 0.03,
                    ),
                    
                    Image.asset('image/icon/student.png',color: Colors.white,width: width * 0.08,height: height * 0.05),
                    SizedBox(
                      width: width * 0.1,
                    ),
                    AutoSizeText(
                      S.of(context).my_children,
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Colors.white),
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
                  get.paymentHistoryModel = null;
                  Navigator.pop(context);
                  get.ChangeBottomBar(index: 2);
                  get.getPaymentHistory();
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: width * 0.03,
                    ),

                    Icon(
                      Icons.payment_outlined,
                      color: Colors.white,
                      size: height * 0.035,
                    ),
                    SizedBox(
                      width: width * 0.1,
                    ),
                    AutoSizeText(
                      S.of(context).payment_history,
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Colors.white),
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
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Colors.white),
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
                  CacheHelper.removeData(key: 'token_student');
                  CacheHelper.removeData(key: 'token');
                  HomeCubit.get(context).deleteAllCardInformation(withCard: true);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WelcomeScreen(),
                      ),
                      (route) => false);
                  get.bottomIndex = 0;
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
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Colors.white),
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
                    value: get.lang == 'en' ? true : false,
                    onChanged: (value) {
                      if (value) {
                        CacheHelper.setData(key: 'lang', value: 'en');
                        S.load(Locale('en'));
                        get.lang = 'en';
                        get.changeLocal(lang: 'en');
                        get.getCourses();
                        // get.getPackages();
                      } else {
                        CacheHelper.setData(key: 'lang', value: 'ar');
                        S.load(Locale('ar'));
                        get.lang = 'ar';
                        get.changeLocal(lang: 'ar');
                        get.getCourses();
                        // get.getPackages();
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
              ),onPressed: ()async{
              var url = 'https://chi-team.com';
              if (await launchUrl(Uri.parse(url),
                  mode: LaunchMode.inAppWebView)) {}
            }),
            SizedBox(
              height: height * 0.01,
            ),
          ],
        ),
      );
    },
  );
}
