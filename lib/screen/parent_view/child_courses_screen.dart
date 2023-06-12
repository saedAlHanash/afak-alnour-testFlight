import 'package:afaq_alnour_academy/adaptive_widget/adabtive_indecator.dart';
import 'package:afaq_alnour_academy/bloc/home_bloc/home_cubit.dart';
import 'package:afaq_alnour_academy/bloc/home_bloc/home_state.dart';
import 'package:afaq_alnour_academy/constant/const.dart';
import 'package:afaq_alnour_academy/data/local/cache_helper.dart';
import 'package:afaq_alnour_academy/generated/l10n.dart';
import 'package:afaq_alnour_academy/model/my_children_model.dart';
import 'package:afaq_alnour_academy/screen/parent_view/child_courses_details_screen.dart';
import 'package:afaq_alnour_academy/screen/welcome_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ChildCoursesScreen extends StatelessWidget {
  const ChildCoursesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var get = HomeCubit.get(context);

        return CacheHelper.getData(key: 'token_student') != null
            ? get.myChildrenModel != null
                ? get.myChildrenModel!.data.isNotEmpty
                    ? Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: width * 0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height * 0.03,
                            ),
                            SizedBox(
                              height: height * 0.78,
                              child: ListView.separated(
                                  itemBuilder: (context, index) =>
                                      childListTile(context,
                                          model: get.myChildrenModel,
                                          index: index,
                                          get: get),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: height * 0.03,
                                      ),
                                  itemCount:
                                      get.myChildrenModel!.data.length),
                            )
                          ],
                        ),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset('image/child_avatar.json',
                                fit: BoxFit.cover),
                            AutoSizeText(
                              S.of(context).child_not_found,
                              style: Theme.of(context).textTheme.headline3,
                              textScaleFactor: 1,
                              maxFontSize: 20,
                              minFontSize: 18,
                            )
                          ],
                        ),
                      )
                : Center(
                    child: AdabtiveIndecator(os: getOS()),
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
              );
      },
    );
  }
}

Widget childListTile(context, {MyChildrenModel? model, int? index, var get}) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black)),
    child: ListTile(
      onTap: () {
        get.myCourseModel = null;
        get.myCourses(id: model!.data[index!].id);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChildCoursesDetailsScreen(
                  childName:
                      '${model.data[index].fore_name} ${model.data[index].sur_name}'),
            ));
      },
      title: AutoSizeText(
        '${model!.data[index!].fore_name} ${model.data[index].sur_name}',
        style: Theme.of(context)
            .textTheme
            .headline3!
            .copyWith(color: Colors.black),
        textScaleFactor: 1,
        minFontSize: 20,
        maxFontSize: 22,
      ),
      trailing: get.lang == 'ar'
          ? Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
            )
          : Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.black,
            ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
