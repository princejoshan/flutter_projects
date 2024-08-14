import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/repositories/user_repository.dart';
import 'package:todoapp/view_model/loginbloc/login_bloc.dart';
import 'package:todoapp/view_model/userbloc/user_bloc.dart';
import 'package:todoapp/views/addedituser_screen.dart';
import 'package:todoapp/views/admin_home_screen.dart';
import 'package:todoapp/views/login_screen.dart';
import 'package:todoapp/views/signup_screen.dart';
import 'package:todoapp/views/user_screen.dart';

class ScreenRoutes {
  static const String login = 'loginPage';
  static const String signup = 'signupPage';
  static const String home = 'homePage';
  static const String addEdit = 'addEdit';
  static const String normalUser = 'normalUser';

  static Route<dynamic>? routes(RouteSettings settings) {
    switch (settings.name) {
      case ScreenRoutes.login:
        return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: ScreenRoutes.login),
          builder: (BuildContext context) {
            return RepositoryProvider(
              create: (context) => UserRepository(),
              child: BlocProvider(
                create: (context) =>
                    LoginBloc(userRepository: context.read<UserRepository>()),
                child: LoginScreen(),
              ),
            );
          },
        );
      case ScreenRoutes.signup:
        return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: ScreenRoutes.signup),
          builder: (BuildContext context) {
            return RepositoryProvider(
              create: (context) => UserRepository(),
              child: BlocProvider(
                create: (context) =>
                    LoginBloc(userRepository: context.read<UserRepository>()),
                child: SignUpScreen(),
              ),
            );
          },
        );
      case ScreenRoutes.addEdit:
        return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: ScreenRoutes.addEdit),
          builder: (BuildContext context) {
            final dynamic arguments = settings.arguments;
            return RepositoryProvider(
              create: (context) => UserRepository(),
              child: BlocProvider.value(
                value: arguments['bloc'] as UserBloc,
                child:
                    AddEditUserScreen(selectedUserData: arguments?['userData']),
              ),
            );
          },
        );
      case ScreenRoutes.home:
        return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: ScreenRoutes.home),
          builder: (BuildContext context) {
            final dynamic arguments = settings.arguments;

            return RepositoryProvider(
              create: (context) => UserRepository(),
              child: BlocProvider(
                create: (context) =>
                    UserBloc(userRepository: context.read<UserRepository>()),
                child: AdminHomeScreen(currentUser: arguments?['current_user'],),
              ),
            );
          },
        );
      case ScreenRoutes.normalUser:
        return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: ScreenRoutes.normalUser),
          builder: (BuildContext context) {
            final dynamic arguments = settings.arguments;

            return RepositoryProvider(
              create: (context) => UserRepository(),
              child: BlocProvider(
                create: (context) =>
                    UserBloc(userRepository: context.read<UserRepository>()),
                child:  UserScreen(currentUser: arguments?['current_user']),
              ),
            );
          },
        );
      default:
        return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: ScreenRoutes.login),
          builder: (BuildContext context) {
            return RepositoryProvider(
              create: (context) => UserRepository(),
              child: BlocProvider(
                create: (context) =>
                    LoginBloc(userRepository: context.read<UserRepository>()),
                child: LoginScreen(),
              ),
            );
          },
        );
    }
  }
}
