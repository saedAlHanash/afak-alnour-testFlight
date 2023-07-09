
import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../../data/network/requstes/edit_user_request.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class EditUserInfoUseCase extends BaseUseCase<EditUserRequest,void> {
  final Repository _repository;
  EditUserInfoUseCase(this._repository);

  @override
  Future<Either<Failure, void>> execute(EditUserRequest input) async{
    return await _repository.editUserInfo(input);
  }


}

