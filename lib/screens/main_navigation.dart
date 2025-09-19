import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
import 'services_screen.dart';
import 'feedback_screen.dart';
import 'profile_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  late List<Widget> _pages;

  bool _isDarkMode = false; // ✅ moved here

  @override
  void initState() {
    super.initState();
    _loadTheme();
    _pages = [
      const HomeScreen(),
      const ServicesPage(),
      const FeedbackScreen(),
      ProfileScreen(onThemeChanged: _toggleTheme), // ✅ pass function
    ];
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool("isDarkMode") ?? false;
    });
  }

  Future<void> _toggleTheme(bool darkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isDarkMode", darkMode);
    setState(() {
      _isDarkMode = darkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Digi Docs Desk",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          backgroundColor: _isDarkMode ? const Color(0xFF4C5C68) : Colors.white,
          selectedItemColor: _isDarkMode
              ? Colors.white
              : const Color(0xFF4C5C68),
          unselectedItemColor: _isDarkMode ? Colors.white70 : Colors.grey,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Services',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.feedback),
              label: 'Feedback',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
