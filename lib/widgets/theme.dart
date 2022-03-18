import 'package:flutter/material.dart';

class ThemeService with ChangeNotifier {
  bool isDarkTheme = false;
  static final ThemeData themeA =
      ThemeData.light(); //.copyWith(scaffoldBackgroundColor: Colors.white);
  static final ThemeData themeB =
      ThemeData.dark(); //.copyWith(scaffoldBackgroundColor: Colors.black);

  ThemeData _currentTheme = themeA;

  get currentTheme => _currentTheme;

  switchToLightTheme() {
    _currentTheme = themeA;
    notifyListeners();
  }

  switchToDarkTheme() {
    _currentTheme = themeB;
    notifyListeners();
  }

  changeTheme() {
    isDarkTheme = !isDarkTheme;
  }
}
