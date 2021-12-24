import 'package:flutter/material.dart';
import 'package:gradely_app/common/style_colors.dart';
import 'package:gradely_app/common/utils.dart';
import 'package:gradely_app/services/firebase/authentication_service.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({Key? key}) : super(key: key);

  @override
  _ResetPasswordFormState createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final AuthenticationService _authService = AuthenticationService();

  String email = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text(
            'Reset Your Password!',
            style: TextStyle(
              fontSize: 24.0,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              color: Colors.black54,
            ),
          ),
          const SizedBox(
            height: 20.0,
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
            decoration: const InputDecoration(
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
                    color: StyleColors.primaryVariantColor,
                    width: 2.0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0,),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async{
                if (_formKey.currentState!.validate()) {
                  await _authService.resetPassword(email).then((value) => Navigator.pop(context));
                }
              },
              style: ElevatedButton.styleFrom(
                  primary: StyleColors.secondaryColor),
              child: const Text(
                'Reset',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 16.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
