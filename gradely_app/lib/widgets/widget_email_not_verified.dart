import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WidgetEmailNotVerified extends StatelessWidget {
  const WidgetEmailNotVerified({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
        color: Colors.redAccent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/ic_lottie_attention_error.json',
            height: 100.0,
            width: double.infinity
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Your Email is Not Verified!\nPlease check your email!',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontSize: 16.0,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
