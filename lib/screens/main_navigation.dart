import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'services_screen.dart';
import 'feedback_screen.dart';
import 'profile_screen.dart';

class MainNavigation extends StatefulWidget {
  final Function(bool) onThemeChanged; // ✅ callback

  const MainNavigation({super.key, required this.onThemeChanged});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomeScreen(),
      const ServicesPage(),
      const FeedbackScreen(),
      ProfileScreen(onThemeChanged: widget.onThemeChanged),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: isDark
            ? const Color(0xFF4C5C68)
            : Colors.white, //  background
        selectedItemColor: isDark
            ? Colors.white
            : const Color(0xFF4C5C68), // ✅ selected icon/text
        unselectedItemColor: isDark
            ? Colors.white70
            : Colors.grey, // ✅ contrast
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
    );
  }
}
