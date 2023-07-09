
import 'package:json_annotation/json_annotation.dart';

import '../../app/constants.dart';
import 'base_response.dart';
import 'homework_response.dart';
import 'my_sessions_response.dart';
import 'resources_response.dart';
part 'session_by_id_response.g.dart';


@JsonSerializable()
class SessionByIdResponse extends BaseResponse {
  Sessions? session;
  HomeWorkResponse? homework;
  List<ResourcesResponse>? resources;

  SessionByIdResponse(this.homework, this.resources, this.session)
      : super(Constants.zero, Constants.empty);


  factory SessionByIdResponse.fromJson(Map<String, dynamic> json) =>
      _$SessionByIdResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SessionByIdResponseToJson(this);
}
