// save as: lib/screens/edit_page.dart
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final String name;
  final String email;
  final String phone;

  const EditPage({super.key, required this.name, required this.email, required this.phone});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _emailController = TextEditingController(text: widget.email);
    _phoneController = TextEditingController(text: widget.phone);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onSave() {
    Navigator.pop(context, {
      'name': _nameController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile"), backgroundColor: const Color(0xFF4C5C68)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: "Name")),
            const SizedBox(height: 12),
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: "Email")),
            const SizedBox(height: 12),
            TextField(controller: _phoneController, decoration: const InputDecoration(labelText: "Phone")),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: _onSave, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4C5C68)),
                child: const Text("Save", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
