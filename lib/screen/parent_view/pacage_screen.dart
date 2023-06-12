import 'package:afaq_alnour_academy/adaptive_widget/adabtive_indecator.dart';
import 'package:afaq_alnour_academy/bloc/home_bloc/home_cubit.dart';
import 'package:afaq_alnour_academy/bloc/home_bloc/home_state.dart';
import 'package:afaq_alnour_academy/constant/const.dart';
import 'package:afaq_alnour_academy/data/local/cache_helper.dart';
import 'package:afaq_alnour_academy/generated/l10n.dart';
import 'package:afaq_alnour_academy/model/package_model.dart';
import 'package:afaq_alnour_academy/screen/parent_view/afaq_layout.dart';
import 'package:afaq_alnour_academy/screen/parent_view/categories_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PackageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is AddChildToCardSuccessState) {
          var get = HomeCubit.get(context);
          get.ChangeBottomBar(index: 3);
          get.initCardList();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AfaqLayout(),
              ));
        }
      },
      builder: (context, state) {
        var get = HomeCubit.get(context);
        int packagePrice = 0;
        if(get.packageModel != null)
          get.packageModel!.data!.courses.forEach((element) {
            packagePrice += element.price!;
          });
        return WillPopScope(
          onWillPop: () {
            return get.deleteAllCardInformation(withCard: false, re: true);
          },
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    get.deleteAllCardInformation(withCard: false);
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios)),
            ),
            extendBodyBehindAppBar: true,
            body: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage('image/background_image/background1.jpg'),
                      fit: BoxFit.cover)),
              child: get.packageModel != null
                  ? ConditionalBuilder(
                      condition: state is! GetPackageByIdLoadingState,
                      builder: (context) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height * 0.12,
                            ),
                            // Container(
                            //   width: width,
                            //   height: height * 0.3,
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(10),
                            //       image: DecorationImage(
                            //           image: NetworkImage(
                            //               '$ImageUrl${get.packageModel!.data!.image_url}'),
                            //           fit: BoxFit.cover)),
                            // ),
                            // SizedBox(
                            //   height: height * 0.02,
                            // ),
                            AutoSizeText(
                              get.packageModel!.data!.description!,
                              style: Theme.of(context).textTheme.headline3,
                              textScaleFactor: 1,
                              minFontSize: 23,
                              maxFontSize: 25,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Expanded(
                              child: ListView.separated(
                                padding: EdgeInsets.all(0),
                                  itemBuilder: (context, index)
                                  {

                                    return courses(
                                        context,
                                        height: height,
                                        width: width,
                                        index: index,model: get.packageModel);
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: height * 0.03,
                                      ),
                                  itemCount:
                                      get.packageModel!.data!.courses.length),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            ConditionalBuilder(
                              condition: state is! AddChildToCardLoadingState,
                              builder: (context) => InkWell(
                                onTap: () {
                                  if (CacheHelper.getData(
                                          key: 'token_student') !=
                                      null) {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) => bottomSheet(
                                            context,
                                            width,
                                            height,
                                            get.myChildrenModel!,
                                            0,
                                            packagePrice: packagePrice,
                                            true));
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) => dialogInRegister(
                                          width * 0.8, height * 0.3, context),
                                    );
                                  }
                                },
                                child: Container(
                                  width: width,
                                  height: height * 0.07,
                                  decoration: BoxDecoration(
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: AutoSizeText(
                                      S.of(context).add_to_cart,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3!
                                          .copyWith(
                                            color: Colors.white,
                                          ),
                                      textScaleFactor: 1,
                                      minFontSize: 23,
                                      maxFontSize: 25,
                                    ),
                                  ),
                                ),
                              ),
                              fallback: (context) =>
                                  Center(child: AdabtiveIndecator(os: getOS())),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                          ],
                        ),
                      ),
                      fallback: (context) =>
                          Center(child: AdabtiveIndecator(os: getOS())),
                    )
                  : Center(child: AdabtiveIndecator(os: getOS())),
            ),
          ),
        );
      },
    );
  }
}

Widget courses(context,
    {double? height, double? width, PackageModel? model, int? index}) {
  return BlocConsumer<HomeCubit, HomeState>(
    listener: (context, state) {
      if (state is AddChildToCardSuccessState) {
        var get = HomeCubit.get(context);
        get.ChangeBottomBar(index: 3);
        get.initCardList();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AfaqLayout(),
            ));
      }
    },
    builder: (context, state) {
      var get = HomeCubit.get(context);
      return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.teal),
            borderRadius: BorderRadius.circular(20)),
        child: ExpansionTile(
          title: AutoSizeText(
            '${get.lang == 'ar' ? model!.data!.courses[index!].ar_name : model!.data!.courses[index!].en_name}',
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
                  Row(
                    children: [
                      SizedBox(
                        width: width! * 0.05,
                      ),
                      Icon(
                        Icons.calendar_month,
                        size: height * 0.035,
                      ),
                      SizedBox(
                        width: width * 0.05,
                      ),
                      AutoSizeText(
                        '${S.of(context).start_date} ${model.data!.courses[index].start_date}',
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
                        '${S.of(context).end_date} ${model.data!.courses[index].end_date}',
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
                        '${S.of(context).start_hour} ${model.data!.courses[index].start_time}',
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
                        '${S.of(context).duration} ${model.data!.courses[index].session_duration} Min',
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
                                  '${model.data!.courses[index].days[index1]}',
                                  style: Theme.of(context).textTheme.headline3,
                                  textScaleFactor: 1,
                                  minFontSize: 21,
                                  maxFontSize: 23,
                                ),
                            separatorBuilder: (context, index) => SizedBox(
                                  width: width * 0.02,
                                ),
                            itemCount: model.data!.courses[index].days.length),
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
                        '${model.data!.courses[index].gender}',
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
                        '${model.data!.courses[index].population}',
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
                      Icon(Icons.group, size: height * 0.035),
                      SizedBox(
                        width: width * 0.05,
                      ),
                      AutoSizeText(
                        '${S.of(context).min_participants} ${model.data!.courses[index].min_participants}',
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
                      Icon(Icons.group, size: height * 0.035),
                      SizedBox(
                        width: width * 0.05,
                      ),
                      AutoSizeText(
                        '${S.of(context).max_participants} ${model.data!.courses[index].max_participants}',
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
                  //       '${S.of(context).remaining_seats} ${int.parse(model.data[index].max_participants!)- int.parse(model.data[index].students_count!) -  studentCount}',
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
                      Icon(Icons.account_balance_wallet_outlined,
                          size: height * 0.035),
                      SizedBox(
                        width: width * 0.05,
                      ),
                      AutoSizeText(
                        '${S.of(context).price} ${model.data!.courses[index].price}£',
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
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

//   Widget Course(context,
//           {double? width,
//           double? height,
//           PackageModel? model,
//           int? index,
//           var get}) =>
//       InkWell(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: width! * 0.3,
//               height: height! * 0.18,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: Colors.teal,
//                 image: DecorationImage(
//                     image: NetworkImage(
//                         '${ImageUrl}${get.lang == 'ar' ? model!.data!.subjects[index!].ar_image_url : model!.data!.subjects[index!].en_image_url}'),
//                     fit: BoxFit.cover),
//               ),
//             ),
//             SizedBox(
//               width: width * 0.03,
//             ),
//             Padding(
//               padding: EdgeInsets.only(top: height * 0.025),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       AutoSizeText(
//                         '${get.lang == 'ar' ? model.data!.subjects[index].ar_name : model.data!.subjects[index].en_name}',
//                         style: Theme.of(context).textTheme.headline3,
//                         textScaleFactor: 1,
//                         minFontSize: 19,
//                         maxFontSize: 21,
//                       )
//                     ],
//                   ),
//                   Container(
//                     width: width * 0.55,
//                     child: AutoSizeText(
//                       '${get.lang == 'ar' ? model.data!.subjects[index].ar_description : model.data!.subjects[index].en_description}',
//                       maxLines: 4,
//                       overflow: TextOverflow.ellipsis,
//                       style: Theme.of(context)
//                           .textTheme
//                           .headline3!
//                           .copyWith(fontWeight: FontWeight.normal),
//                       textScaleFactor: 1,
//                       minFontSize: 16,
//                       maxFontSize: 18,
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//         onTap: () {
//           get.getCategories(id: model.data!.subjects[index].id);
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => CategoriesPackageScreen(
//                     index: index,
//                     description: get.lang == 'ar'
//                         ? model.data!.subjects[index].ar_description
//                         : model.data!.subjects[index].en_description,
//                     image: get.lang == 'ar'
//                         ? model.data!.subjects[index].ar_image_url
//                         : model.data!.subjects[index].en_image_url,
//                     name: get.lang == 'ar'
//                         ? model.data!.subjects[index].ar_name
//                         : model.data!.subjects[index].en_name,
//                     levelOrder: int.parse(model.data!.level_order) == 0
//                         ? 0
//                         : int.parse(model.data!.level_order!) - 1),
//               ));
//         },
//       );
// }

// Widget dialogPay(context,
//     {double? width, double? height, int? price, int? packageId, int? classId}) {
//   return AlertDialog(
//     title: Container(
//       width: width,
//       height: height,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: Colors.white,
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           SizedBox(
//             height: height! * 0.05,
//           ),
//           AutoSizeText(
//             'How do you want to pay ?',
//             style: Theme.of(context).textTheme.bodyText2,
//             textScaleFactor: 1,
//             minFontSize: 23,
//             maxFontSize: 25,
//           ),
//           SizedBox(
//             height: height * 0.2,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               InkWell(
//                 onTap: () {
//                   HomeCubit.get(context).makePayment(context,
//                       amount: price.toString(),
//                       currency: 'gbp',
//                       packageId: packageId,
//                       classId: classId,
//                       type: 'one time');
//                 },
//                 child: Card(
//                   elevation: 0,
//                   child: Container(
//                     width: width! * 0.39,
//                     height: height * 0.37,
//                     color: Colors.white,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.account_balance_wallet,
//                           size: height * 0.24,
//                           color: Colors.indigo,
//                         ),
//                         AutoSizeText(
//                           'Once!',
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodyText2!
//                               .copyWith(color: Colors.indigo),
//                           textScaleFactor: 1,
//                           minFontSize: 21,
//                           maxFontSize: 23,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   final pay = price! / 3;
//                   HomeCubit.get(context).makePayment(context,
//                       amount: pay.round().toString(),
//                       currency: 'gbp',
//                       classId: classId,
//                       packageId: packageId,
//                       type: 'recurring');
//                 },
//                 child: Card(
//                   elevation: 0,
//                   child: Container(
//                     width: width * 0.4,
//                     height: height * 0.37,
//                     color: Colors.white,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.account_balance_wallet,
//                             size: height * 0.24, color: Colors.green),
//                         AutoSizeText(
//                           'Monthly',
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodyText2!
//                               .copyWith(color: Colors.green),
//                           textScaleFactor: 1,
//                           minFontSize: 21,
//                           maxFontSize: 23,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 splashColor: Colors.grey,
//                 focusColor: Colors.grey,
//                 highlightColor: Colors.grey,
//                 hoverColor: Colors.grey,
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//     backgroundColor: Colors.white,
//     elevation: 0,
//   );
// }
