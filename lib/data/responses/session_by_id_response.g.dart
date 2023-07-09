// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_by_id_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionByIdResponse _$SessionByIdResponseFromJson(Map<String, dynamic> json) =>
    SessionByIdResponse(
      json['homework'] == null
          ? null
          : HomeWorkResponse.fromJson(json['homework'] as Map<String, dynamic>),
      (json['resources'] as List<dynamic>?)
          ?.map((e) => ResourcesResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['session'] == null
          ? null
          : Sessions.fromJson(json['session'] as Map<String, dynamic>),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$SessionByIdResponseToJson(
        SessionByIdResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'session': instance.session,
      'homework': instance.homework,
      'resources': instance.resources,
    };
