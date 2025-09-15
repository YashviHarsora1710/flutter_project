import 'package:flutter/material.dart';

class ChecklistPage extends StatefulWidget {
  final List<String> documents;

  const ChecklistPage({super.key, required this.documents});

  @override
  State<ChecklistPage> createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  late List<bool> _checked; // keeps track of checkboxes

  @override
  void initState() {
    super.initState();
    _checked = List.generate(widget.documents.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checklist"),
        backgroundColor: const Color(0xFF4C5C68),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: widget.documents.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(
              widget.documents[index],
              style: TextStyle(
                decoration: _checked[index]
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            value: _checked[index],
            onChanged: (bool? value) {
              setState(() {
                _checked[index] = value ?? false;
              });
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () {
          // Collect completed documents
          final completed = <String>[];
          for (int i = 0; i < widget.documents.length; i++) {
            if (_checked[i]) {
              completed.add(widget.documents[i]);
            }
          }

          // Show summary
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                completed.isEmpty
                    ? "No items completed yet!"
                    : "Completed: ${completed.join(', ')}",
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }
}
