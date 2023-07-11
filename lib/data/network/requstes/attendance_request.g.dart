// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceRequest _$AttendanceRequestFromJson(Map<String, dynamic> json) =>
    AttendanceRequest(
      students:
          (json['students'] as List<dynamic>).map((e) => e as int).toList(),
      date: json['date'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$AttendanceRequestToJson(AttendanceRequest instance) =>
    <String, dynamic>{
      'students': instance.students,
      'date': instance.date,
      'status': instance.status,
    };
