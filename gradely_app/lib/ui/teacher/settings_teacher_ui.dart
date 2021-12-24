import 'package:flutter/material.dart';

class SettingsTeacherUI extends StatelessWidget {
  const SettingsTeacherUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      width: double.infinity,
      child: Column(
        children: [
          const Text(
            'Settings',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24.0,
                color: Colors.black54,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Enable Notification',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16.0,
                      color: Colors.black54),
                ),
              ),
              Switch(
                value: false,
                onChanged: (val) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Comming soon!')));
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
