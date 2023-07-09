
import 'dart:io';

class EditUserRequest {
  String bio;
  String phoneNumber;
  String fieldOfStudy;
  String qualification;
  File image;

  EditUserRequest(this.bio, this.fieldOfStudy, this.phoneNumber,
      this.qualification, this.image);
}
