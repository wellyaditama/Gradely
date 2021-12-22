import 'package:flutter/material.dart';
import 'package:gradely_app/common/styles.dart';
import 'package:gradely_app/common/utils.dart';

class AboutUI extends StatelessWidget {
  const AboutUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            'About App',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 24.0,
              color: Colors.black54,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          SizedBox(height: 200, child: Image.asset('assets/ic_app_logo.png')),
          const Divider(),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Column(
                  children: const [
                    Text(
                      'App Name : ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black45,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  children: const [
                    Text(
                      'Gradely App',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black45,
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Column(
                  children: const [
                    Text(
                      'App Theme : ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black45,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  children: const [
                    Text(
                      'Utility',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black45,
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Column(
                  children: const [
                    Text(
                      'Capstone Group : ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black45,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  children: const [
                    Text(
                      'CS-185',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black45,
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Column(
                  children: const [
                    Text(
                      'Developer : ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black45,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: const [
                    Text(
                      '1.) Wellyanto Pria Aditama',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black45,
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      '2.) Ivana Gabriela Manurung',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black45,
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          const SizedBox(
            width: double.infinity,
            child: Text(
              'Credits ',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.black45,
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          const Divider(),
          InkWell(
            onTap: () async {
              await Utility.launchURL('https://www.freepik.com');
            },
            child: SizedBox(
              width: double.infinity,
              child: RichText(
                text: const TextSpan(
                  text:
                  'Some icon in this app has been designed using resources from ',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black45,
                    fontSize: 16.0,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'flaticon.com',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Styles.primaryColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0,),
          InkWell(
            onTap: () async {
              await Utility.launchURL('https://undraw.co/');
            },
            child: SizedBox(
              width: double.infinity,
              child: RichText(
                text: const TextSpan(
                  text:
                  'Some images in this app has been designed using resources from ',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black45,
                    fontSize: 16.0,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'undraw.co ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Styles.primaryColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: 'and ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black45,
                        fontSize: 16.0,
                      ),
                    ),
                    TextSpan(
                      text: 'vexels.com',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Styles.primaryColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Column(
                  children: const [
                    Text(
                      'App Version : ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black45,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  children: const [
                    Text(
                      '0.5.0',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black45,
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
