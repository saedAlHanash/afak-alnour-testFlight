import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:afaq_alnour_academy/model/card_model.dart';
import 'package:afaq_alnour_academy/model/level_model.dart';
import 'package:afaq_alnour_academy/model/level_model_by_id.dart';
import 'package:afaq_alnour_academy/model/my_children_model.dart';
import 'package:afaq_alnour_academy/model/my_course_model.dart';
import 'package:afaq_alnour_academy/model/package_model.dart';
import 'package:afaq_alnour_academy/model/payment_history_model.dart';
import 'package:afaq_alnour_academy/model/payment_model.dart';
import 'package:afaq_alnour_academy/model/payment_request.dart';
import 'package:afaq_alnour_academy/model/test_model.dart';
import 'package:afaq_alnour_academy/screen/parent_view/afaq_layout.dart';
import 'package:afaq_alnour_academy/screen/parent_view/card_screen.dart';
import 'package:afaq_alnour_academy/screen/parent_view/child_courses_screen.dart';
import 'package:afaq_alnour_academy/screen/parent_view/payment_history_screen.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../../data/local/cache_helper.dart';
import '../../data/remote/dio_helper.dart';
import '../../model/categoris_model.dart';
import '../../model/course_model.dart';
import '../../model/enroll_model.dart';
import '../../model/class_model.dart';
import '../../model/levle_response.dart';
import '../../model/slider_model.dart';
import '../../screen/parent_view/home_page_screen.dart';
import '../../widget/toast.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(InitialHomeState());

  static HomeCubit get(context) => BlocProvider.of(context);
  Locale locale = Locale('en');
  String? lang = CacheHelper.getData(key: 'lang');
  bool language = true;

  int? childId = 0;
  String? subjectName = '';
  int? subjectId = 0;
  String? childName = '';
  List<CardModel> cardModel = [];
  PaymentModel paymentModel = PaymentModel({}, {}, {}, {});
  bool loading = false;

  void changeLoading({bool? value}) {
    loading = value!;
    emit(LoadingState());
  }

  void addChildToCard(int? classId, String? className, int? price, bool? isPackage) {
    emit(AddChildToCardLoadingState());
    Future.delayed(
      Duration(seconds: 2),
      () async {
        cardModel.add(CardModel(childId, childName, classId, className, price, subjectId,
            subjectName, isPackage));
        final List<String> dataList = cardModel.map((value) {
          return json.encode(value);
        }).toList();
        await CacheHelper.setData(key: 'card', value: dataList).then((value) {
          deleteAllCardInformation(withCard: false);
          emit(AddChildToCardSuccessState());
        });
      },
    );
  }

  void removeChildFromCard(int index) {
    emit(AddChildToCardLoadingState());
    cardModel.removeAt(index);
    Future.delayed(
      Duration(seconds: 2),
      () async {
        final List<String> dataList = cardModel.map((value) {
          return json.encode(value);
        }).toList();
        await CacheHelper.setData(key: 'card', value: dataList)
            .then((value) => emit(RemoveChildFromCardSuccessState()));
      },
    );
  }

  void initCardList() {
    cardModel = [];
    if (CacheHelper.getListData(key: 'card') != null) {
      List<String> dataList = CacheHelper.getListData(key: 'card');
      dataList.map((value) {
        return cardModel.add(CardModel.fromJson(json.decode(value)));
      }).toList();
    }
  }

  Future<bool> deleteAllCardInformation({bool? withCard, bool? re = false}) async {
    childId = 0;
    childName = '';
    subjectName = '';
    subjectId = 0;
    cardModel = [];
    if (withCard!) {
      await CacheHelper.removeData(key: 'card');
      emit(DeleteAllCardInformationState());
    }
    return re!;
  }

  void enrollStudentToLevel(int id, String name) {
    childId = id;
    childName = name;
    emit(EnrollStudentToLevelState());
  }

  Map<String, dynamic> answers = {};

  addAnswers(int questionId, int answerId) {
    answers[questionId.toString()] = answerId;
    emit(AnswersAdded());
  }

  changeLocal({String lang = 'en'}) {
    locale = Locale(lang);
    if (lang == 'en') {
      language = true;
    } else {
      language = false;
    }
    emit(ChangeLocalHomeState());
  }

  List<Widget> screen = [
    HomePage(),
    ChildCoursesScreen(),
    PaymentHistoryScreen(),
    CardScreen(),
  ];

  int bottomIndex = 0;

  void ChangeBottomBar({int? index}) {
    bottomIndex = index!;
    emit(ChangeBottomBarState());
  }

  Map<String, dynamic>? paymentIntentData;

  Future<void> makePayment(context,
      {required String amount,
      required String currency,
      String? type,
      String? price,
      String? invoiceID,
      PaymentRequest? paymentRequest}) async {
    try {
      paymentIntentData = await createPaymentIntent(amount, currency,
          paymentRequest: paymentRequest, type: type, price: price, invoiceID: invoiceID);
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
          customerId: paymentIntentData!['customer'],
          merchantDisplayName: 'Prospects',
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
        ));
        await displayPaymentSheet(context);
      }
    } catch (e, s) {}
  }

  Future<void> displayPaymentSheet(context) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      ChangeBottomBar(index: 2);
      await deleteAllCardInformation(withCard: true);
      paymentHistoryModel = null;
      getPaymentHistory();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => AfaqLayout(),
          ),
          (route) => false);
    } on Exception catch (e) {
      if (e is StripeException) {
      } else {}
    } catch (e) {}
  }

  createPaymentIntent(
    String amount,
    String currency, {
    PaymentRequest? paymentRequest,
    String? type,
    String? price,
    String? invoiceID,
  }) async {
    Map<String, dynamic> s = {};
    Map<String, dynamic> r = {};

    if (type == 'payment') {
      s = {};
      s['type'] = type;
      s['invoice_id'] = invoiceID;
    } else {
      paymentRequest!.data.forEach((key, value) {
        r = {};
        value.forEach((key1, value1) {
          r[key1] = value1;
        });
        s[key] = json.encode(r);
      });
      s['type'] = type;
      s['total'] = (double.parse(price!) * 100).toString();
    }

    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'customer': CacheHelper.getData(key: 'stripe_id'),
        'metadata': s,
        'payment_method_types[]': 'card'
      };

      var response = DioHelper.postData(
              url: 'https://api.stripe.com/v1/payment_intents',
              data: body,
              token:
                  'sk_test_51LDmtnIaXvRCgKNeElayWSRee3h2fhXCPtPwiDVGUmqxy582arZB2BBWAycf04e6gsCbHVfBeMCItQq6LjRaY36l00fOP4euL8',
              type: 'application/x-www-form-urlencoded')
          .then((value) {
        return value.data;
      });
      return response;
    } catch (err) {}
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }

  CourseModel? model;

  void getCourses() {
    emit(GetCoursesLoadingHomeState());
    DioHelper.getData(url: 'subjects', lang: lang).then((value) {
      model = CourseModel.fromJson(value.data);
      emit(GetCoursesSuccessHomeState());
    }).catchError((error) {
      emit(GetCoursesErrorHomeState(error: error.toString()));
    });
  }

  CourseModel? packages;

  // void getPackages() {
  //   emit(GetPackageLoadingState());
  //   DioHelper.getData(url: 'packages', lang: lang).then((value) {
  //     packages = CourseModel.fromJson(value.data);
  //     emit(GetPackageSuccessState());
  //   }).catchError((error) {
  //     emit(GetPackageErrorState());
  //   });
  // }

  CourseModel? seasonal;

  void getSeasonalCourse() {
    emit(GetSeasonalLoadingState());
    DioHelper.getData(url: 'seasonal-courses', lang: lang).then((value) {
      seasonal = CourseModel.fromJson(value.data);
      emit(GetSeasonalSuccessState());
    }).catchError((error) {
      emit(GetSeasonalErrorState());
    });
  }

  CategorisModel? categorisModel;

  void getCategories({int? id}) {
    emit(GetCategoriesLoadingState());
    DioHelper.getData(
            url: 'categories',
            lang: lang,
            id: id,
            token: CacheHelper.getData(key: 'token_student'))
        .then((value) {
      log(value.data.toString());
      categorisModel = CategorisModel.fromJson(value.data);
      emit(GetCategoriesSuccessState());
    }).catchError((error) {
      emit(GetCategoriesErrorState());
    });
  }

  EnrollModel? enrollModel;

  void enrollStudent({int? category_id, bool? isTest}) {
    emit(EnrollSutdentsLoadingState());
    DioHelper.postData(
      url: 'levels/enroll',
      data: {},
      category_id: category_id,
      token: CacheHelper.getData(key: 'token_student'),
      isTest: isTest,
      student_id: childId,
    ).then((value) {
      if (value.data['message'] == "Level 1 does not exist within this category.") {
        toast(msg: value.data['message'], color: Colors.red);
        loading = false;
        emit(EnrollSutdentsErrorState());
      } else {
        loading = false;
        toast(msg: value.data['message'], color: Colors.green);
        getLevelById(studentId: childId, catId: category_id);
        emit(EnrollSutdentsSuccessState());
      }
    }).catchError((error) {
      emit(EnrollSutdentsErrorState());
    });
  }

  SliderModel? sliderModel;

  void getSlider() {
    emit(GetSliderLoadingState());
    DioHelper.getData(url: 'sliders').then((value) {
      sliderModel = SliderModel.fromJson(value.data);
      emit(GetSliderSuccessState());
    }).catchError((error) {
      emit(GetSliderErrorState());
    });
  }

  LevelModel? levelModel;

  void getLevel({int? catId, required int index}) {
    emit(GetLevelLoadingState(index: index));
    DioHelper.getData(
      url: 'levels',
      lang: lang,
      catid: catId,
    ).then((value) {
      var list = LevelResponse.fromJson(value.data, catId ?? 0).data;
      emit(GetLevelSuccessState(levels: list, byId: false));
    }).catchError((error) {
      emit(GetLevelErrorState());
    });
  }

  LevelModelById? levelModelById;

  List<LevelData> levels = [];

  void getLevelById({int? catId, int? studentId}) {
    emit(GetLevelLoadingState(index: -1));
    DioHelper.getData(
            url: 'levels',
            catid: catId,
            studId: studentId,
            token: CacheHelper.getData(key: 'token_student'))
        .then((value) {
      levelModelById = LevelModelById.fromJson(value.data);
      emit(GetLevelSuccessState(levels: [], byId: true));
    }).catchError((error) {
      emit(GetLevelErrorState());
    });
  }

  ClassModel? classModel;

  void getLevelCourses({int? id}) {
    emit(GetClassLoadingState());
    DioHelper.getData(
      url: 'courses',
      lvlID: id,
      lang: lang,
    ).then((value) {
      classModel = ClassModel.fromJson(value.data);
      emit(GetClassSuccessState());
    }).catchError((error) {
      emit(GetClassErrorState());
    });
  }

  void startClass({int? id}) {
    emit(StartClassLoadingState());
    DioHelper.postData(
            url: 'enroll-course',
            data: {},
            student_id: CacheHelper.getData(key: 'id'),
            token: CacheHelper.getData(key: 'token_student'),
            course_id: id)
        .then((value) {
      // toast(msg: '${value.data['message']}', color: Colors.green);
      emit(StartClassSuccessState());
    }).catchError((error) {
      emit(StartClassErrorState());
    });
  }

  MyCourseModel? myCourseModel;

  void myCourses({int? id}) {
    emit(GetMyCoursesLoadingState());
    DioHelper.getData(
            url: 'student/courses',
            token: CacheHelper.getData(key: 'token_student'),
            studId: id)
        .then((value) {
      myCourseModel = MyCourseModel.fromJson(value.data);
      emit(GetMyCoursesSuccessState());
    }).catchError((error) {
      emit(GetMyCoursesErrorState());
    });
  }

  PackageModel? packageModel;

  void getPackageById({int? id}) {
    emit(GetPackageByIdLoadingState());
    DioHelper.getData(url: 'package', lang: lang, packageId: id).then((value) {
      if (value.statusCode == 200) {
        packageModel = PackageModel.fromJson(value.data);
        emit(GetPackageByIdSuccessState());
      }
      if (value.statusCode == 422) {
        toast(msg: value.data['message'], color: Colors.red);
        emit(GetPackageByIdErrorState());
      }
      if (value.statusCode == 500) {
        emit(GetPackageByIdErrorState());
      }
    }).catchError((error) {
      emit(GetPackageByIdErrorState());
    });
  }

  bool isPackage = false;

  void enrollPackage({int? id}) {
    emit(EnrollPackageLoadingState());
    DioHelper.postData(
            url: 'enroll-package',
            data: {},
            packageId: id,
            token: CacheHelper.getData(key: 'token_student'))
        .then((value) {
      emit(EnrollPackageSuccessState());
    }).catchError((error) {
      emit(EnrollPackageErrorState());
    });
  }

  void sendFireBaseToken() {
    DioHelper.postData(
            url: 'device-token-guardian',
            data: {'device_token': CacheHelper.getData(key: 'fireBase_token')},
            token: CacheHelper.getData(key: 'token_student'))
        .then((value) {
      emit(SendFirebaseTokenSuccessState());
    }).catchError((error) {
      emit(SendFirebaseTokenErrorState());
    });
  }

  MyChildrenModel? myChildrenModel;

  void getMyChildren() {
    emit(GetMyChildrenLoadingState());
    DioHelper.getData(url: 'students', token: CacheHelper.getData(key: 'token_student'))
        .then((value) {
      if (value.statusCode == 200) {
        myChildrenModel = MyChildrenModel.fromJson(value.data);
        emit(GetMyChildrenSuccessState());
      }
      if (value.statusCode == 401) {
        emit(GetMyChildrenErrorState());
      }
      if (value.statusCode == 422) {
        emit(GetMyChildrenErrorState());
      }
      if (value.statusCode == 500) {
        emit(GetMyChildrenErrorState());
      }
    }).catchError((error) {
      emit(GetMyChildrenErrorState());
    });
  }

  TestModel? testModel;
  int testValue = 0;
  int? testIndex = 0;

  changeTestValue(int value) {
    testValue = value;
    emit(ChangeTestValue());
  }

  void changeTestIndex(int index) {
    testIndex = index;
    emit(ChangeTestIndexState());
  }

  int catId = 0;

  void getTest({required int id}) {
    emit(GetTestLoadingState());
    DioHelper.getData(
            url: 'exam', catid: id, token: CacheHelper.getData(key: 'token_student'))
        .then((value) {
      loading = false;
      log(value.data.toString());
      testModel = TestModel.fromJson(value.data);
      if (testModel!.data.isNotEmpty) {
        emit(GetTestSuccessState());
      } else {
        emit(GetTestDataEmptyState());
      }
    }).catchError((error) {
      emit(GetTestErrorState());
    });
  }

  PaymentHistoryModel? paymentHistoryModel;

  void getPaymentHistory() {
    emit(GetPaymentHistoryLoadingState());
    DioHelper.getData(url: 'invoices', token: CacheHelper.getData(key: 'token_student'))
        .then((value) {
      if (value.statusCode == 200) {
        paymentHistoryModel = PaymentHistoryModel.fromJson(value.data);
        emit(GetPaymentHistorySuccessState());
      } else {
        emit(GetPaymentHistoryErrorState());
      }
    }).catchError((error) {
      emit(GetPaymentHistoryErrorState());
    });
  }

  sendExam(int examId) {
    emit(SendExamLoadingState());
    DioHelper.postData(
            url: 'exam/submit',
            token: CacheHelper.getData(key: 'token_student'),
            student_id: childId,
            lang: lang,
            exam_id: examId,
            data: answers)
        .then((value) {
      loading = false;
      testValue = 0;
      testIndex = 0;
      emit(SendExamSuccessState());
      getLevelById(catId: catId, studentId: childId);
    }).catchError((error) {
      emit(SendExamErrorState());
    });
  }

  ChildData? editMyChild;

  deleteMyChild(int id) {
    emit(DeleteMyChildLoadingState());
    DioHelper.deleteData(
            url: 'students',
            data: {},
            student_id: id,
            token: CacheHelper.getData(key: 'token_student'))
        .then((value) {
      emit(DeleteMyChildSuccessState());
    }).catchError((error) {
      emit(DeleteMyChildErrorState());
    });
  }
}
