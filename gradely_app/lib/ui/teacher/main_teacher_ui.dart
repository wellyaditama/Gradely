import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gradely_app/common/constant.dart';
import 'package:gradely_app/common/styles.dart';
import 'package:gradely_app/model/user_register.dart';
import 'package:gradely_app/model/user_uid.dart';
import 'package:gradely_app/services/firebase/authentication_service.dart';
import 'package:gradely_app/services/firebase/cloud_firestore_service.dart';
import 'package:gradely_app/ui/teacher/account_teacher_ui.dart';
import 'package:gradely_app/widgets/teacher/classes_list.dart';
import 'package:gradely_app/widgets/widget_email_not_verified.dart';
import 'package:gradely_app/widgets/widget_error.dart';
import 'package:gradely_app/widgets/widget_loading_screens.dart';
import 'package:provider/provider.dart';

import 'classes_teacher_ui.dart';

class HomeTeacherUI extends StatefulWidget {
  const HomeTeacherUI({Key? key}) : super(key: key);

  @override
  State<HomeTeacherUI> createState() => _HomeTeacherUIState();
}

class _HomeTeacherUIState extends State<HomeTeacherUI> {
  final AuthenticationService _authenticationService = AuthenticationService();
  String _title = 'Gradely Teacher';
  // TODO: Change to 1

  int _currentMenu = 3;

  @override
  Widget build(BuildContext context) {
    final uid = Provider.of<UserUID?>(context);
    final SnackBar snackBar = SnackBar(content: Text('This is user'));
    final SnackBar snackBar2 = SnackBar(content: Text('This is scanner'));

    print(uid!.uid);

    return StreamBuilder(
      stream: DatabaseService(uid.uid).userRegister,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          UserRegister userRegister = snapshot.data;
          return Container(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Styles.primaryColor,
                title: Text(_title),
                actions: [
                  IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar2);
                    },
                    icon: const Icon(
                      Icons.qr_code_scanner,
                      color: Colors.white,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
              drawer: Drawer(
                child: ListView(
                  // Important: Remove any padding from the ListView.
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
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
                                  image: ConstantVariables
                                      .iconDefaultTeacherFemale,
                                  width: 75.0,
                                  height: 75.0,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                userRegister.name,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20.0,
                                ),
                              ),
                              Text(
                                userRegister.email,
                                style: TextStyle(
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
                      leading: Icon(Icons.home),
                      onTap: () {
                        setState(() {
                          _currentMenu = 1;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Account'),
                      leading: Icon(Icons.account_circle),
                      onTap: () {
                        setState(() {
                          _currentMenu = 2;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Classes'),
                      leading: Icon(Icons.class_),
                      onTap: () {
                        setState(() {
                          _currentMenu = 3;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Students'),
                      leading: Icon(Icons.school),
                      onTap: () {
                        setState(() {
                          _currentMenu = 4;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Notifications'),
                      leading: Icon(Icons.notifications),
                      onTap: () {
                        setState(() {
                          _currentMenu = 5;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    ListTile(
                      title: const Text('Settings'),
                      leading: Icon(Icons.settings),
                      onTap: () {
                        setState(() {
                          _currentMenu = 6;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text('History'),
                      leading: Icon(Icons.history),
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
                      leading: Icon(Icons.share),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Help'),
                      leading: Icon(Icons.help),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text('About'),
                      leading: Icon(Icons.info),
                      onTap: () {
                        setState(() {
                          _currentMenu = 8;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: const Text('Logout'),
                      leading: Icon(Icons.exit_to_app),
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
                      WidgetEmailNotVerified(),
                      // WidgetStartClass(),
                      // WidgetDashboard(),
                      ClassesList(),
                    ] else if (_currentMenu == 2) ...[
                      Container(child: AccountTeacherUI()),
                    ] else if (_currentMenu == 3) ...[
                      ClassesTeacherUI(),
                    ] else if (_currentMenu == 4) ...[
                      Container(child: Text('This is menu 4')),
                      Container(child: Text('this is content menu 4')),
                    ] else if (_currentMenu == 5) ...[
                      Container(child: Text('This is menu 5')),
                      Container(child: Text('this is content menu 5')),
                    ] else if (_currentMenu == 6) ...[
                      Container(child: Text('This is menu 6')),
                      Container(child: Text('this is content menu 6')),
                    ] else if (_currentMenu == 7) ...[
                      Container(child: Text('This is menu 7')),
                      Container(child: Text('this is content menu 7')),
                    ] else if (_currentMenu == 8) ...[
                      Container(child: Text('This is menu 8')),
                      Container(child: Text('this is content menu 8')),
                    ] else ...[
                      WidgetLoadingScreens(),
                    ]
                  ],
                ),
              ),
            ),
          );
        } else {
          return WidgetLoadingScreens();
        }
      },
    );
  }
}
