import 'package:flutter/material.dart';
import 'package:gradely_app/common/style_colors.dart';
import 'package:gradely_app/model/classroom.dart';
import 'package:gradely_app/model/user_register.dart';
import 'package:gradely_app/services/firebase/cloud_firestore_service.dart';
import 'package:gradely_app/ui/student/scan_qr_class.dart';

class JoinClassUI extends StatefulWidget {
  const JoinClassUI({Key? key, required this.userRegister}) : super(key: key);

  final UserRegister userRegister;

  @override
  _JoinClassUIState createState() => _JoinClassUIState();
}

class _JoinClassUIState extends State<JoinClassUI> {
  final _formKey = GlobalKey<FormState>();
  String classToken = '';
  bool loading = false;
  var textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textController.text = classToken;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Join Class'),
        backgroundColor: StyleColors.primaryColor,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                child: LinearProgressIndicator(
                  color: StyleColors.secondaryColor,
                  backgroundColor: StyleColors.primaryVariantColor,
                  minHeight: 5.0,
                ),
                visible: loading,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Input your Token Class',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  color: StyleColors.primaryColor,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    classToken = value;
                  });
                },
                controller: textController,
                enabled: true,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Enter your class token!';
                  }

                  if (val.length < 40) {
                    return 'Wrong token!';
                  }
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.app_registration),
                  hintText: 'Class Token',
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        loading = !loading;
                      });

                      bool check = await DatabaseTeacherClass('', '')
                          .checkIfClassroomExist(classToken)
                          .then((value) {
                        print(value);

                        setState(() {
                          loading = !loading;
                        });
                        String token = classToken;
                        String teacherUID = token.substring(0, 28);
                        String className = token.substring(28, 33);
                        String classToken2 = token.substring(34);
                        int length = token.length;

                        if(value) {
                          AddNewClass(teacherUID, className, widget.userRegister);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Success!')));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed!')));
                        }

                        return value;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(primary: StyleColors.primaryColor),
                  child: Text(
                    'Join',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 16.0),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ScanQRClass(setData: setData,),));
                    textController.text = result;
                  },
                  style: ElevatedButton.styleFrom(primary: StyleColors.primaryColor),
                  child: Text(
                    'Scan QR',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 16.0),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void setData(String data) {
    setState(() {
      classToken = data;
    });
  }

  void AddNewClass(String teacherUID, String className, UserRegister userRegister) async {
    Classroom? classroom = await DatabaseTeacherClass(teacherUID, className).getClass().then((value) {
      if(value != null) {
        DatabaseTeacherClass(userRegister.uid, className).updateTeacherClassData(value);
        print(value.className);
        DatabaseTeacherClass(teacherUID, className).addStudentToClasses(userRegister);
      }
    });
  }
}
