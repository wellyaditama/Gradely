import 'package:flutter/material.dart';
import 'package:gradely_app/model/classroom.dart';
import 'package:gradely_app/model/students.dart';
import 'package:gradely_app/model/user_register.dart';
import 'package:gradely_app/widgets/teacher/list_student_active_point.dart';

class AddActivePointTeacherUI extends StatelessWidget {
  const AddActivePointTeacherUI({Key? key, required this.listStudent, required this.classroom})
      : super(key: key);

  final List<Student> listStudent;
  final Classroom classroom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Active Student'),
        elevation: 20.0,
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: const Text(
                'Choose 1 active student',
                style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins',
                    fontSize: 24.0),
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: listStudent.length,
              itemBuilder: (BuildContext context, int index) {
                return ListStudentActivePoint(
                  student: listStudent[index], classroom: classroom,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
