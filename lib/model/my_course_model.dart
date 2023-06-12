import 'dart:convert';

class MyCourseModel{
  List<Data> data = [];

  MyCourseModel.fromJson(Map<String,dynamic> json)
  {
    json['data'].forEach((element){
      data.add(Data.fromJson(element));
    });
  }
}

class Data {
  int? id;
  String? ar_name;
  String? code;
  int? level_id;
  int? category_order_id;
  String? gender;
  String? population;
  String? location;
  String? purpose;
  var price;
  String? start_date;
  String? end_date;
  List<String> days = [];
  String? start_time;
  int? session_duration;
  int? min_participants;
  int? max_participants;
  String? en_name;
  
  Data.fromJson(Map<String,dynamic> json){
    id = json['id'];
    ar_name = json['ar_name'];
    code = json['code'];
    level_id = json['level_id'];
    category_order_id = json['category_order_id'];
    gender = json['gender'];
    population = json['population'];
    location = json['location'];
    purpose = json['purpose'];
    price = json['price'];
    start_date = json['start_date'];
    end_date = json['end_date'];
    jsonDecode(json['days']).forEach((element){
      days.add(element);
    });
    start_time = json['start_time'];
    session_duration = json['session_duration'];
    min_participants = json['min_participants'];
    max_participants = json['max_participants'];
    en_name = json['en_name'];
  }
}
