import 'package:json_annotation/json_annotation.dart';
part 'homework_response.g.dart';


@JsonSerializable()
class HomeWorkResponse {
  int? id;
  String? name;
  String? url;
  String? type;
  int? session_id;
  String? created_at;
  String? updated_at;

  HomeWorkResponse(this.created_at, this.id, this.updated_at, this.type,
      this.name, this.session_id, this.url);

  factory HomeWorkResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeWorkResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeWorkResponseToJson(this);
}
