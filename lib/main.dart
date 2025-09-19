import 'package:document_helper_app/screens/admin.dart';
import 'package:document_helper_app/screens/login_screen.dart';
import 'package:document_helper_app/screens/signup_screen.dart';
import 'package:document_helper_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/main_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool("isDarkMode") ?? false;

  runApp(MyApp(isDarkMode: isDarkMode));
}

class MyApp extends StatefulWidget {
  final bool isDarkMode;
  const MyApp({super.key, required this.isDarkMode});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
  }

  void toggleTheme(bool darkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isDarkMode", darkMode);
    setState(() {
      _isDarkMode = darkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digi Docs Desk',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: SplashScreen(),
      //home: AdminPanel(onThemeChanged: toggleTheme),
      // home: LoginScreen(),
      // home: SignUpScreen(),
      // home: SplashScreen(),
    );
  }
}
