import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gradely_app/common/styles.dart';
import 'package:gradely_app/common/utils.dart';
import 'package:gradely_app/model/classroom.dart';
import 'package:gradely_app/model/history.dart';
import 'package:gradely_app/model/students.dart';
import 'package:gradely_app/services/firebase/cloud_firestore_service.dart';
import 'package:gradely_app/services/pdf/pdf_api.dart';
import 'package:gradely_app/services/pdf/pdf_attendance.dart';
import 'package:gradely_app/ui/teacher/start_review_session_teacher_ui.dart';
import 'package:gradely_app/widgets/teacher/list_active_student_attending.dart';
import 'package:gradely_app/widgets/teacher/list_assistant_attending.dart';
import 'package:gradely_app/widgets/teacher/list_student_attending.dart';
import 'package:gradely_app/widgets/widget_big_qr_code_image.dart';
import 'package:gradely_app/widgets/widget_loading_screens.dart';

import 'add_active_point_teacher_ui.dart';

class ClassBegin extends StatefulWidget {
  const ClassBegin({Key? key, required this.classroom}) : super(key: key);

  final Classroom classroom;

  @override
  _ClassBeginState createState() => _ClassBeginState();
}

class _ClassBeginState extends State<ClassBegin> {
  @override
  Widget build(BuildContext context) {
    String qrdata = widget.classroom.teacherID +
        widget.classroom.className +
        widget.classroom.classToken;

    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseTeacherClass(
              widget.classroom.teacherID, widget.classroom.className)
          .listStudentAttending,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.size == 0) {
            return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: Card(
                          color: Styles.accentColor2,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20.0,
                              ),
                              WidgetBigQRCodeImage(qrData: qrdata),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                widget.classroom.subjectName,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                widget.classroom.className,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              Text(
                                widget.classroom.teacherName,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Image.asset('assets/ic_undraw_scan.png'),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20.0),
                        child: const Text(
                          'No student attend this subject! Share your QR Code!',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14.0,
                              color: Colors.black54),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: Card(
                          color: Styles.accentColor2,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20.0,
                              ),
                              WidgetBigQRCodeImage(qrData: qrdata),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                widget.classroom.subjectName,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                widget.classroom.className,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              Text(
                                widget.classroom.teacherName,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        width: double.infinity,
                        child: const Text(
                          'Assistant Attending : ',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            color: Colors.black54,
                            fontSize: 20.0,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Divider(),
                      ListAssistantAttending(
                        className: widget.classroom.className,
                        teacherID: widget.classroom.teacherID,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        width: double.infinity,
                        child: const Text(
                          'Students Attending : ',
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
                      ListStudentAttending(
                        listStudent: listStudentFromSnapshot(snapshot),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        width: double.infinity,
                        child: const Text(
                          "Today's Active Students : ",
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
                      ListActiveStudentAttending(
                        className: widget.classroom.className,
                        teacherID: widget.classroom.teacherID,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddActivePointTeacherUI(
                                  classroom: widget.classroom,
                                  listStudent:
                                      listStudentFromSnapshot(snapshot),
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.star_rate,
                            color: Colors.white,
                          ),
                          label: const Text('Add Activity Points'),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    StartReviewSessionTeacherUI(
                                  classroom: widget.classroom,
                                  listStudent:
                                      listStudentFromSnapshot(snapshot),
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.app_registration),
                          label: const Text('Start Review Session'),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () async {

                            String detail = 'Teacher Name : ' + widget.classroom.teacherName + ', Classname : ' + widget.classroom.className;

                            final pdfFile = await PdfAttendance.generate(widget.classroom, listStudentFromSnapshot(snapshot));
                            await DatabaseTeacherClass(widget.classroom.teacherID, widget.classroom.className).addTeacherHistory(TeacherHistory('Practicum Session', detail, Utility.convertDateTo12HFormat(DateTime.now())));
                            await DatabaseTeacherClass(
                                    widget.classroom.teacherID,
                                    widget.classroom.className)
                                .removeAllCollection().then((value) => Navigator.pop(context));

                            PdfApi.openFile(pdfFile);
                          },
                          icon: const Icon(Icons.done_all_rounded),
                          label: const Text('End Today Class'),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        } else {
          return WidgetLoadingScreens();
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
