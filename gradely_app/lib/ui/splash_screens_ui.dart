import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:gradely_app/common/styles.dart';
import 'package:lottie/lottie.dart';
import 'onboarding_ui.dart';

class SplashScreensUI extends StatefulWidget {
  const SplashScreensUI({Key? key}) : super(key: key);

  @override
  State<SplashScreensUI> createState() => _SplashScreensUIState();
}

class _SplashScreensUIState extends State<SplashScreensUI> {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreensUI()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Styles.primaryColor,
                Styles.primaryVariantColor,
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black87.withOpacity(0.4),
                          spreadRadius: 6,
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Lottie.asset(
                      'assets/ic_splash_screen_lottie.json',
                      height: 250,
                      width: 250,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: AnimatedTextKit(
                    animatedTexts: [
                      FadeAnimatedText(
                        'Gradely App',
                        textStyle: const TextStyle(
                          fontSize: 36.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        duration: const Duration(seconds: 3),
                        fadeInEnd: 0.6,
                        fadeOutBegin: 0.7,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
