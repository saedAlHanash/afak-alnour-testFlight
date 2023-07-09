// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_in_course_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentInCourseResponse _$StudentInCourseResponseFromJson(
        Map<String, dynamic> json) =>
    StudentInCourseResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => StudentDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$StudentInCourseResponseToJson(
        StudentInCourseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

StudentDataResponse _$StudentDataResponseFromJson(Map<String, dynamic> json) =>
    StudentDataResponse(
      json['id'] as int?,
      json['date_of_birth'] as String?,
      json['gender'] as String?,
      json['guardian_relationship'] as String?,
      json['post_code'] as String?,
      json['building_number'] as String?,
      json['street'] as String?,
      json['city'] as String?,
      json['country'] as String?,
      json['email'] as String?,
      json['phone_number'] as String?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['forename'] as String?,
      json['guardian_id'] as int?,
      json['middlename'] as String?,
      json['surname'] as String?,
      json['username'] as String?,
    );

Map<String, dynamic> _$StudentDataResponseToJson(
        StudentDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'forename': instance.forename,
      'middlename': instance.middlename,
      'surname': instance.surname,
      'gender': instance.gender,
      'date_of_birth': instance.date_of_birth,
      'guardian_relationship': instance.guardian_relationship,
      'phone_number': instance.phone_number,
      'email': instance.email,
      'country': instance.country,
      'city': instance.city,
      'street': instance.street,
      'building_number': instance.building_number,
      'post_code': instance.post_code,
      'username': instance.username,
      'guardian_id': instance.guardian_id,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
