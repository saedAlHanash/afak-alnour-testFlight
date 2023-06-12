class CategorisModel {
  List<Data> data = [];
  CategorisModel.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(Data.fromJson(element));
    });
  }
}

class Data {
  var id;
  String? name;
  var min_age;
  var max_age;
  String? description;
  List<StudentLevel> student_level = [];

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    min_age = json['min_age'];
    max_age = json['max_age'];
    description = json['description'];
    if(json['student_level'] != null)
    json['student_level'].forEach((element){
      student_level.add(StudentLevel.fromJson(element));
    });
  }
}

class StudentLevel {
  var id;
  String? ar_name;
  String? en_name;
  String? ar_description;
  String? en_description;
  var order;
  var category_id;

  StudentLevel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    ar_name = json['ar_name'];
    en_name = json['en_name'];
    ar_description = json['ar_description'];
    en_description = json['en_description'];
    order = json['order'];
    category_id = json['category_id'];
  }
}