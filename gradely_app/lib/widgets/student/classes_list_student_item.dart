import 'package:flutter/material.dart';
import 'package:gradely_app/common/style_colors.dart';
import 'package:gradely_app/model/classroom.dart';
import 'package:gradely_app/ui/student/detail_student_class.dart';

import '../widget_small_qr_code_image.dart';

class ClassesListStudentItem extends StatelessWidget {
  final Classroom classroom;

  const ClassesListStudentItem({Key? key, required this.classroom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String qrData =
        classroom.teacherID + classroom.className + classroom.classToken;

    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailStudentClass(classroom: classroom),));
      },
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: Container(
          color: StyleColors.primaryColor,
          child: ListTile(
            leading: WidgetSmallQRCodeImage(
              qrData: qrData,
            ),
            title: Text(
              classroom.subjectName + ' ' + classroom.className,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            subtitle: Text(
              classroom.teacherName,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}