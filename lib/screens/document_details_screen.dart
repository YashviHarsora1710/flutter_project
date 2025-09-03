import 'package:flutter/material.dart';
import '../models/service_model.dart';

class ServiceDetailScreen extends StatelessWidget {
  final ServiceModel service;

  const ServiceDetailScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(service.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Required Documents:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...service.requiredDocuments
                .map(
                  (doc) => ListTile(
                    leading: const Icon(Icons.description),
                    title: Text(doc),
                  ),
                )
                .toList(),
            const SizedBox(height: 20),
            const Text(
              'Procedure Steps:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...service.procedureSteps
                .map(
                  (step) => ListTile(
                    leading: const Icon(Icons.check_circle_outline),
                    title: Text(step),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
