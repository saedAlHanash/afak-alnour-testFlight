
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../app/app_pref.dart';
import '../../app/constants.dart';

const String applicationJson = "application/json";
const String contentType = "Content-Type";
const String accept = "Accept";
const String authorization = "Authorization";
const String user = "user";
const String teacher = "teacher";
const String bearer = "Bearer";
// const String language = "language";

class DioFactory {
  final AppPreferences _appPreferences;
  DioFactory(this._appPreferences);



  Future<Dio> getDio() async {
    Dio dio = Dio();
    var userToken = _appPreferences.getUserToken();
    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      authorization: '$bearer ${userToken ?? Constants.empty}',
      user : teacher
    };
    dio.options = BaseOptions(
        baseUrl: Constants.baseUrl,
        headers: headers,
        receiveTimeout:const Duration(milliseconds:  Constants.apiTimeOut),
        sendTimeout:const Duration(milliseconds:  Constants.apiTimeOut));

    if (!kReleaseMode) {
      dio.interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseHeader: true));
    }

    return dio;
  }
}
