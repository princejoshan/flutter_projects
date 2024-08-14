part of 'login_bloc.dart';

@immutable
sealed class LoginState {
  final TaskStatus? status;
  final String? msg;
  const LoginState({this.status,this.msg});
}

class LoginInitial extends LoginState {}


class LoginSuccess extends LoginState {
  final UserModel? currentUser;
  const LoginSuccess({super.status,super.msg,this.currentUser});
}

class LoginFormInvalid extends LoginState {
  final String emailError;
  final String passwordError;

  const LoginFormInvalid({required this.emailError, required this.passwordError});
}

class SignUpSuccess extends LoginState {
  const SignUpSuccess({super.status,super.msg});
}
