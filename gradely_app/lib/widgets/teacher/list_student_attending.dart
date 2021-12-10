import 'package:flutter/material.dart';
import 'package:gradely_app/model/students.dart';

import 'list_student_attending_tile.dart';

class ListStudentAttending extends StatefulWidget {
  const ListStudentAttending({Key? key, required this.listStudent})
      : super(key: key);

  final List<Student> listStudent;

  @override
  _ListStudentAttendingState createState() => _ListStudentAttendingState();
}

class _ListStudentAttendingState extends State<ListStudentAttending> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.listStudent.length,
        itemBuilder: (BuildContext context, int index) {
          return StudentAttendingItem(
            student: widget.listStudent[index],
          );
        });
  }
}
