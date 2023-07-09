
import 'package:dio/dio.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

import '../app_controller.dart';
import '../data/data_source/remote_data_source.dart';
import '../data/network/app_api.dart';
import '../data/network/dio_factory.dart';
import '../data/network/network_info.dart';
import '../data/repository/repository_impl.dart';
import '../domain/repository/repository.dart';
import '../domain/usecase/edit_user_info_usecase.dart';
import '../domain/usecase/firebase_token_useCase.dart';
import '../domain/usecase/get_my_sessions_usecase.dart';
import '../domain/usecase/get_session_by_id_usecase.dart';
import '../domain/usecase/get_student_in_course_usecase.dart';
import '../domain/usecase/login_usecase.dart';
import '../domain/usecase/my_course_usecase.dart';
import '../domain/usecase/register_usecase.dart';
import '../domain/usecase/schedule_usecase.dart';
import '../domain/usecase/set_attendance_usecase.dart';
import '../domain/usecase/set_schedule_usecase.dart';
import 'app_pref.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  await FlutterDownloader.initialize(debug: false, ignoreSsl: true);

  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  Dio dio = await instance<DioFactory>().getDio();

  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance()));

  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance(), instance()));

  instance.registerFactory<ImagePicker>(() => ImagePicker());

  instance.registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));

  instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));

  instance.registerFactory<FireBaseTokenUseCase>(
      () => FireBaseTokenUseCase(instance()));

  instance.registerFactory<SetScheduleUseCase>(
      () => SetScheduleUseCase(instance()));

  instance.registerFactory<ScheduleUseCase>(() => ScheduleUseCase(instance()));

  instance.registerFactory<MyCourseUseCase>(() => MyCourseUseCase(instance()));

  instance.registerFactory<GetMySessionsUseCase>(
      () => GetMySessionsUseCase(instance()));

  instance.registerFactory<GetSessionByIdUseCase>(
      () => GetSessionByIdUseCase(instance()));

  instance.registerFactory<SetAttendanceUseCase>(
      () => SetAttendanceUseCase(instance()));

  instance.registerFactory<GetStudentInCourseUseCase>(
      () => GetStudentInCourseUseCase(instance()));

  instance.registerFactory<EditUserInfoUseCase>(
          () => EditUserInfoUseCase(instance()));

  Get.put(AppController(),permanent: true);
}
