import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gradely_app/common/constant.dart';
import 'package:gradely_app/common/styles.dart';
import 'package:gradely_app/model/classroom.dart';
import 'package:gradely_app/model/user_uid.dart';
import 'package:gradely_app/services/firebase/cloud_firestore_service.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

class ClassesTeacherUI extends StatefulWidget {
  const ClassesTeacherUI({Key? key}) : super(key: key);

  @override
  State<ClassesTeacherUI> createState() => _ClassesTeacherUIState();
}

class _ClassesTeacherUIState extends State<ClassesTeacherUI> {
  final _formKey = GlobalKey<FormState>();
  String className = '';
  String subjectName = '';
  String teacherName = '';
  String teacherID = '';
  String classPicture = '';
  DateTime classBegin = DateTime(2021, 12, 9, 8, 0, 0, 0, 0);
  DateTime classEnd = DateTime(2021, 12, 9, 9, 0, 0, 0, 0);
  int studentCount = 0;
  String day = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Styles.accentColor2),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10.0,
              ),
              Text(
                'CLASSES',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Lottie.asset('assets/ic_lottie_classes.json',
                  height: 150.0, width: double.infinity),
              SizedBox(
                height: 16.0,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Subject Name :  ',
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    subjectName = value;
                  });
                },
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Ex : Math..',
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    borderSide: BorderSide(
                        color: Styles.primaryVariantColor, width: 2.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              SizedBox(
                height: 16.0,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Class :  ',
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    className = value;
                  });
                },
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Ex : IF19C..',
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    borderSide: BorderSide(
                        color: Styles.primaryVariantColor, width: 2.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              SizedBox(
                height: 16.0,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Teacher Name :  ',
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFormField(
                onChanged: (value) {
                  teacherName = value;
                },
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Ex : Rizki Putra..',
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    borderSide: BorderSide(
                        color: Styles.primaryVariantColor, width: 2.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              SizedBox(
                height: 16.0,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Day :  ',
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFormField(
                onChanged: (value) {
                  day = value;
                },
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Ex : Monday..',
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    borderSide: BorderSide(
                        color: Styles.primaryVariantColor, width: 2.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              SizedBox(
                height: 16.0,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Class Begin :  ',
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextButton(
                onPressed: () {
                  DatePicker.showTimePicker(context, showTitleActions: true,
                      onChanged: (date) {
                    print('change $date');
                  }, onConfirm: (date) {
                    setState(() {
                      classBegin = date;
                    });
                    print('confirm $date');
                  });
                },
                child: Text('Choose Time'),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
              ),
              Text('At : ' +
                  classBegin.hour.toString() +
                  ': ' +
                  classBegin.minute.toString()),
              SizedBox(
                height: 8.0,
              ),
              SizedBox(
                height: 16.0,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Class End :  ',
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextButton(
                onPressed: () {
                  DatePicker.showTimePicker(context, showTitleActions: true,
                      onChanged: (date) {
                    print('change $date');
                  }, onConfirm: (date) {
                    setState(() {
                      classEnd = date;
                    });
                    print('confirm $date');
                  });
                },
                child: Text('Choose Time'),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
              ),
              Text('At : ' +
                  classEnd.hour.toString() +
                  ': ' +
                  classEnd.minute.toString()),
              ElevatedButton(
                onPressed: () async {
                  // if(_formKey.currentState!.validate()) {
                  //
                  final user = Provider.of<UserUID?>(context, listen: false);
                  setState(() {
                    teacherID = user!.uid;
                  });
                  //
                  //   DatabaseTeacherClass _databaseTeacherClass = DatabaseTeacherClass(teacherID, className);
                  //
                  Classroom classroom = Classroom(
                      'IF19D',
                      'Biologi',
                      'Rizki',
                      'Tes123',
                      ConstantVariables.iconDefaultTeacherMale,
                      classBegin,
                      classEnd,
                      0,
                      'Sunday');
                  //
                  //   await _databaseTeacherClass.updateTeacherClassData(classroom);
                  // }

                  DatabaseTeacherClass(teacherID, 'IF19D').updateTeacherClassData(classroom);
                },
                child: Text(
                  'Add new Classes',
                  style: TextStyle(color: Styles.primaryColor),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
