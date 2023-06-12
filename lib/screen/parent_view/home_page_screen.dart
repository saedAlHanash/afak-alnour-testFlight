import 'package:afaq_alnour_academy/data/local/cache_helper.dart';
import 'package:afaq_alnour_academy/model/course_model.dart';
import 'package:afaq_alnour_academy/model/slider_model.dart';
import 'package:afaq_alnour_academy/screen/parent_view/all_course_screen.dart';
import 'package:afaq_alnour_academy/screen/parent_view/all_package_screen.dart';
import 'package:afaq_alnour_academy/screen/parent_view/pacage_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../adaptive_widget/adabtive_indecator.dart';
import '../../bloc/home_bloc/home_cubit.dart';
import '../../bloc/home_bloc/home_state.dart';
import '../../constant/const.dart';
import '../../generated/l10n.dart';

import 'categories_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var get = HomeCubit.get(context);
        return SingleChildScrollView(
          child: get.model != null
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.03,
                      ),
                      if (get.sliderModel?.data.isNotEmpty ?? false)
                        CarouselSlider(
                            items: List.generate(
                                get.sliderModel!.data.length,
                                (index) => slider(
                                    height: height,
                                    width: width,
                                    model: get.sliderModel,
                                    index: index)),
                            options: CarouselOptions(
                              autoPlay: true,
                              autoPlayAnimationDuration: Duration(seconds: 2),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              initialPage: 0,
                              reverse: false,
                              viewportFraction: 1.0,
                              scrollDirection: Axis.horizontal,
                              height: height * 0.3,
                              enableInfiniteScroll: true,
                              autoPlayInterval: Duration(seconds: 3),
                            )),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      get.model!.data!.isNotEmpty
                          ? Card(
                              elevation: 0,
                              margin: EdgeInsets.all(0),
                              color: Colors.white.withOpacity(0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsetsDirectional.only(start: width * 0.02),
                                    child: Row(
                                      children: [
                                        AutoSizeText(
                                          S.of(context).all_courses,
                                          style: Theme.of(context).textTheme.bodyText2,
                                          textScaleFactor: 1,
                                          minFontSize: 26,
                                          maxFontSize: 28,
                                        ),
                                        Spacer(),
                                        TextButton(
                                            child: AutoSizeText(
                                              S.of(context).see_all,
                                              style:
                                                  Theme.of(context).textTheme.bodyText2,
                                              textScaleFactor: 1,
                                              minFontSize: 21,
                                              maxFontSize: 23,
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AllCourseScreen(),
                                                  ));
                                            }),
                                        SizedBox(
                                          width: width * 0.02,
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Container(
                                    width: width,
                                    height: height * 0.3,
                                    child: ListView.builder(
                                        padding: EdgeInsets.all(0),
                                        itemBuilder: (context, index) => CourseBuilder(
                                            context,
                                            width: width,
                                            index: index,
                                            get: get,
                                            height: height,
                                            model: get.model!),
                                        itemCount: get.model!.data!.length > 3
                                            ? 3
                                            : get.model!.data!.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      // get.packages!.data!.isNotEmpty
                      //     ? Card(
                      //         elevation: 0,
                      //         margin: EdgeInsets.all(0),
                      //         color: Colors.white.withOpacity(0),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Padding(
                      //               padding: EdgeInsetsDirectional.only(
                      //                   start: width * 0.02),
                      //               child: Row(
                      //                 children: [
                      //                   AutoSizeText(
                      //                     S.of(context).all_packages,
                      //                     style: Theme.of(context)
                      //                         .textTheme
                      //                         .bodyText2,
                      //                     textScaleFactor: 1,
                      //                     minFontSize: 26,
                      //                     maxFontSize: 28,
                      //                   ),
                      //                   Spacer(),
                      //                   TextButton(
                      //                       child: AutoSizeText(
                      //                         S.of(context).see_all,
                      //                         style: Theme.of(context)
                      //                             .textTheme
                      //                             .bodyText2,
                      //                         textScaleFactor: 1,
                      //                         minFontSize: 21,
                      //                         maxFontSize: 23,
                      //                       ),
                      //                       onPressed: () {
                      //                         Navigator.push(
                      //                             context,
                      //                             MaterialPageRoute(
                      //                               builder: (context) =>
                      //                                   AllPackageScreen(),
                      //                             ));
                      //                       }),
                      //                   SizedBox(
                      //                     width: width * 0.02,
                      //                   )
                      //                 ],
                      //               ),
                      //             ),
                      //             SizedBox(
                      //               height: height * 0.01,
                      //             ),
                      //             Container(
                      //                 height: height * 0.2,
                      //                 width: width,
                      //                 child: ListView.builder(
                      //                     itemBuilder: (context, index) =>
                      //                         packageBuilder(context,
                      //                             model: get.packages!,
                      //                             get: get,
                      //                             height: height,
                      //                             index: index,
                      //                             width: width),
                      //                     shrinkWrap: true,
                      //                     padding: EdgeInsets.all(0),
                      //                     physics: BouncingScrollPhysics(),
                      //                     scrollDirection: Axis.horizontal,
                      //                     itemCount:
                      //                         get.packages!.data!.length > 3
                      //                             ? 3
                      //                             : get.packages!.data!
                      //                                 .length))
                      //           ],
                      //         ),
                      //       )
                      //     : const SizedBox(),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      // get.seasonal!.data!.isNotEmpty
                      //     ? Card(
                      //         elevation: 0,
                      //         margin: EdgeInsets.all(0),
                      //         color: Colors.white.withOpacity(0),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Padding(
                      //               padding: EdgeInsetsDirectional.only(
                      //                   start: width * 0.02),
                      //               child: Row(
                      //                 children: [
                      //                   Text(
                      //                     S.of(context).seasonal_course,
                      //                     style: Theme.of(context)
                      //                         .textTheme
                      //                         .bodyText2!
                      //                         .copyWith(
                      //                             fontSize: height * 0.030),
                      //                   ),
                      //                   Spacer(),
                      //                   TextButton(
                      //                       child: Text(
                      //                         S.of(context).see_all,
                      //                         style: Theme.of(context)
                      //                             .textTheme
                      //                             .bodyText2!
                      //                             .copyWith(
                      //                                 fontSize: height * 0.025),
                      //                       ),
                      //                       onPressed: () {}),
                      //                   SizedBox(
                      //                     width: width * 0.02,
                      //                   )
                      //                 ],
                      //               ),
                      //             ),
                      //             SizedBox(
                      //               height: height * 0.01,
                      //             ),
                      //             Container(
                      //                 height: height * 0.2,
                      //                 width: width,
                      //                 child: ListView.builder(
                      //                     itemBuilder: (context, index) =>
                      //                         CourseBuilder(context,
                      //                             model: get.seasonal!,
                      //                             get: get,
                      //                             height: height,
                      //                             index: index,
                      //                             width: width),
                      //                     shrinkWrap: true,
                      //                     physics: BouncingScrollPhysics(),
                      //                     scrollDirection: Axis.horizontal,
                      //                     itemCount: get.seasonal!.data!.length > 3 ? 3 : get.seasonal!.data!.length)),
                      //           ],
                      //         ),
                      //       )
                      //     : const SizedBox(),
                      // SizedBox(
                      //   height: height * 0.03,
                      // )
                    ],
                  ),
                )
              : Center(child: AdabtiveIndecator(os: getOS())),
        );
      },
    );
  }

  Widget slider({double? width, double? height, SliderModel? model, int? index}) {
    return Container(
      height: height! * 0.25,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: NetworkImage('$ImageUrl${model!.data[index!].image_url}'),
              fit: BoxFit.cover)),
      // child: Image.network(
      //   '$ImageUrl${model!.data[index!].image_url}',
      //   fit: BoxFit.cover,
      //   height: height! * 0.25,
      //   width: width,
      // ),
    );
  }

  Widget CourseBuilder(context,
          {CourseModel? model, var get, int? index, double? width, double? height}) =>
      InkWell(
        onTap: () {
          get.getCategories(id: model!.data![index!].id);
          get.subjectName = model.data![index].name;
          get.subjectId = model.data![index].id;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CategoriesScreen(
                        index: index,
                        name: model.data![index].name,
                        id: model.data![index].id,
                        description: model.data![index].description,
                        image: model.data![index].image_url,
                      )));
        },
        child: Container(
          height: height! * 0.3,
          width: width! * 0.6,
          margin: EdgeInsets.symmetric(horizontal: width * 0.03),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              image: DecorationImage(
                  image: NetworkImage('$ImageUrl${model!.data![index!].image_url}'),
                  fit: BoxFit.cover)),
        ),
      );
}

Widget packageBuilder(context,
        {CourseModel? model, var get, int? index, double? width, double? height}) =>
    BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is GetPackageByIdSuccessState) {}
      },
      builder: (context, state) {
        return InkWell(
          onTap: () {
            get.packageModel = null;
            get.subjectName = model!.data![index!].name;
            get.subjectId = model.data![index].id;
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PackageScreen(),
                ));
            get.getPackageById(id: model.data![index].id);
          },
          child: Card(
            color: HexColor('#d6eaf7'),
            child: Container(
              height: height! * 0.3,
              width: width! * 0.6,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage('$ImageUrl${model!.data![index!].image_url}'),
                      fit: BoxFit.cover)),
            ),
          ),
        );
      },
    );
