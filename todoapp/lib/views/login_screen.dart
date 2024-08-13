import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/utilities/app_enums.dart';
import 'package:todoapp/utilities/buttonwidget.dart';
import 'package:todoapp/utilities/loader.dart';
import 'package:todoapp/utilities/navigation_manager.dart';
import 'package:todoapp/view_model/loginbloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Form key to identify the form

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Login'), elevation: 0.5),
        body: _getBody(context: context));
  }

  Widget _getBody({required BuildContext context}) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (context, state) {
        return state is LoginSuccess;
      },
      listener: (context, state) {
        if (state is LoginSuccess) {
          if (state.status == TaskStatus.loading) {
            Loader.of(context).show();
          } else {
            Loader.of(context).hide();
            if (state.status == TaskStatus.success) {
              _showSnackBar(context, state.msg ?? "");
              var arg = {
                'current_user':state.currentUser
              };
              Navigator.pushReplacementNamed(
                arguments: arg,
                  context,
                  (state.currentUser?.role == 'admin')
                      ? ScreenRoutes.home
                      : ScreenRoutes.normalUser);
            } else {
              _showSnackBar(context, state.msg ?? "");
            }
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  return context.read<LoginBloc>().validateEmail(value ?? "");
                },
              ),
              TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    return context
                        .read<LoginBloc>()
                        .validatePassword(value ?? "");
                  }),
              const SizedBox(height: 20),
              AppButtonWidget(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(LoginSubmitted(
                        email: _emailController.text,
                        pwd: _passwordController.text));
                  }
                },
                title: ('Login'),
              ),
              const SizedBox(height: 20),
              AppButtonWidget(
                onPressed: () {
                  Navigator.pushNamed(context, ScreenRoutes.signup);
                },
                title: ('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {
          // Handle the "Undo" action
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
