import 'package:afaq_alnour_academy/model/payment_history_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class PaymentDetailsScreen extends StatelessWidget {
  List<Payments> payments = [];
  PaymentDetailsScreen({required this.payments});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.02,
          ),
          SizedBox(
            height: height * 0.85,
            child: ListView.separated(
                padding: EdgeInsets.all(0),
                itemBuilder: (context, index) => paymentItem(context,
                    payments: payments[index], width: width,height: height),
                separatorBuilder: (context, index) => SizedBox(
                      height: height * 0.02,
                    ),
                itemCount: payments.length),
          ),
        ],
      ),
    );
  }

  Widget paymentItem(context, {Payments? payments, double? width,double? height}) {
    var createdAt = DateTime.parse(payments!.created_at!);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width! * 0.05),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black26, width: 2)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SelectableText('id : ${payments.payment_stripe_id!}',
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                    fontSize: 18
                  ),
                  textScaleFactor: 1),
              SizedBox(
                height: height !* 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText('created at : ${createdAt.year}-${createdAt.month}-${createdAt.day} ${createdAt.hour}:${createdAt.minute}:${createdAt.second}',style: Theme.of(context).textTheme.bodyText1,minFontSize: 14,maxFontSize: 16,textScaleFactor: 1),
                  AutoSizeText('total : ${payments.amount!.toDouble().round() / 100}',style: Theme.of(context).textTheme.bodyText1,minFontSize: 14,maxFontSize: 16,textScaleFactor: 1),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
