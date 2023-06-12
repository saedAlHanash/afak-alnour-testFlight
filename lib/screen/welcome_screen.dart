import 'dart:async';

import 'package:afaq_alnour_academy/screen/login_screen.dart';
import 'package:afaq_alnour_academy/screen/parent_view/afaq_layout.dart';
import 'package:afaq_alnour_academy/screen/parent_view/register_parent.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/home_bloc/home_cubit.dart';
import '../bloc/login_bloc/login_cubit.dart';
import '../bloc/login_bloc/login_state.dart';
import '../constant/const.dart';
import '../generated/l10n.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.1,
          ),
          Center(
              child: AutoSizeText(
            S.of(context).welcome,
            style: Theme.of(context)
                .textTheme
                .headline3,
                textScaleFactor: 1,
                minFontSize: 31,
                maxFontSize: 33,
          )),
          Center(
              child: AutoSizeText(
            S.of(context).name_company,
            style: Theme.of(context).textTheme.headline3,
                textScaleFactor: 1,minFontSize: 18,maxLines: 20,
          )),
          Container(
            width: width,
            height: height * 0.4,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('image/welcome.jpg'), fit: BoxFit.cover)),
          ),
          Container(
            width: width * 0.9,
            height: height * 0.07,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: HexColor('#c0e1f4')),
            child: TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return BlocConsumer<LoginCubit, LoginState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          var get = LoginCubit.get(context);
                          return AlertDialog(
                            title: Container(
                              width: width * 0.8,
                              height: height * 0.31,
                              child: Column(
                                children: [
                                  AutoSizeText(S.of(context).sign_in_ass,style: Theme.of(context).textTheme.bodyText2,
                                    textScaleFactor: 1,
                                    minFontSize: 21,
                                    maxFontSize: 23,
                                  ),
                                  SizedBox(
                                    height: height * 0.05,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'image/icon/parent.png',
                                              fit: BoxFit.cover,
                                              height: height * 0.07,
                                              width: width * 0.15,
                                              color: get.user == 'parent' ? Colors.teal:Colors.grey,
                                            ),
                                            AutoSizeText(S.of(context).parent,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2!.copyWith(
                                                  color: get.user == 'parent' ? Colors.teal : Colors.grey,
                                                ),
                                              textScaleFactor: 1,
                                              minFontSize: get.user == 'parent' ? 19 : 17,
                                              maxFontSize:get.user == 'parent' ? 21 : 19,
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          get.changeUser(value: 'parent');
                                        },
                                      ),
                                      InkWell(
                                        child: Column(
                                          children: [
                                            Image.asset(
                                                'image/icon/student.png',
                                                fit: BoxFit.cover,
                                                height: height * 0.07,
                                                width: width * 0.15,
                                                color: get.user == 'child' ?Colors.teal : Colors.grey),
                                            AutoSizeText(S.of(context).child,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2!.copyWith(
                                                  color: get.user == 'child' ? Colors.teal: Colors.grey,),
                                              textScaleFactor: 1,
                                              minFontSize: get.user == 'child' ? 19 : 17,
                                              maxFontSize:get.user == 'dhild' ? 21 : 19,
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          get.changeUser(value: 'child');
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.05,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LoginScreen(),
                                          ));
                                    },
                                    child: Container(
                                      width: width * 0.7,
                                      height: height * 0.06,
                                      decoration: BoxDecoration(
                                          color: HexColor('#c0e1f4'),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: Text(S.of(context).lets_go,style: Theme.of(context).textTheme.bodyText2),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    });
              },
              child: AutoSizeText(
                S.of(context).login,
                style: Theme.of(context)
                    .textTheme
                    .headline5,
                textScaleFactor: 1,
                minFontSize: 20,
                maxFontSize: 22,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                S.of(context).have_account,
                style: Theme.of(context)
                    .textTheme
                    .headline4,
                textScaleFactor: 1,
                minFontSize: 18,
                maxFontSize: 20,
              ),
              TextButton(
                  onPressed: () async {
                    // final url = 'http://afaqalnour-web.chi-team.com/sign-up';
                    // if (await launchUrl(Uri.parse(url),
                    //     mode: LaunchMode.externalNonBrowserApplication)) {}
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterParent(),));

                  },
                  child: AutoSizeText(
                    S.of(context).register,
                    style: TextStyle(
                        fontFamily: primaryfont,
                        fontWeight: FontWeight.bold),
                    textScaleFactor: 1,
                    minFontSize: 21,
                    maxFontSize: 23,
                  ))
            ],
          ),
          Center(
              child: TextButton(
            child: AutoSizeText(
              S.of(context).guest,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Colors.indigo),
              textScaleFactor: 1,
              minFontSize: 21,
              maxFontSize: 23,
            ),
            onPressed: () {
              HomeCubit.get(context).getCourses();
              // HomeCubit.get(context).getPackages();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AfaqLayout(),
                  ),
                  (route) => false);
            },
          )),
          HomeCubit.get(context).lang == 'ar' ?
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(S.of(context).policy,style: Theme.of(context).textTheme.headline3,
                textScaleFactor: 1,
                minFontSize: 12,
                maxFontSize: 13,
              ),
              TextButton(onPressed: ()async{
                var url = 'https://afaqalnour.com/app/ar/privacy-policy';
                if (await launchUrl(Uri.parse(url),
                    mode: LaunchMode.inAppWebView)) {}
              }, child: AutoSizeText(S.of(context).policy1,style:Theme.of(context).textTheme.headline3!.copyWith(
                  color: Colors.blue
              ),
                textScaleFactor: 1,
                minFontSize: 12,
                maxFontSize: 13,
              ),style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(0))
              ),),
              AutoSizeText(S.of(context).policy2,style: Theme.of(context).textTheme.headline3,
                textScaleFactor: 1,
                minFontSize: 12,
                maxFontSize: 13,
              ),
            ],
          ) : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(S.of(context).policy,style: Theme.of(context).textTheme.headline3,
                textScaleFactor: 1,
                minFontSize: 12,
                maxFontSize: 13,
              ),
              TextButton(onPressed: ()async{
                var url = 'https://afaqalnour.com/app/en/privacy-policy';
                if (await launchUrl(Uri.parse(url),
                    mode: LaunchMode.inAppWebView)) {}
              }, child: AutoSizeText(S.of(context).policy1,style:Theme.of(context).textTheme.headline3!.copyWith(
                  color: Colors.blue
              ),
                textScaleFactor: 1,
                minFontSize: 12,
                maxFontSize: 13,
              ),style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.all(0)),
              ),),
            ],
          ),
        ],
      ),
    );
  }
}

void checkNotifications() async {
  var state = await Permission.notification.status;
  var state1 = await Permission.accessNotificationPolicy.status;
  if (state.isGranted) {
  } else if (state.isDenied) {
    await Permission.notification.request();
  }
  if (state1.isGranted) {
  } else if (state1.isDenied) {
    await Permission.notification.request();
  }
}
