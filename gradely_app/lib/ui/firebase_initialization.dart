import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradely_app/model/user_account.dart';
import 'package:gradely_app/model/user_uid.dart';
import 'package:gradely_app/services/firebase/authentication_service.dart';
import 'package:provider/provider.dart';

import '../main_wrapper.dart';

class FirebaseInitialization extends StatefulWidget {
  static const routeName = '/firebase_initialization';

  const FirebaseInitialization({Key? key}) : super(key: key);

  @override
  _FirebaseInitializationState createState() => _FirebaseInitializationState();
}

class _FirebaseInitializationState extends State<FirebaseInitialization> {
  Future<void> initializeFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  }

  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

    return FutureBuilder(
      future: _initialization,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          debugPrint('Error');
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<UserUID?>(
            create: (_) => AuthenticationService().user,
            initialData: null,
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: MainWrapper(),
            ),
          );
        }

        return CupertinoActivityIndicator();
      },
    );
  }
}
