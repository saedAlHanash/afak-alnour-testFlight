import 'dart:convert';

class ClassModel {
  List<Data> data = [];

  ClassModel.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(Data.fromJson(element));
    });
  }
}

class Data {
  int? id;
  String? ar_name;
  String? en_name;
  int? level_id;
  int? category_order_id;
  String? gender;
  String? population;
  String? location;
  String? purpose;
  String? start_time;
  var price;
  String? book_cost;
  String? start_date;
  String? end_date;
  List<String> days = [];
  var session_duration;
  var min_participants;
  var max_participants;
  int? students_count;
  String? ar_image_url;
  String? en_image_url;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ar_name = json['ar_name'];
    en_name = json['en_name'];
    level_id = json['level_id'];
    category_order_id = json['category_order_id'];
    gender = json['gender'];
    population = json['population'];
    location = json['location'];
    purpose = json['purpose'];
    start_time = json['start_time'];
    price = json['price'];
    book_cost = json['book_cost'];
    start_date = json['start_date'];
    end_date = json['end_date'];
    jsonDecode(json['days']).forEach((element) {
      days.add(element);
    });
    session_duration = json['session_duration'];
    min_participants = json['min_participants'];
    max_participants = json['max_participants'];
    students_count = json['students_count'];
    en_image_url = json['en_image_url'];
    ar_image_url = json['ar_image_url'];
  }
}
