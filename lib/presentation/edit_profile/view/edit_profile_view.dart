
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:get/get.dart';

import '../../resources/color_manger.dart';
import '../../resources/string_manger.dart';
import '../../resources/values_manger.dart';
import '../../widget/app_image.dart';
import '../../widget/custom_text_filed.dart';
import '../view_model/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.editProfile.tr, textScaleFactor: 1),
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios_outlined,color: ColorManger.purple,)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.05,
            ),
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Obx(
                  () => Container(
                    width: AppSize.s175,
                    height: AppSize.s175,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: ColorManger.primary, width: AppSize.s1)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppSize.s100),
                      child: controller.profilePicture.value.path.isEmpty
                          ? AppImage(
                              imageUrl: controller.userModel.image_url,
                              boxFit: BoxFit.cover)
                          : Image.file(controller.profilePicture.value,
                              fit: BoxFit.cover),
                    ),
                  ),
                ),
                Positioned(
                    top: height * 0.17,
                    left: width * 0.33,
                    child: InkWell(
                      onTap: () => _showImagePicker(context),
                      child: Icon(
                        Icons.add_a_photo,
                        color: ColorManger.darkPrimary,
                        size: AppSize.s35,
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Center(
              child: Text(
                '${controller.userModel.forename} ${controller.userModel.surname} ',
                style: Theme.of(context).textTheme.displayLarge,
                textScaleFactor: 1,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: height * 0.05),
              child: Column(
                children: [
                  CustomTextFiled(
                    label: AppStrings.bio.tr,
                    action: TextInputAction.next,
                    controller: controller.bioController,
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  CustomTextFiled(
                    label: AppStrings.mobileNumber.tr,
                    action: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    controller: controller.mobileController,
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  CustomTextFiled(
                    label: AppStrings.specialty.tr,
                    action: TextInputAction.next,
                    controller: controller.specialtyController,
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  DropdownButtonFormField(
                    items: controller.dropDownItems
                        .map(
                          (e) => DropdownMenuItem(
                              value: e.value,
                              child: Text(
                                e.title,
                                style: Theme.of(context).textTheme.displayLarge,
                              )),
                        )
                        .toList(),
                    onChanged: (dynamic value) {
                      controller.userModel.qualification = value.toString();
                    },
                    iconDisabledColor: ColorManger.purple,
                    iconEnabledColor: ColorManger.purple,
                    value: controller.userModel.qualification,
                    decoration:
                        InputDecoration(labelText: AppStrings.qualification.tr),
                  )
                ],
              ),
            ),
            Obx(
              () => controller.loading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox(
                      height: height * 0.06,
                      width: width * 0.9,
                      child: ElevatedButton(
                          onPressed: () {
                            controller.updateUser();
                          },
                          child: Text(AppStrings.save.tr))),
            )
          ],
        ),
      ),
    );
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
                  Get.back();
                },
              ),
            ],
          ));
        });
  }
}
