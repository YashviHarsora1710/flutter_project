import 'package:flutter/material.dart';
import '../models/service_model.dart';

class ServiceDetailScreen extends StatelessWidget {
  final ServiceModel service;

  const ServiceDetailScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(service.name),
        backgroundColor: const Color(0xFF4C5C68), // keep your color
        foregroundColor: Colors.white,
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
                  child: Text("• $step", style: const TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
