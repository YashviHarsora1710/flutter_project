import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminServicesScreen extends StatefulWidget {
  const AdminServicesScreen({super.key});

  @override
  State<AdminServicesScreen> createState() => _AdminServicesScreenState();
}

class _AdminServicesScreenState extends State<AdminServicesScreen> {
  final TextEditingController serviceController = TextEditingController();
  final CollectionReference _adminServices = FirebaseFirestore.instance
      .collection('admin_services');

  // 🔹 Function to automatically decide icon name
  String getIconForService(String title) {
    title = title.toLowerCase();

    if (title.contains("pdf")) return "picture_as_pdf";
    if (title.contains("pickup") || title.contains("drop")) return "local_taxi";
    if (title.contains("check") || title.contains("list")) return "checklist";
    if (title.contains("print")) return "print";
    if (title.contains("scan")) return "scanner";
    if (title.contains("photo")) return "photo";
    if (title.contains("copy")) return "content_copy";
    if (title.contains("repair") || title.contains("fix")) return "build";

    // default icon
    return "miscellaneous_services";
  }

  // 🔹 Add new service
  void addService() {
    String title = serviceController.text.trim();
    if (title.isNotEmpty) {
      String iconName = getIconForService(title);

      _adminServices.add({"title": title, "icon": iconName});

      serviceController.clear();
    }
  }

  // 🔹 Delete a service
  void removeService(String docId) {
    _adminServices.doc(docId).delete();
  }

  // 🔹 Convert stored icon name to actual IconData
  IconData getIconData(String iconName) {
    switch (iconName) {
      case 'picture_as_pdf':
        return Icons.picture_as_pdf;
      case 'local_taxi':
        return Icons.local_taxi;
      case 'checklist':
        return Icons.checklist;
      case 'print':
        return Icons.print;
      case 'scanner':
        return Icons.scanner;
      case 'photo':
        return Icons.photo;
      case 'content_copy':
        return Icons.content_copy;
      case 'build':
        return Icons.build;
      default:
        return Icons.miscellaneous_services;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Admin - Services"),
        centerTitle: true,
        backgroundColor: theme.primaryColor,
        foregroundColor: theme.appBarTheme.foregroundColor ?? Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: serviceController,
                    decoration: InputDecoration(
                      labelText: "Enter new service",
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: theme.colorScheme.surface,
                    ),
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                  ),
                  onPressed: addService,
                  icon: const Icon(Icons.add),
                  label: const Text("Add"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "Available Services:",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(color: theme.dividerColor),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _adminServices.snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: theme.primaryColor,
                      ),
                    );
                  }

                  final services = snapshot.data!.docs;

                  if (services.isEmpty) {
                    return Center(
                      child: Text(
                        "No services available",
                        style: theme.textTheme.bodyMedium,
                      ),
                    );
                  }

                  return ListView.separated(
                    itemCount: services.length,
                    separatorBuilder: (context, index) =>
                        Divider(color: theme.dividerColor),
                    itemBuilder: (context, index) {
                      final service = services[index];
                      final title = service['title'];
                      final iconName = service['icon'];
                      final icon = getIconData(iconName);

                      return Card(
                        color: theme.cardColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 2,
                        child: ListTile(
                          leading: Icon(icon, color: theme.colorScheme.primary),
                          title: Text(title, style: theme.textTheme.bodyLarge),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: theme.colorScheme.error,
                            ),
                            onPressed: () => removeService(service.id),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
