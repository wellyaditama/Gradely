import 'package:flutter/material.dart';
import 'package:gradely_app/common/constant.dart';
import 'package:gradely_app/common/style_colors.dart';
import 'package:gradely_app/common/utils.dart';
import 'package:gradely_app/model/user_register.dart';
import 'package:gradely_app/services/firebase/authentication_service.dart';
import 'package:gradely_app/ui/assistant/scan_attendance_assistant.dart';
import 'package:gradely_app/ui/student/classes_student_ui.dart';
import 'package:gradely_app/ui/teacher/account_teacher_ui.dart';
import 'package:share_plus/share_plus.dart';

import '../about_ui.dart';
import 'join_class_assistant_ui.dart';

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
        backgroundColor: StyleColors.primaryColor,
        title: Text(_title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ScanAttendanceAssistant(userRegister: widget.userRegister),));
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
            child: const ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(100.0)),
              child: Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/ic_bg_drawer.jpg'))
              ),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/ic_teacher_male.png',
                          image: ConstantVariables.iconDefaultAssistantMale,
                          width: 75.0,
                          height: 75.0,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        widget.userRegister.name,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                        ),
                      ),
                      Text(
                        widget.userRegister.email,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            ListTile(
              title: const Text('Home'),
              leading: const Icon(Icons.home),
              onTap: () {
                setState(() {
                  _currentMenu = 1;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Account'),
              leading: const Icon(Icons.account_circle),
              onTap: () {
                setState(() {
                  _currentMenu = 2;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Classes'),
              leading: const Icon(Icons.class_),
              onTap: () {
                setState(() {
                  _currentMenu = 3;
                });
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Share'),
              leading: const Icon(Icons.share),
              onTap: () {
                String message = 'Gradely is an App that help your practicum session easy\nDownload Gradely from this link: \nhttps://drive.google.com/drive/folders/1Q5J0obDb_wflpQm-reElVbMR-Ic1QGbm?usp=sharing';
                Share.share(message);
              },
            ),
            ListTile(
              title: const Text('Help'),
              leading: const Icon(Icons.help),
              onTap: () {
                Utility.launchURL('https://drive.google.com/drive/folders/1Ulan6Jh3UEiMv9Lt4KqjKzT2RG3riFoG?usp=sharing');
              },
            ),
            ListTile(
              title: const Text('About'),
              leading: const Icon(Icons.info),
              onTap: () {
                setState(() {
                  _currentMenu = 7;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Logout'),
              leading: const Icon(Icons.exit_to_app),
              onTap: () {
                FutureBuilder<dynamic>(
                  future: _authenticationService.signOut(),
                  builder: (context, snapshot) {
                    return const CircularProgressIndicator();
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            if (_currentMenu == 1) ...[
              const SizedBox(
                height: 20.0,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                width: double.infinity,
                child: const Text(
                  'All the Classes',
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
              const ClassesStudentUI()
            ] else if (_currentMenu == 2) ...[
              const AccountTeacherUI(),
            ] else if (_currentMenu == 3) ...[
              const ClassesStudentUI(),
              TextButton(
                child: const Text('Join now'),
                onPressed: () {
                  UserRegister _userRegister = widget.userRegister;

                  Navigator.push(context, MaterialPageRoute(builder: (context) => JoinClassAssistantUI(userRegister: _userRegister,),));
                },
              ),
            ] else if (_currentMenu == 4) ...[
              const Text('This is menu 4'),
            ] else if (_currentMenu == 5) ...[
              const Text('This is menu 5'),
            ] else if (_currentMenu == 6) ...[
              const Text('This is menu 6'),
            ] else if (_currentMenu == 7) ...[
              const AboutUI(),
            ]
          ],
        ),
      ),
    );
  }
}
