// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resources_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResourcesResponse _$ResourcesResponseFromJson(Map<String, dynamic> json) =>
    ResourcesResponse(
      json['url'] as String?,
      json['session_id'] as int?,
      json['name'] as String?,
      json['type'] as String?,
      json['updated_at'] as String?,
      json['id'] as int?,
      json['created_at'] as String?,
    );

Map<String, dynamic> _$ResourcesResponseToJson(ResourcesResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'type': instance.type,
      'session_id': instance.session_id,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
