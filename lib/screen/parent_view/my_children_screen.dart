import 'package:afaq_alnour_academy/adaptive_widget/adabtive_indecator.dart';
import 'package:afaq_alnour_academy/bloc/home_bloc/home_cubit.dart';
import 'package:afaq_alnour_academy/bloc/home_bloc/home_state.dart';
import 'package:afaq_alnour_academy/constant/const.dart';
import 'package:afaq_alnour_academy/data/local/cache_helper.dart';
import 'package:afaq_alnour_academy/generated/l10n.dart';
import 'package:afaq_alnour_academy/model/my_children_model.dart';
import 'package:afaq_alnour_academy/screen/register_screen.dart';
import 'package:afaq_alnour_academy/screen/welcome_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyChildrenScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if(state is DeleteMyChildSuccessState){
          Navigator.pop(context);
          HomeCubit.get(context).getMyChildren();
        }
      },
      builder: (context, state) {
        var get = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: AutoSizeText(S.of(context).my_children,
                style: Theme.of(context).textTheme.headline3,
                textScaleFactor: 1,
                minFontSize: 18,
                maxFontSize: 20),
          ),
          body: CacheHelper.getData(key: 'token_student') != null
              ? get.myChildrenModel == null
                  ? Center(child: AdabtiveIndecator(os: getOS()))
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                      child: Column(
                        children: [
                          SizedBox(height: height * 0.02),
                          Container(
                            height: height * 0.86,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                ListView.separated(
                                    itemBuilder: (context, index) => myChild(
                                        context,
                                        width: width,
                                        height: height,
                                        model: get.myChildrenModel,
                                        index: index),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                          height: height * 0.03,
                                        ),
                                    itemCount:
                                        get.myChildrenModel!.data.length),
                                Positioned(
                                  top: height * 0.78,
                                  left: get.lang == 'ar' ? 0 : width * 0.49,
                                  right: get.lang == 'ar' ? width * 0.49 : 0,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterScreen(),
                                          ));
                                    },
                                    child: Container(
                                      width: width * 0.4,
                                      height: height * 0.07,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          AutoSizeText(
                                              S.of(context).add_child,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline3,
                                              textScaleFactor: 1,
                                              minFontSize: 18,
                                              maxFontSize: 20),
                                          SizedBox(
                                            width: width * 0.02,
                                          ),
                                          Icon(
                                            Icons.add,
                                            size: height * 0.03,
                                          )
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
              : Center(
                  child: Container(
                    width: width * 0.5,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.teal)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            child: AutoSizeText(
                              S.of(context).gust_register,
                              style: Theme.of(context).textTheme.headline3,
                              textScaleFactor: 1,
                              minFontSize: 21,
                              maxFontSize: 23,
                            ),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WelcomeScreen(),
                                  ),
                                  (route) => false);
                              get.bottomIndex = 0;
                            }),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Icon(
                          Icons.login,
                          size: height * 0.03,
                        )
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  Widget myChild(context,
          {double? width,
          double? height,
          MyChildrenModel? model,
          int? index}) =>
      Stack(
        alignment: HomeCubit.get(context).lang == "ar"
            ? Alignment.topLeft
            : Alignment.topRight,
        children: [
          InkWell(
            onTap: () {
              HomeCubit.get(context).editMyChild = model!.data[index!];
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterScreen(),
                  ));
            },
            child: Container(
              width: width,
              // height: height * 0.15,
              child: Padding(
                padding: EdgeInsets.only(
                    top: height! * 0.02,
                    left: width! * 0.05,
                    right: width * 0.05,
                    bottom: height * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: width,
                        child: AutoSizeText(
                          '${S.of(context).child_name} ${model!.data[index!].fore_name ?? ''} ${model.data[index].middle_name ?? ''} ${model.data[index].sur_name ?? ''}',
                          textScaleFactor: 1,
                          minFontSize: 20,
                          maxFontSize: 22,
                          style: Theme.of(context).textTheme.bodyText2,
                        )),
                    AutoSizeText(
                      '${S.of(context).guardian_relationship} ${model.data[index].guardian_relationship ?? ''}',
                      textScaleFactor: 1,
                      minFontSize: 20,
                      maxFontSize: 22,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black)),
            ),
          ),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: Colors.white,
                    title: Column(
                      children: [
                        Text(
                          S.of(context).are_you_sure,
                          style: Theme.of(context).textTheme.bodyText2,
                          textScaleFactor: 1,
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: height * 0.05,
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.02),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Center(
                                  child: Text(
                                    S.of(context).no,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                    textScaleFactor: 1,
                                  ),
                                ),
                              ),
                            ),
                            HomeCubit.get(context).state
                                    is DeleteMyChildLoadingState
                                ? Center(
                                    child: AdabtiveIndecator(os: getOS()),
                                  )
                                : InkWell(
                                    onTap: () {
                                      HomeCubit.get(context).deleteMyChild(model.data[index].id!);
                                    },
                                    child: Container(
                                      height: height * 0.05,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.02),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border:
                                              Border.all(color: Colors.black),
                                          color: Colors.black),
                                      child: Center(
                                        child: Text(
                                          S.of(context).yes,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(color: Colors.white),
                                          textScaleFactor: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              icon: Icon(
                Icons.delete_forever,
                color: Colors.red,
                size: height * 0.035,
              ))
        ],
      );
}
