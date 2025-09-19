import 'package:flutter/material.dart';

class AdminFeedbackScreen extends StatefulWidget {
  const AdminFeedbackScreen({super.key});

  @override
  State<AdminFeedbackScreen> createState() => _AdminFeedbackScreenState();
}

class _AdminFeedbackScreenState extends State<AdminFeedbackScreen> {
  List<Map<String, String>> feedbacks = [
    {"user": "Sneha", "message": "Add dark mode.", "reply": "Will do!"},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Admin - Feedback"),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: theme.appBarTheme.foregroundColor ?? Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: feedbacks.isEmpty
            ? Center(
                child: Text(
                  "No feedbacks yet",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
                  ),
                ),
              )
            : ListView.builder(
                itemCount: feedbacks.length,
                itemBuilder: (context, index) {
                  final fb = feedbacks[index];
                  return Card(
                    color: theme.scaffoldBackgroundColor == Colors.white
                        ? Colors.white
                        : const Color.fromARGB(255, 60, 60, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: CircleAvatar(
                        backgroundColor: primaryColor,
                        child: Text(
                          fb['user']![0],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        fb['user']!,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          Text(
                            fb['message']!,
                            style: theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Reply: ${fb['reply']!.isEmpty ? 'No reply yet' : fb['reply']}",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: fb['reply']!.isEmpty
                                  ? theme.hintColor
                                  : theme.colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.reply, color: primaryColor),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (ctx) {
                                  final replyController = TextEditingController(
                                    text: fb['reply'],
                                  );
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    title: Text("Reply to ${fb['user']}"),
                                    content: TextField(
                                      controller: replyController,
                                      decoration: const InputDecoration(
                                        hintText: "Enter your reply...",
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(ctx),
                                        child: const Text("Cancel"),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: primaryColor,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            feedbacks[index]['reply'] =
                                                replyController.text;
                                          });
                                          Navigator.pop(ctx);
                                        },
                                        child: const Text("Send Reply"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: theme.colorScheme.error,
                            ),
                            onPressed: () {
                              setState(() {
                                feedbacks.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
