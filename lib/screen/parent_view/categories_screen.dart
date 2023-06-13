import 'package:afaq_alnour_academy/model/my_children_model.dart';
import 'package:afaq_alnour_academy/screen/parent_view/level_screen.dart';
import 'package:afaq_alnour_academy/screen/parent_view/my_children_screen.dart';
import 'package:afaq_alnour_academy/screen/parent_view/test_screen.dart';
import 'package:afaq_alnour_academy/screen/welcome_screen.dart';
import 'package:afaq_alnour_academy/widget/toast.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../adaptive_widget/adabtive_indecator.dart';
import '../../bloc/home_bloc/home_cubit.dart';
import '../../bloc/home_bloc/home_state.dart';
import '../../constant/const.dart';
import '../../data/local/cache_helper.dart';
import '../../generated/l10n.dart';
import '../../model/categoris_model.dart';

class CategoriesScreen extends StatelessWidget {
  int index;
  String? description;
  String? image;
  String? name;
  int? id;

  CategoriesScreen(
      {required this.index,
      required this.description,
      required this.image,
      required this.id,
      required this.name});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is GetLevelSuccessState) {
          Future.delayed(
            Duration(seconds: 1),
            () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LevelScreen(list: state.levels),
                  ));
            },
          );
        }
        if (state is EnrollSutdentsErrorState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var get = HomeCubit.get(context);
        return WillPopScope(
          onWillPop: () {
            get.categorisModel = null;
            return get.deleteAllCardInformation(withCard: false, re: true);
          },
          child: Scaffold(
            appBar: AppBar(
              title: AutoSizeText(
                '${get.model!.data![index].name}',
                style: Theme.of(context).textTheme.headline3,
                textScaleFactor: 1,
                minFontSize: 23,
                maxFontSize: 25,
              ),
              leading: IconButton(
                  onPressed: () {
                    get.deleteAllCardInformation(withCard: false);
                    get.categorisModel = null;
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios)),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: ConditionalBuilder(
                  condition: get.categorisModel != null,
                  builder: (context) => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * 0.02,
                      ),
                      if (state is EnrollSutdentsLoadingState)
                        LinearProgressIndicator(
                          backgroundColor: Colors.teal,
                          color: Colors.teal,
                        ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Container(
                        width: width,
                        height: height * 0.3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage('$ImageUrl${image}'),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      AutoSizeText(
                        S.of(context).description_course,
                        style: Theme.of(context).textTheme.bodyText2,
                        textScaleFactor: 1,
                        minFontSize: 26,
                        maxFontSize: 28,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      AutoSizeText(
                        '$description',
                        style: Theme.of(context).textTheme.bodyText2,
                        textScaleFactor: 1,
                        minFontSize: 21,
                        maxFontSize: 23,
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      ListView.separated(
                          itemBuilder: (context, index) => CourseTile(context,
                              width: width,
                              height: height,
                              index: index,
                              id: id,
                              myChildrenModel: get.myChildrenModel,
                              model: get.categorisModel,
                              name: name,
                              state: state),
                          separatorBuilder: (context, index) => SizedBox(
                                height: height * 0.03,
                              ),
                          shrinkWrap: true,
                          padding: EdgeInsets.all(0),
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: get.categorisModel!.data.length),
                      SizedBox(
                        height: height * 0.03,
                      ),
                    ],
                  ),
                  fallback: (context) => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * 0.4,
                      ),
                      AdabtiveIndecator(os: getOS()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget CourseTile(context,
    {double? width,
    double? height,
    String? name,
    int? id,
    CategorisModel? model,
    int? index,
    MyChildrenModel? myChildrenModel,
    var state}) {
  return BlocConsumer<HomeCubit, HomeState>(
    listener: (context, state) {},
    builder: (context, state) {
      var get = HomeCubit.get(context);
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.transparent,
            border: Border.all(color: Colors.teal)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: width! * 0.55,
                    child: AutoSizeText(
                      '${model!.data[index!].name}',
                      style: Theme.of(context).textTheme.headline3,
                      textScaleFactor: 1,
                      minFontSize: 21,
                      maxFontSize: 23,
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      if (CacheHelper.getData(key: 'token_student') != null) {
                        get.getLevel(catId: model.data[index].id);
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                dialogInRegister(width * 0.8, height! * 0.3, context));
                      }
                    },
                    child: (state is GetLevelLoadingState)
                        ? Center(
                      child: AdabtiveIndecator(os: getOS()),
                    )
                        : AutoSizeText(
                            S.of(context).see_Levels,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.blue),
                            textScaleFactor: 1,
                            minFontSize: 10,
                            maxFontSize: 12,
                          ),
                  )
                ],
              ),
              SizedBox(
                height: height! * 0.01,
              ),
              AutoSizeText(
                '${model.data[index].min_age} - ${model.data[index].max_age}',
                style: Theme.of(context).textTheme.headline3,
                textScaleFactor: 1,
                minFontSize: 20,
                maxFontSize: 22,
              ),
              AutoSizeText(
                S.of(context).description_course,
                style: Theme.of(context).textTheme.headline3,
                textScaleFactor: 1,
                minFontSize: 24,
                maxFontSize: 26,
              ),
              AutoSizeText(
                '${model.data[index].description}',
                style: Theme.of(context).textTheme.headline3,
                textScaleFactor: 1,
                minFontSize: 22,
                maxFontSize: 24,
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget dialogEnroll(double width, double height, BuildContext context, String? name,
    CategorisModel model, int? index, int id) {
  return BlocConsumer<HomeCubit, HomeState>(
    listener: (context, state) {
      if (state is EnrollSutdentsSuccessState) {
        HomeCubit.get(context).getLevelById(
            catId: model.data[index!].id, studentId: HomeCubit.get(context).childId);
      }
      if (state is GetTestSuccessState) {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TestScreen(),
            ));
      }
      if (state is GetTestDataEmptyState) {
        toast(msg: S.of(context).empty_test, color: Colors.red);
      }
    },
    builder: (context, state) {
      var get = HomeCubit.get(context);
      return AlertDialog(
        title: Container(
          width: width,
          height: height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              AutoSizeText(
                S.of(context).test_dialog,
                style: Theme.of(context).textTheme.bodyText2,
                textScaleFactor: 1,
                minFontSize: 23,
                maxFontSize: 25,
              ),
              SizedBox(
                height: height * 0.16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      get.enrollStudent(
                          isTest: false, category_id: model.data[index!].id);
                    },
                    child: Card(
                      elevation: 0,
                      child: Container(
                        width: width * 0.4,
                        height: height * 0.37,
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cast_for_education_outlined,
                              size: height * 0.24,
                              color: Colors.indigo,
                            ),
                            AutoSizeText(
                              S.of(context).test_lvl1,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.indigo),
                              textScaleFactor: 1,
                              minFontSize: 16,
                              maxFontSize: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      get.answers = {};
                      get.getTest(id: model.data[index!].id);
                      get.catId = model.data[index].id;
                    },
                    child: Card(
                      elevation: 0,
                      child: Container(
                        width: width * 0.39,
                        height: height * 0.45,
                        color: Colors.white,
                        child: state is! GetTestLoadingState
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.history_edu,
                                      size: height * 0.24, color: Colors.green),
                                  AutoSizeText(
                                    S.of(context).test,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: Colors.green),
                                    textScaleFactor: 1,
                                    minFontSize: 16,
                                    maxFontSize: 18,
                                  ),
                                ],
                              )
                            : Center(
                                child: AdabtiveIndecator(
                                os: getOS(),
                              )),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        titlePadding:
            EdgeInsets.only(top: height * 0.05, left: width * 0.05, right: width * 0.05),
        elevation: 0,
      );
    },
  );
}

Widget dialogInRegister(double width, double height, BuildContext context) {
  return AlertDialog(
    title: Container(
      width: width,
      height: height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: height * 0.05,
          ),
          AutoSizeText(
            S.of(context).gust_dialog,
            style: Theme.of(context).textTheme.bodyText2,
            textScaleFactor: 1,
            minFontSize: 23,
            maxFontSize: 25,
          ),
          SizedBox(
            height: height * 0.16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WelcomeScreen(),
                      ),
                      (route) => false);
                },
                child: Card(
                  elevation: 0,
                  child: Container(
                    // width: width * 0.35,
                    // height: height * 0.37,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.login,
                          size: height * 0.24,
                          color: Colors.indigo,
                        ),
                        AutoSizeText(
                          S.of(context).gust_register,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.indigo),
                          textScaleFactor: 1,
                          minFontSize: 16,
                          maxFontSize: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Card(
                  elevation: 0,
                  child: Container(
                    // width: width * 0.39,
                    // height: height * 0.37,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search, size: height * 0.24, color: Colors.green),
                        AutoSizeText(
                          S.of(context).gust,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.green),
                          textScaleFactor: 1,
                          minFontSize: 16,
                          maxFontSize: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    backgroundColor: Colors.white,
    elevation: 0,
  );
}

Widget bottomSheet(context, double width, double height, MyChildrenModel myChildrenModel,
    int catId, bool isPackage,
    {String? name, CategorisModel? model, int? index, int? id, int? packagePrice}) {
  return BlocConsumer<HomeCubit, HomeState>(
    listener: (context, state) {},
    builder: (context, state) {
      var get = HomeCubit.get(context);
      return Column(
        children: [
          SizedBox(
            height: height * 0.05,
          ),
          AutoSizeText(S.of(context).Choose_child,
              style: Theme.of(context).textTheme.headline3,
              textScaleFactor: 1,
              minFontSize: 25,
              maxFontSize: 28),
          SizedBox(
            height: height * 0.03,
          ),
          Divider(
              height: 2,
              color: Colors.black54,
              indent: width * 0.25,
              endIndent: width * 0.25),
          SizedBox(
            height: height * 0.37,
            child: get.myChildrenModel!.data.isNotEmpty
                ? ListView.separated(
                    itemCount: get.myChildrenModel!.data.length,
                    itemBuilder: (context, index) => RadioListTile<int>(
                        value: get.myChildrenModel!.data[index].id!,
                        title: AutoSizeText(
                            '${get.myChildrenModel!.data[index].fore_name} ${get.myChildrenModel!.data[index].sur_name}',
                            minFontSize: 18,
                            maxFontSize: 20,
                            style: Theme.of(context).textTheme.bodyText2,
                            textScaleFactor: 1),
                        groupValue: get.childId,
                        activeColor: Colors.teal,
                        onChanged: (value) {
                          get.enrollStudentToLevel(
                              value!,
                              get.myChildrenModel!.data[index].fore_name! +
                                  " " +
                                  get.myChildrenModel!.data[index].sur_name!);
                          if (!isPackage) {
                            get.getLevelById(catId: catId, studentId: value);
                          }
                        }),
                    separatorBuilder: (context, index) => Divider(
                        height: 1,
                        color: Colors.black54,
                        indent: width * 0.1,
                        endIndent: width * 0.1),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: AutoSizeText(
                          S.of(context).add_child_to_invoice,
                          textScaleFactor: 1,
                          textAlign: TextAlign.center,
                          minFontSize: 16,
                          maxFontSize: 18,
                          style: Theme.of(context).textTheme.headline3,
                        )),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        InkWell(
                          child: Container(
                            width: width * 0.23,
                            height: height * 0.06,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.teal),
                            child: Center(
                              child: AutoSizeText(S.of(context).add_child,
                                  textScaleFactor: 1,
                                  textAlign: TextAlign.center,
                                  minFontSize: 16,
                                  maxFontSize: 18,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(color: Colors.white)),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyChildrenScreen(),
                                ));
                          },
                        )
                      ],
                    ),
                  ),
          ),
          Row(
            children: [
              Spacer(),
              Padding(
                padding: EdgeInsets.only(
                    right: get.lang == 'ar' ? 0.0 : width * 0.05,
                    left: get.lang == 'ar' ? width * 0.05 : 0.0),
                child: InkWell(
                  onTap: () {
                    if (get.childId != 0) {
                      get.changeLoading(value: true);
                      if (!isPackage) {
                        Future.delayed(
                          Duration(seconds: 1),
                          () {
                            if (index == 0) {
                              get.enrollStudent(
                                  isTest: false, category_id: model!.data[index!].id);
                            } else {
                              get.answers = {};
                              get.getTest(id: model!.data[index!].id);
                              get.catId = model.data[index].id;
                            }
                          },
                        );
                      } else {
                        Future.delayed(
                          Duration(seconds: 1),
                          () {
                            Navigator.pop(context);
                            get.addChildToCard(
                                0, get.packageModel!.data!.name, packagePrice, true);
                            get.changeLoading(value: false);
                          },
                        );
                      }
                    } else {
                      toast(msg: 'please select child first', color: Colors.red);
                    }
                  },
                  child: get.loading
                      ? Center(
                          child: AdabtiveIndecator(os: getOS()),
                        )
                      : Container(
                          width: width * 0.2,
                          height: height * 0.06,
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: AutoSizeText(
                              S.of(context).button_next,
                              minFontSize: 16,
                              maxFontSize: 18,
                              textScaleFactor: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                ),
              )
            ],
          )
        ],
      );
    },
  );
}
