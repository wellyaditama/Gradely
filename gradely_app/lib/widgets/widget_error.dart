import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WidgetError extends StatelessWidget {
  const WidgetError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/ic_lottie_not_found.json',
              height: 250.0, width: double.infinity),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Something wrong! Check your Internet Connection!',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
