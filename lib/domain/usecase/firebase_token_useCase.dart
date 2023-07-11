
import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class FireBaseTokenUseCase extends BaseUseCase<FireBaseTokenUseCaseInputs,void> {

  final Repository _repository;
  FireBaseTokenUseCase(this._repository);

  @override
  Future<Either<Failure, void>> execute(FireBaseTokenUseCaseInputs input) async {
   return  await _repository.sendFirebaseToken(input.firebase,input.authorization);
  }

}

class FireBaseTokenUseCaseInputs{
  String firebase;
  String authorization;
  FireBaseTokenUseCaseInputs(this.firebase,this.authorization);
}