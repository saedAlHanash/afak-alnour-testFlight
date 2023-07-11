import 'dart:io';


import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../app/constants.dart';
import '../responses/base_response.dart';
import '../responses/my_course_response.dart';
import '../responses/my_sessions_response.dart';
import '../responses/schedule_response.dart';
import '../responses/session_by_id_response.dart';
import '../responses/student_in_course_response.dart';
import '../responses/user_response.dart';
import 'requstes/attendance_request.dart';
import 'requstes/test_request.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/teacher")
  @MultiPart()
  Future<BaseResponse> register(
    @Part(name: "forename") String firstName,
    @Part(name: "surname") String lastName,
    @Part(name: "phone_number") String mobileNumber,
    @Part(name: "email") String email,
    @Part(name: "gender") String gender,
    @Part(name: "nationality") String nationality,
    @Part(name: "residency") String residency,
    @Part(name: "qualification") String qualification,
    @Part(name: "field_of_study") String specialty,
    @Part(name: "years_of_experience") int experienceYear,
    @Part(name: "english_level") String langLevel,
    @Part(name: "subject") String subject,
    @Part(name: "image_url") File image,
    @Part(name: "apps") String onlinePrograms,
    @Part(name: "appointment") String appointment,
    @Part(name: "cv_file_url") File cv,
    @Part(name: "other_file_url") File otherFile,
  );

  @POST('/teachers-login')
  Future<UserData> login(
    @Field('email') String email,
    @Field('password') String password,
  );

  @POST('/device-token-teacher')
  Future<void> sendFirebaseToken(@Header('Authorization') String authorization,
      @Field('device_token') String firebase);

  @POST('/teachers/schedule')
  Future<void> setSchedule(@Header('Authorization') String authorization,
      @Body(nullToAbsent: true) TestRequest testRequest);

  @GET('/teachers/schedule')
  Future<ScheduleResponse> getSchedule(
      @Header('Authorization') String authorization);

  @GET('/teacher/courses')
  Future<MyCourseResponse> getCourses(
      @Header('Authorization') String authorization);

  @GET("/level/sessions")
  Future<MySessionsResponse> getMySessions(
      @Header('Authorization') String authorization,
      @Header("level_id") int levelId);

  @GET("/session")
  Future<SessionByIdResponse> getSessionsById(
      @Header('Authorization') String authorization,
      @Header("session_id") int sessionId);

  @GET("/course/students")
  Future<StudentInCourseResponse> getStudentinCourse(
    @Header('Authorization') String authorization,
    @Header('course_id') int courseId,
  );

  @POST('/session/attendance')
  Future<void> setAttendance(
      @Header('Authorization') String authorization,
      @Header('session_id') int sessionId,
      @Body() AttendanceRequest attendanceRequest);

  @POST("/teacher/update")
  @MultiPart()
  Future<void> editUserInfo(
    @Header('Authorization') String authorization,
    @Part(name: "bio") String bio,
    @Part(name: "phone_number") String phoneNumber,
    @Part(name: "field_of_study") String fieldOfStudy,
    @Part(name: "qualification") String qualification,
    @Part(name: 'image_url') File image,
  );
}
