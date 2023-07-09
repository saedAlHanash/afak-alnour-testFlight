// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_course_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyCourseResponse _$MyCourseResponseFromJson(Map<String, dynamic> json) =>
    MyCourseResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => MyCourseResponseData.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$MyCourseResponseToJson(MyCourseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

MyCourseResponseData _$MyCourseResponseDataFromJson(
        Map<String, dynamic> json) =>
    MyCourseResponseData(
      json['price'] as int?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['id'] as int?,
      json['days'] as String?,
      json['code'] as String?,
      json['gender'] as String?,
      json['ar_description'] as String?,
      json['ar_name'] as String?,
      json['category_order_id'] as int?,
      json['course_type_id'] as int?,
      json['en_description'] as String?,
      json['en_name'] as String?,
      json['end_date'] as String?,
      json['level_id'] as int?,
      json['location'] as String?,
      json['max_participants'] as int?,
      json['min_participants'] as int?,
      json['population'] as String?,
      json['purpose'] as String?,
      json['session_duration'] as int?,
      json['start_date'] as String?,
      json['start_time'] as String?,
      json['teacher_id'] as int?,
    );

Map<String, dynamic> _$MyCourseResponseDataToJson(
        MyCourseResponseData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ar_name': instance.ar_name,
      'en_name': instance.en_name,
      'ar_description': instance.ar_description,
      'en_description': instance.en_description,
      'code': instance.code,
      'level_id': instance.level_id,
      'category_order_id': instance.category_order_id,
      'gender': instance.gender,
      'population': instance.population,
      'location': instance.location,
      'purpose': instance.purpose,
      'price': instance.price,
      'start_date': instance.start_date,
      'end_date': instance.end_date,
      'start_time': instance.start_time,
      'days': instance.days,
      'session_duration': instance.session_duration,
      'min_participants': instance.min_participants,
      'max_participants': instance.max_participants,
      'course_type_id': instance.course_type_id,
      'teacher_id': instance.teacher_id,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
