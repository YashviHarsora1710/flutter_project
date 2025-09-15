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
      // ✅ Save to DB here if required
    }
  }

  void removeService(int index) {
    setState(() {
      services.removeAt(index);
    });
    // ✅ Update DB here if required
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        245,
        246,
        246,
      ), // ✅ Set background color
      appBar: AppBar(
        title: const Text("Admin - Services"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(
          255,
          55,
          77,
          75,
        ), // ✅ Matching AppBar color
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Input Box + Button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: serviceController,
                    decoration: const InputDecoration(
                      labelText: "Enter new service",
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white, // ✅ White input background
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.teal,
                  ),
                  onPressed: addService,
                  icon: const Icon(Icons.add),
                  label: const Text("Add"),
                ),
              ],
            ),
            const SizedBox(height: 20),

            const Text(
              "Available Services:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Divider(color: Colors.white),

            // ✅ Service List
            Expanded(
              child: services.isEmpty
                  ? const Center(
                      child: Text(
                        "No services available",
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                    )
                  : ListView.separated(
                      itemCount: services.length,
                      separatorBuilder: (context, index) =>
                          const Divider(color: Colors.white),
                      itemBuilder: (context, index) {
                        return ListTile(
                          tileColor: const Color.fromARGB(255, 162, 165, 165),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          leading: const Icon(Icons.build, color: Colors.white),
                          title: Text(
                            services[index],
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Color.fromARGB(255, 12, 12, 12),
                            ),
                            onPressed: () => removeService(index),
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
