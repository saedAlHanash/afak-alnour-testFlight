import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../resources/assets_manger.dart';
import '../../resources/color_manger.dart';
import '../../resources/font_manger.dart';
import '../../resources/routes_manger.dart';
import '../../resources/string_manger.dart';
import '../../resources/values_manger.dart';
import '../view_model/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  final _formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.2,
                ),
                Text(
                  AppStrings.welcome.tr,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: FontSize.s26),
                  textScaleFactor: 1,
                ),
                Text(
                  AppStrings.nameAcademy.tr,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: FontSize.s22),
                  textScaleFactor: 1,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Center(
                    child: Image.asset(
                  ImageAssets.login,
                  fit: BoxFit.cover,
                  width: 200,
                  height: 200,
                )),
                AutofillGroup(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: AppPadding.p14,
                        left: AppPadding.p18,
                        right: AppPadding.p18,
                      ),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        keyboardType: TextInputType.emailAddress,
                        style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontSize: FontSize.s15
                        ),
                        controller: controller.emailController,
                        validator: (String? value) {
                          if (value!.isEmpty) return AppStrings.valid.tr;
                          return null;
                        },
                        onChanged: (String value) {
                          controller.setEmail(value);
                        },
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.email],
                        decoration: InputDecoration(
                          labelText: AppStrings.email.tr,
                        ),
                      ),
                    ),
                    Obx(
                      ()=> Padding(
                        padding: const EdgeInsets.only(
                          top: AppPadding.p14,
                          left: AppPadding.p18,
                          right: AppPadding.p18,
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          style: Theme.of(context).textTheme.displayLarge!.copyWith(
                              fontSize: FontSize.s15
                          ),
                          validator: (String? value) {
                            if (value!.isEmpty) return AppStrings.valid.tr;
                            return null;
                          },
                          onChanged: (String value) {
                            controller.setPassword(value);
                          },
                          controller: controller.passwordController,
                          autofillHints: const [AutofillHints.password],
                          obscureText: controller.password.value,
                          decoration: InputDecoration(
                              suffixIcon: controller.password.value
                                  ? IconButton(
                                      onPressed: () => controller.password.value =
                                          !controller.password.value,
                                      splashColor: Colors.white.withOpacity(0.0001),
                                      icon: Icon(
                                        Icons.visibility_off,
                                        color: ColorManger.grey,
                                      ))
                                  : IconButton(
                                      onPressed: () => controller.password.value =
                                          !controller.password.value,
                                  splashColor: Colors.white.withOpacity(0.0001),
                                      icon: Icon(
                                        Icons.visibility,
                                        color: ColorManger.grey,
                                      )),
                              labelText: AppStrings.password.tr),
                        ),
                      ),
                    ),
                  ],
                )),
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  height: height * 0.06,
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p18),
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          controller.login();
                        }
                      },
                      child: Center(
                        child: Text(
                          AppStrings.login.tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: FontSize.s18),
                          textScaleFactor: 1,
                        ),
                      )),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.registerRoute);
                  },
                  child: Text(
                    AppStrings.registerText.tr,
                    style: Theme.of(context).textTheme.displayLarge,
                    textScaleFactor: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
