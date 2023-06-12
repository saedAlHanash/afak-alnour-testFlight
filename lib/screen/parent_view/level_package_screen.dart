//
//
// import 'package:afaq_alnour_academy/model/package_model.dart';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
//
// import '../../bloc/home_bloc/home_cubit.dart';
// import '../../bloc/home_bloc/home_state.dart';
// import 'class_screen.dart';
//
// class LevelPackageScreen extends StatelessWidget {
// Levels? levels;
// LevelPackageScreen({required this.levels});
//
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     return BlocConsumer<HomeCubit, HomeState>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         var get = HomeCubit.get(context);
//         return Scaffold(
//           extendBodyBehindAppBar: true,
//           appBar: AppBar(),
//           body: Container(
//             width: width,
//             height: height,
//             decoration: BoxDecoration(
//                 image: DecorationImage(
//                     image: AssetImage('image/background_image/background5.jpg'),
//                     fit: BoxFit.cover)),
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: width * 0.05),
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: height * 0.18,
//                     ),
//                     CourseTile(context,width: width,height: height,get: get,levels: levels),
//                   ],
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
// Widget CourseTile(
//     context, {
//       double? width,
//       double? height,
//       Levels? levels,
//       var get
//     }) =>
//     Container(
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: Colors.teal)
//       ),
//       child: ListTile(
//         title: AutoSizeText('${get.lang == 'ar' ? levels!.ar_name : levels!.en_name}',style: Theme.of(context).textTheme.headline3,
//           textScaleFactor: 1,
//           minFontSize: 23,
//           maxFontSize: 25,
//         ),
//         subtitle: AutoSizeText('${get.lang == 'ar' ? levels.ar_description : levels.en_description}',style: Theme.of(context).textTheme.headline3,
//           textScaleFactor: 1,
//           minFontSize: 18,
//           maxFontSize: 20,
//         ),
//         onTap: (){
//           get.getLevelCourses(id:levels.id);
//           get.isPackage = true;
//           Navigator.push(context, MaterialPageRoute(builder: (context) => ClassScreen(),));
//         },
//       ),
//     );