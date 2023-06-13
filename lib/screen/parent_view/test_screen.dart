import 'package:afaq_alnour_academy/adaptive_widget/adabtive_indecator.dart';
import 'package:afaq_alnour_academy/bloc/home_bloc/home_cubit.dart';
import 'package:afaq_alnour_academy/bloc/home_bloc/home_state.dart';
import 'package:afaq_alnour_academy/constant/const.dart';
import 'package:afaq_alnour_academy/screen/parent_view/level_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestScreen extends StatelessWidget {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
          HomeCubit.get(context).testIndex = 0;
          HomeCubit.get(context).testValue = 0;
          HomeCubit.get(context).testModel = null;
        }, icon: Icon(Icons.arrow_back_ios_new_outlined)),
      ),
      extendBodyBehindAppBar: true,
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var get = HomeCubit.get(context);
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('image/background_image/background5.jpg'),
                    fit: BoxFit.cover)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.12,
                  ),
                  AutoSizeText(
                      get.testModel!.data[0].questions[get.testIndex!]
                          .question!,
                      style: Theme.of(context).textTheme.headline3,
                      textScaleFactor: 1,
                      minFontSize: 22,
                      maxFontSize: 24),
                  SizedBox(
                    height: height * 0.7,
                    child: PageView.builder(
                      itemBuilder: (context, index) {
                        return answersItem(width: width);
                      },
                      controller: _pageController,
                      itemCount: get.testModel!.data[0].questions.length,
                      physics: NeverScrollableScrollPhysics(),
                      onPageChanged: (int index) {
                        get.changeTestIndex(index);
                      },
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Row(
                    children: [
                      Spacer(),
                      InkWell(
                        onTap: get.testValue != 0
                            ? () {
                                if (get.testIndex ==
                                    get.testModel!.data[0].questions.length -
                                        1) {
                                  get.sendExam(get.testModel!.data[0].id!);
                                } else {
                                  _pageController.nextPage(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.fastOutSlowIn);
                                  get.testValue = 0;
                                }
                              }
                            : null,
                        child: state is !SendExamLoadingState ? Container(
                          width: width * 0.2,
                          height: height * 0.06,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: get.testValue != 0
                                  ? Colors.teal
                                  : Colors.grey),
                          child: Center(
                            child: AutoSizeText(
                              get.testIndex ==
                                      get.testModel!.data[0].questions.length -
                                          1
                                  ? 'Send'
                                  : 'Next',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(color: Colors.white),
                              textScaleFactor: 1,
                              minFontSize: 18,
                              maxFontSize: 20,
                            ),
                          ),
                        ) :  Center(child: AdabtiveIndecator(os: getOS())),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget answersItem({double? width}) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // if (state is GetLevelSuccessState) {
        //   Navigator.pushReplacement(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => LevelScreen(
        //           list: HomeCubit.get(context).levelModelById!,
        //         ),
        //       ));
        // }
      },
      builder: (context, state) {
        var get = HomeCubit.get(context);
        return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 16),
          itemBuilder: (context, index) {
            return RadioListTile<int>(
                contentPadding: EdgeInsets.all(0),
                title: AutoSizeText(
                  get.testModel!.data[0].questions[get.testIndex!]
                      .answers[index].answer!,
                  minFontSize: 18,
                  maxFontSize: 20,
                  textScaleFactor: 1,
                ),
                activeColor: Colors.black,
                value: get.testModel!.data[0].questions[get.testIndex!]
                    .answers[index].id!,
                groupValue: get.testValue,
                onChanged: (dynamic value) {
                  get.changeTestValue(value);
                  get.addAnswers(
                      get.testModel!.data[0].questions[get.testIndex!].id!,
                      get.testModel!.data[0].questions[get.testIndex!]
                          .answers[index].id!);
                });
          },
          itemCount:
              get.testModel!.data[0].questions[get.testIndex!].answers.length,
          shrinkWrap: true,
        );
      },
    );
  }
}
