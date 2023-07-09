class ResourcesModel{
  int id;
  String name;
  String url;
  String type;
  int session_id;
  String created_at;
  String updated_at;

  ResourcesModel(this.url, this.session_id, this.name, this.type,
      this.updated_at, this.id, this.created_at);
}