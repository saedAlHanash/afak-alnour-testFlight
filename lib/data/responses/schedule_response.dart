import 'package:json_annotation/json_annotation.dart';

import 'base_response.dart';
part 'schedule_response.g.dart';



@JsonSerializable()
class ScheduleResponse extends BaseResponse{
  @JsonKey(name: "data")
  String? data;
  ScheduleResponse(this.data,super.status,super.message);

  factory ScheduleResponse.fromJson(Map<String, dynamic> json) =>
      _$ScheduleResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ScheduleResponseToJson(this);
}