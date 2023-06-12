

import 'package:afaq_alnour_academy/bloc/home_bloc/home_cubit.dart';
import 'package:afaq_alnour_academy/bloc/home_bloc/home_state.dart';
import 'package:afaq_alnour_academy/data/local/cache_helper.dart';
import 'package:afaq_alnour_academy/generated/l10n.dart';
import 'package:afaq_alnour_academy/screen/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:hexcolor/hexcolor.dart';


class On_Boarding_Screen extends StatefulWidget {
  On_Boarding_Screen({Key? key}) : super(key: key);

  @override
  _On_Boarding_ScreenState createState() => _On_Boarding_ScreenState();
}

class _On_Boarding_ScreenState extends State<On_Boarding_Screen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OverBoard(
        allowScroll: true,
        pages: pages,
        showBullets: true,
        skipText: '${S.of(context).button_skip}',
        nextText: '${S.of(context).button_next}',
        finishText: "${S.of(context).button_finish}",
        buttonColor: Colors.black,
        inactiveBulletColor: Colors.white,
        activeBulletColor: Colors.black,
        // backgroundProvider: NetworkImage('https://picsum.photos/720/1280'),
        skipCallback: () {
          CacheHelper.setData(key: 'on_boarding', value: true).then((value) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => WelcomeScreen(),
                ),
                    (route) => false);
          });
        },
        finishCallback: () {
          CacheHelper.setData(key: 'on_boarding', value: true).then((value) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => WelcomeScreen(),
                ),
                    (route) => false);
          });
        },
      ),
    );
  }

  final pages = [
    PageModel.withChild(
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            var get = HomeCubit.get(context);
            return Container(
              width: 300,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Image.asset(
                      '${get.lang == "ar" ? "image/on_boarding_img/onBoarding1.png" : "image/on_boarding_img/on_boarding_1e.png"}',
                      height: 300,
                      width: 300,
                    ),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            );
          },
        ),
        color: HexColor('#fdd4a1'),
        bodyColor: Colors.white,
        titleColor: Colors.white,
        doAnimateChild: true),
    PageModel.withChild(
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            var get = HomeCubit.get(context);
            return Container(
              width: 300,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Image.asset(
                      '${get.lang == "ar" ? "image/on_boarding_img/onBoarding2.png" : "image/on_boarding_img/on_boarding_2e.png"}',
                      height: 300,
                      width: 300,
                    ),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            );
          },
        ),
        color: HexColor('#bab4d3'),
        bodyColor: Colors.white,
        titleColor: Colors.white,
        doAnimateChild: true),
    PageModel.withChild(
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            var get = HomeCubit.get(context);
            return Container(
              width: 300,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Image.asset(
                      '${get.lang == "ar" ? "image/on_boarding_img/onBoarding3.png" : "image/on_boarding_img/on_boarding_3e.png"}',
                      height: 300,
                      width: 300,
                    ),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            );
          },
        ),
        color: HexColor('#93cbea'),
        bodyColor: Colors.white,
        titleColor: Colors.white,
        doAnimateChild: true),
  ];
}
