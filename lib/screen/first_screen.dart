import 'package:afaq_alnour_academy/screen/parent_view/on_boarding_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../bloc/home_bloc/home_cubit.dart';
import '../bloc/home_bloc/home_state.dart';
import '../data/local/cache_helper.dart';
import '../generated/l10n.dart';

class FirstScreen extends StatefulWidget {
  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var get = HomeCubit.get(context);
        return Directionality(
          textDirection:
              get.lang == 'ar' ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            // backgroundColor: HexColor('#fcfcfe'),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.07),
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Image.asset(
                      'image/logo_afaq.png',
                      height: height * 0.25,
                      width: width * 0.5,
                      fit: BoxFit.fitHeight,
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    AutoSizeText(
                      '${S.of(context).name_company}',
                      style: Theme.of(context).textTheme.bodyText2,
                      textScaleFactor: 1,
                      minFontSize: 30,
                      maxFontSize: 32,
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Container(
                      height: height * 0.39,
                      child: SingleChildScrollView(
                        child: AutoSizeText(
                          '${S.of(context).description}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  backgroundColor:
                                      Colors.white.withOpacity(0.5)),
                          textScaleFactor: 1,
                          minFontSize: 16,
                          maxFontSize: 18,
                        ),
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                CacheHelper.setData(key: 'lang', value: 'ar');
                                S.load(Locale('ar'));
                                get.lang = 'ar';
                                get.changeLocal(lang: 'ar');
                              });
                            },
                            child: Image.asset(
                              'image/arabic_lang.png',
                              width: width * 0.2,
                              height: get.lang == "ar"
                                  ? height * 0.09
                                  : height * 0.08,
                            )),
                        InkWell(
                            onTap: () {
                              setState(() {
                                CacheHelper.setData(key: 'lang', value: 'en');
                                S.load(Locale('en'));
                                get.lang = 'en';
                                get.changeLocal(lang: 'en');
                              });
                            },
                            child: Image.asset(
                              'image/english_lang.png',
                              width: width * 0.2,
                              height: get.lang == null || get.lang == "en"
                                  ? height * 0.09
                                  : height * 0.08,
                            )),
                        Spacer(),
                        Container(
                            width: width * 0.25,
                            height: height * 0.06,
                            decoration: BoxDecoration(
                                color: get.lang == null || get.lang == "en"
                                    ? HexColor('#c0e1f4')
                                    : HexColor("#f2d4dc"),
                                borderRadius: BorderRadius.circular(10)),
                            child: MaterialButton(
                              onPressed: () {
                                if (get.lang == null) {
                                  CacheHelper.setData(
                                      key: 'lang', value: 'en');
                                  get.lang = 'en';
                                  CacheHelper.setData(
                                          key: 'first', value: true)
                                      .then((value) {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              On_Boarding_Screen(),
                                        ),
                                        (route) => false);
                                  });
                                } else {
                                  CacheHelper.setData(
                                          key: 'first', value: true)
                                      .then((value) {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              On_Boarding_Screen(),
                                        ),
                                        (route) => false);
                                  });
                                }
                              },
                              child: AutoSizeText(
                                '${S.of(context).button_next}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                textScaleFactor: 1,
                                minFontSize: 21,
                                maxFontSize: 23,
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
