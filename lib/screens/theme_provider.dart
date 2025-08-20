// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ThemeProvider extends ChangeNotifier {
//   ThemeMode _themeMode = ThemeMode.light;

//   ThemeProvider() {
//     _loadTheme();
//   }

//   ThemeMode get themeMode => _themeMode;

//   bool get isDarkMode => _themeMode == ThemeMode.dark;

//   void toggleTheme(bool isOn) async {
//     _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
//     notifyListeners();

//     final prefs = await SharedPreferences.getInstance();
//     prefs.setBool('isDarkMode', isOn);
//   }

//   Future<void> _loadTheme() async {
//     final prefs = await SharedPreferences.getInstance();
//     final isDark = prefs.getBool('isDarkMode') ?? false;
//     _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
//     notifyListeners();
//   }
// }
