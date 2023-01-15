import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fb_notes/screens/home_screen.dart';

import 'package:flutter_fb_notes/screens/login_screen.dart';
import 'package:flutter_fb_notes/styles/app_style.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
              theme: ThemeData(accentColor: AppStyle.accentColor),
              debugShowCheckedModeBanner: false,
              home: (FirebaseAuth.instance.currentUser == null)
                  ? LoginScreen()
                  : HomeScreen());
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(body: Container()),
          );
        }
      },
    );
  }
}
