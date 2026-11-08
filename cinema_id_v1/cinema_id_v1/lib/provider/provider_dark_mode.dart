import 'package:flutter/material.dart';

// Light theme
ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.light(
    primary: Colors.black,
    background: Colors.white,
    secondary: Colors.black,
    onPrimary: Colors.black87,
  ),
);

// Dark theme
ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: Colors.white,
    background: Colors.black,
    secondary: Colors.white,
    onPrimary: Colors.white24,
  ),
);

class DarkMode extends ChangeNotifier {
  ThemeData _themeData = lightTheme; // Default theme is light

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkTheme;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners(); // Notify listeners that theme has changed
  }

  void toggleDarkMode() {
    if (_themeData == lightTheme) {
      themeData = darkTheme;
    } else {
      themeData = lightTheme;
    }
  }
}
