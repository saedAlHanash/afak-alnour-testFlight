class MyCourseModel {
  List<MyCourseDataModel> data = [];

  MyCourseModel(this.data);
}

class MyCourseDataModel {
  int id;
  String ar_name;
  String en_name;
  String ar_description;
  String en_description;
  String code;
  int level_id;
  int category_order_id;
  String gender;
  String population;
  String location;
  String purpose;
  int price;
  String start_date;
  String end_date;
  String start_time;
  List<dynamic> days = [];
  int session_duration;
  int min_participants;
  int max_participants;
  int course_type_id;
  int teacher_id;
  String created_at;
  String updated_at;

  MyCourseDataModel(
      this.price,
      this.created_at,
      this.updated_at,
      this.id,
      this.days,
      this.code,
      this.gender,
      this.ar_description,
      this.ar_name,
      this.category_order_id,
      this.course_type_id,
      this.en_description,
      this.en_name,
      this.end_date,
      this.level_id,
      this.location,
      this.max_participants,
      this.min_participants,
      this.population,
      this.purpose,
      this.session_duration,
      this.start_date,
      this.start_time,
      this.teacher_id);
}
