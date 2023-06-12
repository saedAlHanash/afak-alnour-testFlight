class PaymentRequest{
Map<String,Map<String,List<int>>> data = {};

  PaymentRequest(this.data);

  Map<String,dynamic> toJson(){
    return {
      'data' : data
    };
  }
}