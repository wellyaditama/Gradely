import 'package:flutter/material.dart';
import 'package:gradely_app/common/styles.dart';
import 'package:gradely_app/ui/firebase_initialization.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreensUI extends StatelessWidget {
  const OnboardingScreensUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntroductionScreen(
        pages: [
          PageViewModel(
            title: 'Welcome!',
            body:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam pulvinar.',
            image: Image.asset('assets/ic_undraw_welcome.png'),
            decoration: PageDecoration(
              pageColor: Colors.white,
              contentMargin:
                  EdgeInsets.symmetric(vertical: 30.0, horizontal: 0.0),
            ),
          ),
          PageViewModel(
            title: 'Easy',
            body:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam pulvinar.',
            image: Image.asset('assets/ic_undraw_control.png'),
            decoration: PageDecoration(
              pageColor: Colors.white,
              contentMargin:
                  EdgeInsets.symmetric(vertical: 30.0, horizontal: 0.0),
            ),
          ),
          PageViewModel(
            title: 'Time Efficient',
            body:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam pulvinar.',
            image: Image.asset('assets/ic_undraw_time.png'),
            decoration: PageDecoration(
              pageColor: Colors.white,
              contentMargin:
                  EdgeInsets.symmetric(vertical: 30.0, horizontal: 0.0),
            ),
          ),
          PageViewModel(
            title: 'Just Scan',
            body:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam pulvinar.',
            image: Image.asset('assets/ic_undraw_scan.png'),
            decoration: PageDecoration(
              pageColor: Colors.white,
              contentMargin:
                  EdgeInsets.symmetric(vertical: 30.0, horizontal: 0.0),
            ),
          ),
          PageViewModel(
            title: 'Register Now!',
            body:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam pulvinar.',
            image: Image.asset('assets/ic_undraw_signin.png'),
            decoration: PageDecoration(
              pageColor: Colors.white,
              contentMargin:
                  EdgeInsets.symmetric(vertical: 30.0, horizontal: 0.0),
            ),
            footer: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, FirebaseInitialization.routeName);
              },
              child: Text('Get Started', style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                primary: Styles.primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 40.0),
              ),
            ),
          ),
        ],
        done: const Text(
          "Done",
          style: TextStyle(color: Colors.black87),
        ),
        skip: const Text(
          'Skip',
          style: TextStyle(color: Colors.black87),
        ),
        next: const Icon(
          Icons.navigate_next,
          color: Colors.black87,
        ),
        dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: Styles.secondaryVariantColor,
          color: Styles.primaryColor,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        onDone: () {
          Navigator.pushNamed(context, FirebaseInitialization.routeName);
        },
      ),
    );
  }
}
