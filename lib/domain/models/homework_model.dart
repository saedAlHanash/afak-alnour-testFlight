class HomeWorkModel {
  int id;
  String name;
  String url;
  String type;
  int session_id;
  String created_at;
  String updated_at;

  HomeWorkModel(this.created_at, this.id, this.updated_at, this.type, this.name,
      this.session_id, this.url);
}
