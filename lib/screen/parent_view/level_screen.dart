import 'package:afaq_alnour_academy/bloc/home_bloc/home_cubit.dart';
import 'package:afaq_alnour_academy/bloc/home_bloc/home_state.dart';
import 'package:afaq_alnour_academy/model/categoris_model.dart';
import 'package:afaq_alnour_academy/model/level_model_by_id.dart';
import 'package:afaq_alnour_academy/screen/parent_view/class_screen.dart';
import 'package:afaq_alnour_academy/screen/parent_view/test_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../adaptive_widget/adabtive_indecator.dart';
import '../../constant/const.dart';
import '../../generated/l10n.dart';
import '../../model/levle_response.dart';
import '../../widget/toast.dart';
import 'categories_screen.dart';

LevelData? selectedItem;

class LevelScreen extends StatefulWidget {
  LevelScreen({required this.list});

  final List<LevelData> list;

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  late HomeCubit homeCubit;

  @override
  void initState() {
    homeCubit = context.read<HomeCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is EnrollSutdentsSuccessState) {
          homeCubit.getLevelCourses(id: selectedItem!.id);
          homeCubit.isPackage = false;
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ClassScreen(),
              ));

        }

        // if (state is GetTestSuccessState) {
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => TestScreen(),
        //       ));
        // }
        if (state is GetTestDataEmptyState) {
          toast(msg: S.of(context).empty_test, color: Colors.red);
        }

        if (state is EnrollSutdentsErrorState) {}
      },
      builder: (context, state) {
        var get = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            itemCount: widget.list.length,
            itemBuilder: (context, index) {
              return CourseTile(
                context,
                width: width,
                height: height,
                get: get,
                index: index,
                model: widget.list[index],
              );
            },
            separatorBuilder: (_, i) => SizedBox(height: 10.0),
          ),
        );
      },
    );
  }
}

Widget CourseTile(
  context, {
  required double width,
  required double height,
  int? index,
  required LevelData model,
  var get,
}) =>
    Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.teal)),
      child: ListTile(
        title: AutoSizeText(
          model.name,
          style: Theme.of(context).textTheme.headline3,
          textScaleFactor: 1,
          minFontSize: 14,
          maxFontSize: 18,
        ),
        subtitle: AutoSizeText(
          model.description,
          style: Theme.of(context).textTheme.headline3,
          textScaleFactor: 1,
          minFontSize: 12,
          maxFontSize: 16,
        ),
        onTap: () {
          selectedItem =model;
          showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              builder: (context) {
                return bottomSheet(
                    context,
                    width,
                    height,
                    context.read<HomeCubit>().myChildrenModel!,
                    model.catId,
                    false,
                    name: '',
                    model: context.read<HomeCubit>().categorisModel!,
                    index: index,
                    id: 0,
                  );
              });

          return;
        },
      ),
    );

