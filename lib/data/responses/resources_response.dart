import 'package:json_annotation/json_annotation.dart';
part 'resources_response.g.dart';

@JsonSerializable()
class ResourcesResponse {
  int? id;
  String? name;
  String? url;
  String? type;
  int? session_id;
  String? created_at;
  String? updated_at;

  ResourcesResponse(this.url, this.session_id, this.name, this.type,
      this.updated_at, this.id, this.created_at);

  factory ResourcesResponse.fromJson(Map<String, dynamic> json) =>
      _$ResourcesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResourcesResponseToJson(this);
}
