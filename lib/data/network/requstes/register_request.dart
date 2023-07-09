import 'dart:io';

class RegisterRequest {
  File image;
  String firstName;
  String lastName;
  String mobileNumber;
  String email;
  String gender;
  String nationality;
  String residency;
  String qualification;
  String specialty;
  int experienceYear;
  String langLevel;
  String onlinePrograms;
  String subject;
  String appointment;
  File cv;
  File otherFile;

  RegisterRequest(
      this.image,
      this.firstName,
      this.lastName,
      this.mobileNumber,
      this.email,
      this.gender,
      this.nationality,
      this.residency,
      this.qualification,
      this.specialty,
      this.experienceYear,
      this.langLevel,
      this.onlinePrograms,
      this.appointment,
      this.subject,
      this.cv,
      this.otherFile);
}
