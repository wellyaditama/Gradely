import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradely_app/common/styles.dart';
import 'package:gradely_app/common/utils.dart';
import 'package:gradely_app/model/user_register.dart';
import 'package:gradely_app/model/user_uid.dart';
import 'package:gradely_app/services/firebase/authentication_service.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

enum Gender { male, female }

class RegisterUI extends StatefulWidget {
  const RegisterUI({Key? key, required this.toggleView}) : super(key: key);

  final Function toggleView;

  @override
  _RegisterUIState createState() => _RegisterUIState();
}

class _RegisterUIState extends State<RegisterUI> {
  final AuthenticationService _authService = AuthenticationService();
  final _formKey = GlobalKey<FormState>();
  final snackBar = SnackBar(content: Text('Form invalid!'));
  final snackBarError = SnackBar(content: Text('Invalid!'));
  final List<String> accountType = ['Student', 'Teacher', 'Assistant'];
  bool loading = false;
  String email = '';
  bool isVerified = false;
  String name = '';
  String university = '';
  Gender gender = Gender.male;
  String genderString = 'male';
  int semester = 1;
  String password = '';
  String validatePassword = '';
  String currentAccountType = 'Student';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Styles.primaryColor),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                  child: LinearProgressIndicator(
                    color: Styles.secondaryColor,
                    backgroundColor: Styles.primaryVariantColor,
                    minHeight: 5.0,
                  ),
                  visible: loading,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Hello Again',
                  style: TextStyle(
                    fontSize: 36.0,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 20.0),
                    child: Text(
                      "Register to our app!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Lottie.asset('assets/ic_login_lottie.json'),
                        ),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Styles.primaryColor, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0),
                            ),
                          ),
                          value: accountType[0],
                          hint: Text('Choose Account Type'),
                          onChanged: (value) {
                            setState(() {
                              currentAccountType = value.toString();
                            });
                          },
                          onSaved: (value) {
                            setState(() {
                              currentAccountType = value.toString();
                            });
                          },
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Can't empty!";
                            } else {
                              return null;
                            }
                          },
                          items: accountType.map((String val) {
                            return DropdownMenuItem(
                                value: val, child: Text(val));
                          }).toList(),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Enter your name!';
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.account_circle),
                            hintText: 'Name',
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                              borderSide: BorderSide(
                                  color: Styles.primaryVariantColor,
                                  width: 2.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Enter your email!';
                            }
                            if (!Utility.validateEmail(val)) {
                              return 'Enter valid email!';
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            hintText: 'Email',
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                              borderSide: BorderSide(
                                  color: Styles.primaryVariantColor,
                                  width: 2.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 10.0),
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(
                                  'Gender',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black54),
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: ListTile(
                                          title: const Text('Male'),
                                          leading: Radio<Gender>(
                                            value: Gender.male,
                                            groupValue: gender,
                                            onChanged: (Gender? value) {
                                              setState(() {
                                                gender = value!;
                                                genderString = 'male';
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: ListTile(
                                          title: const Text('Female'),
                                          leading: Radio<Gender>(
                                            value: Gender.female,
                                            groupValue: gender,
                                            onChanged: (Gender? value) {
                                              setState(() {
                                                gender = value!;
                                                genderString = 'female';
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              university = value;
                            });
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Enter your University!';
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.school),
                            hintText: 'University',
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                              borderSide: BorderSide(
                                  color: Styles.primaryVariantColor,
                                  width: 2.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Semester : $semester',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black54),
                              ),
                              Slider(
                                min: 1,
                                max: 14,
                                divisions: 13,
                                value: (semester.toDouble()),
                                onChanged: (double value) {
                                  setState(() {
                                    semester = value.round();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Enter your password!';
                            }

                            if (val.length < 7) {
                              return 'Minimum password is 8!';
                            }
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline),
                            hintText: 'Password',
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                              borderSide: BorderSide(
                                  color: Styles.primaryVariantColor,
                                  width: 2.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              validatePassword = value;
                            });
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Validate password must filled!';
                            }
                            if (val != password) {
                              return 'Validate password must be the same!';
                            }
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline),
                            hintText: 'Validate Password',
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                              borderSide: BorderSide(
                                  color: Styles.primaryVariantColor,
                                  width: 2.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  loading = !loading;
                                });

                                UserRegister userRegister = UserRegister(
                                    email,
                                    isVerified,
                                    name,
                                    university,
                                    genderString,
                                    semester,
                                    currentAccountType,
                                    'uid');

                                dynamic result = await _authService.signUp(
                                    email: email,
                                    password: password,
                                    userRegister: userRegister);
                                if (result == null) {
                                  setState(() {
                                    loading = false;
                                  });
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBarError);
                                }

                                debugPrint(email);
                                debugPrint(name);
                                debugPrint(university);
                                print(gender);
                                print(semester);
                                debugPrint(password);
                                debugPrint(validatePassword);
                                debugPrint(currentAccountType);
                              }

                              final user =
                                  Provider.of<UserUID?>(context, listen: false);
                              print(user);
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Styles.secondaryColor),
                            child: Text(
                              'Register',
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
                            onPressed: () {
                              widget.toggleView();
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 16.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
