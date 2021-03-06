import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gradely_app/model/classroom.dart';
import 'package:gradely_app/model/user_uid.dart';
import 'package:gradely_app/services/firebase/cloud_firestore_service.dart';
import 'package:gradely_app/widgets/teacher/classes_list.dart';
import 'package:gradely_app/widgets/widget_loading_screens.dart';
import 'package:provider/provider.dart';

class ClassesTeacherUI extends StatefulWidget {
  const ClassesTeacherUI({Key? key}) : super(key: key);

  @override
  _ClassesTeacherUIState createState() => _ClassesTeacherUIState();
}

class _ClassesTeacherUIState extends State<ClassesTeacherUI> {
  @override
  Widget build(BuildContext context) {
    final uid = Provider.of<UserUID?>(context);

    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseTeacherClass(uid!.uid, '').listClassroomTeacher,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.size == 0) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/ic_undraw_study.png',
                    fit: BoxFit.fill,
                  ),
                  Text(
                    "You don't have class! Create a new one!",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black54,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            );
          } else {
            List<Classroom> classrooms = listClassroomFromSnapshot(snapshot);
            return ClassesList(
              classrooms: classrooms,
            );
          }
        } else
          return WidgetLoadingScreens();
      },
    );
  }

  List<Classroom> listClassroomFromSnapshot(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    List<Classroom> _listClassroom = [];

    snapshot.data!.docs.forEach((doc) {
      Timestamp classBegin = doc['classBegin'];
      Timestamp classEnd = doc['classEnd'];

      DateTime dateClassBegin = DateTime.parse(classBegin.toDate().toString());
      DateTime dateClassEnd = DateTime.parse(classEnd.toDate().toString());

      _listClassroom.add(Classroom(
          doc['className'],
          doc['subjectName'],
          doc['teacherName'],
          doc['teacherID'],
          doc['classPicture'],
          dateClassBegin,
          dateClassEnd,
          doc['studentCount'],
          doc['day'],
          doc['classToken'],
          doc['isStarted'] ?? false));
    });

    return _listClassroom;
  }
}
