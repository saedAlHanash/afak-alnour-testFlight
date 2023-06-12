class AllSessionsModel {
  int? status;
  List<Sessions> sessions = [];

  AllSessionsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    json['sessions'].forEach((element) {
      sessions.add(Sessions.fromJson(element));
    });
  }
}

class Sessions {
  int? id;
  int? level_id;
  int? order;
  String? created_at;
  String? updated_at;

  Sessions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    level_id = json['level_id'];
    order = json['order'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }
}
