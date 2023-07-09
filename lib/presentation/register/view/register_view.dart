import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:get/get.dart';

import '../../../app/function.dart';
import '../../resources/assets_manger.dart';
import '../../resources/color_manger.dart';
import '../../resources/string_manger.dart';
import '../../resources/values_manger.dart';
import '../../widget/custom_text_filed.dart';
import '../view_model/register_controller.dart';

class RegisterScreen extends GetView<RegisterController> {
  final _formKey = GlobalKey<FormState>();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.arrow_back_ios_outlined,color: ColorManger.purple,)),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.1,
                ),
                Center(
                  child: Obx(() => Stack(
                        children: [
                          Container(
                            width: AppSize.s175,
                            height: AppSize.s175,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(AppSize.s100),
                              child:
                                  controller.profilePicture.value.path.isEmpty
                                      ? Image.asset(
                                          ImageAssets.profilePicture,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.file(
                                          controller.profilePicture.value,
                                          fit: BoxFit.cover,
                                        ),
                            ),
                          ),
                          Positioned(
                            left: width * 0.3,
                            top: height * 0.15,
                            child: IconButton(
                              onPressed: () {
                                _showImagePicker(context);
                              },
                              icon: const Icon(
                                Icons.add_a_photo,
                                size: AppSize.s35,
                              ),
                              color: ColorManger.darkPrimary,
                            ),
                          ),
                        ],
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: width * 0.4,
                      child: Padding(
                        padding: const EdgeInsets.only(top: AppPadding.p20),
                        child: CustomTextFiled(
                          validator: (String? value) {
                            if (validate(value!)) return AppStrings.valid.tr;
                            return null;
                          },
                          controller: controller.firstNameController,
                          label: AppStrings.firstName.tr,
                          action: TextInputAction.next,
                          onChanged: (String? value) {
                            controller.setFirstName(value!);
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4,
                      child: Padding(
                        padding: const EdgeInsets.only(top: AppPadding.p20),
                        child: CustomTextFiled(
                          controller: controller.lastNameController,
                          validator: (String? value) {
                            if (validate(value!)) return AppStrings.valid.tr;
                            return null;
                          },
                          label: AppStrings.lastName.tr,
                          action: TextInputAction.next,
                          onChanged: (String? value) {
                            controller.setLastName(value!);
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: height * 0.06,
                      width: Get.width * 0.4,
                      margin: const EdgeInsets.only(
                          top: AppPadding.p14, left: AppPadding.p18),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: ColorManger.primary, width: AppSize.s2),
                          borderRadius: BorderRadius.circular(AppSize.s12)),
                      child: CountryCodePicker(
                        padding: const EdgeInsets.only(
                            right: AppPadding.p18, left: AppPadding.p18),
                        initialSelection: "+963",
                        hideSearch: true,
                        dialogBackgroundColor: ColorManger.purple,
                        showDropDownButton: true,
                        favorite: const ["+966", "+44", "+963"],
                        showCountryOnly: false,
                        hideMainText: true,
                        showOnlyCountryWhenClosed: true,
                        onChanged: (country) {
                          controller.countryCode =
                              country.dialCode!.substring(1);
                        },
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.55,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: AppPadding.p14,
                            right: AppPadding.p18,
                            left: AppPadding.p14),
                        child: CustomTextFiled(
                          label: AppStrings.mobileNumber.tr,
                          controller: controller.mobileNumberController,
                          validator: (String? value) {
                            if (validate(value!)) return AppStrings.valid.tr;
                            return null;
                          },
                          action: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          onChanged: (String? value) {
                            controller.setMobileNumber(value!);
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: AppPadding.p14,
                      right: AppPadding.p18,
                      left: AppPadding.p18),
                  child: CustomTextFiled(
                    label: AppStrings.email.tr,
                    keyboardType: TextInputType.emailAddress,
                    action: TextInputAction.next,
                    controller: controller.emailController,
                    validator: (String? value) {
                      if (validate(value!)) return AppStrings.valid.tr;
                      return null;
                    },
                    onChanged: (String? value) {
                      controller.setEmail(value!);
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: AppPadding.p14, left: AppPadding.p18),
                  child: Text(
                    AppStrings.gender.tr,
                    style: Theme.of(context).textTheme.titleLarge,
                    textScaleFactor: 1,
                  ),
                ),
                StatefulBuilder(
                  builder: (context, setState) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Radio(
                              value: AppStrings.male.tr,
                              groupValue: controller.registerObject.gender,
                              onChanged: (dynamic value) {
                                setState(() {
                                  controller.setGender(value);
                                });
                              },
                              activeColor: ColorManger.purple),
                          Text(
                            AppStrings.male.tr,
                            style: Theme.of(context).textTheme.titleMedium,
                            textScaleFactor: 1,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                              value: AppStrings.female.tr,
                              groupValue: controller.registerObject.gender,
                              onChanged: (dynamic value) {
                                setState(() {
                                  controller.setGender(value);
                                });
                              },
                              activeColor: ColorManger.purple),
                          Text(
                            AppStrings.female.tr,
                            style: Theme.of(context).textTheme.titleMedium,
                            textScaleFactor: 1,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      AppStrings.nationality.tr,
                      style: Theme.of(context).textTheme.titleLarge,
                      textScaleFactor: 1,
                    ),
                    Container(
                      height: height * 0.06,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: ColorManger.primary, width: AppSize.s2),
                          borderRadius: BorderRadius.circular(AppSize.s12)),
                      child: CountryCodePicker(
                        padding: const EdgeInsets.only(
                            right: AppPadding.p18, left: AppPadding.p18),
                        initialSelection: "+963",
                        hideSearch: true,
                        dialogBackgroundColor: ColorManger.purple,
                        showDropDownButton: true,
                        favorite: const ["+966", "+44", "+963"],
                        showCountryOnly: true,
                        hideMainText: false,
                        showOnlyCountryWhenClosed: true,
                        onChanged: (country) {
                          controller.setNationality(country.name!);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      AppStrings.place.tr,
                      style: Theme.of(context).textTheme.titleLarge,
                      textScaleFactor: 1,
                    ),
                    Container(
                      height: height * 0.06,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: ColorManger.primary, width: AppSize.s2),
                          borderRadius: BorderRadius.circular(AppSize.s12)),
                      child: CountryCodePicker(
                        padding: const EdgeInsets.only(
                            right: AppPadding.p18, left: AppPadding.p18),
                        initialSelection: "+963",
                        dialogBackgroundColor: ColorManger.purple,
                        showDropDownButton: true,
                        hideSearch: true,
                        favorite: const ["+966", "+44", "+963"],
                        showCountryOnly: true,
                        hideMainText: false,
                        showOnlyCountryWhenClosed: true,
                        onChanged: (country) {
                          controller.setResidency(country.name!);
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: AppPadding.p14,
                      right: AppPadding.p18,
                      left: AppPadding.p18),
                  child: CustomTextFiled(
                    controller: controller.qualificationController,
                    label: AppStrings.qualification.tr,
                    readOnly: true,
                    keyboardType: TextInputType.none,
                    validator: (String? value) {
                      if (validate(value!)) return AppStrings.valid.tr;
                      return null;
                    },
                    onTap: () {
                      _qualificationSheet(context,
                          height: height, data: controller.qualification);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: AppPadding.p14,
                      right: AppPadding.p18,
                      left: AppPadding.p18),
                  child: CustomTextFiled(
                    controller: controller.specialityController,
                    label: AppStrings.specialty.tr,
                    action: TextInputAction.next,
                    validator: (String? value) {
                      if (validate(value!)) return AppStrings.valid.tr;
                      return null;
                    },
                    onChanged: (String? value) {
                      controller.setSpeciality(value!);
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: AppPadding.p14,
                      right: AppPadding.p18,
                      left: AppPadding.p18),
                  child: CustomTextFiled(
                    label: AppStrings.experience.tr,
                    controller: controller.yearExperienceController,
                    keyboardType: TextInputType.number,
                    action: TextInputAction.next,
                    onChanged: (String? value) {
                      controller.setYearExperience(value!);
                      return null;
                    },
                    validator: (String? value) {
                      if (validate(value!)) return AppStrings.valid.tr;
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: AppPadding.p14,
                      right: AppPadding.p18,
                      left: AppPadding.p18),
                  child: CustomTextFiled(
                    controller: controller.languageController,
                    keyboardType: TextInputType.none,
                    label: AppStrings.englishLevel.tr,
                    validator: (String? value) {
                      if (validate(value!)) return AppStrings.valid.tr;
                      return null;
                    },
                    onTap: () {
                      _languageSheet(context,
                          height: height, data: controller.language);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: AppPadding.p14,
                      right: AppPadding.p18,
                      left: AppPadding.p18),
                  child: CustomTextFiled(
                    controller: controller.onlineProgramController,
                    keyboardType: TextInputType.none,
                    label: AppStrings.onlinePrograms.tr,
                    validator: (String? value) {
                      if (validate(value!)) return AppStrings.valid.tr;
                      return null;
                    },
                    onTap: () {
                      _checkBoxSheet(context, height: height, width: width);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: AppPadding.p14,
                      right: AppPadding.p18,
                      left: AppPadding.p18),
                  child: CustomTextFiled(
                    controller: controller.appointmentController,
                    keyboardType: TextInputType.none,
                    label: AppStrings.appointment.tr,
                    validator: (String? value) {
                      if (validate(value!)) return AppStrings.valid.tr;
                      return null;
                    },
                    onTap: () {
                      _appointment(context,
                          height: height, data: controller.appointment);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: AppPadding.p14,
                      right: AppPadding.p18,
                      left: AppPadding.p18),
                  child: CustomTextFiled(
                    controller: controller.cvController,
                    keyboardType: TextInputType.none,
                    label: AppStrings.cv.tr,
                    validator: (String? value) {
                      if (validate(value!)) return AppStrings.valid.tr;
                      return null;
                    },
                    onTap: () async {
                      await controller.pickCvFile();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: AppPadding.p14,
                      right: AppPadding.p18,
                      left: AppPadding.p18),
                  child: CustomTextFiled(
                    controller: controller.otherFileController,
                    keyboardType: TextInputType.none,
                    label: AppStrings.otherFile.tr,
                    onTap: () async {
                      await controller.pickOtherFile();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: AppPadding.p14,
                      right: AppPadding.p18,
                      left: AppPadding.p18),
                  child: Center(child: dropDownSubjectItems(context)),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p18),
                  child: SizedBox(
                    width: width,
                    height: height * 0.06,
                    child: ElevatedButton(
                        onPressed: () {
                          if (controller
                              .registerObject.profilePicture.path.isEmpty) {
                            Get.snackbar(
                                'Error :', 'profile picture is required',
                                snackPosition: SnackPosition.BOTTOM);
                          } else {
                            if (_formKey.currentState!.validate() &&
                                !controller.isAllDataValidate()) {
                              Get.snackbar('Error :', 'All data required',
                                  snackPosition: SnackPosition.BOTTOM);
                            } else {
                              controller.register();
                            }
                          }
                        },
                        child: Text(AppStrings.register.tr)),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      AppStrings.alreadyHaveAccount.tr,
                      style: Theme.of(context).textTheme.displayLarge,
                      textScaleFactor: 1,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _languageSheet(context,
      {required double height, required List<String> data}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => SafeArea(
              child: Container(
            height: height * 0.33,
            padding: const EdgeInsets.only(top: AppPadding.p14),
            child: ListView.separated(
              itemBuilder: (context, index) => RadioListTile(
                value: data[index],
                groupValue: controller.registerObject.language,
                onChanged: (dynamic value) {
                  setState(() {
                    controller.setLanguage(value);
                  });
                  Get.back();
                },
                title: Text(
                  data[index],
                  style: Theme.of(context).textTheme.titleLarge,
                  textScaleFactor: 1,
                ),
                activeColor: ColorManger.purple,
                toggleable: true,
              ),
              separatorBuilder: (context, index) => const SizedBox(
                height: AppSize.s12,
              ),
              itemCount: data.length,
            ),
          )),
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(AppSize.s12),
            topLeft: Radius.circular(AppSize.s12)),
      ),
    ).whenComplete(() {
      controller.languageController.text = controller.registerObject.language;
    });
  }

  _qualificationSheet(context,
      {required double height, required List<String> data}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => SafeArea(
              child: Container(
            height: height * 0.33,
            padding: const EdgeInsets.only(top: AppPadding.p14),
            child: ListView.separated(
              itemBuilder: (context, index) => RadioListTile(
                value: data[index],
                groupValue: controller.registerObject.qualification,
                onChanged: (dynamic value) {
                  setState(() {
                    controller.setQualification(value);
                  });
                  Get.back();
                },
                title: Text(
                  data[index],
                  style: Theme.of(context).textTheme.titleLarge,
                  textScaleFactor: 1,
                ),
                activeColor: ColorManger.purple,
                toggleable: true,
              ),
              separatorBuilder: (context, index) => const SizedBox(
                height: AppSize.s12,
              ),
              itemCount: data.length,
            ),
          )),
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(AppSize.s12),
            topLeft: Radius.circular(AppSize.s12)),
      ),
    ).whenComplete(() {
      controller.qualificationController.text =
          controller.registerObject.qualification;
    });
  }

  _appointment(context, {required double height, required List<String> data}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => SafeArea(
              child: Container(
            height: height * 0.33,
            padding: const EdgeInsets.only(top: AppPadding.p14),
            child: ListView.separated(
              itemBuilder: (context, index) => RadioListTile(
                value: data[index],
                groupValue: controller.registerObject.appointment,
                onChanged: (dynamic value) {
                  setState(() {
                    controller.setAppointment(value);
                  });
                  Get.back();
                },
                title: Text(
                  data[index],
                  style: Theme.of(context).textTheme.titleLarge,
                  textScaleFactor: 1,
                ),
                activeColor: ColorManger.purple,
                toggleable: true,
              ),
              separatorBuilder: (context, index) => const SizedBox(
                height: AppSize.s12,
              ),
              itemCount: data.length,
            ),
          )),
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(AppSize.s12),
            topLeft: Radius.circular(AppSize.s12)),
      ),
    ).whenComplete(() {
      controller.appointmentController.text =
          controller.registerObject.appointment;
    });
  }

  _checkBoxSheet(context, {required double height, required double width}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => SafeArea(
              child: Container(
            height: height * 0.33,
            padding: const EdgeInsets.only(top: AppPadding.p14),
            child: Column(
              children: [
                CheckboxListTile(
                  value: controller.allPrograms.value,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (value) {
                    setState(() {
                      controller.allPrograms.value = value;
                      controller.setOnlineProgram(controller.allPrograms.title,
                          controller.allPrograms.title,
                          value: value);
                      for (var element in controller.checkBoxItems) {
                        element.value = value;
                      }
                    });
                    Get.back();
                  },
                  activeColor: ColorManger.purple,
                  title: Text(
                    controller.allPrograms.title,
                    style: Theme.of(context).textTheme.titleLarge,
                    textScaleFactor: 1,
                  ),
                ),
                Divider(
                  height: AppSize.s2,
                  color: ColorManger.grey,
                  indent: width * 0.05,
                  endIndent: width * 0.2,
                ),
                SizedBox(
                  height: height * 0.24,
                  child: ListView.builder(
                    itemBuilder: (context, index) => CheckboxListTile(
                      value: controller.checkBoxItems[index].value,
                      onChanged: (value) {
                        setState(() {
                          controller.checkBoxItems[index].value = value;
                          controller.allPrograms.value = controller
                              .checkBoxItems
                              .every((element) => element.value!);
                          if (controller.allPrograms.value!) {
                            controller.setOnlineProgram(
                                controller.allPrograms.title,
                                controller.allPrograms.title);
                          } else {
                            controller.setOnlineProgram(
                                controller.checkBoxItems[index].apiName,
                                controller.checkBoxItems[index].title);
                          }
                        });
                        Get.back();
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: ColorManger.purple,
                      title: Text(
                        controller.checkBoxItems[index].title,
                        style: Theme.of(context).textTheme.titleLarge,
                        textScaleFactor: 1,
                      ),
                    ),
                    itemCount: controller.checkBoxItems.length,
                  ),
                ),
              ],
            ),
          )),
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(AppSize.s12),
            topLeft: Radius.circular(AppSize.s12)),
      ),
    ).whenComplete(() {
      controller.onlineProgramController.text =
          controller.registerObject.programs;
    });
  }

  _showImagePicker(context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(AppSize.s12),
              topLeft: Radius.circular(AppSize.s12)),
        ),
        builder: (context) {
          return SafeArea(
              child: Wrap(
            children: [
              ListTile(
                trailing: const Icon(Icons.arrow_forward_ios_outlined),
                leading: Icon(
                  Icons.image,
                  color: ColorManger.purple,
                ),
                title: Text(
                  AppStrings.photoGallery.tr,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                onTap: () {
                  controller.imageFromGallery();
                  Get.back();
                },
              ),
              ListTile(
                trailing: const Icon(Icons.arrow_forward_ios_outlined),
                leading: Icon(
                  Icons.camera_alt_outlined,
                  color: ColorManger.purple,
                ),
                title: Text(AppStrings.photoCamera.tr,
                    style: Theme.of(context).textTheme.titleLarge),
                onTap: () {
                  controller.imageFromCamera();
                },
              ),
            ],
          ));
        });
  }

  Widget dropDownSubjectItems(context) {
    return StatefulBuilder(
      builder: (context, setState) => DropdownButtonFormField(
        items: controller.dropDownItems
            .map((item) => DropdownMenuItem(
                  value: item.value,
                  child: Text(
                    item.title,
                    style: Theme.of(context).textTheme.displayLarge,
                    textScaleFactor: 1,
                  ),
                ))
            .toList(),
        onChanged: (dynamic value) {
          setState(() {
            controller.setSubject(value);
          });
        },
        isExpanded: true,
        iconEnabledColor: ColorManger.purple,
        iconDisabledColor: ColorManger.purple,
        value: controller.registerObject.subject,
        borderRadius: BorderRadius.circular(AppSize.s12),
        dropdownColor: ColorManger.white,
        style: Theme.of(context).textTheme.titleLarge,
        hint: Text(
          'Subjects',
          style: Theme.of(context).textTheme.titleLarge,
          textScaleFactor: 1,
        ),
        disabledHint: Text(
          'Subjects',
          style: Theme.of(context).textTheme.titleLarge,
          textScaleFactor: 1,
        ),
      ),
    );
  }
}
