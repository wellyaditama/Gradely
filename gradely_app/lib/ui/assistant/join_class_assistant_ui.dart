import 'package:flutter/material.dart';
import 'package:gradely_app/common/style_colors.dart';
import 'package:gradely_app/model/user_register.dart';
import 'package:gradely_app/services/firebase/cloud_firestore_service.dart';
import 'package:gradely_app/ui/student/scan_qr_class.dart';

class JoinClassAssistantUI extends StatefulWidget {
  const JoinClassAssistantUI({Key? key, required this.userRegister})
      : super(key: key);

  final UserRegister userRegister;

  @override
  _JoinClassAssistantUIState createState() => _JoinClassAssistantUIState();
}

class _JoinClassAssistantUIState extends State<JoinClassAssistantUI> {
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
        title: const Text('Join Class'),
        backgroundColor: StyleColors.primaryColor,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                child: const LinearProgressIndicator(
                  color: StyleColors.secondaryColor,
                  backgroundColor: StyleColors.primaryVariantColor,
                  minHeight: 5.0,
                ),
                visible: loading,
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                'Input your Token Class',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  color: StyleColors.primaryColor,
                ),
              ),
              const SizedBox(
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
                decoration: const InputDecoration(
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
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        loading = !loading;
                      });

                      await DatabaseTeacherClass('', '')
                          .checkIfClassroomExist(classToken)
                          .then((value) {
                        print(value);

                        setState(() {
                          loading = !loading;
                        });

                        String token = classToken;
                        String teacherUID = token.substring(0, 28);
                        String className = token.substring(28, 33);

                        if (value) {
                          addNewClass(
                              teacherUID, className, widget.userRegister);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Success!')));
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(content: Text('Failed!')));
                        }

                        return value;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(primary: StyleColors.primaryColor),
                  child: const Text(
                    'Join',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 16.0),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ScanQRClass(setData: setData,),));
                    textController.text = result;
                  },
                  style: ElevatedButton.styleFrom(primary: StyleColors.primaryColor),
                  child: const Text(
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

  void addNewClass(
      String teacherUID, String className, UserRegister userRegister) async {
    await DatabaseTeacherClass(teacherUID, className)
        .getClass()
        .then((value) {
      DatabaseTeacherClass(userRegister.uid, className)
          .updateTeacherClassData(value);
      DatabaseTeacherClass(teacherUID, className)
          .addAssistantToClasses(userRegister);
    });
  }
}
