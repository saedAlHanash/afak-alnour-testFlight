abstract class LoginState{}

class LoginInitalState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginErrorState extends LoginState {}

class LoginChildSuccessState extends LoginState {}


class ChangeUserState extends LoginState {}
class ChangePasswordState extends LoginState {}
