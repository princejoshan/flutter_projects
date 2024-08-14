import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/firebase_options.dart';
import 'package:todoapp/utilities/appcolors.dart';
import 'package:todoapp/utilities/navigation_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    // _initializeFireBase();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        onGenerateRoute: ScreenRoutes.routes,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
          useMaterial3: true,
        ),
        initialRoute: ScreenRoutes.login);
  }
}

