import 'package:flutter/material.dart';
import 'package:todoapp/model/user_model.dart';
import 'package:todoapp/utilities/app_enums.dart';

@immutable
sealed class UserState {
  final TaskStatus status;
  final String? msg;

  const UserState({this.status = TaskStatus.initial, this.msg});
}

final class UserInitial extends UserState {}

class FetchUserState extends UserState {
  final List<UserModel>? userList;
  final UserModel? currentUser;
  const FetchUserState( {this.userList, super.status, super.msg,this.currentUser});
}

class UpdateUserSuccess extends UserState {
  const UpdateUserSuccess({super.status,super.msg});
}
class AddNewUserSuccess extends UserState {
  const AddNewUserSuccess({super.status,super.msg});
}
