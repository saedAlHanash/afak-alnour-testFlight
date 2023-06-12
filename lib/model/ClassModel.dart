import 'dart:convert';

class ClassModel{
  List<Data> data = [];

  ClassModel.fromJson(Map<String,dynamic> json)
  {
    json['data'].forEach((element){
      data.add(Data.fromJson(element));
    });
  }
}

class Data {
  var id;
  String? name;
  String? start_date;
  String? end_date;
  String? start_hour;
  var duration;
  String? zoom_link;
  var price;
  var capacity;
  List<String> days = [];
  var level_id;
  var students_count;


  Data.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    start_date = json['start_date'];
    end_date = json['end_date'];
    start_hour = json['start_hour'];
    duration = json['duration'];
    zoom_link = json['zoom_link'];
    price = json['price'];
    capacity = json['capacity'];
    jsonDecode(json['days']).forEach((element){
      days.add(element);
    });
    level_id = json['level_id'];
    students_count = json['students_count'];
  }
}
