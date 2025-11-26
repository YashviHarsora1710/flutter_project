import 'dart:convert'; // for base64 encode/decode
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'contact_us_screen.dart';
import 'login_screen.dart';
import 'edit_page.dart';

class ProfileScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;
  const ProfileScreen({super.key, required this.onThemeChanged});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "";
  String email = "";
  String phone = "";
  String? profileImageBase64;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  // Load profile from Firestore based on logged-in user
  Future<void> _loadProfile() async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await _firestore
          .collection("Profile_page")
          .doc(user.uid)
          .get();
      if (doc.exists) {
        final data = doc.data()!;
        setState(() {
          name = data['name'] ?? "";
          email = data['email'] ?? user.email ?? "";
          phone = data['phone'] ?? "";
          profileImageBase64 = data['profileImageBase64'];
        });
      } else {
        setState(() {
          name = user.displayName ?? "";
          email = user.email ?? "";
        });
      }
    }
  }

  // Save profile updates to Firestore
  Future<void> _saveProfile(String newName, String newPhone) async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection("Profile_page").doc(user.uid).set({
        "name": newName,
        "email": email,
        "phone": newPhone,
        "profileImageBase64": profileImageBase64,
      }, SetOptions(merge: true));

      setState(() {
        name = newName;
        phone = newPhone;
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      final base64Image = base64Encode(bytes);

      setState(() {
        profileImageBase64 = base64Image;
      });

      final user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection("Profile_page").doc(user.uid).set({
          "profileImageBase64": base64Image,
        }, SetOptions(merge: true));
      }
    }
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
      final newPhone = result['phone'] ?? phone;

      await _saveProfile(newName, newPhone);
    }
  }

  void _openFullImage() {
    if (profileImageBase64 == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProfileImagePage(imageBase64: profileImageBase64!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;

    if (user == null) {
      return const Center(child: Text("Please login to view your profile"));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color(0xFF4C5C68),
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              if (value == "light") {
                widget.onThemeChanged(false);
              } else if (value == "dark") {
                widget.onThemeChanged(true);
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: "light", child: Text("Light Mode")),
              PopupMenuItem(value: "dark", child: Text("Dark Mode")),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Circle
            Stack(
              children: [
                GestureDetector(
                  onTap: _openFullImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: const Color(0xFF4C5C68),
                    backgroundImage: (profileImageBase64 != null)
                        ? MemoryImage(base64Decode(profileImageBase64!))
                        : null,
                    child: (profileImageBase64 == null)
                        ? Text(
                            name.isNotEmpty ? name[0].toUpperCase() : "?",
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                        : null,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300, width: 2),
                    ),
                    padding: const EdgeInsets.all(6),
                    child: InkWell(
                      onTap: _pickImage,
                      child: const Icon(
                        Icons.camera_alt,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            // Name
            Text(
              name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Email
            Text(
              email,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            // Phone
            Text(
              phone,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            // Edit Profile Button
            ElevatedButton.icon(
              onPressed: _openEdit,
              icon: const Icon(Icons.edit, color: Colors.white),
              label: const Text(
                "Edit Profile",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4C5C68),
              ),
            ),

            const SizedBox(height: 24),
            const Divider(),

            // Contact Us
            ListTile(
              leading: const Icon(Icons.contact_mail, color: Color(0xFF4C5C68)),
              title: const Text("Contact Us"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ContactUsScreen()),
                );
              },
            ),

            // Logout
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
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          Navigator.pushAndRemoveUntil(
                            context,
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

// Full Screen Profile Image
class ProfileImagePage extends StatelessWidget {
  final String imageBase64;
  const ProfileImagePage({super.key, required this.imageBase64});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.memory(base64Decode(imageBase64)),
        ),
      ),
    );
  }
}
