import 'package:flutter/material.dart';

class TranslateScreen extends StatefulWidget {
  const TranslateScreen({super.key});

  @override
  State<TranslateScreen> createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  final TextEditingController _controller = TextEditingController();
  String translatedText = "";

  void translate() {
    setState(() {
      // Fake translation
      translatedText = "Translated: ${_controller.text}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Translate")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: "Enter text"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: translate,
              child: const Text("Translate"),
            ),
            const SizedBox(height: 20),
            Text(translatedText),
          ],
        ),
      ),
    );
  }
}
