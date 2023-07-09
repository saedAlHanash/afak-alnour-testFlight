
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../app/app_pref.dart';
import '../../../app/constants.dart';
import '../../../app/di.dart';
import '../../../domain/usecase/firebase_token_useCase.dart';
import '../../../domain/usecase/login_usecase.dart';
import '../../common/freezed/freezed_data_classes.dart';
import '../../common/state_rendere/state_renderer.dart';
import '../../resources/routes_manger.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool password = true.obs;

  final LoginUseCase _useCase = instance<LoginUseCase>();
  final FireBaseTokenUseCase _fireBaseTokenUseCase =
      instance<FireBaseTokenUseCase>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  LoginObject loginObject = LoginObject(Constants.empty, Constants.empty);

  setEmail(String value) {
    if (value.isNotEmpty) {
      loginObject = loginObject.copyWith(email: value);
    } else {
      loginObject = loginObject.copyWith(email: Constants.empty);
    }
  }

  setPassword(String value) {
    if (value.isNotEmpty) {
      loginObject = loginObject.copyWith(password: value);
    } else {
      loginObject = loginObject.copyWith(password: Constants.empty);
    }
  }

  void login() async {
    getPopUpStateRenderer(PopUpStateRendererType.popupLoadingState);
    (await _useCase.execute(
            LoginUseCaseInputs(loginObject.email, loginObject.password)))
        .fold((l) {
      getPopUpStateRenderer(PopUpStateRendererType.popupErrorState,
          errorMessage: l.message);
    }, (r) async {
      await _appPreferences.setUserToken(r.token);
      await _appPreferences.setUserToCache(r.user!);
      _fireBaseTokenUseCase.execute(FireBaseTokenUseCaseInputs(
          _appPreferences.getFirebaseToken() ?? Constants.empty,
          '${Constants.bearer} ${_appPreferences.getUserToken() ?? Constants.empty}'));
      Get.offAllNamed(Routes.mainRoute);
    });
  }
}
