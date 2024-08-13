part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class EmailChanged extends LoginEvent {
  final String email;

  EmailChanged(this.email);
}

class PasswordChanged extends LoginEvent {
  final String password;

  PasswordChanged(this.password);
}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String pwd;

  LoginSubmitted({required this.email, required this.pwd});
}

class SignUpEvent extends LoginEvent {
  final String email;
  final String pwd;
  final String role;

  SignUpEvent({required this.email, required this.pwd, required this.role});
}
