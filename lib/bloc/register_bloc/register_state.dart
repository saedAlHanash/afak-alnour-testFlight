abstract class RegisterState {}

class InitialRegisterState extends RegisterState {}

class RegisterChildSuccessRegisterState extends RegisterState {}
class RegisterParentSuccessRegisterState extends RegisterState {}

class EditChildSuccessRegisterState extends RegisterState {}

class RegisterChildErrorRegisterState extends RegisterState {
  var error;
  RegisterChildErrorRegisterState({required this.error});
}

class RegisterChildLoadingRegisterState extends RegisterState {}
class ChangePasswordState extends RegisterState {}
class ChangeAddress extends RegisterState {}
