

class PaymentHistoryModel{
  List<Data> data = [];

  PaymentHistoryModel.fromJson(Map<String,dynamic> json){
    json['data'].forEach((element){
      data.add(Data.fromJson(element));
    });
  }
}

class Data{
  int? id;
  int? user_id;
  String? stripe_invoice_id;
  var total;
  var unpaid_amount;
  String? type;
  String? created_at;
  String? updated_at;
  List<Payments> payments = [];

  Data.fromJson(Map<String,dynamic> json){
    id = json['id'];
    user_id = json['user_id'];
    stripe_invoice_id = json['stripe_invoice_id'];
    total = json['total'];
    unpaid_amount = json['unpaid_amount'];
    type = json['type'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    json['payments'].forEach((element){
      payments.add(Payments.fromJson(element));
    });
  }
}

class Payments{
  int? id;
  int? invoice_id;
  var amount;
  String? payment_stripe_id;
  String? created_at;

  Payments.fromJson(Map<String,dynamic> json){
    id = json['id'];
    invoice_id = json['invoice_id'];
    amount = json['amount'];
    payment_stripe_id = json['payment_stripe_id'];
    created_at = json['created_at'];
  }
}