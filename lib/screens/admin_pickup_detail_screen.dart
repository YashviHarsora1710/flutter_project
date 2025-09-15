import 'package:flutter/material.dart';

class PickupDetailScreen extends StatelessWidget {
  final Map<String, String> request;
  final VoidCallback onDelete; // callback from parent

  const PickupDetailScreen({
    super.key,
    required this.request,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin - Pick-Up Details"),
        backgroundColor: const Color.fromARGB(255, 55, 77, 75),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name: ${request["name"]}"),
                Text("Phone: ${request["phone"]}"),
                Text("Pickup: ${request["pickup"]}"),
                Text("Drop: ${request["drop"]}"),
                Text("Date: ${request["date"]}"),
                Text("Time: ${request["time"]}"),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    icon: const Icon(Icons.delete),
                    label: const Text("Delete"),
                    onPressed: onDelete, // call parent delete
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
