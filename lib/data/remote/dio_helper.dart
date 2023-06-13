import 'package:afaq_alnour_academy/constant/const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../local/cache_helper.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: '$BaseUrl',
        receiveDataWhenStatusError: true,
        headers:
        {
          'Accept': 'application/json',
        },
        validateStatus:  (statusCode) {
          if (statusCode == null) {
            return false;
          }
          if(statusCode == 500) {
            return true;
          }
          if (statusCode == 422) {
            // your http status code
            return true;
          }
          if (statusCode == 401) {
            // your http status code
            return true;
          } else {
            return statusCode >= 200 && statusCode < 300;
          }
        },
      ),
    );

    if (!kReleaseMode) {
      dio?.interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseHeader: true));
    }
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
    String? lang,
    int? id,
    int? catid,
    bool? isTest,
    int? lvlID,
    int? studId,
    int? packageId,
    int? sessionId,
  }) async {
    dio!.options.headers = {
      'Accept': 'application/json',
      'Accept-Language': lang??CacheHelper.getData(key: 'lang'),
      'subject-id':id,
      'level-id' : lvlID,
      'is-test' : isTest,
      'category-id' : catid,
      'student-id' : studId,
      'Authorization': 'Bearer $token',
      'package-id' : packageId,
      'session_id' : sessionId
    };

    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
     String? lang,
    String? token,
    int? student_id,
    int? exam_id,
    int? category_id,
    bool? isTest,
    int? course_id,
    int? packageId,
    String? user,
    String? type = 'application/json'
  }) async
  {
    dio!.options.headers =
    {
      'lang':lang,
      'Accept': 'application/json',
      'student-id' : student_id,
      'exam-id' : exam_id,
      'course-id' : course_id,
      'is-test' : isTest,
      'category-id' : category_id,
      'Authorization': 'Bearer $token',
      'package-id' : packageId,
      'Content-Type' : type,
      'user' : user
    };

    return dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }


  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async
  {
    dio!.options.headers =
    {
      'lang':lang,
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    return dio!.put(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? lang,
    String? token,
    int? student_id,
    int? exam_id,
    int? category_id,
    bool? isTest,
    int? course_id,
    int? packageId,
    String? user,
    String? type = 'application/json'
  }) async
  {
    dio!.options.headers =
    {
      'lang':lang,
      'Accept': 'application/json',
      'student-id' : student_id,
      'exam-id' : exam_id,
      'course-id' : course_id,
      'is-test' : isTest,
      'category-id' : category_id,
      'Authorization': 'Bearer $token',
      'package-id' : packageId,
      'Content-Type' : type,
      'user' : user
    };

    return dio!.delete(
      url,
      queryParameters: query,
      data: data,
    );
  }

}