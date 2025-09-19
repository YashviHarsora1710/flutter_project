import 'package:flutter/material.dart';

class AdminServicesScreen extends StatefulWidget {
  const AdminServicesScreen({super.key});

  @override
  State<AdminServicesScreen> createState() => _AdminServicesScreenState();
}

class _AdminServicesScreenState extends State<AdminServicesScreen> {
  final TextEditingController serviceController = TextEditingController();
  List<String> services = ["PDF Conversion", "Pick-up & Drop", "Checklist"];

  void addService() {
    if (serviceController.text.trim().isNotEmpty) {
      setState(() {
        services.add(serviceController.text.trim());
        serviceController.clear();
      });
    }
  }

  void removeService(int index) {
    setState(() {
      services.removeAt(index);
    });
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
              child: services.isEmpty
                  ? Center(
                      child: Text(
                        "No services available",
                        style: theme.textTheme.bodyMedium,
                      ),
                    )
                  : ListView.separated(
                      itemCount: services.length,
                      separatorBuilder: (context, index) =>
                          Divider(color: theme.dividerColor),
                      itemBuilder: (context, index) {
                        return Card(
                          color: theme.cardColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 2,
                          child: ListTile(
                            leading: Icon(
                              Icons.build,
                              color: theme.colorScheme.primary,
                            ),
                            title: Text(
                              services[index],
                              style: theme.textTheme.bodyLarge,
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: theme.colorScheme.error,
                              ),
                              onPressed: () => removeService(index),
                            ),
                          ),
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