class ChildModel {
User? user;
String? token;

ChildModel.fromJson(Map<String,dynamic> json){
  token = json['token'];
  user = User.fromJson(json['user']);
}
}

class User{
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

  User.fromJson(Map<String,dynamic> json){
    id = json['id'];
    fore_name = json['fore_name'];
    middle_name = json['middle_name'];
    sur_name = json['sur_name'];
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