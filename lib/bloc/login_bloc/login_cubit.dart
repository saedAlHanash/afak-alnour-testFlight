import 'dart:async';
import 'dart:convert';

import 'package:afaq_alnour_academy/constant/const.dart';
import 'package:afaq_alnour_academy/data/local/cache_helper.dart';
import 'package:afaq_alnour_academy/data/remote/dio_helper.dart';
import 'package:afaq_alnour_academy/generated/l10n.dart';
import 'package:afaq_alnour_academy/model/child_model.dart';
import 'package:afaq_alnour_academy/model/user_model.dart';
import 'package:afaq_alnour_academy/widget/toast.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitalState());

  static LoginCubit get(context) => BlocProvider.of(context);

  UserModel? model;
  ChildModel? childModel;
  bool password = true;

  onPassword() {
    password = !password;
    emit(ChangePasswordState());
  }

  void loginUser(context,
      {required String email, required String password}) async {
    try {
      emit(LoginLoadingState());
      var response = await http.post(Uri.parse('${BaseUrl}guardians-login'),
          headers: {'Accept': 'application/json', 'user': 'guardian'},
          body: {'email': email, 'password': password});
      if (response.statusCode == 301) {
        emit(LoginErrorState());
      }
      if (response.statusCode == 201) {
        model = UserModel.fromJson(jsonDecode(response.body));
        CacheHelper.setData(key: 'stripe_id', value: model?.user?.stripe_id);
        CacheHelper.setData(key: 'id', value: model?.user?.id);
        CacheHelper.setData(key: "country", value: model!.user!.country);
        CacheHelper.setData(key: "city", value: model!.user!.city);
        CacheHelper.setData(key: "street", value: model!.user!.street);
        CacheHelper.setData(key: "building_number", value: model!.user!.building_number);
        CacheHelper.setData(key: "post_code", value: model!.user!.post_code);
        emit(LoginSuccessState());
      } else if (response.statusCode == 401) {
        toast(msg: jsonDecode(response.body)['message'], color: Colors.red);
        emit(LoginErrorState());
      } else if (response.statusCode == 500) {
        emit(LoginErrorState());
      }
    } catch (error) {
      emit(LoginErrorState());
    }
  }

  void loginChild({required String userName, required String password}) {
    emit(LoginLoadingState());
    DioHelper.postData(
        url: 'students-login',
        user: 'student',
        data: {'username': userName, 'password': password}).then((value) {
      if (value.statusCode == 201) {
        childModel = ChildModel.fromJson(value.data);
        emit(LoginChildSuccessState());
      }
      if (value.statusCode == 401) {
        toast(msg: '${value.data['message']}', color: Colors.red);
        emit(LoginErrorState());
      }
      if (value.statusCode == 500) {
        emit(LoginErrorState());
      }
    }).catchError((e) {
      emit(LoginErrorState());
    });
  }

  String user = '';

  void changeUser({String? value}) {
    user = value!;
    emit(ChangeUserState());
  }
}
