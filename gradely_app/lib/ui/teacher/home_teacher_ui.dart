import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gradely_app/common/styles.dart';
import 'package:gradely_app/services/firebase/authentication_service.dart';

class HomeTeacherUI extends StatefulWidget {
  const HomeTeacherUI({Key? key}) : super(key: key);

  @override
  State<HomeTeacherUI> createState() => _HomeTeacherUIState();
}

class _HomeTeacherUIState extends State<HomeTeacherUI> {
  final AuthenticationService _authenticationService = AuthenticationService();
  String _title = 'Gradely Teacher';
  int _currentMenu = 1;

  @override
  Widget build(BuildContext context) {
    final SnackBar snackBar = SnackBar(content: Text('This is user'));
    final SnackBar snackBar2 = SnackBar(content: Text('This is scanner'));
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
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Styles.primaryColor,
                ),
                child: Text('Drawer Header'),
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
              Divider(color: Colors.grey,),
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
              Divider(color: Colors.grey,),
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
        body: Column(
          children: [
            if (_currentMenu == 1) ...[
              Container(child: Text('This is menu $_currentMenu')),
              Container(child: Text('this is content menu 1')),
            ] else if (_currentMenu == 2)...[
              Container(child: Text('This is menu 2')),
              Container(child: Text('this is content menu 2')),
            ] else if (_currentMenu == 3)...[
              Container(child: Text('This is menu 3')),
              Container(child: Text('this is content menu 3')),
            ] else if (_currentMenu == 4)...[
              Container(child: Text('This is menu 4')),
              Container(child: Text('this is content menu 4')),
            ] else if (_currentMenu == 5)...[
              Container(child: Text('This is menu 5')),
              Container(child: Text('this is content menu 5')),
            ] else if (_currentMenu == 6)...[
              Container(child: Text('This is menu 6')),
              Container(child: Text('this is content menu 6')),
            ] else if (_currentMenu == 7)...[
              Container(child: Text('This is menu 7')),
              Container(child: Text('this is content menu 7')),
            ] else if (_currentMenu == 8)...[
              Container(child: Text('This is menu 8')),
              Container(child: Text('this is content menu 8')),
            ] else ...[
              Container(child: Text('Error!')),
            ]
          ],
        ),
      ),
    );
  }
}
