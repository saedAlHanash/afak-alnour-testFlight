class LevelModelById {
  List<Data> data = [];
  LevelModelById.fromJson(List<dynamic> json){
    json.forEach((element) {
      data.add(Data.fromJson(element));
    });
  }
}

class Data{
  int? id;
  String? ar_name;
  String? en_name;
  String? ar_description;
  String? en_description;
  int? order;
  int? category_id;
  int? mark;

  Data.fromJson(Map<String,dynamic> json){
    id = json['id'];
    ar_name = json['ar_name'];
    en_name = json['en_name'];
    ar_description = json['ar_description'];
    en_description = json['en_description'];
    order = json['order'];
    category_id = json['category_id'];
    mark = json['mark'];
  }
}