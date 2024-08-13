
import 'package:flutter/material.dart';
import 'package:todoapp/model/user_model.dart';

@immutable
sealed class UserEvent {}
class FetchUsersEvent extends UserEvent {}
class UpdateUsersEvent extends UserEvent {
  final UserModel? selectedUser;
  final String role;
  UpdateUsersEvent({required this.selectedUser,required this.role});
}
class AddNewUserEvent extends UserEvent {
  final String email;
  final String pwd;
  final String role;

  AddNewUserEvent({required this.email, required this.pwd, required this.role});
}
