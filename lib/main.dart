import 'package:flutter/material.dart';
import 'package:document_helper_app/screens/splash_screen.dart';
import 'package:document_helper_app/screens/login_screen.dart';
import 'package:document_helper_app/screens/signup_screen.dart';
import 'package:document_helper_app/screens/main_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digi Docs Desk',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
