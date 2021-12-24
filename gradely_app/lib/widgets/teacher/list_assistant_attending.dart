import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gradely_app/model/students.dart';
import 'package:gradely_app/services/firebase/cloud_firestore_service.dart';

import '../widget_loading_screens.dart';
import 'list_student_attending_tile.dart';

class ListAssistantAttending extends StatefulWidget {
  const ListAssistantAttending(
      {Key? key, required this.teacherID, required this.className})
      : super(key: key);

  final String teacherID;
  final String className;

  @override
  _ListAssistantAttendingState createState() => _ListAssistantAttendingState();
}

class _ListAssistantAttendingState extends State<ListAssistantAttending> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseTeacherClass(widget.teacherID, widget.className)
          .listAssistantAttending,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.size == 0) {
            return Column(
              children: [
                Image.asset('assets/ic_undraw_scan.png'),
                const Text(
                  'No assistant attend this subject!',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                    color: Colors.black54
                  ),
                )
              ],
            );
          } else {
            List<Student> _listStudent = listStudentFromSnapshot(snapshot);
            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _listStudent.length,
                itemBuilder: (BuildContext context, int index) {
                  return StudentAttendingItem(
                    student: _listStudent[index],
                  );
                });
          }
        } else {
          return const WidgetLoadingScreens();
        }
      },
    );
  }

  List<Student> listStudentFromSnapshot(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    List<Student> _listStudent = [];

    snapshot.data!.docs.forEach((doc) {
      Timestamp attendanceTime = doc['attendanceTime'];

      DateTime dateTimeAttendanceTime =
          DateTime.parse(attendanceTime.toDate().toString());

      _listStudent.add(Student(
        doc['uid'],
        doc['email'],
        doc['name'],
        dateTimeAttendanceTime,
      ));
    });

    return _listStudent;
  }
}
