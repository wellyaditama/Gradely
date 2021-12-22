import 'package:flutter/material.dart';
import 'package:gradely_app/common/styles.dart';
import 'package:gradely_app/model/user_register.dart';

class StudentListTile extends StatefulWidget {
  const StudentListTile({Key? key, required this.userRegister})
      : super(key: key);
  final UserRegister userRegister;

  @override
  _StudentListTileState createState() => _StudentListTileState();
}

class _StudentListTileState extends State<StudentListTile> {
  @override
  Widget build(BuildContext context) {
    bool isMale = widget.userRegister.gender == 'male';

    return Card(
      margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        color: Styles.primaryColor,
        child: ListTile(
          leading: (isMale)
              ? Image.asset(
                  'assets/ic_student_male.png',
                  width: 50.0,
                  height: 50.0,
                )
              : Image.asset(
                  'assets/ic_student_female.png',
                  width: 50.0,
                  height: 50.0,
                ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              widget.userRegister.name,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0),
            ),
          ),
          subtitle: Text(
            widget.userRegister.email + '\n' + widget.userRegister.university,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14.0,
              color: Colors.black45
            ),
          ),
        ),
      ),
    );
  }
}
