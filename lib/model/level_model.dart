class LevelModel{

  List<Data> data = [];
  LevelModel.fromJson(Map<String,dynamic> json)
  {
    json['data'].forEach((element){
      data.add(Data.fromJson(element));
    });
  }
}

class Data {
  var id;
  String? name;
  String? description;

  Data.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }
}