import 'dart:convert';

import 'package:afaq_alnour_academy/bloc/register_bloc/register_state.dart';
import 'package:afaq_alnour_academy/constant/const.dart';
import 'package:afaq_alnour_academy/data/local/cache_helper.dart';
import 'package:afaq_alnour_academy/model/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../widget/toast.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(InitialRegisterState());
  String countryCode = "963";
  String countryCode2 = "963";
  String countryCode3 = "963";
  bool sameAddress = false;
  String? country;
  String? city;
  String? street;
  String? building;
  String? post;

  changeSameAddress(bool value) {
    sameAddress = value;
    emit(ChangeAddress());
  }

  initUser() {
    if (CacheHelper.getData(key: "country") != null) {
      country = CacheHelper.getData(key: "country");
    }
    if (CacheHelper.getData(key: "city") != null) {
      city = CacheHelper.getData(key: "city");
    }
    if (CacheHelper.getData(key: "street") != null) {
      street = CacheHelper.getData(key: "street");
    }
    if (CacheHelper.getData(key: "building_number") != null) {
      building = CacheHelper.getData(key: "building_number");
    }
    if (CacheHelper.getData(key: "post_code") != null) {
      post = CacheHelper.getData(key: "post_code");
    }
  }

  static RegisterCubit get(context) => BlocProvider.of(context);
  List error = [];
  bool password = true;

  onPassword() {
    password = !password;
    emit(ChangePasswordState());
  }

  void RegisterChild({
    required String first_name,
    required String last_name,
    required String guardian_name,
    required String guardian_relationship,
    required String gender,
    required String phone_number,
    required String email,
    required String country,
    required String city,
    required String street,
    required String building_number,
    required String password,
    required int date_day,
    required int date_month,
    required int date_year,
    required String postCode,
  }) async {
    try {
      Map<String, dynamic> body = {
        'forename': first_name,
        'surname': last_name,
        'middlename': guardian_name,
        'guardian_relationship': guardian_relationship,
        'gender': gender,
        'phone_number': countryCode3 + phone_number,
        // 'email': email,
        'country': country,
        'city': city,
        'street': street,
        'building_number': building_number,
        // 'password': password,
        'date_day': date_day.toString(),
        'date_month': date_month.toString(),
        'date_year': date_year.toString(),
        'post_code': postCode,
      };
      emit(RegisterChildLoadingRegisterState());
      var response = await http
          .post(Uri.parse('${BaseUrl}students'), body: body, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${CacheHelper.getData(key: 'token_student')}'
      });

      if (response.statusCode == 200) {
        emit(RegisterChildSuccessRegisterState());
        return jsonDecode(response.body);
      } else if (response.statusCode == 422) {
        error = jsonDecode(response.body)['errors'].keys.toList();
        for (int i = 0; i <= error.length - 1; i++) {
          toast(
              color: Colors.red,
              msg: jsonDecode(response.body)['errors'][error[i]][0]);
        }
        emit(RegisterChildErrorRegisterState(error: 'error'));
        return jsonDecode(response.body);
      }
      if (response.statusCode == 500) {
        emit(RegisterChildErrorRegisterState(error: 'error'));
      }
      emit(RegisterChildErrorRegisterState(error: 'error'));
    } catch (error) {
      emit(RegisterChildErrorRegisterState(error: 'error'));
    }
  }

  void editChild(
      {required String first_name,
      required String last_name,
      required String guardian_name,
      required String guardian_relationship,
      required String gender,
      required String phone_number,
      required String email,
      required String country,
      required String city,
      required String street,
      required String building_number,
      required String password,
      required int date_day,
      required int date_month,
      required int date_year,
      required String postCode,
      required int studentId}) async {
    try {
      Map<String, dynamic> body = {
        'forename': first_name,
        'surname': last_name,
        'middlename': guardian_name,
        'guardian_relationship': guardian_relationship,
        'gender': gender,
        'phone_number': phone_number,
        // 'email': email,
        'country': country,
        'city': city,
        'street': street,
        'building_number': building_number,
        // 'password': password,
        'date_day': date_day.toString(),
        'date_month': date_month.toString(),
        'date_year': date_year.toString(),
        'post_code': postCode,
      };
      emit(RegisterChildLoadingRegisterState());
      var response =
          await http.put(Uri.parse('${BaseUrl}students'), body: body, headers: {
        'Accept': 'application/json',
        "student-id": studentId.toString(),
        'Authorization': 'Bearer ${CacheHelper.getData(key: 'token_student')}'
      });

      if (response.statusCode == 200) {
        emit(EditChildSuccessRegisterState());
        return jsonDecode(response.body);
      } else if (response.statusCode == 422) {
        error = jsonDecode(response.body)['errors'].keys.toList();
        for (int i = 0; i <= error.length - 1; i++) {
          toast(
              color: Colors.red,
              msg: jsonDecode(response.body)['errors'][error[i]][0]);
        }
        emit(RegisterChildErrorRegisterState(error: 'error'));
        return jsonDecode(response.body);
      }
      if (response.statusCode == 500) {
        emit(RegisterChildErrorRegisterState(error: 'error'));
      }
      emit(RegisterChildSuccessRegisterState());
    } catch (error) {
      emit(RegisterChildErrorRegisterState(error: 'error'));
    }
  }

  void RegisterParent({
    required String first_name,
    required String last_name,
    required String phone_number,
    required String email,
    required String country,
    required String city,
    required String street,
    required String building_number,
    required String password,
    required String postCode,
    required String emergency_phone_number,
    required String emergency_relationship,
  }) async {
    try {
      Map<String, dynamic> body = {
        'forename': first_name,
        'surname': last_name,
        'phone_number': countryCode + phone_number,
        'email': email,
        'country': country,
        'city': city,
        'street': street,
        'building_number': building_number,
        'password': password,
        'post_code': postCode,
        'emergency_phone_number': countryCode2 + emergency_phone_number,
        'emergency_relationship': emergency_relationship,
      };
      emit(RegisterChildLoadingRegisterState());
      var response = await http.post(Uri.parse('${BaseUrl}guardians-register'),
          body: body,
          headers: {
            'Accept': 'application/json',
            'Authorization':
                'Bearer ${CacheHelper.getData(key: 'token_student')}'
          });

      if (response.statusCode == 200) {
        emit(RegisterParentSuccessRegisterState());
        return jsonDecode(response.body);
      } else if (response.statusCode == 422) {
        error = jsonDecode(response.body)['errors'].keys.toList();
        for (int i = 0; i <= error.length - 1; i++) {
          toast(
              color: Colors.red,
              msg: jsonDecode(response.body)['errors'][error[i]][0]);
        }
        emit(RegisterChildErrorRegisterState(error: 'error'));
        return jsonDecode(response.body);
      }
      if (response.statusCode == 500) {
        emit(RegisterChildErrorRegisterState(error: 'error'));
      }
      emit(RegisterChildErrorRegisterState(error: 'error'));
    } catch (error) {
      emit(RegisterChildErrorRegisterState(error: 'error'));
    }
  }
}
