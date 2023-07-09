// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleResponse _$ScheduleResponseFromJson(Map<String, dynamic> json) =>
    ScheduleResponse(
      json['data'] as String?,
      json['status'] as int?,
      json['message'] as String?,
    );

Map<String, dynamic> _$ScheduleResponseToJson(ScheduleResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
