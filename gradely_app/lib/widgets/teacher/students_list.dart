import 'package:flutter/material.dart';
import 'package:gradely_app/model/user_register.dart';
import 'package:gradely_app/widgets/teacher/students_list_tile.dart';

class StudentsList extends StatefulWidget {
  final List<UserRegister> listStudent;

  const StudentsList({Key? key, required this.listStudent}) : super(key: key);

  @override
  _StudentsListState createState() => _StudentsListState();
}

class _StudentsListState extends State<StudentsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.listStudent.length,
      itemBuilder: (BuildContext context, int index) {
        return StudentListTile(
          userRegister: widget.listStudent[index],
        );
      },
    );
  }
}
