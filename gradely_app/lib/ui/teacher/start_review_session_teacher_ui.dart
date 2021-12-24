import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gradely_app/common/utils.dart';
import 'package:gradely_app/model/classroom.dart';
import 'package:gradely_app/model/history.dart';
import 'package:gradely_app/model/student_grade.dart';
import 'package:gradely_app/model/students.dart';
import 'package:gradely_app/services/firebase/cloud_firestore_service.dart';
import 'package:gradely_app/services/pdf/pdf_api.dart';
import 'package:gradely_app/services/pdf/pdf_review_session.dart';
import 'package:gradely_app/widgets/teacher/list_student_active_point.dart';
import 'package:gradely_app/widgets/teacher/list_student_review_session.dart';
import 'package:gradely_app/widgets/widget_error.dart';
import 'package:gradely_app/widgets/widget_loading_screens.dart';
import 'package:pdf/pdf.dart';

class StartReviewSessionTeacherUI extends StatefulWidget {
  const StartReviewSessionTeacherUI(
      {Key? key, required this.listStudent, required this.classroom})
      : super(key: key);
  final List<Student> listStudent;
  final Classroom classroom;

  @override
  _StartReviewSessionTeacherUIState createState() =>
      _StartReviewSessionTeacherUIState();
}

class _StartReviewSessionTeacherUIState
    extends State<StartReviewSessionTeacherUI> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: DatabaseTeacherClass(
              widget.classroom.teacherID, widget.classroom.className)
          .addAllStudentToReviewSession(widget.listStudent),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return StreamBuilder<QuerySnapshot>(
            stream: DatabaseTeacherClass(
                    widget.classroom.teacherID, widget.classroom.className)
                .listReviewSessionStudents,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(widget.classroom.teacherID);
                print(widget.classroom.className);
                print(snapshot.data!.size);

                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Review Sessions'),
                  ),
                  body: SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: const Text(
                            'Tap the student to edit their grade!',
                            style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'Poppins',
                                fontSize: 16.0),
                          ),
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: listStudentFromSnapshot(snapshot).length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListStudentReviewSession(
                              classroom: widget.classroom,
                              studentGrade:
                                  listStudentFromSnapshot(snapshot)[index],
                            );
                          },
                        ),
                        const SizedBox(height: 30.0,),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              
                              String detail = 'Teacher Name : ' + widget.classroom.teacherName + ', Classname : ' + widget.classroom.className;
                              
                              final pdfFile = await PdfReviewSession.generate(widget.classroom, listStudentFromSnapshot(snapshot));
                              await DatabaseTeacherClass(widget.classroom.teacherID, widget.classroom.className).addTeacherHistory(TeacherHistory('Review Session', detail, Utility.convertDateTo12HFormat(DateTime.now())));
                              await DatabaseTeacherClass(widget.classroom.teacherID, widget.classroom.className).removeReviewSession().then((value) => Navigator.pop(context));

                              PdfApi.openFile(pdfFile);
                            },
                            icon: const Icon(Icons.done_all_outlined),
                            label: const Text('Finish Review Session', style: TextStyle(fontFamily: 'Poppins', fontSize: 16.0),),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return const WidgetError();
              } else {
                return const WidgetLoadingScreens();
              }
            },
          );
        } else if (snapshot.hasError) {
          return const WidgetError();
        } else {
          return const WidgetLoadingScreens();
        }
      },
    );
  }

  List<StudentGrade> listStudentFromSnapshot(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    List<StudentGrade> _listStudent = [];

    for (var doc in snapshot.data!.docs) {
      Timestamp attendanceTime = doc['attendanceTime'];

      DateTime dateTimeAttendanceTime =
          DateTime.parse(attendanceTime.toDate().toString());

      _listStudent.add(StudentGrade(
        doc['uid'],
        doc['email'],
        doc['name'],
        doc['grade'],
        dateTimeAttendanceTime,
      ));
    }

    return _listStudent;
  }
}
