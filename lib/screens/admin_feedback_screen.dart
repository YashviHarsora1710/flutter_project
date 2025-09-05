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
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        title: const Text("Admin - Feedback"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 55, 77, 75),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: feedbacks.isEmpty
            ? const Center(
                child: Text(
                  "No feedbacks yet",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
            : ListView.builder(
                itemCount: feedbacks.length,
                itemBuilder: (context, index) {
                  final fb = feedbacks[index];
                  return Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: CircleAvatar(
                        backgroundColor: const Color.fromARGB(
                          255,
                          152,
                          159,
                          159,
                        ),
                        child: Text(
                          fb['user']![0], // First letter of user name
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        fb['user']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          Text(
                            fb['message']!,
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Reply: ${fb['reply']!.isEmpty ? 'No reply yet' : fb['reply']}",
                            style: TextStyle(
                              fontSize: 13,
                              color: fb['reply']!.isEmpty
                                  ? Colors.grey
                                  : Colors.teal.shade700,
                            ),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.reply, color: Colors.teal),
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
                                          backgroundColor: Colors.teal,
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
                            icon: const Icon(Icons.delete, color: Colors.red),
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
