import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradely_app/ui/firebase_initialization.dart';
import 'package:gradely_app/ui/splash_screens_ui.dart';

import 'common/styles.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Styles.themeColor,
        primaryColor: Styles.primaryColor,
        fontFamily: "Poppins",
      ),
      home: SplashScreensUI(),
      routes: {
        FirebaseInitialization.routeName: (context) => FirebaseInitialization(),
      },
    );
  }
}
