import 'package:document_helper_app/screens/admin.dart';
import 'package:document_helper_app/screens/main_navigation.dart';
import 'package:document_helper_app/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'screens/theme_notifier.dart';
import 'widgets/common_widgets.dart' show toggleTheme;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDngaC8Dm_E_EW9EX_EAy7oFBr7oSsyywY",
        authDomain: "digi-docs-desk-23e63.firebaseapp.com",
        projectId: "digi-docs-desk-23e63",
        storageBucket: "digi-docs-desk-23e63.firebasestorage.app",
        messagingSenderId: "832125493439",
        appId: "1:832125493439:web:dfdb11026ac7f16a97260a",
        measurementId: "G-ZJF27LB9J3",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

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
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.isDark ? ThemeMode.dark : ThemeMode.light,
      home: SplashScreen(),
    );
  }
}
