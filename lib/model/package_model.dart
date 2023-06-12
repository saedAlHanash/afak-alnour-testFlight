import 'dart:convert';

class PackageModel {
  Data? data;

  PackageModel.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
  }
}

class Data {
  int? id;
  String? name;
  String? description;
  String? image_url;

  List<Courses> courses = [];
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image_url = json['image_url'];
    json['courses'].forEach((element){
      courses.add(Courses.fromJson(element));
    });
  }
}

class Courses{

  int? id;
  String? ar_name;
  String? en_name;
  String? ar_description;
  String? en_description;
  String? code;
  int? level_id;
  int? category_order_id;
  String? gender;
  String? population;
  String? location;
  String? purpose;
  int? price;
  String? start_date;
  String? end_date;
  List<String> days = [];
  String? start_time;
  int? session_duration;
  int? min_participants;
  int? max_participants;
  int? course_type_id;

  Courses.fromJson(Map<String,dynamic> json){
    id = json['id'];
    ar_name = json['ar_name'];
    en_name = json['en_name'];
    ar_description = json['ar_description'];
    en_description = json['en_description'];
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
    if(json['days'] != null)
    jsonDecode(json['days']).forEach((element){
      days.add(element);
    });
    start_time = json['start_time'];
    session_duration = json['session_duration'];
    min_participants = json['min_participants'];
    max_participants = json['max_participants'];
    course_type_id = json['course_type_id'];
  }
}
