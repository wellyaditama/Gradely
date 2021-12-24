import 'package:flutter/material.dart';
import 'package:gradely_app/common/style_colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WidgetLoadingScreens extends StatelessWidget {
  const WidgetLoadingScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              StyleColors.primaryColor,
              StyleColors.primaryVariantColor,
            ]),
      ),
      child: const Padding(
        padding: EdgeInsets.all(20.0),
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 150.0,
        ),
      ),
    );
  }
}
