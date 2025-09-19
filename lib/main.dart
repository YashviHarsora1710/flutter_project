import 'package:document_helper_app/screens/admin.dart';
import 'package:document_helper_app/screens/login_screen.dart';
import 'package:document_helper_app/screens/signup_screen.dart';
import 'package:document_helper_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/main_navigation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Digi Docs Desk',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
