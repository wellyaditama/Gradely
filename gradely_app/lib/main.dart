import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gradely_app/firebase/authentication_service.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirebaseInitialization(),
    );
  }
}

class FirebaseInitialization extends StatefulWidget {
  const FirebaseInitialization({Key? key}) : super(key: key);

  @override
  _FirebaseInitializationState createState() => _FirebaseInitializationState();
}

class _FirebaseInitializationState extends State<FirebaseInitialization> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return FirebaseErrorUi();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(providers: [
            Provider<AuthenticationService>(
              create: (_) => AuthenticationService(FirebaseAuth.instance),
            ),
            StreamProvider(
              create: (context) =>
                  context.read<AuthenticationService>().authStateChanges,
              initialData: null,
            ),
          ], child: AuthenticationWrapper());
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return CupertinoActivityIndicator();
      },
    );
  }
}

class FirebaseErrorUi extends StatelessWidget {
  const FirebaseErrorUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Something went wrong!'),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return HomeUI();
    }

    return LoginUI();
  }
}

class HomeUI extends StatelessWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home UI'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Home UI'),
            ElevatedButton(
              onPressed: () {
                context.read<AuthenticationService>().signOut();
              },
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginUI extends StatelessWidget {
  LoginUI({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? error = "Test";

    return Scaffold(
      appBar: AppBar(
        title: Text("Login To Your Account"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  hintText: 'Username',
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Flexible(
              child: TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  hintText: 'Password',
                ),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Flexible(
              child: ElevatedButton(
                onPressed: () {
                  context
                      .read<AuthenticationService>()
                      .signIn(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      )
                      .then(
                        (value) => showErrorDialog(value, context),
                      );
                },
                child: Container(
                  child: Text('Login'),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 10.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showErrorDialog(String? value, BuildContext context) {
    if(value!.contains("Signed in")) {
      HomeUI();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Login Error!'),
          content: Text(value),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            )
          ],
        ),
      );
    }
  }
}
