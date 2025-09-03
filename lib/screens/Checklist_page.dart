import 'package:flutter/material.dart';

class ChecklistPage extends StatelessWidget {
  const ChecklistPage({super.key, required this.documents});

  final List<String> documents;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // no back arrow
        title: const Text("Checklist"),
        backgroundColor: const Color(0xFF4C5C68),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          "This page appear very soon",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
