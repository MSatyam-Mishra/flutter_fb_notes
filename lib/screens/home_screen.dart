import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_fb_notes/screens/note_editor.dart';
import 'package:flutter_fb_notes/screens/note_reader.dart';
import 'package:flutter_fb_notes/styles/app_style.dart';
import 'package:flutter_fb_notes/widgets/note_card.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Your Note App",
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(
              Icons.people,
              color: Colors.black,
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: AppStyle.appBarColor,
      ),
      body: Container(
        decoration: BoxDecoration(color: AppStyle.bgColor),
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("notes")
                      .where("uid",
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasData) {
                      return GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        children: snapshot.data!.docs
                            .map((note) => noteCard(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NoteReaderScreen(
                                                doc: note,
                                              )));
                                }, note))
                            .toList(),
                      );
                    }
                    return Text(
                      "There is no Notes",
                      style: GoogleFonts.nunito(color: Colors.white),
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NoteEditorScreen()));
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 148, 52, 52),
                    Color.fromARGB(255, 100, 22, 22)
                  ])),
          width: 100, height: 40,

          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Icon(
                  Icons.add,
                  color: AppStyle.bgColor,
                ),
                Text(
                  "Add Note",
                  style: TextStyle(color: AppStyle.bgColor),
                )
              ]),
            ),
          ),

          //label: Text("Add Note"),
          //icon: Icon(Icons.add),
        ),
      ),
    );
  }
}
