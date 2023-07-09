
import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';
class UserDataModel {
  UserModel? user;
  String token;

  UserDataModel(this.token, this.user);

}

@JsonSerializable()
class UserModel {
  int id;
  String bio;
  String forename;
  String surname;
  String phone_number;
  String email;
  String image_url;
  String gender;
  String nationality;
  String residency;
  String years_of_experience;
  String qualification;
  String field_of_study;
  String english_level;
  String subject;
  String apps;

  UserModel(
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
      this.years_of_experience,this.bio);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

}
