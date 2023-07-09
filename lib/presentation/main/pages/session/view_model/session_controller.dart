import 'dart:io' as io;
import 'dart:isolate';
import 'dart:ui';


import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../app/constants.dart';
import '../../../../../app/di.dart';
import '../../../../../data/network/requstes/attendance_request.dart';
import '../../../../../domain/models/my_course_model.dart';
import '../../../../../domain/models/my_sessions_model.dart';
import '../../../../../domain/models/session_by_id_model.dart';
import '../../../../../domain/models/student_in_course_model.dart';
import '../../../../../domain/usecase/get_my_sessions_usecase.dart';
import '../../../../../domain/usecase/get_session_by_id_usecase.dart';
import '../../../../../domain/usecase/get_student_in_course_usecase.dart';
import '../../../../../domain/usecase/set_attendance_usecase.dart';
import '../../../../common/state_rendere/state_renderer.dart';
import '../../../../resources/string_manger.dart';
import '../../home_page/view_model/home_controller.dart';

class SessionController extends GetxController {
  late MyCourseModel myCourseModel;
  MySessionsModel? mySessionsModel;
  StudentInCourseModel? studentInCourseModel;
  final GetMySessionsUseCase _getMySessionsUseCase =
      instance<GetMySessionsUseCase>();
  final GetSessionByIdUseCase _getSessionByIdUseCase =
      instance<GetSessionByIdUseCase>();
  final GetStudentInCourseUseCase _getStudentInCourseUseCase =
      instance<GetStudentInCourseUseCase>();
  final SetAttendanceUseCase _setAttendanceUseCase =
      instance<SetAttendanceUseCase>();
  RxList<int> childAttendance = <int>[].obs;
  RxBool mySessionsLoading = false.obs;
  RxBool getSessionByIdLoading = false.obs;
  RxBool getStudentByCourseLoading = false.obs;
  RxBool homeWork = false.obs;
  SessionByIdModel? sessionByIdModel;
  late AttendanceRequest attendanceRequest;
  int sessionById = 0;

  setAttendance(int sessionId) async {
    attendanceRequest = AttendanceRequest(
        students: childAttendance.value,
        status: 'completed',
        date:
            '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}');
    (await _setAttendanceUseCase
            .execute(SetAttendanceUseCaseInput(attendanceRequest, sessionId)))
        .fold((l) {
      appSnackBar(AppStrings.error.tr, l.message);
    }, (r) {
      appSnackBar(AppStrings.success.tr, AppStrings.successAttendance.tr);
    });
  }

  getCourseItems() {
    myCourseModel = Get.find<HomeController>().model;
  }

  getStudentInCourse(int courseId) async {
    getStudentByCourseLoading.value = true;
    (await _getStudentInCourseUseCase.execute(courseId)).fold((l) {
      appSnackBar(AppStrings.error.tr, l.message);
    }, (r) {
      studentInCourseModel = r;
    });
    getStudentByCourseLoading.value = false;
  }

  addOrRemoveChildInList(int childId) {
    if (childAttendance.contains(childId)) {
      childAttendance.remove(childId);
    } else {
      childAttendance.add(childId);
    }
    childAttendance.refresh();
  }

  getMySessionsModel(int levelId) async {
    mySessionsLoading.value = true;
    (await _getMySessionsUseCase.execute(levelId)).fold((l) {
      appSnackBar(AppStrings.error.tr, l.message);
    }, (r) {
      mySessionsModel = r;
    });
    mySessionsLoading.value = false;
  }

  getSessionById(int sessionsId) async {
    getSessionByIdLoading.value = true;
    (await _getSessionByIdUseCase.execute(sessionsId)).fold((l) {
      appSnackBar(AppStrings.error.tr, l.message);
    }, (r) {
      sessionByIdModel = r;
    });
    getSessionByIdLoading.value = false;
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
            url: Constants.imageUrl + url,
            savedDir: baseStorage!.path,
            openFileFromNotification: true,
            fileName: url.split("/").last,
            showNotification: true);
      } catch (e) {
        appSnackBar(AppStrings.error.tr, AppStrings.errorDownloadFile.tr);
      }
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

  ReceivePort receivePort = ReceivePort();
  RxInt progress = 0.obs;

  @pragma('vm:entry-point')
  static void downloadCallBack(id, status, progress) {
    final SendPort? sendPort =
        IsolateNameServer.lookupPortByName("downloader_send_port");
    sendPort!.send(progress);
  }

  @override
  void onInit() {
    IsolateNameServer.registerPortWithName(
        receivePort.sendPort, "downloader_send_port");
    receivePort.listen((message) {
      progress.value = message;
    });
    FlutterDownloader.registerCallback(downloadCallBack);
    super.onInit();
  }

  @override
  void onClose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.onClose();
  }
}
