import 'package:flutter/material.dart';
import 'package:gradely_app/common/styles.dart';
import 'package:gradely_app/common/utils.dart';
import 'package:gradely_app/model/user_uid.dart';
import 'package:gradely_app/services/firebase/authentication_service.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({Key? key, required this.toggleView}) : super(key: key);

  final Function toggleView;

  @override
  _LoginUIState createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  final AuthenticationService _authService = AuthenticationService();
  final _formKey = GlobalKey<FormState>();
  final snackBar = SnackBar(content: Text('Form invalid!'));
  final snackBarError = SnackBar(content: Text('Invalid!'));
  bool loading = false;
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 1.1,
            decoration: BoxDecoration(color: Styles.primaryColor),
            child: Column(
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
                      "Welcome Back! You've been missed!",
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
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Lottie.asset('assets/ic_login_lottie.json'),
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
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'Forgot your password?',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 14.0),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async{
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  loading = !loading;
                                });
                                dynamic result = await _authService.signIn(email: email, password: password);
                                if(result == null) {
                                  setState(() {
                                    loading = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(snackBarError);
                                }
                              }

                              final user = Provider.of<UserUID?>(context, listen: false);
                              print(user);
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Styles.secondaryColor),
                            child: Text(
                              'Login',
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
                              'Register',
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
