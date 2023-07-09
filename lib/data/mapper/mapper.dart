import 'dart:convert';
import 'dart:developer';


import 'package:afaq_teacher/app/extensions.dart';

import '../../app/constants.dart';
import '../../domain/models/homework_model.dart';
import '../../domain/models/my_course_model.dart';
import '../../domain/models/my_sessions_model.dart';
import '../../domain/models/resources_model.dart';
import '../../domain/models/schedule_model.dart';
import '../../domain/models/session_by_id_model.dart';
import '../../domain/models/student_in_course_model.dart';
import '../../domain/models/user_model.dart';
import '../responses/homework_response.dart';
import '../responses/my_course_response.dart';
import '../responses/my_sessions_response.dart';
import '../responses/resources_response.dart';
import '../responses/schedule_response.dart';
import '../responses/session_by_id_response.dart';
import '../responses/student_in_course_response.dart';
import '../responses/user_response.dart';



extension UserResponseEx on User? {
  UserModel toDomain() {
    return UserModel(
        this?.id.orZero() ?? Constants.zero,
        this?.qualification.orEmpty() ?? Constants.empty,
        this?.email.orEmpty() ?? Constants.empty,
        this?.gender.orEmpty() ?? Constants.empty,
        this?.subject.orEmpty() ?? Constants.empty,
        this?.residency.orEmpty() ?? Constants.empty,
        this?.nationality.orEmpty() ?? Constants.empty,
        this?.image_url.orEmpty() ?? Constants.empty,
        this?.apps.orEmpty() ?? Constants.empty,
        this?.english_level.orEmpty() ?? Constants.empty,
        this?.field_of_study.orEmpty() ?? Constants.empty,
        this?.forename.orEmpty() ?? Constants.empty,
        this?.phone_number.orEmpty() ?? Constants.empty,
        this?.surname.orEmpty() ?? Constants.empty,
        this?.years_of_experience.orEmpty() ?? Constants.empty,
        this?.bio.orEmpty() ?? Constants.empty);
  }
}

extension UserDataEx on UserData? {
  UserDataModel toDomain() {
    return UserDataModel(this?.token.orEmpty() ?? Constants.empty,
        this?.user != null ? this!.user.toDomain() : null);
  }
}

extension ScheduleDataEx on ScheduleResponse? {
  ScheduleModel toDomain() {
    return ScheduleModel(this?.data.orEmpty() ?? Constants.empty);
  }
}

extension MyCourseDataMapper on MyCourseResponseData? {
  MyCourseDataModel toDomain() {
    var days = this?.days.orEmpty() ?? Constants.empty;
    late List<dynamic> day;
    try {
      day = jsonDecode(days);
    } catch (e) {
      log(e.toString());
    }

    return MyCourseDataModel(
        this?.price.orZero() ?? Constants.zero,
        this?.created_at.orEmpty() ?? Constants.empty,
        this?.updated_at.orEmpty() ?? Constants.empty,
        this?.id.orZero() ?? Constants.zero,
        day,
        this?.code.orEmpty() ?? Constants.empty,
        this?.gender.orEmpty() ?? Constants.empty,
        this?.ar_description.orEmpty() ?? Constants.empty,
        this?.ar_name.orEmpty() ?? Constants.empty,
        this?.category_order_id.orZero() ?? Constants.zero,
        this?.course_type_id.orZero() ?? Constants.zero,
        this?.en_description.orEmpty() ?? Constants.empty,
        this?.en_name.orEmpty() ?? Constants.empty,
        this?.end_date.orEmpty() ?? Constants.empty,
        this?.level_id.orZero() ?? Constants.zero,
        this?.location.orEmpty() ?? Constants.empty,
        this?.max_participants.orZero() ?? Constants.zero,
        this?.min_participants.orZero() ?? Constants.zero,
        this?.population.orEmpty() ?? Constants.empty,
        this?.purpose.orEmpty() ?? Constants.empty,
        this?.session_duration.orZero() ?? Constants.zero,
        this?.start_date.orEmpty() ?? Constants.empty,
        this?.start_time.orEmpty() ?? Constants.empty,
        this?.teacher_id.orZero() ?? Constants.zero);
  }
}

extension MyCourseMapper on MyCourseResponse? {
  MyCourseModel toDomain() {
    return MyCourseModel(this!.data != null
        ? this?.data!.map((e) => e.toDomain()).toList() ?? []
        : []);
  }
}

extension MySessionsMapper on MySessionsResponse? {
  MySessionsModel toDomain() {
    return MySessionsModel(this?.sessions != null
        ? this?.sessions!.map((e) => e.toDomain()).toList() ?? []
        : []);
  }
}

extension SessionsMapper on Sessions? {
  SessionsModel toDomain() {
    return SessionsModel(
        this?.updated_at.orEmpty() ?? Constants.empty,
        this?.id.orZero() ?? Constants.zero,
        this?.order.orZero() ?? Constants.zero,
        this?.created_at.orEmpty() ?? Constants.empty,
        this?.level_id.orZero() ?? Constants.zero);
  }
}

extension HomeWorkMapper on HomeWorkResponse? {
  HomeWorkModel toDomain() {
    return HomeWorkModel(
        this?.created_at.orEmpty() ?? Constants.empty,
        this?.id.orZero() ?? Constants.zero,
        this?.updated_at.orEmpty() ?? Constants.empty,
        this?.type.orEmpty() ?? Constants.empty,
        this?.name.orEmpty() ?? Constants.empty,
        this?.session_id.orZero() ?? Constants.zero,
        this?.url.orEmpty() ?? Constants.empty);
  }
}

extension ResourcesMapper on ResourcesResponse? {
  ResourcesModel toDomain() {
    return ResourcesModel(
        this?.url.orEmpty() ?? Constants.empty,
        this?.session_id.orZero() ?? Constants.zero,
        this?.name.orEmpty() ?? Constants.empty,
        this?.type.orEmpty() ?? Constants.empty,
        this?.updated_at.orEmpty() ?? Constants.empty,
        this?.id.orZero() ?? Constants.zero,
        this?.created_at.orEmpty() ?? Constants.empty);
  }
}

extension GetSessionByIdMapper on SessionByIdResponse? {
  SessionByIdModel toDomain() {
    return SessionByIdModel(
        this?.session != null ? this!.session.toDomain() : null,
        this?.resources != null
            ? this?.resources!.map((e) => e.toDomain()).toList() ?? []
            : [],
        this?.homework != null ? this!.homework.toDomain() : null);
  }
}

extension StudentInCourseMapper on StudentInCourseResponse? {
  StudentInCourseModel toDomain() {
    return StudentInCourseModel(this?.data != null
        ? this!.data!.map((e) => e.toDomain()).toList()
        : []);
  }
}

extension StudentDataMapper on StudentDataResponse? {
  StudentDataModel toDomain() {
    return StudentDataModel(
        this?.id.orZero() ?? Constants.zero,
        this?.date_of_birth.orEmpty() ?? Constants.empty,
        this?.gender.orEmpty() ?? Constants.empty,
        this?.guardian_relationship.orEmpty() ?? Constants.empty,
        this?.post_code.orEmpty() ?? Constants.empty,
        this?.building_number.orEmpty() ?? Constants.empty,
        this?.street.orEmpty() ?? Constants.empty,
        this?.city.orEmpty() ?? Constants.empty,
        this?.country.orEmpty() ?? Constants.empty,
        this?.email.orEmpty() ?? Constants.empty,
        this?.phone_number.orEmpty() ?? Constants.empty,
        this?.created_at.orEmpty() ?? Constants.empty,
        this?.updated_at.orEmpty() ?? Constants.empty,
        this?.forename.orEmpty() ?? Constants.empty,
        this?.guardian_id.orZero() ?? Constants.zero,
        this?.middlename.orEmpty() ?? Constants.empty,
        this?.surname.orEmpty() ?? Constants.empty,
        this?.username.orEmpty() ?? Constants.empty);
  }
}
