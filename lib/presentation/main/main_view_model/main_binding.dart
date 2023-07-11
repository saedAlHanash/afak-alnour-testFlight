
import 'package:get/get.dart';

import '../pages/home_page/view_model/home_controller.dart';
import '../pages/profile_page/view_model/profile_controller.dart';
import '../pages/session/view_model/session_controller.dart';
import '../pages/set_my_available_page/view_model/set_my_available_controller.dart';
import 'main_controller.dart';

class MainBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(MainController());
    Get.put(HomeController());
    Get.put(ProfileController());
    Get.put(SetMyAvailabelController());
    Get.put(SessionController());
  }

}