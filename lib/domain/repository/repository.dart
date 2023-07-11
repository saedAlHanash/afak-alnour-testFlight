
import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../../data/network/requstes/attendance_request.dart';
import '../../data/network/requstes/edit_user_request.dart';
import '../../data/network/requstes/login_request.dart';
import '../../data/network/requstes/register_request.dart';
import '../../data/network/requstes/test_request.dart';
import '../../data/responses/base_response.dart';
import '../models/my_course_model.dart';
import '../models/my_sessions_model.dart';
import '../models/schedule_model.dart';
import '../models/session_by_id_model.dart';
import '../models/student_in_course_model.dart';
import '../models/user_model.dart';

abstract class Repository {
  Future<Either<Failure, BaseResponse>> register(
      RegisterRequest registerRequest);

  Future<Either<Failure, UserDataModel>> login(LoginRequest loginRequest);

  Future<Either<Failure, void>> sendFirebaseToken(
      String firebase, String authorization);

  Future<Either<Failure, void>> setSchedule(
      TestRequest schedule, String authorization);

  Future<Either<Failure, ScheduleModel>> getSchedule(String authorization);

  Future<Either<Failure, MyCourseModel>> getCourses(String authorization);

  Future<Either<Failure, MySessionsModel>> getMySessions(int levelId);

  Future<Either<Failure, SessionByIdModel>> getSessionById(int sessionId);

  Future<Either<Failure, StudentInCourseModel>> getStudentInCourse(
      int courseId);

  Future<Either<Failure, void>> setAttendance(
      int sessionId, AttendanceRequest attendanceRequest);

  Future<Either<Failure, void>> editUserInfo(EditUserRequest editUserRequest);
}
