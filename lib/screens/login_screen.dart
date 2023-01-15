import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fb_notes/screens/home_screen.dart';
import 'package:flutter_fb_notes/styles/app_style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  Future<void> createNewUser() async {
    _firestore.collection("users").doc(_auth.currentUser!.uid).set({
      'uid': _auth.currentUser!.uid,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Image.asset("assets/bg1.png"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: AppStyle.bgGradient,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 25, bottom: 25, left: 25, right: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login Now",
                      style: AppStyle.bigTextStyle.copyWith(fontSize: 25),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.email,
                          color: AppStyle.bigTextColor,
                          size: 20,
                        ),
                        border: InputBorder.none,
                        hintText: "Type Your Email Here",
                      ),
                      style: AppStyle.mainContent,
                      onChanged: (textEntered) {
                        email = textEntered;
                      },
                    ),
                    Divider(),
                    TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            icon: Icon(Icons.lock,
                                color: AppStyle.bigTextColor, size: 20),
                            border: InputBorder.none,
                            hintText: "Enter Your Password Here"),
                        style: AppStyle.mainContent,
                        onChanged: (textEntered) {
                          password = textEntered;
                        }),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            try {
                              await _auth.signInWithEmailAndPassword(
                                  email: email, password: password);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ));
                              FirebaseFirestore.instance
                                  .collection("notes")
                                  .add({
                                "note_title": "Welcome",
                                "creation_date": DateTime.now,
                                "note_content": "Hello, User Welcome",
                                "color_id": 2,
                                "uid": _auth.currentUser,
                              }).then((value) {
                                Navigator.pop(context);
                              }).catchError((error) => print(
                                      "Failed to add note due to $error"));
                            } on FirebaseAuthException catch (err) {
                              if (err.code == "user-not-found") {
                                try {
                                  await _auth
                                      .createUserWithEmailAndPassword(
                                          email: email, password: password)
                                      .then(
                                    (user) {
                                      user.user!.sendEmailVerification();
                                      createNewUser();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomeScreen()),
                                      );
                                    },
                                  );
                                } catch (err) {}
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        title: Text("Error"),
                                        content: Text(err.message.toString()),
                                        actions: [
                                          FlatButton(
                                            child: Text("Ok"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    });
                              }
                            }
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppStyle.bigTextColor),
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.2,
                              alignment: Alignment.center,
                              child: Text(
                                "Log in",
                                style: AppStyle.mainContent
                                    .copyWith(color: AppStyle.bgColor),
                              )),
                        ),
                        Text(
                          "Forgot Password",
                          style: AppStyle.mainContent
                              .copyWith(color: AppStyle.bigTextColor),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
