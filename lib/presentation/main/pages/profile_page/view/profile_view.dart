
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resources/assets_manger.dart';
import '../../../../resources/color_manger.dart';
import '../../../../resources/routes_manger.dart';
import '../../../../resources/string_manger.dart';
import '../../../../resources/values_manger.dart';
import '../../../../widget/app_image.dart';
import '../view_model/profile_controller.dart';
import '../widget/sections_widget.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                height: height * 0.14,
                width: width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(ImageAssets.profileCover),
                        fit: BoxFit.fitWidth)),
              ),
              Obx(
                ()=> Positioned(
                  top: height * 0.08,
                  child: Container(
                    width: AppSize.s175,
                    height: AppSize.s175,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: ColorManger.primary, width: AppSize.s1)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppSize.s100),
                      child: AppImage(
                          imageUrl: controller.userModel.value.image_url,
                          boxFit: BoxFit.cover),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: height * 0.17,
          ),
          Center(
            child: Text(
              '${controller.userModel.value.forename} ${controller.userModel.value.surname} ',
              style: Theme.of(context).textTheme.displayLarge,
              textScaleFactor: 1,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.bio.tr,
                  style: Theme.of(context).textTheme.titleLarge,
                  textScaleFactor: 1,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Obx(
                  ()=> Text(
                    controller.userModel.value.bio,
                    style: Theme.of(context).textTheme.titleLarge,
                    textScaleFactor: 1,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                InkWell(
                  onTap: () => Get.toNamed(Routes.editProfileRoute,
                      arguments: controller.userModel.value),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: SectionWidget(
                    AppStrings.editProfile.tr,
                    Icons.edit,
                  ),
                ),
                Obx(
                  () => ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    iconColor: ColorManger.purple,
                    trailing: const Icon(Icons.arrow_forward_ios_outlined),
                    collapsedIconColor: ColorManger.purple,
                    // title: Border.all(
                    //     color: Theme.of(context).scaffoldBackgroundColor),
                    title: Row(
                      children: [
                        Container(
                            width: AppSize.s35,
                            height: AppSize.s35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s14),
                              color: ColorManger.purple,
                            ),
                            child: Icon(
                              Icons.language,
                              color: ColorManger.primary,
                            )),
                        const SizedBox(
                          width: AppSize.s18,
                        ),
                        Text(
                          AppStrings.lang.tr,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    children: [
                      RadioListTile(
                        value: 'ar',
                        groupValue: controller.language.value,
                        onChanged: (value) {
                          controller.changeLang(value.toString());
                        },
                        title: Text(
                          AppStrings.arabicLang.tr,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        activeColor: ColorManger.purple,
                      ),
                      RadioListTile(
                        value: 'en',
                        groupValue: controller.language.value,
                        onChanged: (value) {
                          controller.changeLang(value.toString());
                        },
                        title: Text(
                          AppStrings.englishLang.tr,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        activeColor: ColorManger.purple,
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: ColorManger.primary,
                  thickness: AppSize.s2,
                ),
                InkWell(
                  onTap: () => Get.toNamed(Routes.aboutUsRoute),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: SectionWidget(AppStrings.info.tr, Icons.info_outline),
                ),
                InkWell(
                  onTap: () {
                    controller.appPreferences.logOut();
                    Get.offAllNamed(Routes.loginRoute);
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: SectionWidget(AppStrings.logout.tr, Icons.logout),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
