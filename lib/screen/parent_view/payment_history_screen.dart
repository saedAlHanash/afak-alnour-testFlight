import 'package:afaq_alnour_academy/adaptive_widget/adabtive_indecator.dart';
import 'package:afaq_alnour_academy/bloc/home_bloc/home_cubit.dart';
import 'package:afaq_alnour_academy/bloc/home_bloc/home_state.dart';
import 'package:afaq_alnour_academy/constant/const.dart';
import 'package:afaq_alnour_academy/generated/l10n.dart';
import 'package:afaq_alnour_academy/model/payment_history_model.dart';
import 'package:afaq_alnour_academy/screen/parent_view/payment_details_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var get = HomeCubit.get(context);
        return  Directionality(
            textDirection: TextDirection.ltr,
            child: state is! GetPaymentHistoryLoadingState
                ? get.paymentHistoryModel != null
                    ? get.paymentHistoryModel!.data.isNotEmpty
                        ? Column(
                            children: [
                              SizedBox(
                                height: height * 0.02,
                              ),
                              SizedBox(
                                height: height * 0.76,
                                child: ListView.separated(
                                    padding: EdgeInsets.all(0),
                                    itemBuilder: (context, index) =>
                                        paymentHistory(context,
                                            width: width,
                                            height: height,
                                            index: index,
                                            model: get.paymentHistoryModel),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                    itemCount:
                                        get.paymentHistoryModel!.data.length),
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                            ],
                          )
                        : Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('image/payment_history.json',
                    fit: BoxFit.cover),
                SizedBox(
                  height: height * 0.02,
                ),
              ],
            )
                    : Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
            onTap: () {
              get.getPaymentHistory();
            },
            child: Lottie.asset('image/error_afaq.json',
                fit: BoxFit.cover),
            ),
            SizedBox(
            height: height * 0.02,
            ),
          ],
        )
                : Center(
                    child: AdabtiveIndecator(os: getOS()),
                  ),
        );
      },
    );
  }
}

Widget paymentHistory(context,
    {double? width, double? height, PaymentHistoryModel? model, int? index}) {
  var createdAt = DateTime.parse(model!.data[index!].created_at!);
  var updatedAt = DateTime.parse(model.data[index].updated_at!);
  var allPrice = model.data[index].unpaid_amount!.toDouble() / 100;
  var price = 0.0;
  if(model.data[index].payments.length <= 1){
    price = (model.data[index].total!.toDouble() / 100) / 3;
  }else{
    price = double.parse(model.data[index].unpaid_amount!) / 100;
  }
  return BlocConsumer<HomeCubit, HomeState>(
    listener: (context, state) {},
    builder: (context, state) {
      var get = HomeCubit.get(context);
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: width! * 0.05),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black26, width: 2)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  'id : ${model.data[index].stripe_invoice_id!}',
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontSize: 18),
                  textScaleFactor: 1,
                ),
                SizedBox(
                  height: height! * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                        'total : ${model.data[index].total!.toDouble() / 100}',
                        style: Theme.of(context).textTheme.bodyText1,
                        minFontSize: 14,
                        maxFontSize: 16,
                        textScaleFactor: 1),
                    AutoSizeText('type : ${model.data[index].type!}',
                        style: Theme.of(context).textTheme.bodyText1,
                        minFontSize: 14,
                        maxFontSize: 16,
                        textScaleFactor: 1),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                AutoSizeText(
                    'created at : ${createdAt.year}-${createdAt.month}-${createdAt.day}  ${createdAt.hour}:${createdAt.minute}:${createdAt.second}',
                    style: Theme.of(context).textTheme.bodyText1,
                    minFontSize: 14,
                    maxFontSize: 16,
                    textScaleFactor: 1),
                SizedBox(
                  height: height * 0.01,
                ),
                AutoSizeText(
                    'updated at : ${updatedAt.year}-${updatedAt.month}-${updatedAt.day}  ${updatedAt.hour}:${updatedAt.minute}:${updatedAt.second}',
                    style: Theme.of(context).textTheme.bodyText1,
                    minFontSize: 14,
                    maxFontSize: 16,
                    textScaleFactor: 1),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: [
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentDetailsScreen(payments: model.data[index].payments,),));
                      },
                      child: Container(
                        height: height * 0.06,
                        width: width * 0.22,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: AutoSizeText('See details',
                              style: Theme.of(context).textTheme.headline3,
                              textScaleFactor: 1,
                              minFontSize: 14,
                              maxFontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                if (allPrice != 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          get.makePayment(context,
                              amount: price.round().toString(),
                              currency: 'gbp',
                              type: 'payment',
                              invoiceID: model.data[index].id!.toString());
                        },
                        child: Container(
                          height: height * 0.06,
                          width: width * 0.22,
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: AutoSizeText(
                              'pay ${price.round()}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                              textScaleFactor: 1,
                              minFontSize: 14,
                              maxFontSize: 16,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          get.makePayment(context,
                              amount: allPrice.round().toString(),
                              currency: 'gbp',
                              type: 'payment',
                              invoiceID: model.data[index].id!.toString());
                        },
                        child: Container(
                          height: height * 0.06,
                          width: width * 0.22,
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: AutoSizeText(
                              'pay all \n${allPrice.round()}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(color: Colors.white),
                              textScaleFactor: 1,
                              minFontSize: 14,
                              maxFontSize: 16,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    },
  );
}



