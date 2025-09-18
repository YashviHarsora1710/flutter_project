import 'package:flutter/material.dart';

import 'admin_pickup_detail.dart';
//import 'admin_pickup_detail_screen.dart';

class AdminPickupScreen extends StatefulWidget {
  const AdminPickupScreen({super.key});

  @override
  State<AdminPickupScreen> createState() => _AdminPickupScreenState();
}

class _AdminPickupScreenState extends State<AdminPickupScreen> {
  // List of requests
  List<Map<String, String>> pickupRequests = [
    {
      "name": "Sneha",
      "phone": "1234567890",
      "pickup": "RK University",
      "drop": "Ahmedabad",
      "date": "30-09-2025",
      "time": "6:30 PM",
    },
    {
      "name": "Rahul",
      "phone": "9876543210",
      "pickup": "Rajkot",
      "drop": "Surat",
      "date": "01-10-2025",
      "time": "10:00 AM",
    },
  ];

  void deleteRequest(int index) {
    setState(() {
      pickupRequests.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Request deleted successfully")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin - Pick-Up Details"),
        backgroundColor: const Color.fromARGB(255, 55, 77, 75),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: pickupRequests.length,
        itemBuilder: (context, index) {
          final request = pickupRequests[index];

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 3,
            child: ListTile(
              leading: CircleAvatar(child: Text(request["name"]![0])),
              title: Text(
                request["name"]!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => deleteRequest(index),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PickupDetailScreen(
                      request: request,
                      onDelete: () {
                        deleteRequest(index);
                        Navigator.pop(context); // close detail screen
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
