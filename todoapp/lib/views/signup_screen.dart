import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/utilities/app_enums.dart';
import 'package:todoapp/utilities/buttonwidget.dart';
import 'package:todoapp/utilities/loader.dart';
import 'package:todoapp/view_model/loginbloc/login_bloc.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Form key to identify the form

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(context: context),
      appBar: AppBar(
        title: const Text('Sign Up'),
        elevation: 0.5,
      ),
    );
  }

  Widget _getBody({required BuildContext context}) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (context, state) {
        return state is SignUpSuccess;
      },
      listener: (context, state) {
        if (state is SignUpSuccess) {
          if (state.status == TaskStatus.loading) {
            Loader.of(context).show();
          } else {
            Loader.of(context).hide();
            if (state.status == TaskStatus.success) {
              _showMyDialog(context, "Success", state.msg ?? "",
                  state.status ?? TaskStatus.initial);
            } else {
              _showMyDialog(context, "Error", state.msg ?? "",
                  state.status ?? TaskStatus.initial);
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
              TextFormField(
                  controller: _roleController,
                  decoration: const InputDecoration(labelText: 'Role'),
                  obscureText: true,
                  validator: (value) {
                    return context.read<LoginBloc>().validateRole(value ?? "");
                  }),
              const SizedBox(height: 20),
              AppButtonWidget(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(SignUpEvent(
                        email: _emailController.text,
                        pwd: _passwordController.text,
                        role: _roleController.text));
                  }
                },
                title: ('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog(
      BuildContext context, String title, String msg, TaskStatus status) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                if (status.isSuccess) {
                  Navigator.of(context).pop(); // Close the dialog
                } else {}
              },
            ),
          ],
        );
      },
    );
  }
}
