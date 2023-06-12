class EnrollModel{
  String? message;
  EnrollModel.fromJson(Map<String,dynamic>json){
    message = json['message'];
  }
}

