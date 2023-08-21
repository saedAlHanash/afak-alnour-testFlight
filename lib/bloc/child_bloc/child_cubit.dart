import 'dart:isolate';
import 'dart:io' as io;
import 'dart:ui';

import 'package:afaq_alnour_academy/bloc/child_bloc/child_state.dart';
import 'package:afaq_alnour_academy/constant/const.dart';
import 'package:afaq_alnour_academy/data/local/cache_helper.dart';
import 'package:afaq_alnour_academy/data/remote/dio_helper.dart';
import 'package:afaq_alnour_academy/model/all_sessions_model.dart';
import 'package:afaq_alnour_academy/model/my_courses_child_model.dart';
import 'package:afaq_alnour_academy/model/session_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ChildCubit extends Cubit<ChildState> {
  ChildCubit() : super(InitialState());

  static ChildCubit get(context) => BlocProvider.of(context);

  MyCoursesChildModel? model;
  CalendarController calendarController = CalendarController();

  void getMyCourses() {
    emit(GetMyCoursesLoadingState());
    DioHelper.getData(
            url: 'courses/my-courses', token: CacheHelper.getData(key: 'token_child'))
        .then((value) {
      model = MyCoursesChildModel.fromJson(value.data);
      emit(GetMyCoursesSuccessState());
    }).catchError((error) {
      emit(GetMyCoursesErrorState());
    });
  }

  void sendFireBaseToken() {
    DioHelper.postData(
            url: 'device-token-student',
            data: {'device_token': CacheHelper.getData(key: 'fireBase_token')},
            token: CacheHelper.getData(key: 'token_child'))
        .then((value) {
      emit(SendFirebaseTokenSuccessState());
    }).catchError((error) {
      emit(SendFirebaseTokenErrorState());
    });
  }

  goToToday() {
    calendarController.displayDate = DateTime.now();
    emit(GoToTodayState());
  }

  AllSessionsModel? allSessionsModel;

  getSessions(int levelId) async {
    emit(GetAllSessionsLoadingState());
    await DioHelper.getData(
            url: 'level/sessions',
            lvlID: levelId,
            token: CacheHelper.getData(key: 'token_child'))
        .then((value) {
      if (value.statusCode == 200) {
        allSessionsModel = AllSessionsModel.fromJson(value.data);
        emit(GetAllSessionsSuccessState());
      }
      emit(GetAllSessionsErrorState());
    }).catchError((error) {
      emit(GetAllSessionsErrorState());
    });
  }

  SessionModel? sessionModel;

  getSessionById(int sessionId) async {
    emit(GetSessionsLoadingState());
    await DioHelper.getData(
      url: 'session',
      token: CacheHelper.getData(key: 'token_child'),
      sessionId: sessionId,
    ).then((value) {
      if (value.statusCode == 200) {
        sessionModel = SessionModel.froJson(value.data);
        emit(GetSessionsSuccessState());
      } else {
        emit(GetSessionsErrorState());
      }
    }).catchError((error) {
      emit(GetSessionsErrorState());
    });
  }

  void downloadFile(String url) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      io.Directory? baseStorage;
      if (io.Platform.isAndroid) {
        baseStorage = io.Directory('/storage/emulated/0/Download');
        if (!await baseStorage.exists()) {
          baseStorage = await getExternalStorageDirectory();
        }
      } else {
        baseStorage = await getExternalStorageDirectory();
      }
      try {
        final id = await FlutterDownloader.enqueue(
            url: ImageUrl + url,
            savedDir: baseStorage!.path,
            openFileFromNotification: true,
            fileName: url.split("/").last,
            showNotification: true);
      } catch (e) {}
    } else {}
  }

  Future<bool> checkFile(String path) async {
    io.Directory? baseStorage;
    if (io.Platform.isAndroid) {
      baseStorage = io.Directory('/storage/emulated/0/Download');
      if (!await baseStorage.exists()) {
        baseStorage = await getExternalStorageDirectory();
      }
      String filePath = '${baseStorage!.path}/${path.split("/").last}';
      if (await io.File(filePath).exists()) {
        openLocalFile(filePath);
      } else {
        downloadFile(path);
      }
      return await io.File(filePath).exists();
    } else {
      baseStorage = await getExternalStorageDirectory();
      String filePath = '${baseStorage!.path}/$path';
      if (await io.File(filePath).exists()) {
        openLocalFile(filePath);
      } else {
        downloadFile(path);
      }
      return await io.Directory(filePath).exists();
    }
  }

  void openLocalFile(String path) async {
    final result = await OpenFilex.open(path);
  }

  @pragma('vm:entry-point')
  static void downloadCallBack(id, status, progress) {
    final SendPort? sendPort = IsolateNameServer.lookupPortByName("downloader_send_port");
    sendPort!.send(progress);
  }
}
