import 'package:flutter/material.dart';
import '../models/service_model.dart';
import 'checklist_page.dart';

class ServiceDetailScreen extends StatelessWidget {
  final ServiceModel service;

  const ServiceDetailScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(service.name),
        backgroundColor: const Color(0xFF4C5C68),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Required Documents:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...service.requiredDocuments.map(
                (doc) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text("• $doc", style: const TextStyle(fontSize: 16)),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Procedure Steps:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...service.procedureSteps.map(
                (step) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text("• $step", style: TextStyle(fontSize: 16)),
                ),
              ),

              const SizedBox(height: 30),

              // ✅ Add Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ChecklistPage(documents: service.requiredDocuments),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4C5C68),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  child: const Text(
                    "Add to Checklist",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
