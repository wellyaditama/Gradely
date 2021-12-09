import 'package:flutter/material.dart';
import 'package:gradely_app/widgets/widget_email_not_verified.dart';

class HomeTeacherUI extends StatelessWidget {
  const HomeTeacherUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          WidgetEmailNotVerified(),
        ],
      ),
    );
  }
}
