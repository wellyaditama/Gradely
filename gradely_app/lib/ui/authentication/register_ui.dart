import 'package:flutter/material.dart';

class RegisterUI extends StatefulWidget {
  const RegisterUI({Key? key, required this.toggleView}) : super(key: key);

  final Function toggleView;

  @override
  _RegisterUIState createState() => _RegisterUIState();
}

class _RegisterUIState extends State<RegisterUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('This is register ui'),
      ),
    );
  }
}
