import 'package:flutter/material.dart';

class ChecklistPage extends StatefulWidget {
  @override
  _ChecklistPageState createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  // List of checklist items
  final List<Map<String, dynamic>> _checklist = [
    {"title": "Identity Proof", "done": false},
    {"title": "Address Proof", "done": false},
    {"title": "Passport-size Photos", "done": false},
    {"title": "Application Form", "done": false},
    {"title": "Affidavit Document", "done": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Checklist")),
      body: ListView.builder(
        itemCount: _checklist.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(
              _checklist[index]["title"],
              style: TextStyle(
                decoration: _checklist[index]["done"]
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            value: _checklist[index]["done"],
            onChanged: (value) {
              setState(() {
                _checklist[index]["done"] = value!;
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          // Show completed items as a summary
          final completed = _checklist
              .where((item) => item["done"] == true)
              .map((item) => item["title"])
              .toList();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                completed.isEmpty
                    ? "No items completed yet!"
                    : "Completed: ${completed.join(', ')}",
              ),
              duration: Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }
}
