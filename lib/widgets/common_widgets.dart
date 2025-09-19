import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class ToggleTheme extends StatefulWidget {
//   const ToggleTheme({super.key});

//   @override
//   State<ToggleTheme> createState() => _ToggleThemeState();
// }

// class _ToggleThemeState extends State<ToggleTheme> {

// late bool _isDarkMode;

void toggleTheme(bool darkMode) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool("isDarkMode", darkMode);
  // setState(() {
  //   _isDarkMode = darkMode;
  // });
}

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
