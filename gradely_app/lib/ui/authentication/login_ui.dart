import 'package:flutter/material.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({Key? key, required this.toggleView}) : super(key: key);

  final Function toggleView;

  @override
  _LoginUIState createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('This is Login UI'),
      ),
    );
  }
}
