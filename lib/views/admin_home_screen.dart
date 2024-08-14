import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/model/user_model.dart';
import 'package:todoapp/utilities/app_enums.dart';
import 'package:todoapp/utilities/appcolors.dart';
import 'package:todoapp/utilities/navigation_manager.dart';
import 'package:todoapp/view_model/userbloc/user_bloc.dart';
import 'package:todoapp/view_model/userbloc/user_state.dart';

import '../view_model/userbloc/user_event.dart';

class AdminHomeScreen extends StatefulWidget {
  final UserModel? currentUser;

  const AdminHomeScreen({super.key, this.currentUser});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) {
      context.read<UserBloc>().add(FetchUsersEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loadList(),
      appBar: AppBar(
        title: const Text('HomePage'),
        elevation: 0.5,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, ScreenRoutes.login);
              },
              child: const Text("Logout"))
        ],
      ),
      floatingActionButton: (widget.currentUser?.role == 'admin')
          ? FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                var arg = {
                  "bloc": context.read<UserBloc>(),
                };
                Navigator.pushNamed(context, ScreenRoutes.addEdit,
                    arguments: arg);
              },
            )
          : null,
    );
  }

  loadList() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is FetchUserState) {
          if (state.status.isSuccess) {
            return ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: state.userList?.length ?? 0,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.userList?[index].email ?? ""),
                    subtitle: Row(
                      children: [
                        Text(state.userList?[index].role ?? ""),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          (state.userList?[index].isCurrentUser == true)
                              ? "You"
                              : "",
                          style: const TextStyle(color: AppColors.purple),
                        ),
                      ],
                    ),
                    trailing: (state.currentUser?.role != 'admin' ||
                            state.userList?[index].isCurrentUser == true)
                        ? null
                        : IconButton(
                            icon: const Icon(
                              Icons.edit,
                              size: 20,
                            ),
                            onPressed: () {
                              var selectedUserData = {
                                "bloc": context.read<UserBloc>(),
                                'userData': state.userList?[index]
                              };
                              Navigator.pushNamed(context, ScreenRoutes.addEdit,
                                  arguments: selectedUserData);
                            },
                            color: AppColors.primaryColor,
                          ),
                  );
                });
          }
          if (state.status.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status.isError) {
            return Center(child: Text(state.msg ?? ""));
          }
        }
        return const SizedBox.shrink();
      },
    );
  }
}
