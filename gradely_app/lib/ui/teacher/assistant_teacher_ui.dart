import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gradely_app/model/user_register.dart';
import 'package:gradely_app/model/user_uid.dart';
import 'package:gradely_app/services/firebase/cloud_firestore_service.dart';
import 'package:gradely_app/widgets/teacher/students_list.dart';
import 'package:gradely_app/widgets/widget_loading_screens.dart';
import 'package:provider/provider.dart';

class AssistantTeacherUI extends StatefulWidget {
  const AssistantTeacherUI({Key? key}) : super(key: key);

  @override
  _AssistantTeacherUIState createState() => _AssistantTeacherUIState();
}

class _AssistantTeacherUIState extends State<AssistantTeacherUI> {
  @override
  Widget build(BuildContext context) {
    final uid = Provider.of<UserUID?>(context);

    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseTeacherClass(uid!.uid, '').listAssistantTeacher,
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
                    "You don't have student!",
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
            List<UserRegister> students = listStudentsFromSnapshot(snapshot);
            return StudentsList(
              listStudent: students,
            );
          }
        } else
          return WidgetLoadingScreens();
      },
    );
  }

  List<UserRegister> listStudentsFromSnapshot(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    List<UserRegister> _listStudents = [];

    snapshot.data!.docs.forEach((doc) {
      _listStudents.add(
        UserRegister(
          doc['email'],
          doc['isVerified'],
          doc['name'],
          doc['university'],
          doc['gender'],
          doc['semester'],
          doc['currentAccountType'],
          doc['uid'],
        ),
      );
    });

    return _listStudents;
  }
}
