
import 'package:json_annotation/json_annotation.dart';

import '../../app/constants.dart';
import 'base_response.dart';
part 'my_sessions_response.g.dart';


@JsonSerializable()
class MySessionsResponse extends BaseResponse {
  List<Sessions>? sessions;

  MySessionsResponse(this.sessions) : super(Constants.zero, Constants.empty);

  factory MySessionsResponse.fromJson(Map<String, dynamic> json) =>
      _$MySessionsResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MySessionsResponseToJson(this);
}

@JsonSerializable()
class Sessions {
  int? id;
  int? level_id;
  int? order;
  String? created_at;
  String? updated_at;

  Sessions(
      this.level_id, this.created_at, this.order, this.id, this.updated_at);

  factory Sessions.fromJson(Map<String, dynamic> json) =>
      _$SessionsFromJson(json);

  Map<String, dynamic> toJson() => _$SessionsToJson(this);
}
