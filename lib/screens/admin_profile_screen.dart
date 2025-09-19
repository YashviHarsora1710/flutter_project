import 'dart:io';
import 'package:document_helper_app/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'full_screenimage.dart';
import 'login_screen.dart';
import 'theme_notifier.dart' show ThemeProvider;

class ProfileScreen extends StatefulWidget {
  final Function(bool darkMode) onThemeChanged;
  ProfileScreen({super.key, required this.onThemeChanged});

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
  // late final themeProvider;

  @override
  void initState() {
    super.initState();
    _loadProfile();
    firstLetter = _name.isNotEmpty ? _name[0].toUpperCase() : "?";
    // themeProvider = Provider.of<ThemeProvider>(context);
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
        const SnackBar(
          content: Text(
            "✨ Wow! You look amazing with your new profile photo! ✨",
            style: TextStyle(fontSize: 16),
          ),
          backgroundColor: const Color.fromARGB(255, 58, 79, 77),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
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
                  if (_profileImagePath == null || _profileImagePath!.isEmpty) {
                    _profileImagePath = null;
                  }
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
        leading: Icon(icon, color: const Color.fromARGB(255, 55, 77, 75)),
        title: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: const Color.fromARGB(255, 58, 79, 77),
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.brightness_6, color: Colors.white),
            onSelected: (value) {
              //  Correct setTheme usage
              if (value == "Light") {
                widget.onThemeChanged(false);
                // themeProvider.setTheme(false);
              } else if (value == "Dark") {
                widget.onThemeChanged(true);
                // themeProvider.setTheme(true);
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: "Light", child: Text("Light Mode")),
              PopupMenuItem(value: "Dark", child: Text("Dark Mode")),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            color: Colors.white,
            onPressed: _editDetails,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            color: Colors.white,
            onPressed: () async {
              // Clear saved login/session data
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.clear();

              // Navigate to LoginScreen
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
                    backgroundColor: const Color.fromARGB(255, 58, 79, 77),
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
                                  style: const TextStyle(
                                    fontSize: 50,
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
