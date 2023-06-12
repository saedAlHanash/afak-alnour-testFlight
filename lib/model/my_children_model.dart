class MyChildrenModel{
  List<ChildData> data = [];

  MyChildrenModel.fromJson(Map<String,dynamic> json){
    json['data'].forEach((element){
      data.add(ChildData.fromJson(element));
    });
  }
}

class ChildData{
  int? id;
  String? fore_name;
  String? middle_name;
  String? sur_name;
  String? gender;
  String? date_of_birth;
  String? guardian_relationship;
  String? phone_number;
  String? email;
  String? country;
  String? city;
  String? street;
  String? building_number;
  String? post_code;

  ChildData.fromJson(Map<String,dynamic> json){
    id = json['id'];
    fore_name = json['forename'];
    middle_name = json['middlename'];
    sur_name = json['surname'];
    gender = json['gender'];
    date_of_birth = json['date_of_birth'];
    guardian_relationship = json['guardian_relationship'];
    phone_number = json['phone_number'];
    email = json['email'];
    country = json['country'];
    city = json['city'];
    street = json['street'];
    building_number = json['building_number'];
    post_code = json['post_code'];
  }
}