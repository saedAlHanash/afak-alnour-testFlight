// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_sessions_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MySessionsResponse _$MySessionsResponseFromJson(Map<String, dynamic> json) =>
    MySessionsResponse(
      (json['sessions'] as List<dynamic>?)
          ?.map((e) => Sessions.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$MySessionsResponseToJson(MySessionsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'sessions': instance.sessions,
    };

Sessions _$SessionsFromJson(Map<String, dynamic> json) => Sessions(
      json['level_id'] as int?,
      json['created_at'] as String?,
      json['order'] as int?,
      json['id'] as int?,
      json['updated_at'] as String?,
    );

Map<String, dynamic> _$SessionsToJson(Sessions instance) => <String, dynamic>{
      'id': instance.id,
      'level_id': instance.level_id,
      'order': instance.order,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
