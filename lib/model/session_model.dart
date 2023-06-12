import 'package:afaq_alnour_academy/model/all_sessions_model.dart';

class SessionModel {
  int? status;
  Sessions? session;
  HomeWork? homeWork;

  SessionModel.froJson(Map<String, dynamic> json) {
    status = json['status'];
    session = Sessions.fromJson(json['session']);
    homeWork = HomeWork.fromJson(json['homework']);
  }
}

class HomeWork {
  int? id;
  String? name;
  String? url;
  String? type;
  int? session_id;
  String? created_at;
  String? updated_at;

  HomeWork.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
    type = json['type'];
    session_id = json['session_id'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }
}
