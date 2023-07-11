class MySessionsModel {
  List<SessionsModel> sessions;

  MySessionsModel(this.sessions);
}

class SessionsModel {
  int id;
  int level_id;
  int order;
  String created_at;
  String updated_at;

  SessionsModel(
      this.updated_at, this.id, this.order, this.created_at, this.level_id);
}
