import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkTheme = false; // ค่าเริ่มต้นเป็นธีมสว่าง

  void changeTheme() {
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }

  void setDarkTheme(bool savedTheme) {
    isDarkTheme = savedTheme;
    notifyListeners();
  }
}
