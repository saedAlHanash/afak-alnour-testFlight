

import '../network/app_api.dart';
import '../network/requstes/attendance_request.dart';
import '../network/requstes/edit_user_request.dart';
import '../network/requstes/login_request.dart';
import '../network/requstes/register_request.dart';
import '../network/requstes/test_request.dart';
import '../responses/base_response.dart';
import '../responses/my_course_response.dart';
import '../responses/my_sessions_response.dart';
import '../responses/schedule_response.dart';
import '../responses/session_by_id_response.dart';
import '../responses/student_in_course_response.dart';
import '../responses/user_response.dart';

abstract class RemoteDataSource {
  Future<BaseResponse> register(RegisterRequest registerRequest);

  Future<UserData> login(LoginRequest loginRequest);

  Future<void> sendFirebaseToken(String firebase, String authorization);

  Future<void> setSchedule(TestRequest schedule, String authorization);

  Future<ScheduleResponse> getSchedule(String authorization);

  Future<MyCourseResponse> getCourses(String authorization);

  Future<MySessionsResponse> getMySessions(String authorization, int levelId);

  Future<SessionByIdResponse> getSessionById(
      String authorization, int sessionId);

  Future<StudentInCourseResponse> getStudentInCourse(
      String authorization, int courseId);

  Future<void> setAttendance(
      String authorization, int sessionId, AttendanceRequest attendanceRequest);

  Future<void> editUserInfo(
      String authorization, EditUserRequest editUserRequest);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<BaseResponse> register(RegisterRequest registerRequest) async {
    return await _appServiceClient.register(
        registerRequest.firstName,
        registerRequest.lastName,
        registerRequest.mobileNumber,
        registerRequest.email,
        registerRequest.gender,
        registerRequest.nationality,
        registerRequest.residency,
        registerRequest.qualification,
        registerRequest.specialty,
        registerRequest.experienceYear,
        registerRequest.langLevel,
        registerRequest.subject,
        registerRequest.image,
        registerRequest.onlinePrograms,
        registerRequest.appointment,
        registerRequest.cv,
        registerRequest.otherFile);
  }

  @override
  Future<UserData> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password);
  }

  @override
  Future<void> sendFirebaseToken(String firebase, String authorization) async {
    return await _appServiceClient.sendFirebaseToken(authorization, firebase);
  }

  @override
  Future<void> setSchedule(TestRequest schedule, String authorization) async {
    return await _appServiceClient.setSchedule(authorization, schedule);
  }

  @override
  Future<ScheduleResponse> getSchedule(String authorization) async {
    return await _appServiceClient.getSchedule(authorization);
  }

  @override
  Future<MyCourseResponse> getCourses(String authorization) async {
    return await _appServiceClient.getCourses(authorization);
  }

  @override
  Future<MySessionsResponse> getMySessions(
      String authorization, int levelId) async {
    return await _appServiceClient.getMySessions(authorization, levelId);
  }

  @override
  Future<SessionByIdResponse> getSessionById(
      String authorization, int sessionId) async {
    return await _appServiceClient.getSessionsById(authorization, sessionId);
  }

  @override
  Future<StudentInCourseResponse> getStudentInCourse(
      String authorization, int courseId) async {
    return _appServiceClient.getStudentinCourse(authorization, courseId);
  }

  @override
  Future<void> setAttendance(String authorization, int sessionId,
      AttendanceRequest attendanceRequest) async {
    return await _appServiceClient.setAttendance(
        authorization, sessionId, attendanceRequest);
  }

  @override
  Future<void> editUserInfo(
      String authorization, EditUserRequest editUserRequest) async {
    return await _appServiceClient.editUserInfo(
        authorization,
        editUserRequest.bio,
        editUserRequest.phoneNumber,
        editUserRequest.fieldOfStudy,
        editUserRequest.qualification,
        editUserRequest.image);
  }
}
