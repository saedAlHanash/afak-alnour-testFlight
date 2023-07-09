class StudentInCourseModel {
  List<StudentDataModel> data;

  StudentInCourseModel(this.data);
}

class StudentDataModel {
  int id;
  String forename;
  String middlename;
  String surname;
  String gender;
  String date_of_birth;
  String guardian_relationship;
  String phone_number;
  String email;
  String country;
  String city;
  String street;
  String building_number;
  String post_code;
  String username;
  int guardian_id;
  String created_at;
  String updated_at;

  StudentDataModel(
      this.id,
      this.date_of_birth,
      this.gender,
      this.guardian_relationship,
      this.post_code,
      this.building_number,
      this.street,
      this.city,
      this.country,
      this.email,
      this.phone_number,
      this.created_at,
      this.updated_at,
      this.forename,
      this.guardian_id,
      this.middlename,
      this.surname,
      this.username);
}
