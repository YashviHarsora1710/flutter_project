import 'package:flutter/material.dart';
import 'admin_pickup_detail.dart';

class AdminPickupScreen extends StatefulWidget {
  const AdminPickupScreen({super.key});

  @override
  State<AdminPickupScreen> createState() => _AdminPickupScreenState();
}

class _AdminPickupScreenState extends State<AdminPickupScreen> {
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
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Admin - Pick-Up Requests"),
        backgroundColor: primaryColor,
        foregroundColor: theme.appBarTheme.foregroundColor ?? Colors.white,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: pickupRequests.length,
        itemBuilder: (context, index) {
          final request = pickupRequests[index];

          return Card(
            color: theme.scaffoldBackgroundColor == Colors.white
                ? Colors.white
                : const Color.fromARGB(255, 60, 60, 60),
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 3,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                child: Text(request["name"]![0]),
              ),
              title: Text(
                request["name"]!,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: theme.colorScheme.error),
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
                        Navigator.pop(context);
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
