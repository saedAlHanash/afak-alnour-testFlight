// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestRequest _$TestRequestFromJson(Map<String, dynamic> json) => TestRequest(
      (json['schedule'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
    );

Map<String, dynamic> _$TestRequestToJson(TestRequest instance) =>
    <String, dynamic>{
      'schedule': instance.schedule,
    };
