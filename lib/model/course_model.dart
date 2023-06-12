class model {
  var id;
  String? name;
  String? image_url;
  String? description;

  model(
      {
      required this.name,
      required this.image_url});

  model.fromjson(Map<String, dynamic> json) {
     id = json['id'];
    name = json['name'];
    image_url = json['home_page'];
     description = json['description'];
  }
}


class CourseModel {
  List<model>? data = [];
  CourseModel({required this.data});
  CourseModel.fromJson(Map<String,dynamic> json)
  {
    json['data'].forEach((element) {
      data!.add(model.fromjson(element));
    });
  }
}