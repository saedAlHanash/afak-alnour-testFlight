import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../domain/models/user_model.dart';

const String userToken = "user_token";
const String user = "user";
const String firebaseToken = "firebase_token";
const String onBoardingView = "on_Boarding";
const String localLang = "local_lang";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<void> setUserToken(String token) async {
    await _sharedPreferences.setString(userToken, token);
  }

  String? getUserToken() {
    return _sharedPreferences.getString(userToken);
  }

  Future<void> setFirebaseToken(String token) async {
    await _sharedPreferences.setString(firebaseToken, token);
  }

  Future<void> setOnBoardingView(bool isView) async {
    await _sharedPreferences.setBool(onBoardingView, isView);
  }

  bool? getOnBoardingView() {
    return _sharedPreferences.getBool(onBoardingView);
  }

  Future<void> setLocal(String local) async {
    await _sharedPreferences.setString(localLang, local);
  }

  String? getLocal() {
    return _sharedPreferences.getString(localLang);
  }

  String? getFirebaseToken() {
    return _sharedPreferences.getString(firebaseToken);
  }

  Future<void> setUserToCache(UserModel userModel) async {
    await _sharedPreferences.setString(user, jsonEncode(userModel.toJson()));
  }

  UserModel getUserFromCache() {
    return UserModel.fromJson(jsonDecode(_sharedPreferences.getString(user)!));
  }

  Future<void> logOut() async {
    await _sharedPreferences.remove(userToken);
  }
}
