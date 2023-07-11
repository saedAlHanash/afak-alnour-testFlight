import '../../data/network/failure.dart';
import '../../data/network/requstes/login_request.dart';
import '../models/user_model.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase extends BaseUseCase<LoginUseCaseInputs, UserDataModel> {
  final Repository _repository;
  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, UserDataModel>> execute(
      LoginUseCaseInputs input) async {
    return await _repository.login(LoginRequest(input.email, input.password));
  }
}

class LoginUseCaseInputs {
  String email;
  String password;

  LoginUseCaseInputs(this.email, this.password);
}
