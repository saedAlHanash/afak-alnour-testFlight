import 'package:flutter_stripe/flutter_stripe.dart';

import '../../model/levle_response.dart';

abstract class HomeState {}

class InitialHomeState extends HomeState {}

class ChangeLocalHomeState extends HomeState {}

class GetCoursesSuccessHomeState extends HomeState {}

class GetCoursesLoadingHomeState extends HomeState {}

class GetCoursesErrorHomeState extends HomeState {
  var error;

  GetCoursesErrorHomeState({required this.error});
}

class GetPackageLoadingState extends HomeState {}

class GetPackageSuccessState extends HomeState {}

class GetPackageErrorState extends HomeState {}

class GetSeasonalLoadingState extends HomeState {}

class GetSeasonalSuccessState extends HomeState {}

class GetSeasonalErrorState extends HomeState {}

class GetCategoriesLoadingState extends HomeState {}

class GetCategoriesSuccessState extends HomeState {}

class GetCategoriesErrorState extends HomeState {}

class GetSliderLoadingState extends HomeState {}

class GetSliderSuccessState extends HomeState {}

class GetSliderErrorState extends HomeState {}

class EnrollSutdentsLoadingState extends HomeState {}

class EnrollSutdentsSuccessState extends HomeState {}

class EnrollSutdentsErrorState extends HomeState {}

class GetLevelLoadingState extends HomeState {
  int index = -1;

  GetLevelLoadingState({
    required this.index,
  });
}

class GetLevelSuccessState extends HomeState {
  List<LevelData> levels = [];
  bool byId = false;

  GetLevelSuccessState({
    required this.levels,
    required this.byId,
  });

}

class GetLevelErrorState extends HomeState {}

class ChangeBottomBarState extends HomeState {}

class GetClassLoadingState extends HomeState {}

class GetClassSuccessState extends HomeState {}

class GetClassErrorState extends HomeState {}

class StartClassLoadingState extends HomeState {}

class StartClassSuccessState extends HomeState {}

class StartClassErrorState extends HomeState {}

class GetMyCoursesLoadingState extends HomeState {}

class GetMyCoursesSuccessState extends HomeState {}

class GetMyCoursesErrorState extends HomeState {}

class GetPackageByIdLoadingState extends HomeState {}

class GetPackageByIdSuccessState extends HomeState {}

class GetPackageByIdErrorState extends HomeState {}

class EnrollPackageLoadingState extends HomeState {}

class EnrollPackageSuccessState extends HomeState {}

class EnrollPackageErrorState extends HomeState {}

class SendFirebaseTokenSuccessState extends HomeState {}

class SendFirebaseTokenErrorState extends HomeState {}

class GetMyChildrenLoadingState extends HomeState {}

class GetMyChildrenSuccessState extends HomeState {}

class GetMyChildrenErrorState extends HomeState {}

class EnrollStudentToLevelState extends HomeState {}

class AddChildToCardLoadingState extends HomeState {}

class AddChildToCardSuccessState extends HomeState {}

class RemoveChildFromCardSuccessState extends HomeState {

}

class DeleteAllCardInformationState extends HomeState {}

class ChangeTestIndexState extends HomeState {}

class LoadingState extends HomeState {}

class GetPaymentHistoryLoadingState extends HomeState {}

class GetPaymentHistorySuccessState extends HomeState {}

class GetPaymentHistoryErrorState extends HomeState {}

class GetTestLoadingState extends HomeState {}

class GetTestSuccessState extends HomeState {}

class GetTestErrorState extends HomeState {}

class GetTestDataEmptyState extends HomeState {}

class ChangeTestValue extends HomeState {}

class AnswersAdded extends HomeState {}

class SendExamLoadingState extends HomeState {}

class SendExamSuccessState extends HomeState {}

class SendExamErrorState extends HomeState {}

class DeleteMyChildLoadingState extends HomeState {}

class DeleteMyChildSuccessState extends HomeState {}

class DeleteMyChildErrorState extends HomeState {}
