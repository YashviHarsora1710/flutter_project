import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _feedbackController = TextEditingController();
  int _rating = 0;

  void _submitFeedback() {
    String feedback = _feedbackController.text.trim();

    if (_rating == 0 || feedback.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please provide rating and feedback")),
      );
    } else {
      // Simulate sending feedback
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Thanks for your feedback! 🎉")),
      );
      _feedbackController.clear();
      setState(() => _rating = 0);
    }
  }

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
          onPressed: () {
            setState(() {
              _rating = index + 1;
            });
          },
        );
      }),
    );
  }

  Widget _buildMoodRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text('😠', style: TextStyle(fontSize: 30)),
        SizedBox(width: 20),
        Text('😐', style: TextStyle(fontSize: 30)),
        SizedBox(width: 20),
        Text('😄', style: TextStyle(fontSize: 30)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 55, 77, 75), // Changed color
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 233, 231, 233),
              Color.fromARGB(255, 215, 213, 217),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      "How was your experience?",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildStarRating(),
                    const SizedBox(height: 10),
                    _buildMoodRow(),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _feedbackController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: "Write your feedback...",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.send),
                      label: const Text("Submit"),
                      onPressed: _submitFeedback,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 78, 90, 109),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
