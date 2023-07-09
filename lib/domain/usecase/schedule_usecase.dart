import '../../data/network/failure.dart';
import '../models/schedule_model.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';
import 'package:dartz/dartz.dart';

class ScheduleUseCase extends BaseUseCase<ScheduleUseCaseInput,ScheduleModel>{
  final Repository _repository;
  ScheduleUseCase(this._repository);

  @override
  Future<Either<Failure, ScheduleModel>> execute(ScheduleUseCaseInput input) async{
    return await _repository.getSchedule(input.authorization);
  }




}

class ScheduleUseCaseInput{
  String authorization;
  ScheduleUseCaseInput(this.authorization);
}