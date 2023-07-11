import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezed_data_classes.freezed.dart';

@freezed
class RegisterObject with _$RegisterObject {
  factory RegisterObject(
      String firstName,
      String lastName,
      String mobileNumber,
      String email,
      String gender,
      String speciality,
      int yearExperience,
      String language,
      String qualification,
      String nationality,
      String residency,
      String subject,
      String onlinePrograms,
      String programs,
      String appointment,
      File profilePicture,
      File cv,
      File otherFile) = _RegisterObject;
}

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String email, String password) = _LoginObject;
}
