import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Checklist_page.dart';
import 'pickup_drop_page.dart';
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

  // Convert icon string from Firestore to IconData
  IconData _getIconFromString(String iconName) {
    switch (iconName) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'taxi':
        return Icons.local_taxi;
      case 'checklist':
        return Icons.checklist;
      case 'build':
        return Icons.build;
      default:
        return Icons.miscellaneous_services;
    }
  }

  @override
  Widget build(BuildContext context) {
    final CollectionReference servicesCollection = FirebaseFirestore.instance
        .collection('admin_services');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Our Services"),
        centerTitle: true,
        backgroundColor: const Color(0xFF4C5C68),
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: servicesCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final services = snapshot.data?.docs ?? [];

          if (services.isEmpty) {
            return const Center(child: Text("No services available"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];
              final title = service['title'] ?? 'Unnamed Service';
              final iconName = service['icon'] ?? 'misc';
              final icon = _getIconFromString(iconName);

              // You can customize navigation based on title
              VoidCallback onTap = () {};
              if (title.toLowerCase().contains("pdf")) {
                onTap = () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PdfConversionPage(),
                  ),
                );
              } else if (title.toLowerCase().contains("pick")) {
                onTap = () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PickupDropScreen()),
                );
              } else if (title.toLowerCase().contains("check")) {
                onTap = () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChecklistPage(documents: []),
                  ),
                );
              }

              return _buildServiceCard(
                icon: icon,
                title: title,
                subtitle: "Tap to explore this service",
                onTap: onTap,
              );
            },
          );
        },
      ),
    );
  }
}
