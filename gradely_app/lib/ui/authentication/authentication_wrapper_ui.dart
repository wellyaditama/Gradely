import 'package:flutter/material.dart';
import 'package:gradely_app/ui/authentication/register_ui.dart';

import 'login_ui.dart';

class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  State<AuthenticationWrapper> createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  @override
  Widget build(BuildContext context) {
    bool showSignIn = false;
    void toggleView() {
      setState(() {
        showSignIn = !showSignIn;
      });
    }

    if (showSignIn) {
      return LoginUI(toggleView: toggleView);
    } else {
      return RegisterUI(toggleView: toggleView);
    }
  }
}
