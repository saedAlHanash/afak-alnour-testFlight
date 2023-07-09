import 'dart:ffi';


import 'package:afaq_teacher/data/mapper/mapper.dart';
import 'package:dartz/dartz.dart';

import '../../app/app_pref.dart';
import '../../app/constants.dart';
import '../../domain/models/my_course_model.dart';
import '../../domain/models/my_sessions_model.dart';
import '../../domain/models/schedule_model.dart';
import '../../domain/models/session_by_id_model.dart';
import '../../domain/models/student_in_course_model.dart';
import '../../domain/models/user_model.dart';
import '../../domain/repository/repository.dart';
import '../data_source/remote_data_source.dart';
import '../network/error_handler.dart';
import '../network/failure.dart';
import '../network/network_info.dart';
import '../network/requstes/attendance_request.dart';
import '../network/requstes/edit_user_request.dart';
import '../network/requstes/login_request.dart';
import '../network/requstes/register_request.dart';
import '../network/requstes/test_request.dart';
import '../responses/base_response.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  final AppPreferences _appPreferences;

  RepositoryImpl(
      this._networkInfo, this._remoteDataSource, this._appPreferences);

  @override
  Future<Either<Failure, BaseResponse>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.register(registerRequest);
        if (response.status == ApiInternalStatus.success) {
          return Right(response);
        } else {
          return Left(
              Failure(code: response.status!, message: response.message!));
        }
      } catch (error) {
        print(error);
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, UserDataModel>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.login(loginRequest);
        return Right(response.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> sendFirebaseToken(
      String firebase, String authorization) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _remoteDataSource.sendFirebaseToken(firebase, authorization);
        return const Right(Void);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setSchedule(
      TestRequest schedule, String authorization) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _remoteDataSource.setSchedule(schedule, authorization);
        return const Right(Void);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, ScheduleModel>> getSchedule(
      String authorization) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getSchedule(authorization);
        return Right(response.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, MyCourseModel>> getCourses(
      String authorization) async {
    var token = "${Constants.bearer} ${_appPreferences.getUserToken()}";
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getCourses(token);
        if (response.status == ApiInternalStatus.success) {
          return Right(response.toDomain());
        } else {
          return Left(
              Failure(code: response.status!, message: response.message!));
        }
      } catch (error) {
        print(error);
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, MySessionsModel>> getMySessions(int levelId) async {
    var token = "${Constants.bearer} ${_appPreferences.getUserToken()}";
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getMySessions(token, levelId);
        if (response.status == ApiInternalStatus.success) {
          return Right(response.toDomain());
        } else {
          return Left(
              Failure(code: response.status!, message: response.message!));
        }
      } catch (error) {
        print(error);
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, SessionByIdModel>> getSessionById(
      int sessionId) async {
    var token = "${Constants.bearer} ${_appPreferences.getUserToken()}";
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _remoteDataSource.getSessionById(token, sessionId);
        if (response.status == ApiInternalStatus.success) {
          return Right(response.toDomain());
        } else {
          return Left(
              Failure(code: response.status!, message: response.message!));
        }
      } catch (error) {
        print(error);
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, StudentInCourseModel>> getStudentInCourse(
      int courseId) async {
    var token = "${Constants.bearer} ${_appPreferences.getUserToken()}";
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _remoteDataSource.getStudentInCourse(token, courseId);
        if (response.status == ApiInternalStatus.success) {
          return Right(response.toDomain());
        } else {
          return Left(
              Failure(code: response.status!, message: response.message!));
        }
      } catch (error) {
        print(error);
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setAttendance(
      int sessionId, AttendanceRequest attendanceRequest) async {
    var token = "${Constants.bearer} ${_appPreferences.getUserToken()}";
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.setAttendance(
            token, sessionId, attendanceRequest);
        return const Right(Void);
      } catch (error) {
        print(error);
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> editUserInfo(
      EditUserRequest editUserRequest) async {
    var token = "${Constants.bearer} ${_appPreferences.getUserToken()}";
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _remoteDataSource.editUserInfo(token, editUserRequest);
        return const Right(Void);
      } catch (error) {
        print(error);
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
}
