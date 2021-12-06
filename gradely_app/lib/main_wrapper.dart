import 'package:flutter/material.dart';
import 'package:gradely_app/ui/authentication/authentication_wrapper_ui.dart';
import 'package:gradely_app/ui/teacher/home_teacher_ui.dart';
import 'package:provider/provider.dart';

import 'model/user_uid.dart';

class MainWrapper extends StatelessWidget {
  const MainWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserUID?>(context);
    print(user);

    if (user == null) {
      return AuthenticationWrapper();
    } else {
      return HomeTeacherUI();
    }
  }
}
