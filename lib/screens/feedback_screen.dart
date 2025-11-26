import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _feedbackController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  int _rating = 0;

  // Submit feedback function
  Future<void> _submitFeedback() async {
    final user = _auth.currentUser;
    final feedback = _feedbackController.text.trim();

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You must be logged in to give feedback")),
      );
      return;
    }

    if (_rating == 0 || feedback.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please provide rating and feedback")),
      );
      return;
    }

    try {
      await _firestore.collection("feedback").add({
        "userId": user.uid,
        "userName": user.email ?? "Anonymous",
        "message": feedback,
        "rating": _rating,
        "reply": "",
        "timestamp": FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Thanks for your feedback! 🎉")),
      );

      _feedbackController.clear();
      setState(() => _rating = 0);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error submitting feedback: $e")));
    }
  }

  // Build star rating widget
  Widget _buildStarRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < _rating ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: 30,
          ),
          onPressed: () => setState(() => _rating = index + 1),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback"),
        backgroundColor: const Color(0xFF4C5C68),
        foregroundColor: Colors.white,
      ),
      body: user == null
          ? const Center(
              child: Text(
                "Please log in to view or submit feedback.",
                style: TextStyle(fontSize: 16),
              ),
            )
          : Column(
              children: [
                // Feedback List
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _firestore
                        .collection("feedback")
                        .where("userId", isEqualTo: user.uid)
                        //.orderBy("timestamp", descending: true) // removed to avoid index error
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text("Error: ${snapshot.error}"));
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final feedbackDocs = snapshot.data?.docs ?? [];

                      if (feedbackDocs.isEmpty) {
                        return const Center(
                          child: Text("No feedback submitted yet."),
                        );
                      }

                      return ListView.builder(
                        itemCount: feedbackDocs.length,
                        itemBuilder: (context, index) {
                          final data =
                              feedbackDocs[index].data()
                                  as Map<String, dynamic>? ??
                              {};

                          final message = data["message"] ?? "No message";
                          final rating = data["rating"] ?? 0;
                          final reply = data["reply"] ?? "";
                          final timestamp = data["timestamp"] as Timestamp?;

                          return Card(
                            margin: const EdgeInsets.all(10),
                            elevation: 3,
                            child: ListTile(
                              title: Text(message),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4),
                                  Text("Rating: $rating ⭐"),
                                  const SizedBox(height: 5),
                                  Text(
                                    reply.isEmpty
                                        ? "Admin has not replied yet."
                                        : "Admin reply: $reply",
                                    style: TextStyle(
                                      color: reply.isEmpty
                                          ? Colors.grey
                                          : Colors.green[700],
                                      fontStyle: reply.isEmpty
                                          ? FontStyle.italic
                                          : FontStyle.normal,
                                    ),
                                  ),
                                  if (timestamp != null)
                                    Text(
                                      "Date: ${timestamp.toDate()}",
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                // Feedback input
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      _buildStarRating(),
                      TextField(
                        controller: _feedbackController,
                        decoration: const InputDecoration(
                          labelText: "Write your feedback...",
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: _submitFeedback,
                        icon: const Icon(Icons.send),
                        label: const Text("Submit Feedback"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4C5C68),
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
