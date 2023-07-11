import '../../app/constants.dart';
import '../../data/network/failure.dart';
import '../models/my_course_model.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';
import 'package:dartz/dartz.dart';

class MyCourseUseCase extends BaseUseCase<void, MyCourseModel> {
  final Repository _repository;

  MyCourseUseCase(this._repository);

  @override
  Future<Either<Failure, MyCourseModel>> execute(void input) async {
    return await _repository.getCourses(Constants.empty);
  }
}
