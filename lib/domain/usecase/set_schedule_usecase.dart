import '../../data/network/failure.dart';
import '../../data/network/requstes/test_request.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';
import 'package:dartz/dartz.dart';

class SetScheduleUseCase extends BaseUseCase<SetScheduleUseCaseInputs,void> {

  final Repository _repository;
  SetScheduleUseCase(this._repository);


  @override
  Future<Either<Failure, dynamic>> execute(input) async {
    return await _repository.setSchedule(input.data,input.authorization);
  }
}

class SetScheduleUseCaseInputs{
  String authorization;
  TestRequest data = TestRequest({});
  SetScheduleUseCaseInputs(this.authorization,this.data);
}