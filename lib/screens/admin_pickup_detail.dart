import 'package:flutter/material.dart';

class PickupDetailScreen extends StatelessWidget {
  final Map<String, String> request;
  final VoidCallback onDelete;

  const PickupDetailScreen({
    super.key,
    required this.request,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Admin - Pick-Up Details"),
        backgroundColor: primaryColor,
        foregroundColor: theme.appBarTheme.foregroundColor ?? Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: theme.scaffoldBackgroundColor == Colors.white
              ? Colors.white
              : const Color.fromARGB(255, 60, 60, 60),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name: ${request["name"]}",
                  style: theme.textTheme.bodyLarge,
                ),
                Text(
                  "Phone: ${request["phone"]}",
                  style: theme.textTheme.bodyLarge,
                ),
                Text(
                  "Pickup: ${request["pickup"]}",
                  style: theme.textTheme.bodyLarge,
                ),
                Text(
                  "Drop: ${request["drop"]}",
                  style: theme.textTheme.bodyLarge,
                ),
                Text(
                  "Date: ${request["date"]}",
                  style: theme.textTheme.bodyLarge,
                ),
                Text(
                  "Time: ${request["time"]}",
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.error,
                      foregroundColor: theme.colorScheme.onError,
                    ),
                    icon: const Icon(Icons.delete),
                    label: const Text("Delete"),
                    onPressed: onDelete,
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
