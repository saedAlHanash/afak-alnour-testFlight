import '../../data/network/failure.dart';
import '../models/session_by_id_model.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';
import 'package:dartz/dartz.dart';

class GetSessionByIdUseCase extends BaseUseCase<int, SessionByIdModel> {
  final Repository _repository;

  GetSessionByIdUseCase(this._repository);

  @override
  Future<Either<Failure, SessionByIdModel>> execute(int input) async {
    return await _repository.getSessionById(input);
  }
}
