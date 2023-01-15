import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  //main app colors

  static Color appBarColor = Color.fromARGB(255, 251, 235, 217);
  static Color bigTextColor = Color.fromARGB(255, 8, 30, 129);
  static LinearGradient bgGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromARGB(255, 251, 235, 217),
        Color.fromARGB(174, 240, 215, 191),
        Color.fromARGB(202, 240, 227, 211)
      ]);
  static Color bgColor = Color.fromARGB(255, 251, 235, 217);
  static Color accentColor = Color.fromARGB(255, 107, 17, 33);
  static Color textColor = Colors.black;

  //colors for cards
/*
  static List<Color> cardsColor = [
    Color.fromARGB(255, 134, 58, 111),
    Color.fromARGB(255, 151, 92, 141),
    Color.fromARGB(255, 217, 137, 181),
    Color.fromARGB(255, 255, 173, 188),
    Color.fromARGB(255, 134, 141, 155),
    Color.fromARGB(255, 206, 119, 119),
    Color.fromARGB(255, 133, 88, 111),
    Color.fromARGB(255, 141, 95, 228)
  ];
  */
  static List<Gradient> cardGradient = [
    LinearGradient(colors: [Color(0x43ff64d9), Color(0x43ff6466)]),
    LinearGradient(colors: [
      Color.fromARGB(67, 29, 16, 151),
      Color.fromARGB(67, 46, 38, 161)
    ]),
    LinearGradient(colors: [
      Color.fromARGB(67, 158, 9, 121),
      Color.fromARGB(67, 128, 69, 155)
    ]),
    LinearGradient(colors: [
      Color.fromARGB(67, 193, 100, 255),
      Color.fromARGB(67, 160, 50, 52)
    ]),
    LinearGradient(colors: [
      Color.fromARGB(67, 148, 81, 131),
      Color.fromARGB(67, 119, 19, 21)
    ]),
    LinearGradient(colors: [
      Color.fromARGB(67, 77, 87, 143),
      Color.fromARGB(67, 57, 29, 121)
    ]),
    LinearGradient(colors: [
      Color.fromARGB(67, 104, 136, 112),
      Color.fromARGB(67, 60, 136, 83)
    ]),
    LinearGradient(colors: [
      Color.fromARGB(67, 184, 129, 116),
      Color.fromARGB(67, 151, 59, 47)
    ]),
  ];

  //Text Style using google fonts

  static TextStyle mainTitle = GoogleFonts.nunito(
      fontSize: 20, fontWeight: FontWeight.bold, color: textColor);

  static TextStyle mainContent = GoogleFonts.nunito(
      fontSize: 18, fontWeight: FontWeight.normal, color: textColor);

  static TextStyle dateStyle = GoogleFonts.roboto(
      fontSize: 15, fontWeight: FontWeight.w500, color: textColor);

  static TextStyle bigTextStyle = GoogleFonts.lato(
      fontSize: 50, fontWeight: FontWeight.bold, color: bigTextColor);
}
