
import 'package:json_annotation/json_annotation.dart';

import '../../app/constants.dart';
import 'base_response.dart';
part 'student_in_course_response.g.dart';


@JsonSerializable()
class StudentInCourseResponse extends BaseResponse {
  List<StudentDataResponse>? data;

  StudentInCourseResponse(this.data) : super(Constants.zero, Constants.empty);

  factory StudentInCourseResponse.fromJson(Map<String, dynamic> json) =>
      _$StudentInCourseResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StudentInCourseResponseToJson(this);
}

@JsonSerializable()
class StudentDataResponse {
  int? id;
  String? forename;
  String? middlename;
  String? surname;
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
  String? username;
  int? guardian_id;
  String? created_at;
  String? updated_at;

  StudentDataResponse(
      this.id,
      this.date_of_birth,
      this.gender,
      this.guardian_relationship,
      this.post_code,
      this.building_number,
      this.street,
      this.city,
      this.country,
      this.email,
      this.phone_number,
      this.created_at,
      this.updated_at,
      this.forename,
      this.guardian_id,
      this.middlename,
      this.surname,
      this.username);

  factory StudentDataResponse.fromJson(Map<String, dynamic> json) =>
      _$StudentDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StudentDataResponseToJson(this);
}
