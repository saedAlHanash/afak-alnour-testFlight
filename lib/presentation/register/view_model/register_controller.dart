import 'dart:io';


import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../app/constants.dart';
import '../../../app/di.dart';
import '../../../domain/models/check_box_item.dart';
import '../../../domain/models/dropdown_item.dart';
import '../../../domain/usecase/register_usecase.dart';
import '../../common/freezed/freezed_data_classes.dart';
import '../../common/state_rendere/state_renderer.dart';
import '../../resources/string_manger.dart';

class RegisterController extends GetxController {
  Rx<File> profilePicture = File(Constants.empty).obs;
  final RegisterUseCase _useCase = RegisterUseCase(instance());
  List<String> _onlineProgramsItems = [];
  List<String> _onlineProgramsDisplay = [];
  final ImagePicker _imagePicker = instance<ImagePicker>();
  String countryCode = "963";

  RegisterObject registerObject = RegisterObject(
      Constants.empty,
      Constants.empty,
      Constants.empty,
      Constants.empty,
      Constants.empty,
      Constants.empty,
      Constants.zero,
      Constants.empty,
      Constants.empty,
      AppStrings.syria.tr,
      AppStrings.syria.tr,
      AppStrings.subjects.tr,
      Constants.empty,
      Constants.empty,
      Constants.empty,
      File(Constants.empty),
      File(Constants.empty),
      File(Constants.empty));

  List<String> qualification = [
    AppStrings.collegeStudent.tr,
    AppStrings.bachelors.tr,
    AppStrings.masters.tr,
    AppStrings.phdDegree.tr
  ];

  List<String> appointment = [
    AppStrings.morning.tr,
    AppStrings.night.tr,
  ];

  List<String> language = [
    AppStrings.beginner.tr,
    AppStrings.intermediate.tr,
    AppStrings.advanced.tr,
  ];

  final allPrograms =
      CheckBoxItem(title: AppStrings.all.tr, apiName: AppStrings.all.tr);

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final emailController = TextEditingController();
  final specialityController = TextEditingController();
  final yearExperienceController = TextEditingController();
  final languageController = TextEditingController();
  final qualificationController = TextEditingController();
  final onlineProgramController = TextEditingController();
  final appointmentController = TextEditingController();
  final cvController = TextEditingController();
  final otherFileController = TextEditingController();

  List<CheckBoxItem> checkBoxItems = [
    CheckBoxItem(title: AppStrings.zoom.tr, apiName: AppStrings.zoom1.tr),
    CheckBoxItem(
        title: AppStrings.googleMeet.tr, apiName: AppStrings.googleMeet1.tr),
    CheckBoxItem(
        title: AppStrings.microsoft.tr, apiName: AppStrings.microsoft1.tr),
  ];

  List<DropDownItem> dropDownItems = [
    DropDownItem(value: AppStrings.subjects.tr, title: AppStrings.subjects.tr),
    DropDownItem(value: AppStrings.arabic1.tr, title: AppStrings.arabic.tr),
    DropDownItem(value: AppStrings.islam1.tr, title: AppStrings.islam.tr),
    DropDownItem(value: AppStrings.quran1.tr, title: AppStrings.quran.tr),
    DropDownItem(value: AppStrings.skills1.tr, title: AppStrings.skills.tr),
  ];

  setProfilePicture(File image) {
    if (image.path.isNotEmpty) {
      registerObject = registerObject.copyWith(profilePicture: image);
    } else {
      registerObject =
          registerObject.copyWith(profilePicture: File(Constants.empty));
    }
  }

  setEmail(String email) {
    if (email.isNotEmpty) {
      registerObject = registerObject.copyWith(email: email);
    } else {
      registerObject = registerObject.copyWith(email: '');
    }
  }

  setFirstName(String firstName) {
    if (firstName.isNotEmpty) {
      registerObject = registerObject.copyWith(firstName: firstName);
    } else {
      registerObject = registerObject.copyWith(firstName: '');
    }
  }

  setLastName(String lastName) {
    if (lastName.isNotEmpty) {
      registerObject = registerObject.copyWith(lastName: lastName);
    } else {
      registerObject = registerObject.copyWith(lastName: '');
    }
  }

  setMobileNumber(String mobileNumber) {
    if (mobileNumber.isNotEmpty) {
      registerObject = registerObject.copyWith(mobileNumber: mobileNumber);
    } else {
      registerObject = registerObject.copyWith(mobileNumber: '');
    }
  }

  setSpeciality(String speciality) {
    if (speciality.isNotEmpty) {
      registerObject = registerObject.copyWith(speciality: speciality);
    } else {
      registerObject = registerObject.copyWith(speciality: '');
    }
  }

  setYearExperience(String yearExperience) {
    if (yearExperience.isNotEmpty) {
      registerObject =
          registerObject.copyWith(yearExperience: int.parse(yearExperience));
    } else {
      registerObject = registerObject.copyWith(yearExperience: Constants.zero);
    }
  }

  setGender(String gender) {
    if (gender.isNotEmpty) {
      registerObject = registerObject.copyWith(gender: gender);
    } else {
      registerObject = registerObject.copyWith(gender: Constants.empty);
    }
  }

  setNationality(String nationality) {
    if (nationality.isNotEmpty) {
      registerObject = registerObject.copyWith(nationality: nationality);
    } else {
      registerObject = registerObject.copyWith(nationality: '');
    }
  }

  setResidency(String residency) {
    if (residency.isNotEmpty) {
      registerObject = registerObject.copyWith(residency: residency);
    } else {
      registerObject = registerObject.copyWith(residency: '');
    }
  }

  setLanguage(String language) {
    if (language.isNotEmpty) {
      registerObject = registerObject.copyWith(language: language);
    } else {
      registerObject = registerObject.copyWith(language: '');
    }
  }

  setQualification(String qualification) {
    if (qualification.isNotEmpty) {
      registerObject = registerObject.copyWith(qualification: qualification);
    } else {
      registerObject = registerObject.copyWith(qualification: '');
    }
  }

  setAppointment(String appointment) {
    if (appointment.isNotEmpty) {
      registerObject = registerObject.copyWith(appointment: appointment);
    } else {
      registerObject = registerObject.copyWith(appointment: '');
    }
  }

  setOnlineProgram(String onlinePrograms, String display, {bool? value}) {
    if (onlinePrograms.isNotEmpty) {
      if (onlinePrograms == AppStrings.all.tr) {
        if (value!) {
          _onlineProgramsDisplay = [];
          _onlineProgramsDisplay = [
            AppStrings.zoom.tr,
            AppStrings.googleMeet.tr,
            AppStrings.microsoft.tr
          ];
          registerObject = registerObject.copyWith(
              onlinePrograms: onlinePrograms.toLowerCase());
          registerObject = registerObject.copyWith(
              programs: _onlineProgramsDisplay
                  .toString()
                  .substring(1, _onlineProgramsDisplay.toString().length - 1));
        } else {
          _onlineProgramsItems = [];
          _onlineProgramsDisplay = [];
          registerObject =
              registerObject.copyWith(onlinePrograms: Constants.empty);
          registerObject = registerObject.copyWith(programs: Constants.empty);
        }
      } else {
        if (!_onlineProgramsItems.contains(onlinePrograms)) {
          _onlineProgramsItems.add(onlinePrograms);
        } else {
          _onlineProgramsItems.remove(onlinePrograms);
        }
        if (!_onlineProgramsDisplay.contains(display)) {
          _onlineProgramsDisplay.add(display);
        } else {
          _onlineProgramsDisplay.remove(display);
        }
        registerObject = registerObject.copyWith(
            onlinePrograms: _onlineProgramsItems
                .toString()
                .substring(1, _onlineProgramsItems.toString().length - 1));
        registerObject = registerObject.copyWith(
            programs: _onlineProgramsDisplay
                .toString()
                .substring(1, _onlineProgramsDisplay.toString().length - 1));
      }
    } else {
      registerObject = registerObject.copyWith(onlinePrograms: Constants.empty);
      registerObject = registerObject.copyWith(programs: Constants.empty);
    }
  }

  setSubject(String subject) {
    if (subject.isNotEmpty) {
      registerObject = registerObject.copyWith(subject: subject);
    } else {
      registerObject = registerObject.copyWith(subject: '');
    }
  }

  imageFromGallery() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setProfilePicture(File(image.path));
        profilePicture.value = File(image.path);
      }
    } else {}
  }

  imageFromCamera() async {
      final status = await Permission.storage.request();
      if (status.isGranted) {
        XFile? image = await _imagePicker.pickImage(source: ImageSource.camera);

        if (image != null) {
          setProfilePicture(File(image.path));
          profilePicture.value = File(image.path);
        }
      } else {}
  }

  pickCvFile() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null) {
        cvController.text = result.paths.single!.split("/").last;
        File file = File(result.paths.single!);
        registerObject = registerObject.copyWith(cv: file);
      } else {
        cvController.text = Constants.empty;
        registerObject = registerObject.copyWith(cv: File(Constants.empty));
      }
    }
  }

  pickOtherFile() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final result = await FilePicker.platform.pickFiles(
        allowedExtensions: ["pdf"],
        type: FileType.custom
      );
      if (result != null) {
        otherFileController.text = result.paths.single!.split("/").last;
        File file = File(result.paths.single!);
        registerObject = registerObject.copyWith(otherFile: file);
      } else {
        otherFileController.text = Constants.empty;
        registerObject = registerObject.copyWith(otherFile: File(''));
      }
    }
  }

  bool isAllDataValidate() {
    return registerObject.profilePicture.path.isNotEmpty &&
        registerObject.firstName.isNotEmpty &&
        registerObject.lastName.isNotEmpty &&
        registerObject.mobileNumber.isNotEmpty &&
        registerObject.email.isNotEmpty &&
        registerObject.yearExperience != 0 &&
        registerObject.language.isNotEmpty &&
        registerObject.qualification.isNotEmpty &&
        registerObject.nationality.isNotEmpty &&
        registerObject.residency.isNotEmpty &&
        registerObject.subject.isNotEmpty &&
        registerObject.onlinePrograms.isNotEmpty &&
        registerObject.programs.isNotEmpty &&
        registerObject.gender.isNotEmpty &&
        registerObject.appointment.isNotEmpty &&
        registerObject.speciality.isNotEmpty &&
        registerObject.cv.path.isNotEmpty;
  }

  void register() async {
    getPopUpStateRenderer(PopUpStateRendererType.popupLoadingState);
    (await _useCase.execute(RegisterUseCaseInputs(
            registerObject.firstName,
            registerObject.lastName,
            countryCode + registerObject.mobileNumber,
            registerObject.email,
            registerObject.speciality,
            registerObject.yearExperience,
            registerObject.language,
            registerObject.qualification,
            registerObject.nationality,
            registerObject.residency,
            registerObject.subject,
            registerObject.onlinePrograms,
            registerObject.profilePicture,
            registerObject.appointment,
            registerObject.gender,
            registerObject.cv,
            registerObject.otherFile)))
        .fold((l) {
      getPopUpStateRenderer(PopUpStateRendererType.popupErrorState,
          errorMessage: l.message);
    }, (r) {
      getPopUpStateRenderer(PopUpStateRendererType.successState,
          successMessage: AppStrings.registerSuccess.tr).whenComplete(() => Get.back());
    });
  }
}
