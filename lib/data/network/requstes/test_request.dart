

import 'package:json_annotation/json_annotation.dart';
part 'test_request.g.dart';


@JsonSerializable()
class TestRequest{
  Map<String,List<String>> schedule = {};

  TestRequest(this.schedule);

  factory TestRequest.fromJson(Map<String, dynamic> json) =>
      _$TestRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TestRequestToJson(this);
}