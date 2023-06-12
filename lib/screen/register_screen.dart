import 'package:afaq_alnour_academy/bloc/home_bloc/home_cubit.dart';
import 'package:afaq_alnour_academy/bloc/register_bloc/register_cubit.dart';
import 'package:afaq_alnour_academy/bloc/register_bloc/register_state.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';

import '../adaptive_widget/adabtive_filed.dart';
import '../adaptive_widget/adabtive_indecator.dart';

import '../constant/const.dart';
import '../generated/l10n.dart';
import '../widget/drop_down_button_widget.dart';
import '../widget/toast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var name1Controller = TextEditingController();
  var name2Controller = TextEditingController();
  var parentController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var countryController = TextEditingController();
  var cityController = TextEditingController();
  var streetController = TextEditingController();
  var buildingController = TextEditingController();
  var postCodeController = TextEditingController();
  var passwordController = TextEditingController();
  var relationshipController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  String selectedDay = '1';
  String selectedMounth = '1';
  String selectedYear = '2000';
  String _groupValue = 'male';

  @override
  void initState() {
    var get = HomeCubit.get(context);
    if (get.editMyChild != null) {
      name1Controller.text = get.editMyChild!.fore_name!;
      name2Controller.text = get.editMyChild!.sur_name!;
      parentController.text = get.editMyChild!.middle_name ?? '';
      phoneController.text = get.editMyChild!.phone_number!;
      emailController.text = get.editMyChild!.email!;
      countryController.text = get.editMyChild!.country!;
      cityController.text = get.editMyChild!.city!;
      streetController.text = get.editMyChild!.street!;
      buildingController.text = get.editMyChild!.building_number!;
      postCodeController.text = get.editMyChild!.post_code!;
      relationshipController.text = get.editMyChild!.guardian_relationship!;
      List<String> date = get.editMyChild!.date_of_birth!.split("-");
      selectedDay = date[2].startsWith("0") ? date[2].substring(1) : date[2];
      selectedMounth = date[1].startsWith("0") ? date[1].substring(1) : date[1];
      selectedYear = date[0];
      _groupValue = get.editMyChild!.gender!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> day = [];
    List<String> mounth = [];
    List<String> year = [];
    for (int i = 1; i <= 31; i++) {
      day.add('$i');
    }

    for (int i = 1; i <= 12; i++) {
      mounth.add('$i');
    }

    for (int i = 1990; i <= DateTime.now().toUtc().year; i++) {
      year.add('$i');
    }
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is EditChildSuccessRegisterState) {
          HomeCubit.get(context).getMyChildren();
          toast(msg: 'Student editing successfully.', color: Colors.green);
          Navigator.pop(context);
          HomeCubit.get(context).editMyChild = null;
        }
        if (state is RegisterChildSuccessRegisterState) {
          HomeCubit.get(context).getMyChildren();
          toast(msg: 'Student Register successfully.', color: Colors.green);
          toast(msg: 'Please check your email', color: Colors.green);
          Navigator.pop(context);
          HomeCubit.get(context).editMyChild = null;
        }
      },
      builder: (context, state) {
        var get = RegisterCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: AutoSizeText(HomeCubit.get(context).editMyChild != null
                ? S.of(context).edit
                : S.of(context).register),
            leading: IconButton(
                onPressed: () {
                  HomeCubit.get(context).editMyChild = null;
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_outlined)),
          ),
          body: WillPopScope(
            onWillPop: () {
              HomeCubit.get(context).editMyChild = null;
              return Future.value(true);
            },
            child: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: width * 0.4,
                                  child: AdabtiveTextFormFiled(
                                    context,
                                    hint: [],
                                    action: TextInputAction.next,
                                    os: getOS(),
                                    controller: name1Controller,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return S.of(context).val;
                                      }
                                      return null;
                                    },
                                    ispassword: false,
                                    type: TextInputType.name,
                                    label: S.of(context).first_name,
                                    prefixicon: Icons.person,
                                  ),
                                ),
                                Container(
                                  width: width * 0.4,
                                  child: AdabtiveTextFormFiled(
                                    context,
                                    hint: [],
                                    action: TextInputAction.next,
                                    os: getOS(),
                                    controller: parentController,
                                    validator: (value) {
                                      return null;
                                    },
                                    ispassword: false,
                                    type: TextInputType.name,
                                    label: S.of(context).middle_name,
                                    prefixicon: Icons.person,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Container(
                              width: width * 0.9,
                              child: AdabtiveTextFormFiled(
                                context,
                                hint: [],
                                action: TextInputAction.next,
                                os: getOS(),
                                controller: name2Controller,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return S.of(context).val;
                                  }
                                  return null;
                                },
                                ispassword: false,
                                type: TextInputType.name,
                                label: S.of(context).last_name,
                                prefixicon: Icons.person,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Container(
                              width: width * 0.9,
                              child: AdabtiveTextFormFiled(
                                context,
                                hint: [],
                                action: TextInputAction.next,
                                os: getOS(),
                                controller: relationshipController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return S.of(context).val;
                                  }
                                  return null;
                                },
                                ispassword: false,
                                type: TextInputType.name,
                                label: S.of(context).guardian_relationship,
                                prefixicon: Icons.person,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Text(
                              S.of(context).age,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                dropDownButton(context,
                                    width: width * 0.23,
                                    height: height * 0.08,
                                    validator: (value) {
                                      if (value == null) {
                                        return S.of(context).val;
                                      }
                                      return null;
                                    },
                                    value: selectedDay,
                                    hint: S.of(context).day,
                                    items: day,
                                    onchange: (item) {
                                      setState(() {
                                        selectedDay = item;
                                      });
                                    }),
                                dropDownButton(context,
                                    width: width * 0.23,
                                    height: height * 0.08,
                                    value: selectedMounth,
                                    hint: S.of(context).Month,
                                    validator: (value) {
                                      if (value == null) {
                                        return S.of(context).val;
                                      }
                                      return null;
                                    },
                                    items: mounth,
                                    onchange: (item) {
                                      setState(() {
                                        selectedMounth = item;
                                      });
                                    }),
                                dropDownButton(context,
                                    width: width * 0.23,
                                    height: height * 0.08,
                                    value: selectedYear,
                                    hint: S.of(context).year,
                                    validator: (value) {
                                      if (value == null) {
                                        return S.of(context).val;
                                      }
                                      return null;
                                    },
                                    items: year,
                                    onchange: (item) {
                                      setState(() {
                                        selectedYear = item;
                                      });
                                    }),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Text(
                              S.of(context).gender,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                        value: 'male',
                                        activeColor: Colors.black,
                                        groupValue: _groupValue,
                                        onChanged: (value) {
                                          setState(() {
                                            _groupValue = value.toString();
                                          });
                                        }),
                                    SizedBox(
                                      width: width * 0.03,
                                    ),
                                    Text(
                                      S.of(context).male,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                        value: 'female',
                                        activeColor: Colors.black,
                                        groupValue: _groupValue,
                                        onChanged: (value) {
                                          setState(() {
                                            _groupValue = value.toString();
                                          });
                                        }),
                                    SizedBox(
                                      width: width * 0.03,
                                    ),
                                    Text(
                                      S.of(context).female,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    )
                                  ],
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
                                  margin:
                                      const EdgeInsets.only(top: 14, left: 14),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: HexColor('#7871aa'), width: 2),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: CountryCodePicker(
                                    padding: const EdgeInsets.only(
                                        right: 18, left: 18),
                                    initialSelection: "+963",
                                    hideSearch: true,
                                    dialogBackgroundColor: HexColor('#7871aa'),
                                    showDropDownButton: true,
                                    favorite: const ["+966", "+44", "+963"],
                                    showCountryOnly: false,
                                    hideMainText: true,
                                    showOnlyCountryWhenClosed: true,
                                    onChanged: (country) {
                                      get.countryCode3 =
                                          country.dialCode!.substring(1);
                                    },
                                  ),
                                ),
                                Container(
                                  width: width * 0.42,
                                  child: AdabtiveTextFormFiled(
                                    context,
                                    hint: [],
                                    action: TextInputAction.next,
                                    os: getOS(),
                                    controller: phoneController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return S.of(context).val;
                                      }
                                      return null;
                                    },
                                    ispassword: false,
                                    type: TextInputType.number,
                                    label: S.of(context).phone,
                                    prefixicon: Icons.phone,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            CheckboxListTile(
                                value: get.sameAddress,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                title: Text(S.of(context).same_address,
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                    textScaleFactor: 1),
                                onChanged: (value) {
                                  get.changeSameAddress(value!);
                                  if(value){
                                    countryController.text = get.country ?? '';
                                    cityController.text = get.city ?? '';
                                    streetController.text = get.street ?? '';
                                    buildingController.text = get.building ?? '';
                                    postCodeController.text = get.post ?? '';
                                  }else{
                                    countryController.clear();
                                    cityController.clear();
                                    streetController.clear();
                                    buildingController.clear();
                                    postCodeController.clear();
                                  }
                                }),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Container(
                              width: width * 0.9,
                              child: AdabtiveTextFormFiled(
                                context,
                                hint: [],
                                action: TextInputAction.next,
                                os: getOS(),
                                controller: countryController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return S.of(context).val;
                                  }
                                  return null;
                                },
                                ispassword: false,
                                type: TextInputType.text,
                                label: S.of(context).country,
                                prefixicon: Icons.home,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Container(
                              width: width * 0.9,
                              child: AdabtiveTextFormFiled(
                                context,
                                hint: [],
                                action: TextInputAction.next,
                                os: getOS(),
                                controller: cityController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return S.of(context).val;
                                  }
                                  return null;
                                },
                                ispassword: false,
                                type: TextInputType.text,
                                label: S.of(context).city,
                                prefixicon: Icons.business,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Container(
                              width: width * 0.9,
                              child: AdabtiveTextFormFiled(
                                context,
                                hint: [],
                                action: TextInputAction.next,
                                os: getOS(),
                                controller: streetController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return S.of(context).val;
                                  }
                                  return null;
                                },
                                ispassword: false,
                                type: TextInputType.text,
                                label: S.of(context).street,
                                prefixicon: Icons.streetview,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: width * 0.5,
                                  child: AdabtiveTextFormFiled(
                                    context,
                                    hint: [],
                                    action: TextInputAction.next,
                                    os: getOS(),
                                    controller: buildingController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return S.of(context).val;
                                      }
                                      return null;
                                    },
                                    ispassword: false,
                                    type: TextInputType.number,
                                    label: S.of(context).building_number,
                                    prefixicon: Icons.account_balance_sharp,
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.03,
                                ),
                                Container(
                                  width: width * 0.37,
                                  child: AdabtiveTextFormFiled(
                                    context,
                                    hint: [],
                                    action: TextInputAction.done,
                                    os: getOS(),
                                    controller: postCodeController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return S.of(context).val;
                                      }
                                      return null;
                                    },
                                    ispassword: false,
                                    type: TextInputType.text,
                                    label: 'Post Code',
                                    prefixicon: Icons.storage_rounded,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                          ],
                        ),
                      ),
                    ),
                    HomeCubit.get(context).lang == 'ar'
                        ? Row(
                            children: [
                              AutoSizeText(
                                S.of(context).policy,
                                style: Theme.of(context).textTheme.headline3,
                                textScaleFactor: 1,
                                minFontSize: 12,
                                maxFontSize: 13,
                              ),
                              TextButton(
                                onPressed: () async {
                                  var url =
                                      'https://afaqalnour.com/app/ar/privacy-policy';
                                  if (await launchUrl(Uri.parse(url),
                                      mode: LaunchMode.inAppWebView)) {}
                                },
                                child: AutoSizeText(
                                  S.of(context).policy1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(color: Colors.blue),
                                  textScaleFactor: 1,
                                  minFontSize: 12,
                                  maxFontSize: 13,
                                ),
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.all(0))),
                              ),
                              AutoSizeText(
                                S.of(context).policy2,
                                style: Theme.of(context).textTheme.headline3,
                                textScaleFactor: 1,
                                minFontSize: 12,
                                maxFontSize: 13,
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              AutoSizeText(
                                S.of(context).policy,
                                style: Theme.of(context).textTheme.headline3,
                                textScaleFactor: 1,
                                minFontSize: 11,
                                maxFontSize: 12,
                              ),
                              TextButton(
                                onPressed: () async {
                                  var url =
                                      'https://afaqalnour.com/app/en/privacy-policy';
                                  if (await launchUrl(Uri.parse(url),
                                      mode: LaunchMode.inAppWebView)) {}
                                },
                                child: AutoSizeText(
                                  S.of(context).policy1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(color: Colors.blue),
                                  textScaleFactor: 1,
                                  minFontSize: 12,
                                  maxFontSize: 13,
                                ),
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.all(0)),
                                ),
                              ),
                            ],
                          ),
                    ConditionalBuilder(
                      condition: state is! RegisterChildLoadingRegisterState,
                      builder: (context) => Center(
                        child: Container(
                          width: width * 0.9,
                          height: height * 0.06,
                          decoration: BoxDecoration(
                              color: HexColor('#c0e1f4'),
                              borderRadius: BorderRadius.circular(10)),
                          child: MaterialButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                if (HomeCubit.get(context).editMyChild !=
                                    null) {
                                  get.editChild(
                                      first_name: name1Controller.text,
                                      last_name: name2Controller.text,
                                      guardian_name: parentController.text,
                                      gender: _groupValue,
                                      guardian_relationship:
                                          relationshipController.text,
                                      phone_number: phoneController.text,
                                      email: emailController.text,
                                      country: countryController.text,
                                      city: cityController.text,
                                      street: streetController.text,
                                      building_number: buildingController.text,
                                      password: passwordController.text,
                                      date_day: int.parse(selectedDay),
                                      date_month: int.parse(selectedMounth),
                                      postCode: postCodeController.text,
                                      date_year: int.parse(selectedYear),
                                      studentId: HomeCubit.get(context)
                                          .editMyChild!
                                          .id!);
                                } else {
                                  get.RegisterChild(
                                      first_name: name1Controller.text,
                                      last_name: name2Controller.text,
                                      guardian_name: parentController.text,
                                      gender: _groupValue,
                                      guardian_relationship:
                                          relationshipController.text,
                                      phone_number: phoneController.text,
                                      email: emailController.text,
                                      country: countryController.text,
                                      city: cityController.text,
                                      street: streetController.text,
                                      building_number: buildingController.text,
                                      password: passwordController.text,
                                      date_day: int.parse(selectedDay),
                                      date_month: int.parse(selectedMounth),
                                      postCode: postCodeController.text,
                                      date_year: int.parse(selectedYear));
                                }
                              }
                            },
                            child: Text(
                              HomeCubit.get(context).editMyChild != null
                                  ? S.of(context).save_edit
                                  : S.of(context).register_course,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                        ),
                      ),
                      fallback: (context) => Center(
                        child: AdabtiveIndecator(os: getOS()),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
