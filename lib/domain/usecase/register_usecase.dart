import 'dart:io';

import '../../data/network/failure.dart';
import '../../data/network/requstes/register_request.dart';
import '../../data/responses/base_response.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCase implements BaseUseCase<RegisterUseCaseInputs, void> {
  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, BaseResponse>> execute(
      RegisterUseCaseInputs input) async {
    return await _repository.register(RegisterRequest(
        input.profilePicture,
        input.firstName,
        input.lastName,
        input.mobileNumber,
        input.email,
        input.gender,
        input.nationality,
        input.residency,
        input.qualification,
        input.speciality,
        input.yearExperience,
        input.language,
        input.onlinePrograms,
        input.appointment,
        input.subject,
        input.cv,
        input.otherFile));
  }
}

class RegisterUseCaseInputs {
  String firstName;
  String lastName;
  String mobileNumber;
  String email;
  String gender;
  String speciality;
  int yearExperience;
  String language;
  String qualification;
  String nationality;
  String residency;
  String subject;
  String onlinePrograms;
  String appointment;
  File profilePicture;
  File cv;
  File otherFile;

  RegisterUseCaseInputs(
      this.firstName,
      this.lastName,
      this.mobileNumber,
      this.email,
      this.speciality,
      this.yearExperience,
      this.language,
      this.qualification,
      this.nationality,
      this.residency,
      this.subject,
      this.onlinePrograms,
      this.profilePicture,
      this.appointment,
      this.gender,
      this.cv,
      this.otherFile);
}
