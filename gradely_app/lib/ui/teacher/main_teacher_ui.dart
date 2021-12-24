import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gradely_app/common/constant.dart';
import 'package:gradely_app/common/style_colors.dart';
import 'package:gradely_app/common/utils.dart';
import 'package:gradely_app/model/user_register.dart';
import 'package:gradely_app/model/user_uid.dart';
import 'package:gradely_app/services/firebase/authentication_service.dart';
import 'package:gradely_app/services/firebase/cloud_firestore_service.dart';
import 'package:gradely_app/ui/assistant/main_assistant_ui.dart';
import 'package:gradely_app/ui/student/main_student_ui.dart';
import 'package:gradely_app/ui/teacher/account_teacher_ui.dart';
import 'package:gradely_app/ui/teacher/history_teacher_ui.dart';
import 'package:gradely_app/ui/teacher/settings_teacher_ui.dart';
import 'package:gradely_app/ui/teacher/students_teacher_ui.dart';
import 'package:gradely_app/widgets/widget_loading_screens.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../about_ui.dart';
import 'add_classes_teacher_ui.dart';
import 'assistant_teacher_ui.dart';
import 'classes_teacher_ui.dart';

class HomeTeacherUI extends StatefulWidget {
  const HomeTeacherUI({Key? key}) : super(key: key);

  @override
  State<HomeTeacherUI> createState() => _HomeTeacherUIState();
}

class _HomeTeacherUIState extends State<HomeTeacherUI> {
  final AuthenticationService _authenticationService = AuthenticationService();
  final String _title = 'Gradely Teacher';

  int _currentMenu = 1;

  @override
  Widget build(BuildContext context) {
    final uid = Provider.of<UserUID?>(context);
    final SnackBar snackBar = const SnackBar(content: Text('Coming soon!'));

    print(uid!.uid);

    return StreamBuilder(
      stream: DatabaseService(uid.uid).userRegister,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          UserRegister userRegister = snapshot.data;
          if (userRegister.currentAccountType ==
              ConstantVariables.accountType[0]) {
            return MainStudentUI(
              userRegister: userRegister,
            );
          } else if (userRegister.currentAccountType ==
              ConstantVariables.accountType[2]) {
            return HomeAssistantUI(userRegister: userRegister);
          } else {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: StyleColors.primaryColor,
                title: Text(_title),
                actions: [
                  IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    icon: const Icon(
                      Icons.notifications,
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
                          // gradient: LinearGradient(
                          //   begin: Alignment.topLeft,
                          //   end: Alignment.bottomRight,
                          //   colors: [Styles.primaryColor, Styles.primaryVariantColor],
                          // ),
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
                                  image:
                                      ConstantVariables.iconDefaultTeacherMale,
                                  width: 75.0,
                                  height: 75.0,
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                userRegister.name,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20.0,
                                ),
                              ),
                              Text(
                                userRegister.email,
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
                    ListTile(
                      title: const Text('Students'),
                      leading: const Icon(Icons.school),
                      onTap: () {
                        setState(() {
                          _currentMenu = 4;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Assistant'),
                      leading: const Icon(Icons.assistant),
                      onTap: () {
                        setState(() {
                          _currentMenu = 5;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    ListTile(
                      title: const Text('Settings'),
                      leading: const Icon(Icons.settings),
                      onTap: () {
                        setState(() {
                          _currentMenu = 6;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text('History'),
                      leading: const Icon(Icons.history),
                      onTap: () {
                        setState(() {
                          _currentMenu = 7;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
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
                          _currentMenu = 8;
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
                            return CircularProgressIndicator();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              body: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: [
                    if (_currentMenu == 1) ...[
                      // WidgetDashboard(),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        width: double.infinity,
                        child: Text(
                          'Your Classes',
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
                      ClassesTeacherUI(),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              _currentMenu = 3;
                            });
                          },
                          child: Text('Show More')),
                      Divider(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        width: double.infinity,
                        child: Text(
                          'Your Assistant : ',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            color: Colors.black54,
                            fontSize: 20.0,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      AssistantTeacherUI(),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              setState(() {
                                _currentMenu = 5;
                              });
                            });
                          },
                          child: Text('Show More')),
                      Divider(),
                      HistoryTeacher(userRegister: userRegister),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              _currentMenu = 7;
                            });
                          },
                          child: Text('Show More')),
                      Divider(),
                    ] else if (_currentMenu == 2) ...[
                      Container(child: AccountTeacherUI()),
                    ] else if (_currentMenu == 3) ...[
                      ClassesTeacherUI(),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ClassesAddTeacherUI()));
                          },
                          label: Text('Add New Class'),
                          style: ElevatedButton.styleFrom(),
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ] else if (_currentMenu == 4) ...[
                      StudentTeacherUI(),
                    ] else if (_currentMenu == 5) ...[
                      AssistantTeacherUI(),
                    ] else if (_currentMenu == 6) ...[
                      SettingsTeacherUI(),
                    ] else if (_currentMenu == 7) ...[
                      HistoryTeacher(
                        userRegister: userRegister,
                      ),
                    ] else if (_currentMenu == 8) ...[
                      AboutUI(),
                    ] else ...[
                      WidgetLoadingScreens(),
                    ]
                  ],
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
}
