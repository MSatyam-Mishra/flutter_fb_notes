import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_fb_notes/styles/app_style.dart';

class NoteReaderScreen extends StatefulWidget {
  NoteReaderScreen({required this.doc, Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;

  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  @override
  Widget build(BuildContext context) {
    int color_id = widget.doc['color_id'];
    return Scaffold(
      // backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.appBarColor,
        elevation: 0.0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(gradient: AppStyle.cardGradient[color_id]),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              widget.doc["note_title"],
              style: AppStyle.mainTitle,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              widget.doc["creation_date"],
              style: AppStyle.dateStyle,
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              widget.doc["note_content"],
              style: AppStyle.mainContent,
              overflow: TextOverflow.ellipsis,
            ),
          ]),
        ),
      ),
    );
  }
}
