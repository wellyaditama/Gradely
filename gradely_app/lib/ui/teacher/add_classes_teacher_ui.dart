import 'package:flutter/material.dart';
import 'package:gradely_app/common/constant.dart';
import 'package:gradely_app/common/style_colors.dart';
import 'package:gradely_app/model/classroom.dart';
import 'package:gradely_app/model/user_uid.dart';
import 'package:gradely_app/services/firebase/cloud_firestore_service.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:gradely_app/common/utils.dart';

class ClassesAddTeacherUI extends StatefulWidget {
  const ClassesAddTeacherUI({Key? key}) : super(key: key);

  @override
  State<ClassesAddTeacherUI> createState() => _ClassesAddTeacherUIState();
}

class _ClassesAddTeacherUIState extends State<ClassesAddTeacherUI> {
  final _formKey = GlobalKey<FormState>();
  final DateFormat timeFormat = DateFormat.Hm();
  String className = '';
  String subjectName = '';
  String teacherName = '';
  String teacherID = '';
  String classPicture = '';
  DateTime classBegin = DateTime.now();
  String formatedClassBegin = '';
  DateTime classEnd = DateTime.now().add(Duration(hours: 1));
  String formatedClassEnd = '';
  int studentCount = 0;
  String day = 'Monday';
  String classToken = '';

  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserUID?>(context, listen: false);
    setState(() {
      formatedClassBegin = timeFormat.format(classBegin);
      formatedClassEnd = timeFormat.format(classEnd);
      teacherID = user!.uid;
      print(user.isVerified);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Class'),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: StyleColors.accentColor2),
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
                    'ADD NEW CLASSES',
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
                    validator: (val) {
                      if (val!.isEmpty) {
                        return ('Please fill the Subject Name!');
                      }
                    },
                    enabled: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.school),
                      hintText: 'Ex : Math..',
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                        borderSide: BorderSide(
                            color: StyleColors.primaryVariantColor, width: 2.0),
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
                    validator: (val) {
                      if (val!.isEmpty) {
                        return ('Please fill the Class Name!');
                      }
                    },
                    enabled: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.home),
                      hintText: 'Ex : IF19C..',
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                        borderSide: BorderSide(
                            color: StyleColors.primaryVariantColor, width: 2.0),
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
                    validator: (val) {
                      if (val!.isEmpty) {
                        return ('Please fill the Teacher Name!');
                      }
                    },
                    enabled: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.school),
                      hintText: 'Ex : Rizki Putra..',
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                        borderSide: BorderSide(
                            color: StyleColors.primaryVariantColor, width: 2.0),
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
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: StyleColors.primaryColor, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                    ),
                    value: ConstantVariables.dayInWeek[0],
                    hint: Text('Choose one'),
                    onChanged: (value) {
                      setState(() {
                        day = value.toString();
                      });
                    },
                    onSaved: (value) {
                      setState(() {
                        day = value.toString();
                      });
                    },
                    items: ConstantVariables.dayInWeek.map((String val) {
                      return DropdownMenuItem(value: val, child: Text(val));
                    }).toList(),
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
                      'Class Begin : $formatedClassBegin',
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
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextButton.icon(
                      onPressed: () {
                        DatePicker.showTimePicker(context,
                            showTitleActions: true, onChanged: (date) {
                          print('change $date');
                        }, onConfirm: (date) {
                          setState(() {
                            classBegin = date;
                            formatedClassBegin = timeFormat.format(classBegin);
                          });
                          print('confirm $date');
                        });
                      },
                      icon: Icon(
                        Icons.more_time,
                        color: StyleColors.primaryColor,
                      ),
                      label: Text('Choose Time'),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
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
                      'Class End : $formatedClassEnd',
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
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextButton.icon(
                      onPressed: () {
                        DatePicker.showTimePicker(context,
                            showTitleActions: true, onChanged: (date) {
                          print('change $date');
                        }, onConfirm: (date) {
                          setState(() {
                            classEnd = date;
                            formatedClassEnd = timeFormat.format(classEnd);
                          });
                          print('confirm $date');
                        });
                      },
                      icon: Icon(
                        Icons.more_time,
                        color: StyleColors.primaryColor,
                      ),
                      label: Text('Choose Time'),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final user =
                            Provider.of<UserUID?>(context, listen: false);
                        setState(() {
                          teacherID = user!.uid;
                          classToken = Utility.getRandomString(8);
                        });

                        DatabaseTeacherClass _databaseTeacherClass =
                            DatabaseTeacherClass(teacherID, className);

                        Classroom classroom = Classroom(
                            className,
                            subjectName,
                            teacherName,
                            teacherID,
                            classPicture,
                            classBegin,
                            classEnd,
                            studentCount,
                            day,
                            classToken,
                            false);

                        await _databaseTeacherClass
                            .updateTeacherClassData(classroom)
                            .then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Successfully Added!')));
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: Text(
                      'Add new Classes',
                      style: TextStyle(color: StyleColors.primaryColor),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
