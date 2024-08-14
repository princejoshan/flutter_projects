import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/repositories/user_repository.dart';
import 'package:todoapp/utilities/app_enums.dart';
import 'package:todoapp/view_model/userbloc/user_event.dart';
import 'package:todoapp/view_model/userbloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<FetchUsersEvent>((event, emit) async {
      await fetchUserRequest(event, emit);
    });
    on<UpdateUsersEvent>((event, emit) async {
      await updateUserRequest(event, emit);
    });
    on<AddNewUserEvent>((event, emit) async {
      await addNewUserRequest(event, emit);
    });
  }

  Future<void> fetchUserRequest(
      FetchUsersEvent event, Emitter<UserState> emit) async {
    try {
      emit(const FetchUserState(status: TaskStatus.loading));
      final user = await userRepository.getUsers();
      var findCurrentUserIndex = user.indexWhere(
          (element) => element.uid == userRepository.currentUser?.uid);
      if (findCurrentUserIndex != -1) {
        user[findCurrentUserIndex].isCurrentUser = true;
      }
      emit(FetchUserState(
          userList: user, status: TaskStatus.success, msg: "Success",currentUser: userRepository.currentUser));
    } catch (e) {
      emit(const FetchUserState(status: TaskStatus.success, msg: "Success"));
    }
  }

  Future<void> updateUserRequest(
      UpdateUsersEvent event, Emitter<UserState> emit) async {
    try {
      emit(const UpdateUserSuccess(status: TaskStatus.loading));
      await userRepository.updateUserRole(
          event.selectedUser?.uid ?? "", event.role);
      emit(const UpdateUserSuccess(
          status: TaskStatus.success,
          msg: "Role has been updated successfully"));
    } catch (e) {
      emit(const UpdateUserSuccess(status: TaskStatus.success, msg: "Success"));
    }
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

  Future<void> addNewUserRequest(
      AddNewUserEvent event, Emitter<UserState> emit) async {
    try {
      emit(const AddNewUserSuccess(status: TaskStatus.loading));
      final user = await userRepository.signUp(
          email: event.email, password: event.pwd, role: event.role);
      if (user.user?.uid != null) {
        emit(const AddNewUserSuccess(
            status: TaskStatus.success, msg: 'New User Added Successfully'));
      }
    } catch (e) {
      emit(AddNewUserSuccess(status: TaskStatus.error, msg: e.toString()));
    }
  }
}
