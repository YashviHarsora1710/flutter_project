import 'package:document_helper_app/screens/admin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/theme_notifier.dart';
import 'screens/admin_home_screen.dart';

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
      title: 'Digi Docs Desk',
      theme: themeProvider.themeData, // ✅ apply theme here
      home: AdminPanel(),
    );
  }
}
