import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle myTextStyle = const TextStyle(fontSize: 15);
TextStyle k2Style = const TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 16,
);

TextStyle k3Style = const TextStyle(
  color: Colors.grey,
  fontSize: 12.0,
);

TextStyle k22style = GoogleFonts.k2d(
  textStyle: const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    //color: Theme.of(context).cardColor,
  ),
);

class color {
  //AppBar
  static Color app = Color(0xFF8009B8);

  //ทั่วไป
  static Color green = Colors.green;
  static Color grey = Color(0xFF8F8F8F);
  static Color white = Colors.white;
  static Color black = Color.fromARGB(255, 61, 61, 61);
  static Color purple = Colors.purple;
  static Color blue = Colors.blue;
  static Color black26 = Colors.black26;
  static Color grey1 = const Color(0x6BFFFFFFF);
  static Color grey2 = Color(0xFF575757F);
  static Color see = Color(0xFFDADADA);

  //map
  static Color hovercolor = Color(0xFFC514BCF);
  static Color iconSend = Color(0xFFA012B3);
  static Color fromRGBO = Color.fromRGBO(23, 157, 139, 1);
  static Color fromRGBO1 = Color.fromRGBO(220, 220, 220, 1);
}

const Color purple = Color(0xFF8009B8);
