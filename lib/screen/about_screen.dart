import 'package:afaq_alnour_academy/bloc/home_bloc/home_cubit.dart';
import 'package:afaq_alnour_academy/generated/l10n.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    List<String> item = [
      'image/about_image/1.jpg',
      'image/about_image/2.jpg',
      'image/about_image/3.jpg',
      'image/about_image/4.jpg',
      'image/about_image/5.jpg',
      'image/about_image/6.jpg',
      'image/about_image/7.jpg',
    ];

    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          S.of(context).info,
          style: Theme.of(context).textTheme.headline3,
          textScaleFactor: 1,
          minFontSize: 23,
          maxFontSize: 25,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              // CarouselSlider(
              //     items: List.generate(
              //       item.length,
              //       (index) => Container(
              //         height: height * 0.4,
              //         width: width,
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(10),
              //             image: DecorationImage(
              //                 image: AssetImage('${item[index]}'),
              //                 fit: BoxFit.cover)),
              //       ),
              //     ),
              //     options: CarouselOptions(
              //       autoPlay: true,
              //       autoPlayAnimationDuration: Duration(seconds: 2),
              //       autoPlayCurve: Curves.fastOutSlowIn,
              //       initialPage: 0,
              //       reverse: false,
              //       viewportFraction: 1.0,
              //       scrollDirection: Axis.horizontal,
              //       height: height * 0.4,
              //       enableInfiniteScroll: true,
              //       autoPlayInterval: Duration(seconds: 3),
              //     )),
              // SizedBox(
              //   height: height * 0.03,
              // ),
              // AutoSizeText(
              //   S.of(context).branch,
              //   style: Theme.of(context)
              //       .textTheme
              //       .headline3,
              //   textScaleFactor: 1,
              //   minFontSize: 21,
              //   maxFontSize: 23,
              // ),
              // SizedBox(
              //   height: height * 0.02,
              // ),
              // Row(
              //   children: [
              //     Icon(
              //       Icons.phone,
              //       size: height * 0.035,
              //     ),
              //     SizedBox(
              //       width: width * 0.05,
              //     ),
              //     AutoSizeText(
              //       '07481255477',
              //       style: Theme.of(context)
              //           .textTheme
              //           .headline3,
              //       textScaleFactor: 1,
              //       minFontSize: 16,
              //       maxFontSize: 18,
              //     )
              //   ],
              // ),
              // SizedBox(
              //   height: height * 0.02,
              // ),
              // Row(
              //   children: [
              //     Icon(Icons.email_outlined, size: height * 0.035),
              //     SizedBox(
              //       width: width * 0.05,
              //     ),
              //     AutoSizeText(
              //       'afaqprospects@gmail.com',
              //       style: Theme.of(context)
              //           .textTheme
              //           .headline3,
              //       textScaleFactor: 1,
              //       minFontSize: 16,
              //       maxFontSize: 18,
              //     )
              //   ],
              // ),
              // SizedBox(
              //   height: height * 0.03,
              // ),
              // AutoSizeText(
              //   S.of(context).branch1,
              //   style: Theme.of(context)
              //       .textTheme
              //       .headline3,
              //   textScaleFactor: 1,
              //   minFontSize: 21,
              //   maxFontSize: 23,
              // ),
              // SizedBox(
              //   height: height * 0.02,
              // ),
              // Row(
              //   children: [
              //     Icon(
              //       Icons.phone,
              //       size: height * 0.035,
              //     ),
              //     SizedBox(
              //       width: width * 0.05,
              //     ),
              //     AutoSizeText(
              //       '07492052253',
              //       style: Theme.of(context)
              //           .textTheme
              //           .headline3,
              //       textScaleFactor: 1,
              //       minFontSize: 16,
              //       maxFontSize: 18,
              //     )
              //   ],
              // ),
              // SizedBox(
              //   height: height * 0.02,
              // ),
              // Row(
              //   children: [
              //     Icon(Icons.email_outlined, size: height * 0.035),
              //     SizedBox(
              //       width: width * 0.05,
              //     ),
              //     AutoSizeText(
              //       'afaqalnourbirmingham@gmail.com',
              //       style: Theme.of(context)
              //           .textTheme
              //           .headline3,
              //       textScaleFactor: 1,
              //       minFontSize: 16,
              //       maxFontSize: 18,
              //     )
              //   ],
              // ),
              // Spacer(),
              // Center(
              //   child: AutoSizeText(
              //     'Made By CHI-Co Team',
              //     style: Theme.of(context)
              //         .textTheme
              //         .headline3,
              //     textScaleFactor: 1,
              //     minFontSize: 19,
              //     maxFontSize: 21,
              //   ),
              // ),
              // SizedBox(
              //   height: height * 0.01,
              // ),
              Text(
                S.of(context).name_company,
                textScaleFactor: 1,
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                S.of(context).description,
                textScaleFactor: 1,
              ),
              Container(
                child: Image.asset(
                  '${HomeCubit.get(context).lang == "ar" ? "image/on_boarding_img/onBoarding1.png" : "image/on_boarding_img/on_boarding_1e.png"}',
                  height: 300,
                  width: 300,
                ),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                clipBehavior: Clip.antiAliasWithSaveLayer,
              ),
              Container(
                child: Image.asset(
                  '${HomeCubit.get(context).lang == "ar" ? "image/on_boarding_img/onBoarding2.png" : "image/on_boarding_img/on_boarding_2e.png"}',
                  height: 300,
                  width: 300,
                ),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                clipBehavior: Clip.antiAliasWithSaveLayer,
              ),
              Container(
                child: Image.asset(
                  '${HomeCubit.get(context).lang == "ar" ? "image/on_boarding_img/onBoarding3.png" : "image/on_boarding_img/on_boarding_3e.png"}',
                  height: 300,
                  width: 300,
                ),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                clipBehavior: Clip.antiAliasWithSaveLayer,
              ),
              Container(
                child: Image.asset(
                  'image/info_p.png',
                  height: 300,
                  width: 300,
                ),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                clipBehavior: Clip.antiAliasWithSaveLayer,
              ),
              Container(
                child: Image.asset(
                  'image/info_pp.png',
                  height: height * 0.3,
                  width: width,
                ),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                clipBehavior: Clip.antiAliasWithSaveLayer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
