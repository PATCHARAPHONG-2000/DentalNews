import 'package:dental_news/Contoller/Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

final ThemeData themeDataLight = ThemeData(
    scaffoldBackgroundColor: Color(0xFFEBE8E8),
    primaryColor: Color(0xFF8009B8),
    cardColor: Color(0xFFFFFFFF),
    hoverColor: Color(0xFF8009B8),
    colorScheme:
        ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 11, 238, 227)),
    brightness: Brightness.light,
    primaryColorBrightness: Brightness.light,
    accentColor: Colors.purple[500],
    accentColorBrightness: Brightness.light);

final ThemeData themeDataDark = ThemeData(
  //hintColor: Color.fromARGB(255, 0, 0, 0),
  hoverColor: Color(0xFFFFFFFF),
  scaffoldBackgroundColor: Color(0xFF3D3D3D),
  cardColor: Color(0xFFFFFFFF),
  primaryColor: Color(0xFF3D3D3D),
  colorScheme: const ColorScheme.dark(),
  textTheme: const TextTheme(),
  brightness: Brightness.dark,
  primaryColorBrightness: Brightness.dark,
  accentColor: Colors.blue[500],
  accentColorBrightness: Brightness.dark,
);
