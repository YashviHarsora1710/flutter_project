// save as: lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'contact_us_screen.dart';
import 'login_screen.dart';
import 'edit_page.dart';

class ProfileScreen extends StatefulWidget {
<<<<<<< HEAD
  const ProfileScreen({super.key});
=======
  final Function(bool) onThemeChanged; // ✅ receive callback
  const ProfileScreen({super.key, required this.onThemeChanged});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "Sneha";
  String email = "sneha@gmail.com";
  String phone = "+91 9876543210";

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("name") ?? name;
      email = prefs.getString("email") ?? email;
      phone = prefs.getString("phone") ?? phone;
    });
  }

  Future<void> _saveProfile(
    String newName,
    String newEmail,
    String newPhone,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("name", newName);
    await prefs.setString("email", newEmail);
    await prefs.setString("phone", newPhone);
  }

  Future<void> _openEdit() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPage(name: name, email: email, phone: phone),
      ),
    );

    if (result != null && result is Map<String, String>) {
      final newName = result['name'] ?? name;
      final newEmail = result['email'] ?? email;
      final newPhone = result['phone'] ?? phone;

      setState(() {
        name = newName;
        email = newEmail;
        phone = newPhone;
      });
      await _saveProfile(newName, newEmail, newPhone);
    }
  }
>>>>>>> himani

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "Sneha";
  String email = "sneha@gmail.com";
  String phone = "+91 9876543210";

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  // Load saved profile from SharedPreferences
  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("name") ?? name;
      email = prefs.getString("email") ?? email;
      phone = prefs.getString("phone") ?? phone;
    });
  }

  // Save profile to SharedPreferences
  Future<void> _saveProfile(String newName, String newEmail, String newPhone) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("name", newName);
    await prefs.setString("email", newEmail);
    await prefs.setString("phone", newPhone);
  }

  // Open EditPage and handle returned data
  Future<void> _openEdit() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPage(name: name, email: email, phone: phone),
      ),
    );

    if (result != null && result is Map<String, String>) {
      final newName = result['name'] ?? name;
      final newEmail = result['email'] ?? email;
      final newPhone = result['phone'] ?? phone;

      // update state and persist
      setState(() {
        name = newName;
        email = newEmail;
        phone = newPhone;
      });
      await _saveProfile(newName, newEmail, newPhone);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color(0xFF4C5C68),
<<<<<<< HEAD
=======
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ), // ✅ visible button at top right
            onSelected: (value) {
              if (value == "light") {
                widget.onThemeChanged(false);
              } else if (value == "dark") {
                widget.onThemeChanged(true);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: "light", child: Text("Light Mode")),
              const PopupMenuItem(value: "dark", child: Text("Dark Mode")),
            ],
          ),
        ],
>>>>>>> himani
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
<<<<<<< HEAD
            const CircleAvatar(radius: 50, backgroundImage: AssetImage('assets/profile_pic.png')),
            const SizedBox(height: 16),

            Text(name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            Text(email, style: const TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 8),

            Text(phone, style: const TextStyle(fontSize: 16, color: Colors.grey)),
=======
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile_pic.png'),
            ),
            const SizedBox(height: 16),
            Text(
              name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              email,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              phone,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
>>>>>>> himani
            const SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: _openEdit,
              icon: const Icon(Icons.edit, color: Colors.white),
<<<<<<< HEAD
              label: const Text("Edit Profile", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4C5C68)),
=======
              label: const Text(
                "Edit Profile",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4C5C68),
              ),
>>>>>>> himani
            ),

            const SizedBox(height: 24),
            const Divider(),

            ListTile(
              leading: const Icon(Icons.contact_mail, color: Color(0xFF4C5C68)),
              title: const Text("Contact Us"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
<<<<<<< HEAD
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ContactUsScreen()));
=======
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ContactUsScreen()),
                );
>>>>>>> himani
              },
            ),

            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("Confirm Logout"),
                    content: const Text("Are you sure you want to logout?"),
                    actions: [
<<<<<<< HEAD
                      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
=======
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text("Cancel"),
                      ),
>>>>>>> himani
                      TextButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          Navigator.pushAndRemoveUntil(
                            context,
<<<<<<< HEAD
                            MaterialPageRoute(builder: (_) => const LoginScreen()),
                            (route) => false,
                          );
                        },
                        child: const Text("Logout", style: TextStyle(color: Colors.red)),
=======
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        child: const Text(
                          "Logout",
                          style: TextStyle(color: Colors.red),
                        ),
>>>>>>> himani
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
