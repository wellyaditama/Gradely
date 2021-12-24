import 'package:gradely_app/model/students.dart';
import 'package:gradely_app/model/user_register.dart';

import 'classroom.dart';

class Attendance {
  final Classroom classroom;
  final UserRegister userRegister;
  final List<Student> listStudent;

  Attendance(this.classroom, this.userRegister, this.listStudent);
}