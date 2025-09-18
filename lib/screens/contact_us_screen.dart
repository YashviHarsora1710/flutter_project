import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Us"),
        backgroundColor: const Color(0xFF4C5C68),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "We’d love to hear from you!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            const ListTile(
              leading: Icon(Icons.email, color: Color(0xFF4C5C68)),
              title: Text("john@rku.ac.in"),
            ),
            const ListTile(
              leading: Icon(Icons.phone, color: Color(0xFF4C5C68)),
              title: Text("+91 65896 87452"),
            ),
            const ListTile(
              leading: Icon(Icons.location_on, color: Color(0xFF4C5C68)),
              title: Text("RKU, Tramba, Gujarat, India"),
            ),

            const SizedBox(height: 30),

            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Example action: open email app
                },
                icon: const Icon(
                  Icons.message,
                  color: Colors.white,
                ), // <-- icon white
                label: const Text(
                  "Send us a Message",
                  style: TextStyle(color: Colors.white), // <-- text white
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4C5C68),
                  foregroundColor:
                      Colors.white, // <-- ensures text/icon are white
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
