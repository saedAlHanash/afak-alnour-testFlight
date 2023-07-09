
import 'package:get/get.dart';

import '../../../../../app/app_pref.dart';
import '../../../../../app/constants.dart';
import '../../../../../app/di.dart';
import '../../../../../app/function.dart';
import '../../../../../app_controller.dart';
import '../../../../../domain/models/user_model.dart';
import '../../../../resources/local_service.dart';

class ProfileController extends GetxController {
  final AppPreferences appPreferences = instance<AppPreferences>();
  Rx<UserModel> userModel = UserModel(
          Constants.zero,
          Constants.empty,
          Constants.empty,
          Constants.empty,
          Constants.empty,
          Constants.empty,
          Constants.empty,
          Constants.empty,
          Constants.empty,
          Constants.empty,
          Constants.empty,
          Constants.empty,
          Constants.empty,
          Constants.empty,
          Constants.empty,
          Constants.empty)
      .obs;
  late RxString language;

  void changeLang(String value) {
    language.value = value;
    LocalizationService.changeLocale(value);
  }

  @override
  void onInit() {
    userModel.value = appPreferences.getUserFromCache();
    if (Get.find<AppController>().lang.value == englishLocale) {
      language = 'en'.obs;
    } else {
      language = 'ar'.obs;
    }
    super.onInit();
  }
}
