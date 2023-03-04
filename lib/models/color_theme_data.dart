import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final ThemeData greenTheme = ThemeData(
  primaryColor: Colors.green,
  primarySwatch: Colors.green,
  scaffoldBackgroundColor: Colors.green,
  appBarTheme: const AppBarTheme(color: Colors.green, centerTitle: true),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: const TextTheme(
    subtitle1: TextStyle(color: Colors.white),
    headline3: TextStyle(color: Colors.white),
  ),
);

final ThemeData redTheme = ThemeData(
  primaryColor: Colors.red,
  primarySwatch: Colors.red,
  scaffoldBackgroundColor: Colors.red,
  appBarTheme: const AppBarTheme(color: Colors.red, centerTitle: true),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: const TextTheme(
    subtitle1: TextStyle(color: Colors.white),
    headline3: TextStyle(color: Colors.white),
  ),
);

class ColorThemeData with ChangeNotifier {
  bool _isGreen = true;
  bool get isGreen => _isGreen;

  ThemeData get selectedTheme => _isGreen ? greenTheme : redTheme;

  void toggleStatus() {
    _isGreen = !_isGreen;
    saveThemeToSharedPref(_isGreen);
    notifyListeners();
  }

  static late SharedPreferences _sharedPref;

  Future<void> createPrefObject() async {
    _sharedPref = await SharedPreferences.getInstance();
  }

  void saveThemeToSharedPref(bool value) {
    _sharedPref.setBool("themeData", value);
  }

  void loadThemeFromSharedPref() {
    _isGreen = _sharedPref.getBool("themeData") ?? true;
  }
}
