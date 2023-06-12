class SliderModel {
  List<Data> data = [];

  SliderModel.fromJson(Map<String,dynamic> json)
  {
    json['data'].forEach((element){
      data.add(Data.fromJson(element));
    });
  }
}

class Data {
  var id;
  String? name;
  String? image_url;

  Data.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    image_url = json['image_url'];
  }
}