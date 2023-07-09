import '../../data/network/failure.dart';
import '../models/student_in_course_model.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';
import 'package:dartz/dartz.dart';

class GetStudentInCourseUseCase extends BaseUseCase<int, StudentInCourseModel> {
  final Repository _repository;

  GetStudentInCourseUseCase(this._repository);

  @override
  Future<Either<Failure, StudentInCourseModel>> execute(int input) async {
    return await _repository.getStudentInCourse(input);
  }
}
