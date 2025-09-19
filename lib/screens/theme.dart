// TODO Implement this library.
import 'package:flutter/material.dart';

class AppThemes {
  // Main color palette
  static const Color primary = Color.fromARGB(255, 58, 79, 77);
  static const Color lightBackground = Colors.white;
  static const Color darkBackground = Color.fromARGB(255, 40, 39, 39);
  static const Color lightText = Colors.black87;
  static const Color darkText = Colors.white70;
  static const Color errorColor = Colors.redAccent;

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primary,
    scaffoldBackgroundColor: lightBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      foregroundColor: Colors.white,
    ),
    cardColor: Colors.white,
    dividerColor: Colors.grey.shade300,
    colorScheme: const ColorScheme.light(
      primary: primary,
      onPrimary: Colors.white,
      secondary: Colors.teal,
      background: lightBackground,
      surface: Colors.white,
      error: errorColor,
      onSurface: lightText,
      onBackground: lightText,
      onError: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: lightText),
      bodyMedium: TextStyle(color: lightText),
      titleMedium: TextStyle(color: lightText),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primary,
    scaffoldBackgroundColor: darkBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: darkBackground,
      foregroundColor: darkText,
    ),
    cardColor: const Color(0xFF1E1E1E),
    dividerColor: Colors.grey.shade700,
    colorScheme: const ColorScheme.dark(
      primary: primary,
      onPrimary: Colors.white,
      secondary: Colors.tealAccent,
      background: darkBackground,
      surface: Color(0xFF1E1E1E),
      error: errorColor,
      onSurface: darkText,
      onBackground: darkText,
      onError: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: darkText),
      bodyMedium: TextStyle(color: darkText),
      titleMedium: TextStyle(color: darkText),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF2A2A2A),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}
