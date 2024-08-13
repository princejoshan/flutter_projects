import 'package:flutter/material.dart';
import 'package:todoapp/model/user_model.dart';
import 'package:todoapp/utilities/navigation_manager.dart';

class UserScreen extends StatefulWidget {
  final UserModel? currentUser;

  const UserScreen({super.key, this.currentUser});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomePage"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, ScreenRoutes.login);
              },
              child: const Text("Logout"))
        ],
      ),
      body: Center(
        child: Text("Welcome ${widget.currentUser?.email ?? ""}"),
      ),
    );
  }
}
