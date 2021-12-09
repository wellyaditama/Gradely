import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gradely_app/common/styles.dart';
import 'package:gradely_app/model/user_register.dart';
import 'package:gradely_app/model/user_uid.dart';
import 'package:gradely_app/services/firebase/cloud_firestore_service.dart';
import 'package:gradely_app/services/firebase/firebase_storage_service.dart';
import 'package:gradely_app/widgets/widget_error.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';

class AccountTeacherUI extends StatefulWidget {
  const AccountTeacherUI({Key? key}) : super(key: key);

  @override
  _AccountTeacherUIState createState() => _AccountTeacherUIState();
}

class _AccountTeacherUIState extends State<AccountTeacherUI> {
  UploadTask? task;
  File? file;

  @override
  Widget build(BuildContext context) {
    final uid = Provider.of<UserUID?>(context);
    final uidString = uid!.uid;
    final fileName = file != null ? basename(file!.path) : 'No File Selected';

    return StreamBuilder<UserRegister>(
      stream: DatabaseService(uidString).userRegister,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserRegister? userRegister = snapshot.data;
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  color: Styles.primaryColor,
                ),
                child: FadeInImage.assetNetwork(
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: 200.0,
                  placeholder: 'assets/ic_teacher_male.png',
                  image:
                      'https://firebasestorage.googleapis.com/v0/b/gradely-d1db3.appspot.com/o/account%2FprofilePicture%2Fic_teacher_male.png?alt=media&token=fa3030cc-d7ad-488f-b9f5-d503e5954b3e',
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Teacher Name :  ',
                        style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Poppins',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        onChanged: (value) {},
                        enabled: false,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.account_circle),
                          hintText: snapshot.data!.name,
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
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
                        height: 16.0,
                      ),
                      Text(
                        'Email :  ',
                        style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Poppins',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        onChanged: (value) {},
                        enabled: false,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: snapshot.data!.email,
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
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
                        height: 16.0,
                      ),
                      Text(
                        'Account Type : ',
                        style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Poppins',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        onChanged: (value) {},
                        enabled: false,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.info),
                          hintText: snapshot.data!.currentAccountType,
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
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
                        height: 16.0,
                      ),
                      Text(
                        'Gender : ',
                        style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Poppins',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        onChanged: (value) {},
                        enabled: false,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.circle),
                          hintText: snapshot.data!.gender,
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
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
                        height: 16.0,
                      ),
                      Text(
                        'University : ',
                        style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Poppins',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        onChanged: (value) {},
                        enabled: false,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.school),
                          hintText: snapshot.data!.university,
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
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
                        height: 16.0,
                      ),
                    ],
                  ),
                ),
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     selectProfilePicture();
              //   },
              //   child: Text('Choose Profile Picture'),
              // ),
              // Text(fileName),
              // ElevatedButton(
              //   onPressed: () {
              //     uploadFile(context);
              //   },
              //   child: Text('Upload profile picture!'),
              // ),
              // task != null ? buildUploadStatus(task!) : Container(),
            ],
          );
        } else {
          return WidgetError();
        }
      },
    );
  }

  Future selectProfilePicture() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result == null) {
      return;
    }

    final path = result.files.single.path!;

    setState(() {
      file = File(path);
    });
  }

  Future uploadFile(BuildContext context) async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'account/profilePicture/$fileName';

    task = FirebaseStorageService.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Success!')));
    });
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );
}
