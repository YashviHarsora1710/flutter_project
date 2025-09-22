import 'package:document_helper_app/screens/admin.dart';
import 'package:document_helper_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'screens/theme_notifier.dart';
import 'widgets/common_widgets.dart' show toggleTheme;

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Document Helper App",
      theme: ThemeData.light(), //light theme
      darkTheme: ThemeData.dark(), //dark theme
      themeMode: themeProvider.isDark ? ThemeMode.dark : ThemeMode.light,
      home: AdminPanel(onThemeChanged: toggleTheme), // or your HomeScreen
    );
  }
}
