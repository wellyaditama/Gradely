import 'package:flutter/material.dart';
import 'package:gradely_app/common/styles.dart';
import 'package:gradely_app/model/user_register.dart';
import 'package:gradely_app/services/firebase/authentication_service.dart';
import 'package:gradely_app/ui/student/scan_attendance_student.dart';

class HomeAssistantUI extends StatefulWidget {
  const HomeAssistantUI({Key? key, required this.userRegister}) : super(key: key);

  final UserRegister userRegister;

  @override
  State<HomeAssistantUI> createState() => _HomeAssistantUIState();
}

class _HomeAssistantUIState extends State<HomeAssistantUI> {

  final AuthenticationService _authenticationService = AuthenticationService();
  final String _title = 'Gradely Assistant';
  final SnackBar snackBar = const SnackBar(content: Text('Coming soon!'));

  int _currentMenu = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.primaryColor,
        title: Text(_title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ScanAttendanceStudent(userRegister: widget.userRegister),));
            },
            icon: const Icon(
              Icons.qr_code_scanner,
              color: Colors.white,
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _currentMenu = 2;
              });
            },
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(100.0)),
              child: Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          )
        ],
      ),
    );
  }
}
