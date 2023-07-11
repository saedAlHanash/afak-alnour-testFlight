import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/app_pref.dart';
import '../../../app/constants.dart';
import '../../../app/di.dart';
import '../../../data/network/requstes/edit_user_request.dart';
import '../../../domain/models/dropdown_item.dart';
import '../../../domain/models/user_model.dart';
import '../../../domain/usecase/edit_user_info_usecase.dart';
import '../../main/pages/profile_page/view_model/profile_controller.dart';
import '../../resources/string_manger.dart';

class EditProfileController extends GetxController {
  late UserModel userModel;
  final UserModel userProfileModel =
      Get.find<ProfileController>().userModel.value;
  final EditUserInfoUseCase _editUserInfoUseCase =
      instance<EditUserInfoUseCase>();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  Rx<File> profilePicture = File(Constants.empty).obs;
  final ImagePicker _imagePicker = instance<ImagePicker>();
  TextEditingController bioController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController specialtyController = TextEditingController();
  RxBool loading = false.obs;

  List<DropDownItem> dropDownItems = [
    DropDownItem(
        value: AppStrings.collegeStudent.tr,
        title: AppStrings.collegeStudent.tr),
    DropDownItem(
        value: AppStrings.bachelors.tr, title: AppStrings.bachelors.tr),
    DropDownItem(value: AppStrings.masters.tr, title: AppStrings.masters.tr),
    DropDownItem(
        value: AppStrings.phdDegree.tr, title: AppStrings.phdDegree.tr),
  ];

  imageFromGallery() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profilePicture.value = File(image.path);
    }
  }

  imageFromCamera() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.camera);

    if (image != null) {
      profilePicture.value = File(image.path);
    }
  }

  updateUser() async {
    loading.value = true;
    (await _editUserInfoUseCase.execute(EditUserRequest(
            bioController.text,
            specialtyController.text,
            mobileController.text,
            userModel.qualification,
            profilePicture.value)))
        .fold((l) {}, (r) {
      userProfileModel.bio = bioController.text;
      userProfileModel.phone_number = mobileController.text;
      userProfileModel.field_of_study = specialtyController.text;
      userProfileModel.qualification = userModel.qualification;
      if(profilePicture.value.path.isNotEmpty){
        userProfileModel.image_url = profilePicture.value.path;
      }
      Get.find<ProfileController>().userModel.refresh();
      _appPreferences.setUserToCache(userProfileModel);
      Get.back();
    });
    loading.value = false;
  }

  @override
  void onInit() {
    userModel = Get.arguments;
    bioController.text = userModel.bio;
    mobileController.text = userModel.phone_number;
    specialtyController.text = userModel.field_of_study;
    super.onInit();
  }
}
