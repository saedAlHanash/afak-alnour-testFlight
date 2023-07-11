// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _AppServiceClient implements AppServiceClient {
  _AppServiceClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'http://afaq-alnour.chi-team.com/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<BaseResponse> register(
    firstName,
    lastName,
    mobileNumber,
    email,
    gender,
    nationality,
    residency,
    qualification,
    specialty,
    experienceYear,
    langLevel,
    subject,
    image,
    onlinePrograms,
    appointment,
    cv,
    otherFile,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry(
      'forename',
      firstName,
    ));
    _data.fields.add(MapEntry(
      'surname',
      lastName,
    ));
    _data.fields.add(MapEntry(
      'phone_number',
      mobileNumber,
    ));
    _data.fields.add(MapEntry(
      'email',
      email,
    ));
    _data.fields.add(MapEntry(
      'gender',
      gender,
    ));
    _data.fields.add(MapEntry(
      'nationality',
      nationality,
    ));
    _data.fields.add(MapEntry(
      'residency',
      residency,
    ));
    _data.fields.add(MapEntry(
      'qualification',
      qualification,
    ));
    _data.fields.add(MapEntry(
      'field_of_study',
      specialty,
    ));
    _data.fields.add(MapEntry(
      'years_of_experience',
      experienceYear.toString(),
    ));
    _data.fields.add(MapEntry(
      'english_level',
      langLevel,
    ));
    _data.fields.add(MapEntry(
      'subject',
      subject,
    ));
    _data.files.add(MapEntry(
      'image_url',
      MultipartFile.fromFileSync(
        image.path,
        filename: image.path.split(Platform.pathSeparator).last,
      ),
    ));
    _data.fields.add(MapEntry(
      'apps',
      onlinePrograms,
    ));
    _data.fields.add(MapEntry(
      'appointment',
      appointment,
    ));
    _data.files.add(MapEntry(
      'cv_file_url',
      MultipartFile.fromFileSync(
        cv.path,
        filename: cv.path.split(Platform.pathSeparator).last,
      ),
    ));
    if(otherFile.path.isNotEmpty) {
      _data.files.add(MapEntry(
      'other_file_url',
      MultipartFile.fromFileSync(
        otherFile.path,
        filename: otherFile.path.split(Platform.pathSeparator).last,
      ),
    ));
    }
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<BaseResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              '/teacher',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UserData> login(
    email,
    password,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'email': email,
      'password': password,
    };
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<UserData>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/teachers-login',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<void> sendFirebaseToken(
    authorization,
    firebase,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = {'device_token': firebase};
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/device-token-teacher',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return null;
  }

  @override
  Future<void> setSchedule(
    authorization,
    testRequest,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(testRequest.toJson());
    _data.removeWhere((k, v) => v == null);
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/teachers/schedule',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return null;
  }

  @override
  Future<ScheduleResponse> getSchedule(authorization) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ScheduleResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/teachers/schedule',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ScheduleResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MyCourseResponse> getCourses(authorization) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<MyCourseResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/teacher/courses',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MyCourseResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MySessionsResponse> getMySessions(
    authorization,
    levelId,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Authorization': authorization,
      r'level_id': levelId,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<MySessionsResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/level/sessions',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MySessionsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SessionByIdResponse> getSessionsById(
    authorization,
    sessionId,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Authorization': authorization,
      r'session_id': sessionId,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SessionByIdResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/session',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SessionByIdResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<StudentInCourseResponse> getStudentinCourse(
    authorization,
    courseId,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Authorization': authorization,
      r'course_id': courseId,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<StudentInCourseResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/course/students',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = StudentInCourseResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<void> setAttendance(
    authorization,
    sessionId,
    attendanceRequest,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Authorization': authorization,
      r'session_id': sessionId,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(attendanceRequest.toJson());
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/session/attendance',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return null;
  }

  @override
  Future<void> editUserInfo(
    authorization,
    bio,
    phoneNumber,
    fieldOfStudy,
    qualification,
    image,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = FormData();
    _data.fields.add(MapEntry(
      'bio',
      bio,
    ));
    _data.fields.add(MapEntry(
      'phone_number',
      phoneNumber,
    ));
    _data.fields.add(MapEntry(
      'field_of_study',
      fieldOfStudy,
    ));
    _data.fields.add(MapEntry(
      'qualification',
      qualification,
    ));
    if(image.path.isNotEmpty) {
      _data.files.add(MapEntry(
      'image_url',
      MultipartFile.fromFileSync(
        image.path,
        filename: image.path.split(Platform.pathSeparator).last,
      ),
    ));
    }
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
        .compose(
          _dio.options,
          '/teacher/update',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return null;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
