import 'package:flutter/material.dart';
import 'package:gradely_app/common/styles.dart';
import 'package:gradely_app/model/classroom.dart';
import 'package:gradely_app/model/students.dart';
import 'package:gradely_app/services/firebase/cloud_firestore_service.dart';
import 'package:intl/intl.dart';

class ListStudentActivePoint extends StatelessWidget {
  final Student student;
  final Classroom classroom;

  const ListStudentActivePoint({Key? key,required this.classroom, required this.student})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    String stringAttendDate = dateFormat.format(student.attendanceTime);

    return InkWell(
      onTap: () async {
        await DatabaseTeacherClass(classroom.teacherID, classroom.className).addStudentToActiveStudent(student).then((value) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Successfully added!')));
        });
      },
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          color: Styles.accentColor2,
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
      ),
    );
  }
}