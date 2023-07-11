// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homework_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeWorkResponse _$HomeWorkResponseFromJson(Map<String, dynamic> json) =>
    HomeWorkResponse(
      json['created_at'] as String?,
      json['id'] as int?,
      json['updated_at'] as String?,
      json['type'] as String?,
      json['name'] as String?,
      json['session_id'] as int?,
      json['url'] as String?,
    );

Map<String, dynamic> _$HomeWorkResponseToJson(HomeWorkResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'type': instance.type,
      'session_id': instance.session_id,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
