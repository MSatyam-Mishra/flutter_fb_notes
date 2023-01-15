import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_fb_notes/styles/app_style.dart';

Widget noteCard(Function()? onTap, QueryDocumentSnapshot doc) {
  return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15.0),
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          gradient: AppStyle.cardGradient[doc['color_id']],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            doc["note_title"],
            style: AppStyle.mainTitle,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            doc["creation_date"],
            style: AppStyle.dateStyle,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            doc["note_content"],
            style: AppStyle.mainContent,
            overflow: TextOverflow.ellipsis,
          ),
        ]),
      ));
}
