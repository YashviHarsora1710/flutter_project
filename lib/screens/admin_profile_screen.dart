import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'full_screenimage.dart';
import 'login_screen.dart';
import 'theme_notifier.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required Function(bool darkMode) onThemeChanged,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = "John";
  String _email = "john@rku.ac.in";
  String _phone = "+91 12345 67890";
  String _role = "Admin";
  String? _profileImagePath;

  String firstLetter = "";

  @override
  void initState() {
    super.initState();
    _loadProfile();
    firstLetter = _name.isNotEmpty ? _name[0].toUpperCase() : "?";
  }

  Future<void> _loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? _name;
      _email = prefs.getString('email') ?? _email;
      _phone = prefs.getString('phone') ?? _phone;
      _profileImagePath = prefs.getString('profileImage');
    });
  }

  Future<void> _saveProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', _name);
    prefs.setString('email', _email);
    prefs.setString('phone', _phone);
    if (_profileImagePath != null) {
      prefs.setString('profileImage', _profileImagePath!);
    } else {
      prefs.remove('profileImage');
    }
  }

  Future<void> _changeProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImagePath = image.path;
      });
      _saveProfile();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "✨ Wow! You look amazing with your new profile photo! ✨",
            style: TextStyle(fontSize: 16),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void _editDetails() {
    TextEditingController nameController = TextEditingController(text: _name);
    TextEditingController emailController = TextEditingController(text: _email);
    TextEditingController phoneController = TextEditingController(text: _phone);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Profile"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: "Phone"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _name = nameController.text.trim();
                  _email = emailController.text.trim();
                  _phone = phoneController.text.trim();
                });
                _saveProfile();
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(value, style: Theme.of(context).textTheme.bodyLarge),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.brightness_6),
            onSelected: (value) {
              if (value == "Light") {
                themeProvider.setTheme(false); // Light
              } else if (value == "Dark") {
                themeProvider.setTheme(true); // Dark
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: "Light", child: Text("Light Mode")),
              PopupMenuItem(value: "Dark", child: Text("Dark Mode")),
            ],
          ),
          IconButton(icon: const Icon(Icons.edit), onPressed: _editDetails),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              }
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  if (_profileImagePath != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FullScreenImage(imagePath: _profileImagePath!),
                      ),
                    );
                  }
                },
                child: Hero(
                  tag: 'profileImage',
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: ClipOval(
                      child: SizedBox(
                        width: 120,
                        height: 120,
                        child: _profileImagePath != null
                            ? FittedBox(
                                fit: BoxFit.cover,
                                child: Image.file(File(_profileImagePath!)),
                              )
                            : Center(
                                child: Text(
                                  firstLetter,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: _changeProfileImage,
                icon: const Icon(Icons.camera_alt),
                label: const Text("Change Photo"),
              ),
              const SizedBox(height: 20),
              _buildInfoCard(Icons.person, "Name", _name),
              _buildInfoCard(Icons.email, "Email Address", _email),
              _buildInfoCard(Icons.phone, "Mobile Number", _phone),
              _buildInfoCard(Icons.security, "Role", _role),
            ],
          ),
        ),
      ),
    );
  }
}