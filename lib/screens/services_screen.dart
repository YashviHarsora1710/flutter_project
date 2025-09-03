import 'package:document_helper_app/screens/Checklist_page.dart';
import 'package:document_helper_app/screens/pickup_drop_page.dart';
import 'package:flutter/material.dart';
import 'pdf_conversion_page.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Icon(icon, color: const Color.fromARGB(255, 55, 77, 75)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Our Services"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 55, 77, 75),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          _buildServiceCard(
            icon: Icons.picture_as_pdf,
            title: "PDF Conversion",
            subtitle: "Convert images into PDF instantly.",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PdfConversionPage(),
                ),
              );
            },
          ),
          _buildServiceCard(
            icon: Icons.local_taxi,
            title: "Pick-up & Drop Facility",
            subtitle: "Book vehicle pick-up & drop service.",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PickupDropScreen(),
                ), // 👈 new page
              );
            },
          ),
          _buildServiceCard(
            icon: Icons.checklist,
            title: "Checklist",
            subtitle: "Create and manage your checklist.",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChecklistPage(documents: []),
                ), // 👈 open checklist page
              );
            },
          ),
        ],
      ),
    );
  }
}
