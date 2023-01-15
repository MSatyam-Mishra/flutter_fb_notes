import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_fb_notes/styles/app_style.dart';
import 'package:intl/intl.dart';

class NoteEditorScreen extends StatefulWidget {
  NoteEditorScreen({Key? key}) : super(key: key);

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  int color_id = Random().nextInt(AppStyle.cardGradient.length);
  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();
  String date = DateFormat("dd-mm-yyyy").format(DateTime.now());

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  String userId = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    addNotes();
  }

  void addNotes() {
    _firestore
        .collection("users")
        .where("uid", isEqualTo: _auth.currentUser)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: AppStyle.appBarColor,
        elevation: 0.0,
        title: Text(
          "Add A New Notes",
        ),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppStyle.cardGradient[color_id]),
        child: Padding(
          padding: EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextField(
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "Enter Title Here"),
              controller: _titleController,
              style: AppStyle.mainTitle,
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "Enter Your Note Here"),
              controller: _mainController,
              style: AppStyle.mainContent,
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppStyle.accentColor,
          onPressed: () async {
            FirebaseFirestore.instance.collection("notes").add({
              "note_title": _titleController.text,
              "creation_date": date,
              "note_content": _mainController.text,
              "color_id": color_id,
              "uid": FirebaseAuth.instance.currentUser!.uid,
            }).then((value) {
              Navigator.pop(context);
            }).catchError((error) => print("Failed to add note due to $error"));
          },
          child: Icon(Icons.save)),
    );
  }
}
/*

 
            */