import 'package:flutter/material.dart';
import 'package:gradely_app/common/style_colors.dart';
import 'package:gradely_app/model/student_grade.dart';
import 'package:gradely_app/services/firebase/cloud_firestore_service.dart';

class EditGradeStudent extends StatefulWidget {
  const EditGradeStudent(
      {Key? key,
      required this.teacherID,
      required this.classname,
      required this.studentGrade})
      : super(key: key);

  final String teacherID;
  final String classname;
  final StudentGrade studentGrade;

  @override
  _EditGradeStudentState createState() => _EditGradeStudentState();
}

class _EditGradeStudentState extends State<EditGradeStudent> {
  final _formKey = GlobalKey<FormState>();

  int grade = 0;

  @override
  void initState() {
    super.initState();

    setState(() {
      grade = widget.studentGrade.grade;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Update ${widget.studentGrade.name}'s Review Session Grade.",
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black54,
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              padding: EdgeInsets.only(top: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Grade : $grade',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54),
                  ),
                  Slider(
                    min: 0,
                    max: 100,
                    divisions: 20,
                    value: (grade.toDouble()),
                    onChanged: (double value) {
                      setState(() {
                        grade = value.round();
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30.0,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await DatabaseTeacherClass(widget.teacherID, widget.classname).updateStudentGrade(widget.studentGrade, grade).then((value) => Navigator.pop(context));
                },
                icon: const Icon(Icons.edit),
                label: const Text('Update', style: TextStyle(fontFamily: 'Poppins', fontSize: 16.0),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
