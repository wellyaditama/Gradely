import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gradely_app/model/history.dart';
import 'package:gradely_app/model/user_register.dart';
import 'package:gradely_app/model/user_uid.dart';
import 'package:gradely_app/services/firebase/cloud_firestore_service.dart';
import 'package:gradely_app/widgets/teacher/history_list.dart';
import 'package:gradely_app/widgets/widget_loading_screens.dart';
import 'package:provider/provider.dart';

class HistoryTeacher extends StatefulWidget {
  const HistoryTeacher({Key? key, required this.userRegister})
      : super(key: key);

  final UserRegister userRegister;

  @override
  _HistoryTeacherState createState() => _HistoryTeacherState();
}

class _HistoryTeacherState extends State<HistoryTeacher> {
  @override
  Widget build(BuildContext context) {
    final uid = Provider.of<UserUID?>(context);

    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseTeacherClass(uid!.uid, '').listHistoryTeacher,
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
                  const Text(
                    "No recent activity!",
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
            List<TeacherHistory> history = listHistoryFromSnapshot(snapshot);
            return Column(
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  width: double.infinity,
                  child: const Text(
                    'Recent Activity : ',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      color: Colors.black54,
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                const Divider(),
                HistoryList(
                  listHistory: history,
                )
              ],
            );
          }
        } else
          return WidgetLoadingScreens();
      },
    );
  }

  List<TeacherHistory> listHistoryFromSnapshot(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    List<TeacherHistory> _listHistory = [];

    snapshot.data!.docs.forEach((doc) {
      _listHistory.add(
        TeacherHistory(
          doc['title'],
          doc['description'],
          doc['date'],
        ),
      );
    });

    return _listHistory;
  }
}
