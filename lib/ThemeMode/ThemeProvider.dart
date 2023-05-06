import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkTheme = true;

  void changeTheme() {
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }
}
