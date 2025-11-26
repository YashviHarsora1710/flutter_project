import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminFeedbackScreen extends StatelessWidget {
  const AdminFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin - Feedback"),
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore
            .collection("feedback")
            .orderBy("timestamp", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final feedbackDocs = snapshot.data!.docs;

          if (feedbackDocs.isEmpty) {
            return const Center(child: Text("No feedbacks yet"));
          }

          return ListView.builder(
            itemCount: feedbackDocs.length,
            itemBuilder: (context, index) {
              final doc = feedbackDocs[index];
              final data = doc.data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Text(data["userName"] ?? "Unknown User"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Message: ${data["message"]}"),
                      Text("Rating: ${data["rating"]} ⭐"),
                      const SizedBox(height: 5),
                      Text(
                        data["reply"].isEmpty
                            ? "No reply yet"
                            : "Reply: ${data["reply"]}",
                        style: TextStyle(
                          color: data["reply"].isEmpty
                              ? Colors.grey
                              : Colors.green[700],
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.reply, color: Colors.blueGrey),
                    onPressed: () {
                      final replyController = TextEditingController(
                        text: data["reply"],
                      );
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text("Reply to ${data["userName"]}"),
                          content: TextField(
                            controller: replyController,
                            decoration: const InputDecoration(
                              hintText: "Enter reply...",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: const Text("Cancel"),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                await firestore
                                    .collection("feedback")
                                    .doc(doc.id)
                                    .update({"reply": replyController.text});
                                Navigator.pop(ctx);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(
                                  0xFF4C5C68,
                                ), // button color
                                foregroundColor: Colors.white,
                              ),
                              child: const Text("Send Reply"),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
