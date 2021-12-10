import 'package:flutter/material.dart';
import 'package:gradely_app/model/classroom.dart';

import 'classes_list_student_item.dart';

class ClassesListStudent extends StatefulWidget {
  final List<Classroom> classrooms;

  const ClassesListStudent({Key? key, required this.classrooms}) : super(key: key);

  @override
  _ClassesListStudentState createState() => _ClassesListStudentState();
}

class _ClassesListStudentState extends State<ClassesListStudent> {

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.classrooms.length,
      itemBuilder: (BuildContext context, int index) {
        return ClassesListStudentItem(classroom: widget.classrooms[index],);
      },
    );
  }
}