import 'package:afaq_alnour_academy/adaptive_widget/adabtive_filed.dart';
import 'package:afaq_alnour_academy/adaptive_widget/adabtive_indecator.dart';
import 'package:afaq_alnour_academy/bloc/register_bloc/register_cubit.dart';
import 'package:afaq_alnour_academy/bloc/register_bloc/register_state.dart';
import 'package:afaq_alnour_academy/constant/const.dart';
import 'package:afaq_alnour_academy/generated/l10n.dart';
import 'package:afaq_alnour_academy/widget/toast.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class RegisterParent extends StatelessWidget {
  RegisterParent({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController buildController = TextEditingController();
  TextEditingController postCodeController = TextEditingController();
  TextEditingController emergencyMobileController = TextEditingController();
  TextEditingController emergencyNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterParentSuccessRegisterState) {
            Navigator.pop(context);
            toast(msg: "Check your email", color: Colors.green);
          }
        },
        builder: (context, state) {
          var get = RegisterCubit.get(context);
          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: width * 0.4,
                          child: AdabtiveTextFormFiled(
                            context,
                            prefixicon: Icons.person,
                            os: getOS(),
                            label: S.of(context).first_name,
                            controller: nameController,
                            hint: [],
                            action: TextInputAction.next,
                            ispassword: false,
                            type: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return S.of(context).val;
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: width * 0.4,
                          child: AdabtiveTextFormFiled(
                            context,
                            prefixicon: Icons.person,
                            os: getOS(),
                            label: S.of(context).last_name,
                            controller: lastNameController,
                            hint: [],
                            action: TextInputAction.next,
                            ispassword: false,
                            type: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return S.of(context).val;
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: height * 0.06,
                          width: width * 0.4,
                          margin: const EdgeInsets.only(top: 14, left: 14),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: HexColor('#7871aa'), width: 2),
                              borderRadius: BorderRadius.circular(12)),
                          child: CountryCodePicker(
                            padding: const EdgeInsets.only(right: 18, left: 18),
                            initialSelection: "+963",
                            hideSearch: true,
                            dialogBackgroundColor: HexColor('#7871aa'),
                            showDropDownButton: true,
                            favorite: const ["+966", "+44", "+963"],
                            showCountryOnly: false,
                            hideMainText: true,
                            showOnlyCountryWhenClosed: true,
                            onChanged: (country) {
                              get.countryCode = country.dialCode!.substring(1);
                            },
                          ),
                        ),
                        SizedBox(
                          width: width * 0.42,
                          child: AdabtiveTextFormFiled(
                            context,
                            prefixicon: Icons.call,
                            os: getOS(),
                            label: S.of(context).phone,
                            controller: mobileController,
                            hint: [],
                            action: TextInputAction.next,
                            ispassword: false,
                            type: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return S.of(context).val;
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    AdabtiveTextFormFiled(
                      context,
                      prefixicon: Icons.email_outlined,
                      os: getOS(),
                      label: S.of(context).email,
                      controller: emailController,
                      hint: [],
                      action: TextInputAction.next,
                      ispassword: false,
                      type: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return S.of(context).val;
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    AdabtiveTextFormFiled(
                      context,
                      prefixicon: Icons.lock,
                      os: getOS(),
                      label: S.of(context).password,
                      controller: passwordController,
                      hint: [],
                      action: TextInputAction.next,
                      ispassword: get.password,
                      suffixIcon: get.password
                          ? Icons.visibility
                          : Icons.visibility_off,
                      onSuffixPressid: () {
                        get.onPassword();
                      },
                      type: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return S.of(context).val;
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    AdabtiveTextFormFiled(
                      context,
                      prefixicon: Icons.home,
                      os: getOS(),
                      label: S.of(context).country,
                      controller: countryController,
                      hint: [],
                      action: TextInputAction.next,
                      ispassword: false,
                      type: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return S.of(context).val;
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    AdabtiveTextFormFiled(
                      context,
                      prefixicon: Icons.business,
                      os: getOS(),
                      label: S.of(context).city,
                      controller: cityController,
                      hint: [],
                      action: TextInputAction.next,
                      ispassword: false,
                      type: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return S.of(context).val;
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    AdabtiveTextFormFiled(
                      context,
                      prefixicon: Icons.streetview,
                      os: getOS(),
                      label: S.of(context).street,
                      controller: streetController,
                      hint: [],
                      action: TextInputAction.next,
                      ispassword: false,
                      type: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return S.of(context).val;
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: width * 0.42,
                          child: AdabtiveTextFormFiled(
                            context,
                            prefixicon: Icons.account_balance_sharp,
                            os: getOS(),
                            label: S.of(context).building_number,
                            controller: buildController,
                            hint: [],
                            action: TextInputAction.next,
                            ispassword: false,
                            type: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return S.of(context).val;
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: width * 0.4,
                          child: AdabtiveTextFormFiled(
                            context,
                            prefixicon: Icons.storage_rounded,
                            os: getOS(),
                            label: "Post code",
                            controller: postCodeController,
                            hint: [],
                            action: TextInputAction.next,
                            ispassword: false,
                            type: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return S.of(context).val;
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    AdabtiveTextFormFiled(
                      context,
                      prefixicon: Icons.person,
                      os: getOS(),
                      label: S.of(context).emergency_name,
                      controller: emergencyNameController,
                      hint: [],
                      action: TextInputAction.next,
                      ispassword: false,
                      type: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return S.of(context).val;
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: height * 0.06,
                          width: width * 0.4,
                          margin: const EdgeInsets.only(top: 14, left: 14),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: HexColor('#7871aa'), width: 2),
                              borderRadius: BorderRadius.circular(12)),
                          child: CountryCodePicker(
                            padding: const EdgeInsets.only(right: 18, left: 18),
                            initialSelection: "+963",
                            hideSearch: true,
                            dialogBackgroundColor: HexColor('#7871aa'),
                            showDropDownButton: true,
                            favorite: const ["+966", "+44", "+963"],
                            showCountryOnly: false,
                            hideMainText: true,
                            showOnlyCountryWhenClosed: true,
                            onChanged: (country) {
                              get.countryCode2 = country.dialCode!.substring(1);
                            },
                          ),
                        ),
                        SizedBox(
                          width: width * 0.42,
                          child: AdabtiveTextFormFiled(
                            context,
                            prefixicon: Icons.call,
                            os: getOS(),
                            label: S.of(context).emergency_mobile,
                            controller: emergencyMobileController,
                            hint: [],
                            action: TextInputAction.done,
                            ispassword: false,
                            type: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return S.of(context).val;
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    state is! RegisterChildLoadingRegisterState
                        ? Container(
                            width: width * 0.9,
                            height: height * 0.06,
                            decoration: BoxDecoration(
                                color: HexColor('#c0e1f4'),
                                borderRadius: BorderRadius.circular(10)),
                            child: MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  get.RegisterParent(
                                      first_name: nameController.text,
                                      last_name: lastNameController.text,
                                      phone_number: mobileController.text,
                                      email: emailController.text,
                                      country: countryController.text,
                                      city: cityController.text,
                                      street: streetController.text,
                                      building_number: buildController.text,
                                      password: passwordController.text,
                                      postCode: postCodeController.text,
                                      emergency_phone_number:
                                          emergencyMobileController.text,
                                      emergency_relationship:
                                          emergencyNameController.text);
                                }
                              },
                              child: Text(
                                S.of(context).register_course,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                          )
                        : Center(
                            child: AdabtiveIndecator(os: getOS()),
                          ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
