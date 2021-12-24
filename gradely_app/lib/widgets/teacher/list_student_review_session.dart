import 'package:flutter/material.dart';
import 'package:gradely_app/common/style_colors.dart';
import 'package:gradely_app/model/classroom.dart';
import 'package:gradely_app/model/student_grade.dart';
import 'package:gradely_app/model/students.dart';
import 'package:gradely_app/services/firebase/cloud_firestore_service.dart';
import 'package:gradely_app/ui/teacher/edit_grade_student.dart';
import 'package:intl/intl.dart';

class ListStudentReviewSession extends StatelessWidget {
  final StudentGrade studentGrade;
  final Classroom classroom;

  const ListStudentReviewSession(
      {Key? key, required this.classroom, required this.studentGrade})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    String stringAttendDate = dateFormat.format(studentGrade.attendanceTime);

    return InkWell(
      onTap: () {
        showModalBottomSheet(context: context, builder: (context) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: EditGradeStudent(studentGrade: studentGrade, classname: classroom.className, teacherID: classroom.teacherID,),
          );
        });
      },
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
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
                studentGrade.name,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0),
              ),
            ),
            subtitle: Text(studentGrade.email + '\n$stringAttendDate'),
            trailing: Text(
              studentGrade.grade.toString(),
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24.0,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
