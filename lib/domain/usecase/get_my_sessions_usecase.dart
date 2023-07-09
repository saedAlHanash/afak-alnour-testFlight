import '../../data/network/failure.dart';
import '../models/my_sessions_model.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';
import 'package:dartz/dartz.dart';

class GetMySessionsUseCase extends BaseUseCase<int, MySessionsModel> {
  final Repository _repository;

  GetMySessionsUseCase(this._repository);

  @override
  Future<Either<Failure, MySessionsModel>> execute(int input) async {
    return await _repository.getMySessions(input);
  }
}
