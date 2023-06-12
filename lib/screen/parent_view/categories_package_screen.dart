// import 'package:afaq_alnour_academy/adaptive_widget/adabtive_indecator.dart';
// import 'package:afaq_alnour_academy/bloc/home_bloc/home_cubit.dart';
// import 'package:afaq_alnour_academy/bloc/home_bloc/home_state.dart';
// import 'package:afaq_alnour_academy/constant/const.dart';
// import 'package:afaq_alnour_academy/data/local/cache_helper.dart';
// import 'package:afaq_alnour_academy/generated/l10n.dart';
// import 'package:afaq_alnour_academy/model/package_model.dart';
// import 'package:afaq_alnour_academy/screen/parent_view/level_package_screen.dart';
// import 'package:afaq_alnour_academy/screen/welcome_screen.dart';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
//
//
//
// class CategoriesPackageScreen extends StatelessWidget {
//   int index;
//   String? description;
//   String? image;
//   String? name;
//   int? levelOrder;
//   CategoriesPackageScreen(
//       {required this.index,
//         required this.description,
//         required this.image,
//         required this.levelOrder,
//         required this.name});
//
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//
//     return BlocConsumer<HomeCubit, HomeState>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         var get = HomeCubit.get(context);
//         return Scaffold(
//           extendBodyBehindAppBar: true,
//           appBar: AppBar(
//             title: AutoSizeText(
//               '${name}',
//               style: Theme.of(context)
//                   .textTheme
//                   .headline3,
//               textScaleFactor: 1,
//               minFontSize: 23,
//               maxFontSize: 25,
//             ),
//           ),
//           body: Container(
//             width: width,
//             height: height,
//             decoration: BoxDecoration(
//                 image: DecorationImage(
//                     image: AssetImage('image/background_image/background3.jpg'),
//                     fit: BoxFit.cover)),
//             child: SingleChildScrollView(
//               physics: BouncingScrollPhysics(),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: width * 0.05),
//                 child: ConditionalBuilder(
//                   condition: get.categorisModel != null,
//                   builder: (context) => Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: height * 0.14,
//                       ),
//                       SizedBox(
//                         height: height * 0.01,
//                       ),
//                       Container(
//                         width: width,
//                         height: height * 0.3,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             image: DecorationImage(
//                                 image: NetworkImage('$ImageUrl${image}'),
//                                 fit: BoxFit.cover)),
//                       ),
//                       SizedBox(
//                         height: height * 0.02,
//                       ),
//                       AutoSizeText(
//                         S.of(context).description_course,
//                         style: Theme.of(context)
//                             .textTheme
//                             .bodyText2,
//                         textScaleFactor: 1,
//                         minFontSize: 26,
//                         maxFontSize: 28,
//                       ),
//                       SizedBox(
//                         height: height * 0.02,
//                       ),
//                       AutoSizeText(
//                         '$description',
//                         style: Theme.of(context)
//                             .textTheme
//                             .bodyText2,
//                         textScaleFactor: 1,
//                         minFontSize: 21,
//                         maxFontSize: 23,
//                       ),
//                       SizedBox(
//                         height: height * 0.05,
//                       ),
//                       CourseTile(context,get: get,height: height,categories: get.packageModel!.data!.subjects[index].categories[0],width: width,index: index,levelOrder: levelOrder),
//                       SizedBox(
//                         height: height * 0.03,
//                       ),
//                     ],
//                   ),
//                   fallback: (context) => Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         height: height * 0.4,
//                       ),
//                       AdabtiveIndecator(os: getOS()),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// Widget CourseTile(context,
//     {double? width,
//       double? height,
//       Categories? categories,
//       int? index,
//       int? levelOrder,
//       var get}) =>
//     Container(
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: Colors.transparent,
//           border: Border.all(color: Colors.teal)),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   width: width! * 0.55,
//                   child: AutoSizeText(
//                     '${get.lang == 'ar' ? categories!.ar_name : categories!.en_name}',
//                     style: Theme.of(context)
//                         .textTheme
//                         .headline3,
//                     textScaleFactor: 1,
//                     minFontSize: 21,
//                     maxFontSize: 23,
//                   ),
//                 ),
//                 Spacer(),
//                 TextButton(
//                     onPressed: () {
//                       if (CacheHelper.getData(key: 'token_student') !=
//                           null) {
//                           // HomeCubit.get(context).getLevel(id: model.data[index].id);
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => LevelPackageScreen(levels: categories.levels[0]),
//                               ));
//
//                       } else {
//                         showDialog(
//                             context: context,
//                             builder: (context) => dialogRegister(
//                                 width * 0.8, height !* 0.3, context));
//                       }
//
//                     },
//                     child: AutoSizeText(
//                       S.of(context).enroll,
//                       style: Theme.of(context).textTheme.bodyText2!.copyWith(
//                           color: Colors.blue),
//                       textScaleFactor: 1,
//                       minFontSize: 18,
//                       maxFontSize: 20,
//                     ))
//               ],
//             ),
//             SizedBox(
//               height: height! * 0.01,
//             ),
//             AutoSizeText(
//               '${categories.min_age} - ${categories.max_age}',
//               style: Theme.of(context)
//                   .textTheme
//                   .headline3,
//               textScaleFactor: 1,
//               minFontSize: 20,
//               maxFontSize: 22,
//             ),
//             AutoSizeText(
//               S.of(context).description_course,
//               style: Theme.of(context)
//                   .textTheme
//                   .headline3,
//               textScaleFactor: 1,
//               minFontSize: 24,
//               maxFontSize: 26,
//             ),
//             AutoSizeText(
//               '${get.lang == 'ar' ? categories.ar_description : categories.en_description}',
//               style: Theme.of(context)
//                   .textTheme
//                   .headline3,
//               textScaleFactor: 1,
//               minFontSize: 24,
//               maxFontSize: 26,
//             ),
//           ],
//         ),
//       ),
//     );
//
// Widget dialogRegister(double width, double height, BuildContext context) {
//   return AlertDialog(
//     title: Container(
//       width: width,
//       height: height,
//       child: Column(
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           SizedBox(
//             height: height * 0.05,
//           ),
//           AutoSizeText(
//             S.of(context).gust_dialog,
//             style: Theme.of(context)
//                 .textTheme
//                 .bodyText2,
//             textScaleFactor: 1,
//             minFontSize: 23,
//             maxFontSize: 25,
//           ),
//           SizedBox(
//             height: height * 0.16,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               InkWell(
//                 onTap: () {
//                   Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => WelcomeScreen(),
//                       ),
//                           (route) => false);
//                 },
//                 child: Card(
//                   elevation: 0,
//                   child: Container(
//                     width: width * 0.39,
//                     height: height * 0.37,
//                     color: Colors.white,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.login,
//                           size: height * 0.24,
//                           color: Colors.indigo,
//                         ),
//                         AutoSizeText(
//                           S.of(context).gust_register,
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodyText2!
//                               .copyWith(
//                               color: Colors.indigo),
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
//                   Navigator.pop(context);
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
//                         Icon(Icons.search,
//                             size: height * 0.24, color: Colors.green),
//                         AutoSizeText(
//                           S.of(context).gust,
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodyText2!
//                               .copyWith(
//                               color: Colors.green),
//                           textScaleFactor: 1,
//                           minFontSize: 21,
//                           maxFontSize: 23,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
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
