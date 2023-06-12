import 'package:afaq_alnour_academy/bloc/home_bloc/home_cubit.dart';
import 'package:afaq_alnour_academy/bloc/home_bloc/home_state.dart';
import 'package:afaq_alnour_academy/model/categoris_model.dart';
import 'package:afaq_alnour_academy/model/level_model_by_id.dart';
import 'package:afaq_alnour_academy/screen/parent_view/class_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LevelScreen extends StatelessWidget {
  LevelScreen({required this.model});

  final LevelModelById model;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var get = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CourseTile(
                    context,
                    width: width,
                    height: height,
                    get: get,
                    model: model,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget CourseTile(context,
        {double? width, double? height, int? index, LevelModelById? model, var get}) =>
    Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.teal)),
      child: ListTile(
        title: AutoSizeText(
          '${get.lang == 'ar' ? model!.data[0].ar_name : model!.data[0].en_name}',
          style: Theme.of(context).textTheme.headline3,
          textScaleFactor: 1,
          minFontSize: 23,
          maxFontSize: 25,
        ),
        subtitle: AutoSizeText(
          '${get.lang == 'ar' ? model.data[0].ar_description : model.data[0].en_description}',
          style: Theme.of(context).textTheme.headline3,
          textScaleFactor: 1,
          minFontSize: 18,
          maxFontSize: 20,
        ),
        onTap: () {
          get.getLevelCourses(id: model.data[0].id);
          get.isPackage = false;
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ClassScreen(),
              ));
        },
      ),
    );

// ConditionalBuilder(
//   condition: state is GetLevelLoadingState,
//   builder:(context)=> Center(child: AdabtiveIndecator(os: getOS())) ,
//   fallback: (context)=> Container(
//     height: height * 0.75,
//     child: ListView.separated(
//         padding: EdgeInsets.all(0),
//         shrinkWrap: true,
//         physics: BouncingScrollPhysics(),
//         itemBuilder: (context, index) => CourseTile(context,
//             height: height,
//             width: width,
//             index: index,
//         get: get,
//         model: get.levelModel),
//         separatorBuilder: (context, index) => SizedBox(
//           height: height * 0.03,
//         ),
//         itemCount: get.levelModel!.data.isNotEmpty ? 1 : get.levelModel!.data.length),
//   ),
// )
