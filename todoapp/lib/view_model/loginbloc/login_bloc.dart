import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todoapp/model/user_model.dart';
import 'package:todoapp/repositories/user_repository.dart';
import 'package:todoapp/utilities/app_enums.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  String _email = '';
  String _password = '';
  final UserRepository userRepository;

  LoginBloc({required this.userRepository}) : super(LoginInitial()) {
    on<EmailChanged>((event, emit) {
      _onEmailChanged(event, emit);
    });
    on<PasswordChanged>((event, emit) {
      _onPasswordChanged(event, emit);
    });
    on<LoginSubmitted>((event, emit) async {
      await validateLoginRequest(event, emit);
    });
    on<SignUpEvent>((event, emit) async {
      await validateSignUpRequest(event, emit);
    });
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    _email = event.email;
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    _password = event.password;
  }

  String? validateEmail(String email) {
    if (email.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  String? validateRole(String password) {
    if (password.isEmpty) {
      return 'Please enter your role';
    }
    return null;
  }

  Future<void> validateLoginRequest(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    try {
      emit(const LoginSuccess(status: TaskStatus.loading));
      final user = await userRepository.signIn(event.email, event.pwd);
      if (user.uid != null) {
        emit( LoginSuccess(
            status: TaskStatus.success, msg: 'Logged in Successfully',currentUser:user));
      }
    } catch (e) {
      emit(LoginSuccess(status: TaskStatus.error, msg: e.toString()));
    }
  }

  Future<void> validateSignUpRequest(
      SignUpEvent event, Emitter<LoginState> emit) async {
    try {
      emit(const SignUpSuccess(status: TaskStatus.loading));
      final user = await userRepository.signUp(
          email: event.email, password: event.pwd, role: event.role);
      if (user.user?.uid != null) {
        emit(const SignUpSuccess(
            status: TaskStatus.success, msg: 'Registered Successfully'));
      }
    } catch (e) {
      emit(SignUpSuccess(status: TaskStatus.error, msg: e.toString()));
    }
  }
}
