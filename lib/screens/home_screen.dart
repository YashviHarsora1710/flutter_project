import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome to Lost Document Helper!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              "This app helps you manage your lost & found documents.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                // Placeholder action
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Report Lost Document")),
                );
              },
              icon: const Icon(Icons.report),
              label: const Text("Report Lost Document"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Placeholder action
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("View Found Documents")),
                );
              },
              icon: const Icon(Icons.search),
              label: const Text("View Found Documents"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
