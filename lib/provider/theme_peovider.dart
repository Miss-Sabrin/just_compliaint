import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier with ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  late SharedPreferences storage;

  // custom dark theme
  final darkTheme = ThemeData(
    primaryColor: Colors.black12,
    brightness: Brightness.dark,
    primaryColorDark: Colors.black12,
  );

  // custom light theme
  final lightTheme = ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.light,
    primaryColorDark: Colors.white,
  );

  // dark mode toggle action
  void changeTheme() {
    _isDarkMode = !_isDarkMode;
    // save the value to the secure storage
    storage.setBool("isDark", _isDarkMode);
    notifyListeners();
  }

  // init method of provider
  void init() async {
    storage = await SharedPreferences.getInstance();
    _isDarkMode = storage.getBool('isDark') ?? false;
    notifyListeners();
  }
}
