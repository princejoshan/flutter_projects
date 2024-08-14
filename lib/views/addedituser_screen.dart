import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/model/user_model.dart';
import 'package:todoapp/utilities/app_enums.dart';
import 'package:todoapp/utilities/buttonwidget.dart';
import 'package:todoapp/utilities/loader.dart';
import 'package:todoapp/view_model/userbloc/user_bloc.dart';
import 'package:todoapp/view_model/userbloc/user_event.dart';
import 'package:todoapp/view_model/userbloc/user_state.dart';

class AddEditUserScreen extends StatefulWidget {
  final UserModel? selectedUserData;

  const AddEditUserScreen({super.key, this.selectedUserData});

  @override
  State<AddEditUserScreen> createState() => _AddEditUserScreenState();
}

class _AddEditUserScreenState extends State<AddEditUserScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _roleController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  UserBloc? userBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.selectedUserData != null) {
      _emailController.text = widget.selectedUserData?.email ?? "";
      _passwordController.text = widget.selectedUserData?.pwd ?? "";
      _roleController.text = widget.selectedUserData?.role ?? "";
    }
  }

  // Form key to identify the form
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(context: context),
      appBar: AppBar(
        title: const Text(''),
        elevation: 0.5,
      ),
    );
  }

  Widget _getBody({required BuildContext context}) {
    return BlocListener<UserBloc, UserState>(
      listenWhen: (context, state) {
        return state is UpdateUserSuccess || state is AddNewUserSuccess;
      },
      listener: (context, state) {
        if (state is UpdateUserSuccess || state is AddNewUserSuccess) {
          if (state.status == TaskStatus.loading) {
            Loader.of(context).show();
          } else {
            Loader.of(context).hide();
            if (state.status == TaskStatus.success) {
              _showMyDialog(context, "Success", state.msg ?? "",
                  state.status);
            } else {
              _showMyDialog(context, "Error", state.msg ?? "",
                  state.status);
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
                enabled: widget.selectedUserData == null,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  return context.read<UserBloc>().validateEmail(value ?? "");
                },
              ),
              TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  enabled: widget.selectedUserData == null,
                  obscureText: true,
                  validator: (value) {
                    return context
                        .read<UserBloc>()
                        .validatePassword(value ?? "");
                  }),
              TextFormField(
                  controller: _roleController,
                  decoration: const InputDecoration(labelText: 'Role'),
                  validator: (value) {
                    return context.read<UserBloc>().validateRole(value ?? "");
                  }),
              const SizedBox(height: 20),
              AppButtonWidget(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (widget.selectedUserData != null) {
                      context.read<UserBloc>().add(UpdateUsersEvent(
                          selectedUser: widget.selectedUserData,role: _roleController.text));
                    }
                    else {
                      context.read<UserBloc>().add(AddNewUserEvent(
                          email: _emailController.text,
                          pwd: _passwordController.text,
                          role: _roleController.text));
                    }
                  }
                },
                title: ('Save'),
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
      builder: (BuildContext ctx) {
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
                  context.read<UserBloc>().add(FetchUsersEvent());
                  Navigator.of(context).pop(); // Close the dialog
                } else {

                }
              },
            ),
          ],
        );
      },
    );
  }
}
