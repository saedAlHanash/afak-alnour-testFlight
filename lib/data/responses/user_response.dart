import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserData {
  @JsonKey(name: "user")
  User? user;
  @JsonKey(name: "token")
  String? token;

  UserData(this.token, this.user);

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}

@JsonSerializable()
class User {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "bio")
  String? bio;
  @JsonKey(name: "forename")
  String? forename;
  @JsonKey(name: "surname")
  String? surname;
  @JsonKey(name: "phone_number")
  String? phone_number;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "image_url")
  String? image_url;
  @JsonKey(name: "gender")
  String? gender;
  @JsonKey(name: "nationality")
  String? nationality;
  @JsonKey(name: "residency")
  String? residency;
  @JsonKey(name: "years_of_experience")
  String? years_of_experience;
  @JsonKey(name: "qualification")
  String? qualification;
  @JsonKey(name: "field_of_study")
  String? field_of_study;
  @JsonKey(name: "english_level")
  String? english_level;
  @JsonKey(name: "subject")
  String? subject;
  @JsonKey(name: "apps")
  String? apps;

  User(
      this.id,
      this.qualification,
      this.email,
      this.gender,
      this.subject,
      this.residency,
      this.nationality,
      this.image_url,
      this.apps,
      this.english_level,
      this.field_of_study,
      this.forename,
      this.phone_number,
      this.surname,
      this.years_of_experience,
      this.bio);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
