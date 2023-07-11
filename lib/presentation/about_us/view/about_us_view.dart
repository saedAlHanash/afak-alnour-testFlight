import 'package:afak_tetcher/presentation/resources/assets_manger.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/color_manger.dart';
import '../../resources/font_manger.dart';
import '../../resources/string_manger.dart';
import '../../resources/values_manger.dart';
import '../view_model/about_us_controller.dart';

class AboutUsView extends GetView<AboutUsController> {
  const AboutUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.info.tr,
          textScaleFactor: 1,
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(fontSize: FontSize.s22),
        ),
        centerTitle: false,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: ColorManger.purple,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height * 0.03,
              ),
              // CarouselSlider(
              //     items: controller.items
              //         .map((e) => Container(
              //               height: Get.height * 0.35,
              //               decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(AppSize.s14),
              //                   image: DecorationImage(
              //                       image: AssetImage(e), fit: BoxFit.cover)),
              //             ))
              //         .toList(),
              //     options: CarouselOptions(
              //       autoPlay: true,
              //       autoPlayAnimationDuration: const Duration(seconds: 2),
              //       autoPlayCurve: Curves.fastOutSlowIn,
              //       initialPage: 0,
              //       reverse: false,
              //       viewportFraction: 1.0,
              //       scrollDirection: Axis.horizontal,
              //       height: Get.height * 0.35,
              //       enableInfiniteScroll: true,
              //       autoPlayInterval: const Duration(seconds: 3),
              //     )),
              // SizedBox(
              //   height: Get.height * 0.03,
              // ),
              // Text(
              //   AppStrings.wolverhampton.tr,
              //   style: Theme.of(context).textTheme.titleLarge,
              //   textScaleFactor: 1,
              // ),
              // SizedBox(
              //   height: Get.height * 0.02,
              // ),
              // Row(
              //   children: [
              //     Icon(
              //       Icons.phone,
              //       size: Get.height * 0.035,
              //     ),
              //     SizedBox(
              //       width: Get.width * 0.05,
              //     ),
              //     Text(
              //       '07481255477',
              //       style: Theme.of(context).textTheme.titleLarge,
              //       textScaleFactor: 1,
              //     )
              //   ],
              // ),
              // SizedBox(
              //   height: Get.height * 0.02,
              // ),
              // Row(
              //   children: [
              //     Icon(Icons.email_outlined, size: Get.height * 0.035),
              //     SizedBox(
              //       width: Get.width * 0.05,
              //     ),
              //     Expanded(
              //       child: Text(
              //         'afaqprospects@gmail.com',
              //         style: Theme.of(context).textTheme.titleLarge,
              //         textScaleFactor: 1,
              //       ),
              //     )
              //   ],
              // ),
              // SizedBox(
              //   height: Get.height * 0.03,
              // ),
              // Text(
              //   AppStrings.birmingham.tr,
              //   style: Theme.of(context).textTheme.titleLarge,
              //   textScaleFactor: 1,
              // ),
              // SizedBox(
              //   height: Get.height * 0.02,
              // ),
              // Row(
              //   children: [
              //     Icon(
              //       Icons.phone,
              //       size: Get.height * 0.035,
              //     ),
              //     SizedBox(
              //       width: Get.width * 0.05,
              //     ),
              //     Text(
              //       '07492052253',
              //       style: Theme.of(context).textTheme.titleLarge,
              //       textScaleFactor: 1,
              //     )
              //   ],
              // ),
              // SizedBox(
              //   height: Get.height * 0.02,
              // ),
              // Row(
              //   children: [
              //     Icon(Icons.email_outlined, size: Get.height * 0.035),
              //     SizedBox(
              //       width: Get.width * 0.05,
              //     ),
              //     Expanded(
              //       child: Text(
              //         'afaqalnourbirmingham@gmail.com',
              //         style: Theme.of(context).textTheme.titleLarge,
              //         textScaleFactor: 1,
              //       ),
              //     )
              //   ],
              // ),
              // const Spacer(),
              // Center(
              //   child: Text(
              //     'Made By CHI-Co Team',
              //     style: Theme.of(context).textTheme.titleLarge,
              //     textScaleFactor: 1,
              //   ),
              // ),
              // SizedBox(
              //   height: Get.height * 0.01,
              // ),
              Text(
                AppStrings.nameAcademy.tr,
                textScaleFactor: 1,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Text(
                AppStrings.desc,
                textScaleFactor: 1,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Container(
                child: Image.asset(
                  ImageAssets.carousel1,
                  height: 300,
                  width: 300,
                ),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                clipBehavior: Clip.antiAliasWithSaveLayer,
              ),
              Container(
                child: Image.asset(
                  ImageAssets.carousel2,
                  height: 300,
                  width: 300,
                ),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                clipBehavior: Clip.antiAliasWithSaveLayer,
              ),
              Container(
                child: Image.asset(
                  ImageAssets.carousel3,
                  height: 300,
                  width: 300,
                ),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                clipBehavior: Clip.antiAliasWithSaveLayer,
              ),
              Container(
                child: Image.asset(
                  ImageAssets.info1,
                  height: 300,
                  width: 300,
                ),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                clipBehavior: Clip.antiAliasWithSaveLayer,
              ),
              Container(
                child: Image.asset(
                  ImageAssets.info2,
                  height: 300,
                  width: 300,
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
