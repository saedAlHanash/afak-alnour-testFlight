class UserModel {
  String? token;
  Sutdent? user;

  UserModel.fromJson(Map<String,dynamic>json)
  {
    token = json['token'];
    user = Sutdent.fromJson(json['user']);
  }

}

class Sutdent {
  var id;
  String? forename;
  String? surname;
  String? phone_number;
  String? email;
  String? country;
  String? city;
  String? street;
  var  building_number;
  String? post_code;
  String? emergency_phone_number;
  String? emergency_relationship;
  String? stripe_id;


  Sutdent.fromJson (Map<String,dynamic>json){
    id = json['id'];
    forename = json['first_name'];
    surname = json['last_name'];
    phone_number = json['phone_number'];
    email = json['email'];
    country = json['country'];
    city = json['city'];
    street = json['street'];
    building_number = json['building_number'];
    post_code = json['post_code'];
    emergency_phone_number = json['emergency_phone_number'];
    emergency_relationship = json['emergency_relationship'];
    stripe_id = json['stripe_id'];
  }

  Map<String,dynamic> toJson (){
    return {
    "id" : id,
    "first_name" : forename,
    "last_name" : surname,
    "phone_number" : phone_number,
    "email" : email,
    "country" : country,
    "city" : city,
    "street" : street,
    "building_number" : building_number,
    "post_code" : post_code,
    "emergency_phone_number" : emergency_phone_number,
    "emergency_relationship" : emergency_relationship,
    "stripe_id" : stripe_id
    };
  }

}
