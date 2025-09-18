import 'package:flutter/material.dart';
import 'theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = AppThemes.lightTheme;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == AppThemes.darkTheme;

  // ✅ Add this method to set theme directly
  void setTheme(bool isDark) {
    _themeData = isDark ? AppThemes.darkTheme : AppThemes.lightTheme;
    notifyListeners(); // rebuild the app with new theme
  }

  void toggleTheme() {
    _themeData = isDarkMode ? AppThemes.lightTheme : AppThemes.darkTheme;
    notifyListeners();
  }
}
