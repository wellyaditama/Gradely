import 'package:flutter/material.dart';
import 'package:gradely_app/common/style_colors.dart';
import 'package:gradely_app/model/students.dart';
import 'package:intl/intl.dart';

class StudentAttendingItem extends StatelessWidget {
  final Student student;

  const StudentAttendingItem({Key? key, required this.student})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    String stringAttendDate = dateFormat.format(student.attendanceTime);

    return Card(
      margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        color: StyleColors.accentColor2,
        child: ListTile(
          leading: Image.asset(
            'assets/ic_student_male.png',
            width: 50.0,
            height: 50.0,
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              student.name,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 20.0
              ),
            ),
          ),
          subtitle: Text(student.email + '\n$stringAttendDate'),
        ),
      ),
    );
  }
}
