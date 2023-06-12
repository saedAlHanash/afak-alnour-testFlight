import 'package:afaq_alnour_academy/bloc/home_bloc/home_cubit.dart';
import 'package:afaq_alnour_academy/bloc/home_bloc/home_state.dart';
import 'package:afaq_alnour_academy/data/local/cache_helper.dart';
import 'package:afaq_alnour_academy/generated/l10n.dart';
import 'package:afaq_alnour_academy/model/card_model.dart';
import 'package:afaq_alnour_academy/model/payment_model.dart';
import 'package:afaq_alnour_academy/model/payment_request.dart';
import 'package:afaq_alnour_academy/screen/welcome_screen.dart';
import 'package:afaq_alnour_academy/widget/toast.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';

class CardScreen extends StatefulWidget {
  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(CacheHelper.getData(key: 'card_time') != null){
      var date = DateTime.now();
      var cardDate = DateTime.parse(CacheHelper.getData(key: 'card_time'));

      if(date.difference(cardDate).inDays > 0){
        CacheHelper.removeData(key: 'card_time');
        HomeCubit.get(context).deleteAllCardInformation(withCard: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var get = HomeCubit.get(context);
        double coursesPrice = 0;
        double packagePrice = 0;
        get.paymentModel = PaymentModel({}, {}, {}, {});

        get.cardModel.forEach((element) {
          if (element.isPackage!) {
            if (get.paymentModel.package[element.subjectId.toString()] ==
                null) {
              get.paymentModel.package[element.subjectId.toString()] = [];
            }
            get.paymentModel.package[element.subjectId.toString()]!
                .add(element.childId!);
            if (get.paymentModel.packageShow[element.subjectName] == null)
              get.paymentModel.packageShow[element.subjectName!] = {};
            if (get.paymentModel.packageShow[element.subjectName]!["price"] ==
                null)
              get.paymentModel.packageShow[element.subjectName]!["price"] =
                  element.price!;
            if (get.paymentModel
                    .packageShow[element.subjectName]!["childNumber"] ==
                null)
              get.paymentModel
                      .packageShow[element.subjectName]!["childNumber"] =
                  get.paymentModel.package[element.subjectId.toString()]!
                      .length;
            get.paymentModel.packageShow[element.subjectName]!["childNumber"] =
                get.paymentModel.package[element.subjectId.toString()]!.length;
          } else {
            if (get.paymentModel.courses[element.classId.toString()] == null) {
              get.paymentModel.courses[element.classId.toString()] = [];
            }
            get.paymentModel.courses[element.classId.toString()]!
                .add(element.childId!);
            if (get.paymentModel.coursesShow[element.className] == null)
              get.paymentModel.coursesShow[element.className!] = {};
            if (get.paymentModel.coursesShow[element.className]!["price"] ==
                null)
              get.paymentModel.coursesShow[element.className]!["price"] =
                  element.price!;
            if (get.paymentModel
                    .coursesShow[element.className]!["childNumber"] ==
                null)
              get.paymentModel.coursesShow[element.className]!["childNumber"] =
                  get.paymentModel.courses[element.classId.toString()]!.length;
            get.paymentModel.coursesShow[element.className]!["childNumber"] =
                get.paymentModel.courses[element.classId.toString()]!.length;
            get.paymentModel.courses.keys.forEach((element2) {
              get.paymentModel.coursesShow[element.className]!['id'] = int.parse(element2);
            });
          }
        });

        get.paymentModel.packageShow.forEach((key, value) {
          if (value['childNumber']! < 3) {
            packagePrice +=
                value['price']!.toDouble() * value['childNumber']!.toDouble();
          } else {
            packagePrice += (value['price']! * value['childNumber']!) * 0.9;
          }
        });
        get.paymentModel.coursesShow.forEach((key, value) {
          if (value['childNumber']! < 3) {
            coursesPrice += value['price']!.toDouble() * value['childNumber']!;
          } else {
            coursesPrice += (value['price']! * value['childNumber']!) * 0.9;
          }
        });

        if(CacheHelper.getData(key: 'token_student') != null ){
          if (get.paymentModel.coursesShow.isNotEmpty ||
              get.paymentModel.packageShow.isNotEmpty){
            return  Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SizedBox(
                    height: height * 0.79,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.all(0),
                      child: Column(
                        children: [
                          ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.all(0),
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => cardItem(context,
                                  height: height,
                                  cardModel: get.cardModel[index],
                                  get: get,
                                  width: width,
                                  index: index),
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: height * 0.05),
                              itemCount: get.cardModel.length),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          if (get.paymentModel.courses.isNotEmpty)
                            ListView.separated(
                                shrinkWrap: true,
                                padding: EdgeInsets.all(0),
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final int childCount = get.paymentModel.coursesShow[
                                  get.paymentModel.coursesShow.keys
                                      .elementAt(index)]!["childNumber"]!;
                                  double price = 0;
                                  if (childCount < 3) {
                                    price = get
                                        .paymentModel
                                        .coursesShow[get
                                        .paymentModel.coursesShow.keys
                                        .elementAt(index)]!["price"]!
                                        .toDouble() *
                                        childCount;
                                  } else {
                                    price = (get.paymentModel.coursesShow[get
                                        .paymentModel.coursesShow.keys
                                        .elementAt(index)]!["price"]! *
                                        childCount) *
                                        0.9;
                                  }
                                  return itemPayment(
                                      context,
                                      get.paymentModel.coursesShow.keys
                                          .elementAt(index),
                                      childCount,
                                      price.toInt(),
                                      height: height);
                                },
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: height * 0.01),
                                itemCount: get.paymentModel.coursesShow.length),
                          if (get.paymentModel.courses.isNotEmpty)
                            SizedBox(
                              height: height * 0.01,
                            ),
                          if (get.paymentModel.package.isNotEmpty)
                            ListView.separated(
                                shrinkWrap: true,
                                padding: EdgeInsets.all(0),
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final int childCount = get.paymentModel.packageShow[
                                  get.paymentModel.packageShow.keys
                                      .elementAt(index)]!["childNumber"]!;
                                  double price = 0;
                                  if (childCount < 3) {
                                    price = get
                                        .paymentModel
                                        .packageShow[get
                                        .paymentModel.packageShow.keys
                                        .elementAt(index)]!["price"]!
                                        .toDouble() *
                                        childCount;
                                  } else {
                                    price = (get.paymentModel.packageShow[get
                                        .paymentModel.packageShow.keys
                                        .elementAt(index)]!["price"]! *
                                        childCount) *
                                        0.9;
                                    packagePrice += price.toInt();
                                  }
                                  return itemPayment(
                                      context,
                                      get.paymentModel.packageShow.keys
                                          .elementAt(index),
                                      childCount,
                                      price.toInt(),
                                      height: height);
                                },
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: height * 0.01),
                                itemCount: get.paymentModel.packageShow.length),
                          if (get.paymentModel.package.isNotEmpty)
                            SizedBox(
                              height: height * 0.02,
                            ),
                          AutoSizeText(
                              '${S.of(context).total} ${coursesPrice.toInt() + packagePrice.toInt()}',
                              style: Theme.of(context).textTheme.headline3,
                              textScaleFactor: 1,
                              minFontSize: 22,
                              maxFontSize: 24),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          InkWell(
                            onTap: () {
                              if (get.paymentModel.coursesShow.isNotEmpty ||
                                  get.paymentModel.packageShow.isNotEmpty) {
                                showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                        )
                                    ),
                                    builder: (context) => paymentBottomSheet(context,
                                        width: width, height: height,price: (coursesPrice+ packagePrice).toString()));
                              }
                            },
                            child: Container(
                              width: width * 0.9,
                              height: height * 0.05,
                              decoration: BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: AutoSizeText(S.of(context).checkout,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(color: Colors.white),
                                    minFontSize: 18,
                                    maxFontSize: 20,
                                    textScaleFactor: 1),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          AutoSizeText(
                              S.of(context).card_deleted,
                              style: Theme.of(context).textTheme.headline3,
                              textScaleFactor: 1,
                              minFontSize: 12,
                              maxFontSize: 14),
                          SizedBox(
                            height: height * 0.02,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }else{
            return noItemInCard(context,width: width,height: height);
          }
        }else{
          return Center(
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
        }


      },
    );
  }

  Widget cardItem(context,
      {double? height,
      CardModel? cardModel,
      var get,
      int? index,
      double? width}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: HexColor("#E9F2DF"),
        border: Border.all(color: Colors.black54),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText('${cardModel!.subjectName}',
                style: Theme.of(context).textTheme.headline3,
                textScaleFactor: 1,
                minFontSize: 20,
                maxFontSize: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText('${cardModel.className}',
                    style: Theme.of(context).textTheme.bodyText2,
                    textScaleFactor: 1,
                    minFontSize: 16,
                    maxFontSize: 18),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => dialogRemove(context,
                              get: get,
                              index: index,
                              width: width,
                              height: height));
                    },
                    icon: Icon(Icons.delete_forever))
              ],
            ),
            SizedBox(
              height: height! * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText('${cardModel.childName}',
                    style: Theme.of(context).textTheme.bodyText2,
                    textScaleFactor: 1,
                    minFontSize: 18,
                    maxFontSize: 20),
                AutoSizeText('${cardModel.price} £',
                    style: Theme.of(context).textTheme.bodyText2,
                    textScaleFactor: 1,
                    minFontSize: 18,
                    maxFontSize: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget itemPayment(context, String subjectName, int childCount, int price,
      {double? height}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          subjectName,
          textScaleFactor: 1,
          minFontSize: 17,
          maxFontSize: 19,
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: Colors.black),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AutoSizeText(
              "${S.of(context).child_num} $childCount",
              minFontSize: 12,
              maxFontSize: 14,
              textScaleFactor: 1,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.normal, color: Colors.black),
            ),
            AutoSizeText(
              "${S.of(context).price} $price£",
              textScaleFactor: 1,
              minFontSize: 12,
              maxFontSize: 14,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.normal, color: Colors.black),
            ),
          ],
        )
      ],
    );
  }

  Widget dialogRemove(context,
      {double? width, double? height, var get, int? index}) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 10,
      title: Container(
        width: width! * 0.8,
        height: height! * 0.12,
        child: Column(
          children: [
            AutoSizeText(
              S.of(context).are_you_sure,
              minFontSize: 18,
              maxFontSize: 20,
              textScaleFactor: 1,
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: width * 0.15,
                    height: height * 0.05,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.teal, width: 2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: AutoSizeText(
                        S.of(context).no,
                        minFontSize: 18,
                        maxFontSize: 20,
                        textScaleFactor: 1,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    get.removeChildFromCard(index);
                  },
                  child: Container(
                    width: width * 0.15,
                    height: height * 0.05,
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: AutoSizeText(
                        S.of(context).yes,
                        minFontSize: 18,
                        maxFontSize: 20,
                        textScaleFactor: 1,
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget paymentBottomSheet(context, {double? height, double? width,String? price}) {
    return BlocConsumer<HomeCubit,HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var get = HomeCubit.get(context);
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                onTap: (){
                  bool twice = false;
                  var price1 = double.parse(price!);
                  PaymentRequest paymentRequest = PaymentRequest({});
                  List<int> childCourse = [];
                  List<int> childPackage = [];

                  get.paymentModel.courses.forEach((key, value) {
                    value.forEach((element) {
                      paymentRequest.data[element.toString()] = {};
                    });
                  });

                  get.paymentModel.package.forEach((key, value) {
                    value.forEach((element) {
                      paymentRequest.data[element.toString()] = {};
                    });
                  });

                  get.paymentModel.courses.forEach((key, value) {
                    childCourse = [];
                    childPackage = [];
                    value.forEach((element) {
                      if(!childCourse.contains(int.parse(key))) {
                        childCourse.add(int.parse(key));
                      }
                      paymentRequest
                          .data[element.toString()]!['course'] =
                          childCourse;
                      paymentRequest
                          .data[element.toString()]!['package'] =
                          childPackage;
                    });
                  });

                  get.paymentModel.package.forEach((key, value) {
                    childPackage = [];
                    value.forEach((element) {
                      if(childPackage.contains(int.parse(key))) {
                        childPackage.add(int.parse(key));
                      }
                      paymentRequest
                          .data[element.toString()]!['package'] =
                          childPackage;
                    });
                  });
                  List<int> valueCourse = [];
                  List<int> valuePackage = [];
                  get.paymentModel.courses.forEach((key, value) {
                    value.forEach((element) {
                      if(valueCourse.contains(element)){
                        twice = true;
                        toast(msg: S.of(context).course_attention, color: Colors.red);
                      }else{
                        valueCourse.add(element);
                      }
                    });
                  });
                  get.paymentModel.package.forEach((key, value) {
                    value.forEach((element) {
                      if(valuePackage.contains(element)){
                        twice = true;
                        toast(msg: S.of(context).package_attention, color: Colors.red);
                      }else{
                        valuePackage.add(element);
                      }
                    });
                  });
                  Navigator.pop(context);
                  if(!twice){
                    get.makePayment(context,
                        amount: price1.toInt().toString(),
                        currency: 'gbp',
                        type: 'one_time',
                        price: price,
                        paymentRequest: paymentRequest);
                  }
                },
                trailing: Icon(Icons.arrow_forward_ios_outlined),
                leading: Icon(Icons.account_balance_wallet),
                title: AutoSizeText(S.of(context).one_time_payment,
                    style: Theme.of(context).textTheme.headline3,
                    minFontSize: 18,
                    maxFontSize: 20,
                    textScaleFactor: 1),
              ),
              ListTile(
                onTap: (){
                  var price1 = double.parse(price!) / 3;
                  PaymentRequest paymentRequest = PaymentRequest({});
                  List<int> childCourse = [];
                  List<int> childPackage = [];

                  get.paymentModel.courses.forEach((key, value) {
                    value.forEach((element) {
                      paymentRequest.data[element.toString()] = {};
                    });
                  });

                  get.paymentModel.package.forEach((key, value) {
                    value.forEach((element) {
                      paymentRequest.data[element.toString()] = {};
                    });
                  });

                  get.paymentModel.courses.forEach((key, value) {
                    childCourse = [];
                    childPackage = [];
                    value.forEach((element) {
                      if (!childCourse.contains(int.parse(key))) {
                        childCourse.add(int.parse(key));
                      }
                      paymentRequest
                          .data[element.toString()]!['course'] =
                          childCourse;
                      paymentRequest
                          .data[element.toString()]!['package'] =
                          childPackage;
                    });
                  });

                  get.paymentModel.package.forEach((key, value) {
                    childPackage = [];
                    value.forEach((element) {
                      if (!childPackage.contains(int.parse(key))) {
                        childPackage.add(int.parse(key));
                      }
                      paymentRequest
                          .data[element.toString()]!['package'] =
                          childPackage;
                    });
                  });

                  Navigator.pop(context);
                  get.makePayment(context,
                      amount: price1.round().toString(),
                      currency: 'gbp',
                      type: 'recurring',
                      price: price,
                      paymentRequest: paymentRequest);
                },
                trailing: Icon(Icons.arrow_forward_ios_outlined),
                leading: Icon(Icons.account_balance_wallet),
                title: AutoSizeText(S.of(context).three_time,
                    style: Theme.of(context).textTheme.headline3,
                    minFontSize: 18,
                    maxFontSize: 20,
                    textScaleFactor: 1),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget noItemInCard(context,{double? width,double? height}){
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset('image/for_card.json',fit: BoxFit.cover),
        SizedBox(
          height: height !* 0.02,
        ),
        AutoSizeText(S.of(context).noItemInCard,style: Theme.of(context).textTheme.headline3,)
      ],
    );
  }
}
