import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gradely_app/common/styles.dart';
import 'package:gradely_app/model/classroom.dart';
import 'package:gradely_app/model/students.dart';
import 'package:gradely_app/services/firebase/cloud_firestore_service.dart';
import 'package:gradely_app/widgets/teacher/list_student_attending.dart';
import 'package:gradely_app/widgets/widget_big_qr_code_image.dart';
import 'package:gradely_app/widgets/widget_loading_screens.dart';

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
              body: Container(
                  child: Column(
                children: [
                  Image.asset('assets/ic_undraw_scan.png'),
                  Text('No student attend this subject!')
                ],
              )),
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
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        width: double.infinity,
                        child: Text(
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
                      Divider(),
                      ListStudentAttending(
                        listStudent: listStudentFromSnapshot(snapshot),
                      ),
                    ],
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  Student student = Student('1234567891234567891234567891',
                      'email@gmail.com', 'namaMahasiswa', DateTime.now());

                  await DatabaseTeacherClass(widget.classroom.teacherID,
                          widget.classroom.className)
                      .addStudentToAttendance(student)
                      .then((val) => print('success'));
                },
                child: Icon(Icons.share),
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
